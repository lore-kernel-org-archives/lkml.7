Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2558C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2A42230B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gwzlq8t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKSKID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:08:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfKSKIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:08:02 -0500
Received: from zn.tnic (p200300EC2F0EDC005592EDCF9C877480.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:dc00:5592:edcf:9c87:7480])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4458B1EC0C98;
        Tue, 19 Nov 2019 11:07:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574158077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ila9OqBBhoMf/cQ8rlDHnWD68xbWOecYwqrJXXsjQ2M=;
        b=gwzlq8t0TWpH0T/KA2xwbyDcLJZXKjADYgqwQIpAjccXpbSy21Gi2zlq+1pxhdvbD2NhsH
        CEU8lUpFW2uttEinixMhFShVoiHlUDm71dp1VC7wuCF1wKwjera9eyi+5gwTfaTb8tn7gV
        Ng/9s/5NOjfwIbrTQJxCr/4aYK/T4Mo=
Date:   Tue, 19 Nov 2019 11:07:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        tyhicks@canonical.com, colin.king@canonical.com,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/mtrr: Require CAP_SYS_ADMIN for all access
Message-ID: <20191119100753.GA27787@zn.tnic>
References: <201911181308.63F06502A1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201911181308.63F06502A1@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 01:09:21PM -0800, Kees Cook wrote:
> Zhang Xiaoxu noted that physical address locations for MTRR were
> visible to non-root users, which could be considered an information
> leak. In discussing[1] the options for solving this, it sounded like
> just moving the capable check into open() was the first step. If this
> breaks userspace, then we will have a test case for the more conservative
> approaches discussed in the thread. In summary:
> 
> - MTRR should check capabilities at open time (or retain the
>   checks on the opener's permissions for later checks).
> 
> - changing the DAC permissions might break something that expects to
>   open mtrr when not uid 0.
> 
> - if we leave the DAC permissions alone and just move the capable check
>   to the opener, we should get the desired protection. (i.e. check
>   against CAP_SYS_ADMIN not just the wider uid 0.)
> 
> - if that still breaks things, as in userspace expects to be able to
>   read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN, then
>   we need to censor the contents using the opener's permissions. For
>   example, as done in other /proc cases, like commit 51d7b120418e
>   ("/proc/iomem: only expose physical resource addresses to privileged
>   users").
> 
> [1] https://lore.kernel.org/lkml/201911110934.AC5BA313@keescook/
> 
> Reported-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/cpu/mtrr/if.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)

Yap, LGTM, thanks!

Reviewed-by: Borislav Petkov <bp@suse.de>

However, as it has a user-visible impact and it is not an urgent thing
to have in the tree, I'd not queue this now but after the merge window
is done so that we have a maximum time of exposure in linux-next and we
can have ample time to addres fallout.

/me puts it on the list for after the merge window.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
