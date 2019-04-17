Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D0C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32528217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbfDQVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:23:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51012 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:23:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGs1Q-00080k-VR; Wed, 17 Apr 2019 21:23:13 +0000
Date:   Wed, 17 Apr 2019 22:23:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        stable@vger.kernel.org, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 11/26] ceph: fix compat_ioctl for ceph_dir_operations
Message-ID: <20190417212312.GY2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-12-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-12-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:19:49PM +0200, Arnd Bergmann wrote:
> The ceph_ioctl function is used both for files and directories, but only
> the files support doing that in 32-bit compat mode.
> 
> For consistency, add the same compat handler to the dir operations
> as well.
> 
> Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ceph/dir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index a8f429882249..7c060cb22aa3 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1785,6 +1785,7 @@ const struct file_operations ceph_dir_fops = {
>  	.open = ceph_open,
>  	.release = ceph_release,
>  	.unlocked_ioctl = ceph_ioctl,
> +	.compat_ioctl = ceph_ioctl,

Again, broken on s390 (and so's the ceph_file_ops, of course).
It wants compat_ptr() applied to argument...
