Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9174CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0310C2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sddgU2aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfCDNLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:11:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40984 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCDNK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:10:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id d25so3000733pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i+uJsIH9vVyOV5Tk28y23klIfxYci68lEiPowiIlx3E=;
        b=sddgU2aRtJ2zYqDNcOUZzUk3M/eU6C/dPxzI/yarFrk5YXqKXTlkj9+V6Ej1gWGl5S
         0Y00j8efBGBPNa38B9fwNBevPWrW4bRQn/oqwpPZl2mEOu7VDUlL2/NWR7kGcp/8ayOP
         N0WFcpQyvsiYdHTddw0D88Z+w4eW1PNS5EVEa0YW+pdelsy46Nk5okbwiL+l56G1rLRp
         29tRCiS9Q840vVihdOrq3YC8lfunYrw3EvcMZxWUyrk195VG02sK+7l5nCxai5WslBOr
         mtj248N5e1raENfLI4cliIs/J1DmKCHFfC8aLYUNyNcKMYIUGSOidPjGzeTm7Brf/ltu
         pTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+uJsIH9vVyOV5Tk28y23klIfxYci68lEiPowiIlx3E=;
        b=nmnrDjpDO0vN/WMi39oTbVV4AF4VYSv7ds50QZ/LpoeXdUwX3E6wmFkwYnHHOUCPLj
         Y3bp14zgOLF0Kl7LGvcHMiT6eHqFpmvhyjwebTLmh9Ab2CVksXQwqVMRzjOoUsKQQNDG
         wNs6bCIvsaEhevhIA8i4jXUMDOGc7N7az6ltHDJXLjiW2d6NrE0iPmFRy6ci98qOGlH2
         jZQDwZxTwtjkEiow47Xe7V8w1pbkjxlaL0dNOtwbX5eQZv4OBmr22oM6zlBN20uuD3BH
         Ryc6tcpy9n0JIJLnoMO2JD1sU5jVZAfbX2p6+cpnr8W/hCxNByn820MiNz7tq5ChHZv2
         6RUw==
X-Gm-Message-State: APjAAAXZ/XtXOIo6OU7gnN7l3NpQ14GEddZ15czUf3+Y09LAD+hjfEf/
        lFSaYJK49bVuv2Cla+yULDukow==
X-Google-Smtp-Source: APXvYqzHr+bDim597mkyh4dboXKIfYc7NYQ38mxKFIYbp8RFyPZGLKWjB/Fag6abhRGxq7b6vqo/4Q==
X-Received: by 2002:a17:902:9a48:: with SMTP id x8mr13344843plv.98.1551705058879;
        Mon, 04 Mar 2019 05:10:58 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id 20sm8185700pgr.80.2019.03.04.05.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:10:58 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 72ACC300429; Mon,  4 Mar 2019 16:10:54 +0300 (+03)
Date:   Mon, 4 Mar 2019 16:10:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v3 03/34] arm: mm: Add p?d_large() definitions
Message-ID: <20190304131054.goxpqsosolkg7khf@kshutemo-mobl1>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-4-steven.price@arm.com>
 <20190301214715.hyzy5tevvwgki4w5@kshutemo-mobl1>
 <974310a0-0114-9a0c-9041-4e0394c4b9aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974310a0-0114-9a0c-9041-4e0394c4b9aa@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:56:13AM +0000, Steven Price wrote:
> On 01/03/2019 21:47, Kirill A. Shutemov wrote:
> > On Wed, Feb 27, 2019 at 05:05:37PM +0000, Steven Price wrote:
> >> walk_page_range() is going to be allowed to walk page tables other than
> >> those of user space. For this it needs to know when it has reached a
> >> 'leaf' entry in the page tables. This information will be provided by the
> >> p?d_large() functions/macros.
> >>
> >> For arm, we already provide most p?d_large() macros. Add a stub for PUD
> >> as we don't have huge pages at that level.
> > 
> > We do not have PUD for 2- and 3-level paging. Macros from generic header
> > should cover it, shouldn't it?
> > 
> 
> I'm not sure of the reasoning behind this, but levels are folded in a
> slightly strange way. arm/include/asm/pgtable.h defines
> __ARCH_USE_5LEVEL_HACK which means:
> 
> PGD has 2048 (2-level) or 4 (3-level) entries which are always
> considered 'present' (pgd_present() returns 1 defined in
> asm-generic/pgtables-nop4d-hack.h).
> 
> P4D has 1 entry which is always present (see asm-generic/5level-fixup.h)
> 
> PUD has 1 entry (see asm-generic/pgtable-nop4d-hack.h). This is always
> present for 2-level, and present only if the first level of real page
> table is present with a 3-level.
> 
> PMD/PTE are as you might expect.
> 
> So in terms of tables which are more than one entry you have PGD,
> (optionally) PMD, PTE. But the levels which actually read the table
> entries are PUD, PMD, PTE.
> 
> This means that the corresponding p?d_large() macros are needed for
> PUD/PMD as that is where the actual entries are read. The asm-generic
> files provide the definitions for PGD/P4D.

Makes sense.

Only additional thing worth nothing that ARM in 2-level paging case folds
PMD manually without help from generic headres.

I'm partly responsible for the mess with folding. Sorry that you need to
explain this to :P

-- 
 Kirill A. Shutemov
