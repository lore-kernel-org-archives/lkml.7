Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7990FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3C421D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="dM09lcgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfIZScD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:32:03 -0400
Received: from pi.kojedz.in ([109.61.102.5]:52844 "EHLO pi.kojedz.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZScD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:32:03 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 14:32:02 EDT
Received: from webmail.srv.kojedz.in (unknown [IPv6:2a01:be00:10:201:0:80:0:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: richard@kojedz.in)
        by pi.kojedz.in (Postfix) with ESMTPSA id 8078712279;
        Thu, 26 Sep 2019 20:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=mail;
        t=1569522378; bh=AUGopV7ZtWwIoZOOc1gsSJnlwsOr1iIzlpBkw7VtrDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=dM09lcgS058/4qz0wxEBLJTKVURTzbiwise2XajOenFu8+mZrIcctEw3TEreDzc2e
         garWVNZ3/PBhvFjfuEbBRxUZjDsj6bCTI2NYT4HXXEl55gdGDMaj906iBugdgOtacq
         upSAmHST4GLxu37acpINZJrIQ+ms4c5JTZFulGeiY5DhZ/9XZ7kU6gpEbJbtbvjmcd
         zN10q386FuhIlmfxqPGiQx7KGkhS3GuPiXU0LnxAwfQ2T+QP7lfFEeUVx80YnYmqCt
         6uu0HItIRfN85OSzgQW4V3BccVOEdH2mdD8XEKHABlWGZenAVSOOcC9fxMLovDLVDc
         t6U0TpJNZbViVeIZNc+CQLHwyJ2b1OuUcWbNIY+Hm70B0P2vYIdAEe1E32FdSA92kK
         iKC+CMNKKV6AcT76K/HkKMOg0p+GE1YVC+oCst1+XgwFwXy6shRNu4ZDaGIAHn4gOj
         GD/mD3ZAFmT9jrsAirIUXMDVMRK9VMOc0N/y+Je1JJXzDZ7RdzppVtAr1hDFD6Mad5
         NeCT1e1x4h5YzOYNyPUhRnaMc/7dcBFKz83hbjAsqq3pM5WKtG0IIT1XrdAXVHoj57
         NW07Nx3FJg0llpE1PIhmALk87GKuIQaUvXDpxtjACxSxzdMH0J9YoMkCJ+x2uQJPDK
         9DoD65qtUrdlbLG2pgIn1ytA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Sep 2019 20:26:12 +0200
From:   Richard Kojedzinszky <richard@kojedz.in>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ali Saidi <alisaidi@amazon.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] binfmt_elf: Do not move brk for INTERP-less ET_EXEC
In-Reply-To: <201909261012.96DE554A@keescook>
References: <201909261012.96DE554A@keescook>
Message-ID: <cfdb3b68100025288177da8a963bc909@kojedz.in>
X-Sender: richard@kojedz.in
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Thanks for the quick patch. It seems my binaries start up well, and work 
as expected, as before.

Thanks again for the quick response.

Regards,
Richard Kojedzinszky

2019-09-26 19:15 időpontban Kees Cook ezt írta:
> When brk was moved for binaries without an interpreter, it should have
> been limited to ET_DYN only. In other words, the special case was an
> ET_DYN that lacks an INTERP, not just an executable that lacks INTERP.
> The bug manifested for giant static executables, where the brk would 
> end
> up in the middle of the text area on 32-bit architectures.
> 
> Reported-by: Richard Kojedzinszky <richard@kojedz.in>
> Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
> direct loader exec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Richard, are you able to test this? I'm able to run the gitea binary
> with this change, and my INTERP-less ET_DYN tests (from the original
> bug) continue to pass as well.
> ---
>  fs/binfmt_elf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index cec3b4146440..ad4c6b1d5074 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1121,7 +1121,8 @@ static int load_elf_binary(struct linux_binprm 
> *bprm)
>  		 * (since it grows up, and may collide early with the stack
>  		 * growing down), and into the unused ELF_ET_DYN_BASE region.
>  		 */
> -		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
> +		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
> +		    loc->elf_ex.e_type == ET_DYN && !interpreter)
>  			current->mm->brk = current->mm->start_brk =
>  				ELF_ET_DYN_BASE;
> 
> --
> 2.17.1
