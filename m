Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9C1C352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC08E207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tjam6gLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfIZShI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:37:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41936 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfIZShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:37:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so2007370pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FaViWsVDn17cy4A6WVHtk7aRB0sfMsNdvmfUCneILOk=;
        b=Tjam6gLCggyyq8CDEVt/g1sC4ML4r6onWz5htyldUVNmDMFc+2UWm666m1mKYKpam7
         810jYtSN3n7AyZPl0r9CEFTv77IXyHlK1XDFAxP4jy/i8sIVAuGwAiVAR1GZ+J7Piv1f
         hq58F7FkF8w0YI0JQaofME6CShFvfn9h9MaNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FaViWsVDn17cy4A6WVHtk7aRB0sfMsNdvmfUCneILOk=;
        b=PtD39003reL7QFpiDJL0hMBN5XDa4prcxIRZzJpELiHqzm3S3uixyVj7KZdHTjdC2a
         d5TS7uooi4W33DaHjoAqBXFL4Q+XCHNBwbWCUD2rDBeMvVsLYimKHKQkPt8nitBQPK0W
         F4V+bxNrmHu5zSBM3bOrmK7GHvQ7qFPn4OsQ1qqnui49lp3+LS1fYPZcxDSrpKWNyZDm
         UvdSKBtwGzVfrqiqIPaqlbZR0LU/BKZYZVgE4RoLh1vzIpSwgc1K25Mplj9aqd6qjt5f
         sLkdBRC8DPUwy7XFY7dtVSaSb1Hzuf4FBcKkLSrFYMvHbzlqrxPQeVrr4Trcf+wNN2I3
         ZoSA==
X-Gm-Message-State: APjAAAWGE6SkHGg542LSv05OPXN3mTOGKyP/03J7ERGt8trjcS5doD3M
        cGq3mT88pDcEcOz91KLU9QCmRA==
X-Google-Smtp-Source: APXvYqyFfzzrXVDShat3RhCC93XbNdkB/5XMvPbHVkA5ryBueLbkpznRm3xLzwxlsjoLPCO1ICwWkQ==
X-Received: by 2002:a63:c052:: with SMTP id z18mr4988073pgi.315.1569523025536;
        Thu, 26 Sep 2019 11:37:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm2653766pjs.1.2019.09.26.11.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 11:37:04 -0700 (PDT)
Date:   Thu, 26 Sep 2019 11:37:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Richard Kojedzinszky <richard@kojedz.in>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ali Saidi <alisaidi@amazon.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] binfmt_elf: Do not move brk for INTERP-less ET_EXEC
Message-ID: <201909261136.780526BB@keescook>
References: <201909261012.96DE554A@keescook>
 <cfdb3b68100025288177da8a963bc909@kojedz.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfdb3b68100025288177da8a963bc909@kojedz.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 08:26:12PM +0200, Richard Kojedzinszky wrote:
> Thanks for the quick patch. It seems my binaries start up well, and work as
> expected, as before.
> 
> Thanks again for the quick response.

Awesome; thanks for the testing (and sorry for the breakage)! :)

-Kees

> 
> Regards,
> Richard Kojedzinszky
> 
> 2019-09-26 19:15 időpontban Kees Cook ezt írta:
> > When brk was moved for binaries without an interpreter, it should have
> > been limited to ET_DYN only. In other words, the special case was an
> > ET_DYN that lacks an INTERP, not just an executable that lacks INTERP.
> > The bug manifested for giant static executables, where the brk would end
> > up in the middle of the text area on 32-bit architectures.
> > 
> > Reported-by: Richard Kojedzinszky <richard@kojedz.in>
> > Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
> > direct loader exec")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Richard, are you able to test this? I'm able to run the gitea binary
> > with this change, and my INTERP-less ET_DYN tests (from the original
> > bug) continue to pass as well.
> > ---
> >  fs/binfmt_elf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index cec3b4146440..ad4c6b1d5074 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1121,7 +1121,8 @@ static int load_elf_binary(struct linux_binprm
> > *bprm)
> >  		 * (since it grows up, and may collide early with the stack
> >  		 * growing down), and into the unused ELF_ET_DYN_BASE region.
> >  		 */
> > -		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
> > +		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
> > +		    loc->elf_ex.e_type == ET_DYN && !interpreter)
> >  			current->mm->brk = current->mm->start_brk =
> >  				ELF_ET_DYN_BASE;
> > 
> > --
> > 2.17.1

-- 
Kees Cook
