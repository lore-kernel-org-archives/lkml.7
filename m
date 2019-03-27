Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1079C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD66B2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553646696;
	bh=dmCrpIIlOeX3Wo5ocEtZ02zBnrBjS5jwNBYJfgk6vFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MqKlaBhocbb1vQIbFekf6/bDiJBlpP6nR3ebeBCsFvZBKVqKpv8B3LDXw+z1FVeJ9
	 XJfsUBrx5ivWfAKIAZ2QT1mVCeSNtd+eYMwrWQ9Ydk+Qjr8ssQDXBbIYBqmo+SyFPQ
	 3nrnAjNHV88FsC1iuBgpryJRFZ0xpCNrXm42FTiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfC0Abf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732310AbfC0Abf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:31:35 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155662075E;
        Wed, 27 Mar 2019 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553646694;
        bh=dmCrpIIlOeX3Wo5ocEtZ02zBnrBjS5jwNBYJfgk6vFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbXaUmIHaE/c7egINaCmkVjniTyEcy2LpIjJIoaDknsQRm0BVCy+Gvhru02ENGBwv
         xK1qDEr2HXryx1kmb3RZ0RlmRO6uGiPxNt1VxG57A/PApuU/F4/dARYz10Y9uhzkTR
         0NtxPaQ8TYY0Asl/w6KCGkKgAJLnmd1XVof6CaA0=
Date:   Wed, 27 Mar 2019 09:31:30 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked
 down
Message-ID: <20190327003130.GB27311@kroah.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326182742.16950-26-matthewgarrett@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:27:41AM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@google.com>
> 
> debugfs has not been meaningfully audited in terms of ensuring that
> userland cannot trample over the kernel. At Greg's request, disable
> access to it entirely when the kernel is locked down. This is done at
> open() time rather than init time as the kernel lockdown status may be
> made stricter at runtime.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: gregkh@linuxfoundation.org
> ---
>  fs/debugfs/file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 4fce1da7db23..9ae12ef29ba0 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -142,6 +142,9 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
>  	const struct file_operations *real_fops = NULL;
>  	int r;
>  
> +	if (kernel_is_locked_down("debugfs", LOCKDOWN_INTEGRITY))
> +		return -EPERM;

Why allow all this, why not just abort the registering of the filesystem
with the vfs core so it can't even be mounted?

thanks,

greg k-h
