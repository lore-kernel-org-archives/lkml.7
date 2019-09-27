Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B33AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20414206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 06:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kojedz.in header.i=@kojedz.in header.b="c2IodFNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfI0GQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 02:16:57 -0400
Received: from pi.kojedz.in ([109.61.102.5]:27889 "EHLO pi.kojedz.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfI0GQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:16:57 -0400
Received: from webmail.srv.kojedz.in (unknown [IPv6:2a01:be00:10:201:0:80:0:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: richard@kojedz.in)
        by pi.kojedz.in (Postfix) with ESMTPSA id 11A8812DCB;
        Fri, 27 Sep 2019 08:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kojedz.in; s=mail;
        t=1569565014; bh=1fai7zVrEIPp6m7DYpaViVG7jo5MqBydWDeWQpzA65U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=c2IodFNRFUKAu7vlA5EmdzsZo0hRpaiwGbzv/MGEMUQ56CaAyOdhYI3+5fhgHTGb5
         mzCOH3GwwhQzrwqSpF3fqzZHb3JPxGO5e41oze+yiIofxwRoDihruyWGck8S1zMm98
         jqgDoa0a6eQstM+qG7QY3JvUlqXpXX6Yl0SMSWgjFdMrD4pBi9RCj8VyB7IeT/FmLg
         MW6u4ykn8fGA9aqE2HVg66wUUqf2j+xZFSwIVItJhhMyhoJb4TpFosgTPWl+y2AkCh
         cSli7eHiMfwwDSIa1m5JfXJOtdl+KG4sRMtVbyq47h2kYN0GTfYiLX2l+Sk8JhqUvE
         h6eB8bAyH71tHValSYv19stqvg6x8zB+B7obGNbaZFKfO1IscBGpAu1ZcNYLZzHx/Y
         mARS8/TJPE2q+GXiFHpDNO1FZrid3iz8CljUCSP3wrQx9wnjSkd8rx3q3To01/pXq2
         EGj1GfyRb8OZkq7MoyXBlpDcqQCnwnP7JBBCuYysDu9L+0Jq4bGE2AnDg4AZ0BUyPM
         ir8F0t0X8qH9lQ+AJQR2uC4bWfvK53Ovaj8ztJk0FdeE82igBZTpvPeoaRtyN5Uyo9
         BNXUQaxIMwGrjU2tnBNobw6W1LnfeImB/1DNWo4ZI8Kukl8qepjKaerzhvEi0WC9rI
         FtejzXk+8kuIAOTosv8vVrpg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 27 Sep 2019 08:16:53 +0200
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
In-Reply-To: <201909261136.780526BB@keescook>
References: <201909261012.96DE554A@keescook>
 <cfdb3b68100025288177da8a963bc909@kojedz.in>
 <201909261136.780526BB@keescook>
Message-ID: <321faad3c5e1f8eaf9d81fd78f3b22d6@kojedz.in>
X-Sender: richard@kojedz.in
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the fix, again. I am not familiar with the code here, I 
suspect the intent was to fix or improve something. That happens 
sometimes, that things get broken. I am happy that I could report it, 
and it got fixed quickly.

Thanks again,
Richard


2019-09-26 20:37 időpontban Kees Cook ezt írta:
> On Thu, Sep 26, 2019 at 08:26:12PM +0200, Richard Kojedzinszky wrote:
>> Thanks for the quick patch. It seems my binaries start up well, and 
>> work as
>> expected, as before.
>> 
>> Thanks again for the quick response.
> 
> Awesome; thanks for the testing (and sorry for the breakage)! :)
> 
> -Kees
> 
>> 
>> Regards,
>> Richard Kojedzinszky
>> 
>> 2019-09-26 19:15 időpontban Kees Cook ezt írta:
>> > When brk was moved for binaries without an interpreter, it should have
>> > been limited to ET_DYN only. In other words, the special case was an
>> > ET_DYN that lacks an INTERP, not just an executable that lacks INTERP.
>> > The bug manifested for giant static executables, where the brk would end
>> > up in the middle of the text area on 32-bit architectures.
>> >
>> > Reported-by: Richard Kojedzinszky <richard@kojedz.in>
>> > Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
>> > direct loader exec")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> > Richard, are you able to test this? I'm able to run the gitea binary
>> > with this change, and my INTERP-less ET_DYN tests (from the original
>> > bug) continue to pass as well.
>> > ---
>> >  fs/binfmt_elf.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> > index cec3b4146440..ad4c6b1d5074 100644
>> > --- a/fs/binfmt_elf.c
>> > +++ b/fs/binfmt_elf.c
>> > @@ -1121,7 +1121,8 @@ static int load_elf_binary(struct linux_binprm
>> > *bprm)
>> >  		 * (since it grows up, and may collide early with the stack
>> >  		 * growing down), and into the unused ELF_ET_DYN_BASE region.
>> >  		 */
>> > -		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
>> > +		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
>> > +		    loc->elf_ex.e_type == ET_DYN && !interpreter)
>> >  			current->mm->brk = current->mm->start_brk =
>> >  				ELF_ET_DYN_BASE;
>> >
>> > --
>> > 2.17.1
