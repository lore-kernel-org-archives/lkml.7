Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662C6C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3723321848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uNdf7j98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfHZNd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:33:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40706 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfHZNd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:33:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id h8so26542600edv.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bcUfL34FoYp4/VabITIx6X/hBshWWuaQCv3+2NB9Wuo=;
        b=uNdf7j98900+3G56FRLP6n5FYs7OQNYJAikxCojCx9KA+DxauVKt+ZYG9nGdLUDcIg
         3jJHThfnxMGoOflE9QMP7dvLmOurLC/5iEe8aY39OkqbfblIkF8lCaoiah7lSbjDwI37
         wNWjcVKwPD9yhjQcHd1oGOyeg7idIF9SeNUBIMPM8Tl96hGaODG4jYNCo6jkfvvWuYoU
         A4jJHSzeU3o+Nmf9c/fi9uSBOKt5n85GzBhlLtig+WxWfNHa6shtmOrGAElgs924psRC
         7xi0dWry0ZRHo/BmCfyC5VS2kR7vwoUpp9XfZUEWHzxm1rFyMyuFp6NxKA5rdmJFgGCQ
         oo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bcUfL34FoYp4/VabITIx6X/hBshWWuaQCv3+2NB9Wuo=;
        b=NRMt3KGJ6Q7hgmEdm5VZ79ysmFo+Fz6uF81dbmlFh0mvhjV5C9I7Jbj1z85nLZCgZg
         7X/5TlPJGTZ11R1eHd5DhnWLH468WIYxj8g06drDTbK8W3UxcWx/PTxMf5VjoWd32stS
         kodfgMNf5L/9b4xqB97hp/B7fysE9jJNOwkD9ht2SHgVtvqnSk/1grdjwiyWWIoMmaW7
         kSJopOGBssAHHHhbJi4tiKT7KpwEC+1ZI8LB+6bB1BOAmaBbE0DV2PSUU8DQEob0/3In
         MuG9cfJsIAF0eRWffxpF/dOznos5hUotzf/6tl+QxgEumSxiHe8CXotGjJLZxb5zfmWH
         moKA==
X-Gm-Message-State: APjAAAVcZgwGns983aMCuGnHQywm0rymjaG1GYof8HgDX+7G2+WI9bRV
        0vzgjNV5KTkYXY8vt1OM0xZXSg==
X-Google-Smtp-Source: APXvYqwEyTAOm70GPqxQ0JdvxB8u4mVlVB3HNyBKxvtxr+6ex91ykH53z1B8TzSHnaxfQXPoFelQbA==
X-Received: by 2002:a17:906:34c2:: with SMTP id h2mr16368397ejb.227.1566826405105;
        Mon, 26 Aug 2019 06:33:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i1sm1294470edi.13.2019.08.26.06.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 06:33:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1101D10050C; Mon, 26 Aug 2019 16:33:26 +0300 (+03)
Date:   Mon, 26 Aug 2019 16:33:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        x86@kernel.org, mingo@kernel.org, kirill.shutemov@linux.intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/boot/compressed/64: Fix boot on machines
 with broken E820 table
Message-ID: <20190826133326.7cxb4vbmiawffv2r@box>
References: <20190813131654.24378-1-kirill.shutemov@linux.intel.com>
 <tip-0a46fff2f9108c2c44218380a43a736cf4612541@git.kernel.org>
 <caa30daa-9ed5-e293-f6cd-ff261c995e1e@embeddedor.com>
 <20190826071539.GB27636@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826071539.GB27636@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:15:39AM +0200, Borislav Petkov wrote:
> On Sun, Aug 25, 2019 at 10:33:15PM -0500, Gustavo A. R. Silva wrote:
> > Hi all,
> > 
> > On 8/19/19 9:16 AM, tip-bot for Kirill A. Shutemov wrote:
> > [..]
> > > 
> > > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > > index 5f2d03067ae5..2faddeb0398a 100644
> > > --- a/arch/x86/boot/compressed/pgtable_64.c
> > > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > > @@ -72,6 +72,8 @@ static unsigned long find_trampoline_placement(void)
> > >  
> > >  	/* Find the first usable memory region under bios_start. */
> > >  	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
> > > +		unsigned long new;
> > > +
> > >  		entry = &boot_params->e820_table[i];
> > >  
> > >  		/* Skip all entries above bios_start. */
> > > @@ -84,15 +86,20 @@ static unsigned long find_trampoline_placement(void)
> > >  
> > >  		/* Adjust bios_start to the end of the entry if needed. */
> > >  		if (bios_start > entry->addr + entry->size)
> > 
> > Notice that if this condition happens to be false, we end up with an
> > uninitialized variable *new*.
> 
> Yap, good catch.

:facepalm:

> > What would be the right value to assign to *new* at declaration under
> > this condition?
> 
> Looking at the changed flow of the loop, how we use new instead of
> bios_start and how we assign new back to bios_start, I think we should
> do:
> 
> 		unsigned long new = bios_start;
> 
> at the beginning...

Right.

What about this:

From b613c675e6690ef5608a5abf71d90e15ced31b2b Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 26 Aug 2019 16:26:01 +0300
Subject: [PATCH] x86/boot/compressed/64: Fix missining initialization in
 find_trampoline_placement()

Gustavo noticed that 'new' can be left uninitialized if 'bios_start'
happens to be less or equal to 'entry->addr + entry->size'.

Initialize the variable at the start of the iteration to current value
of 'bios_start'.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Fixes: 0a46fff2f910 ("x86/boot/compressed/64: Fix boot on machines with broken E820 table")
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 2faddeb0398a..c8862696a47b 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -72,7 +72,7 @@ static unsigned long find_trampoline_placement(void)
 
 	/* Find the first usable memory region under bios_start. */
 	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
-		unsigned long new;
+		unsigned long new = bios_start;
 
 		entry = &boot_params->e820_table[i];
 
-- 
 Kirill A. Shutemov
