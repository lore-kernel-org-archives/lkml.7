Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CDCC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2342075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfEBMmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:42:54 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55204 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfEBMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:42:54 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hMB35-0000gN-0P; Thu, 02 May 2019 14:42:51 +0200
Message-ID: <e5cfeb7ad11b3783239e05ab7414fcec28dce1b5.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] devcoredump: use memory_read_from_buffer
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Thu, 02 May 2019 14:42:49 +0200
In-Reply-To: <1556787561-5113-2-git-send-email-akinobu.mita@gmail.com> (sfid-20190502_105940_876596_E74F58C8)
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
         <1556787561-5113-2-git-send-email-akinobu.mita@gmail.com>
         (sfid-20190502_105940_876596_E74F58C8)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-02 at 17:59 +0900, Akinobu Mita wrote:
> Use memory_read_from_buffer() to simplify devcd_readv().

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/base/devcoredump.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index f1a3353..3c960a6 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -164,16 +164,7 @@ static struct class devcd_class = {
>  static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
>  			   void *data, size_t datalen)
>  {
> -	if (offset > datalen)
> -		return -EINVAL;
> -
> -	if (offset + count > datalen)
> -		count = datalen - offset;
> -
> -	if (count)
> -		memcpy(buffer, ((u8 *)data) + offset, count);
> -
> -	return count;
> +	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
>  }
>  
>  static void devcd_freev(void *data)

