Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE3C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD321734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfEBMrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:47:52 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55384 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:47:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hMB7s-0000qc-KI; Thu, 02 May 2019 14:47:48 +0200
Message-ID: <f0f772e5e33519dac93672be26fa7995f8109721.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] devcoredump: allow to create several coredump files
 in one device
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Thu, 02 May 2019 14:47:47 +0200
In-Reply-To: <1556787561-5113-3-git-send-email-akinobu.mita@gmail.com> (sfid-20190502_105944_673346_AEC5725E)
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
         <1556787561-5113-3-git-send-email-akinobu.mita@gmail.com>
         (sfid-20190502_105944_673346_AEC5725E)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-02 at 17:59 +0900, Akinobu Mita wrote:
> 
>  static void devcd_del(struct work_struct *wk)
>  {
>  	struct devcd_entry *devcd;
> +	int i;
>  
>  	devcd = container_of(wk, struct devcd_entry, del_wk.work);
>  
> +	for (i = 0; i < devcd->num_files; i++) {
> +		device_remove_bin_file(&devcd->devcd_dev,
> +				       &devcd->files[i].bin_attr);
> +	}

Not much value in the braces?

> +static struct devcd_entry *devcd_alloc(struct dev_coredumpm_bulk_data *files,
> +				       int num_files, gfp_t gfp)
> +{
> +	struct devcd_entry *devcd;
> +	int i;
> +
> +	devcd = kzalloc(sizeof(*devcd), gfp);
> +	if (!devcd)
> +		return NULL;
> +
> +	devcd->files = kcalloc(num_files, sizeof(devcd->files[0]), gfp);
> +	if (!devcd->files) {
> +		kfree(devcd);
> +		return NULL;
> +	}
> +	devcd->num_files = num_files;

IMHO it would be nicer to allocate all of this in one struct, i.e. have

struct devcd_entry {
	...
	struct devcd_file files[];
}

(and then use struct_size())

> @@ -309,7 +339,41 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   put_module:
>  	module_put(owner);
>   free:
> -	free(data);
> +	for (i = 0; i < num_files; i++)
> +		files[i].free(files[i].data);
> +}

and then you don't need to do all this kind of thing to free

Otherwise looks fine. I'd worry a bit that existing userspace will only
capture the 'data' file, rather than a tarball of all files, but I guess
that's something you'd have to work out then when actually desiring to
use multiple files.

johannes

