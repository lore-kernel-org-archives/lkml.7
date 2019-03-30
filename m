Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D26C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FCB218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553924635;
	bh=yx1+MMpS/f+ia9+BoiS7MxiMuONqOm+udiXAsBGHQYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lVnS8/xCCfa/6D0bJD+TIgClm1UmyZzgwfMlpeIKwx+YzT+JDGJLkIrvp4FVOx2tb
	 t0Qt5XS1Q8h0CcYLS/vL2f8TNphki6qI1e2K0e/B01HN76x4dNFHt3VXjKBwoZOACE
	 B3tXEV08IV9UgtpMxaTygGq0AiC4W9rOaUmesvFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfC3Fny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfC3Fnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:43:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F3A6218A3;
        Sat, 30 Mar 2019 05:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553924633;
        bh=yx1+MMpS/f+ia9+BoiS7MxiMuONqOm+udiXAsBGHQYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ex8FwZfVtA3jrUjdWXmkmCK8fLM3JQsS8Q1a9mPmuLj253tY9NADbb6sVO4/hdVOB
         tzN5nDP4QEniRgnFKbcnEd1xwtNdUqGleAxPd5JUiWbcbYxlLdYdP3ap70TpCfwd2Q
         Ws9WIxVioIBGe/jSWNhASLVCjFImbYI5WOy4W30I=
Date:   Sat, 30 Mar 2019 06:43:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH AUTOSEL 4.19 40/57] kvm: properly check debugfs dentry
 before using it
Message-ID: <20190330054350.GB23655@kroah.com>
References: <20190330012854.32212-1-sashal@kernel.org>
 <20190330012854.32212-40-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190330012854.32212-40-sashal@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:28:33PM -0400, Sasha Levin wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [ Upstream commit 8ed0579c12b2fe56a1fac2f712f58fc26c1dc49b ]
> 
> debugfs can now report an error code if something went wrong instead of
> just NULL.  So if the return value is to be used as a "real" dentry, it
> needs to be checked if it is an error before dereferencing it.
> 
> This is now happening because of ff9fb72bc077 ("debugfs: return error
> values, not NULL").  syzbot has found a way to trigger multiple debugfs
> files attempting to be created, which fails, and then the error code
> gets passed to dentry_path_raw() which obviously does not like it.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Reported-and-tested-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c436d95fd7aa..fb74f994cb63 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3912,7 +3912,7 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>  	}
>  	add_uevent_var(env, "PID=%d", kvm->userspace_pid);
>  
> -	if (kvm->debugfs_dentry) {
> +	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
>  		char *tmp, *p = kmalloc(PATH_MAX, GFP_KERNEL);
>  
>  		if (p) {
> -- 
> 2.19.1
> 

Same thing here, this was a 5.0-only thing, no need for it to be
backported, please drop it from all trees.

thanks,

greg k-h
