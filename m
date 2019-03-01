Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD06C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEDC2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Tm1tQon+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfCAM2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:28:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34418 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCAM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:28:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so11402877pgd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=//6YYsQF8GgCh58e9gUcqUx70l8klEmhGzm+30mhqCg=;
        b=Tm1tQon+UU7S9BJ8mWVuw58F/jEjjJT9Y5SBanjOnNYZcQNzXTmiC1Xwnxp2FbG17u
         C5C0XCbHKjGbuxPl314LrXHPwi0tTbrK3izEi8T/5Rb1o2kho9SfYMCznGhpXWQjf2Do
         GzBvvN4CDeaFJurfVbSpa/vXOO/FnrGjf5VvcSJYqof1rdcuKdbrJj7dEsL6sP35P7tS
         zFw4Y3/r5eLSZxvH+5SiSpeBb50fMj17WHwcPQbn+R4ech237C7IyExUbEn1GfNMWDP+
         NeKbTY/pFIFt+UnNt4GTLrffJXkDwmL5jvrQGSQ4GPIujgW5nQMdeMVgaVTpENey7BdI
         j4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=//6YYsQF8GgCh58e9gUcqUx70l8klEmhGzm+30mhqCg=;
        b=PiZf3OSmYh1sCW3E72TFpzRtga+gUriGPBcSC6Qr8fBM2yeN07asKn8ksEa23FN9ZX
         TnjBDbEx5+B8jdlpUqGblcZKPfBW+aoucDy6Q2rBApD1pB8fzNGv2EY+mlMv2pr5HU32
         iM6LLJbV7b1Wd9jJEKb+ypsvedrkDxoP5UWaBlAcKV/+cye2Qv5KiIg/Vc7ORwAEvipB
         /fBKQyzAEby2/Rwg4JlqhjhtwmwGqCwqBQxdyEq8l0/ZLk2yBRUgBhV+hC/y3O0Riag8
         3eGcLuLNxFY8eit5j58PALApj9voaDMLe5dGcUBBTy7dEsiPQBh7LQTN4DvVR/+HS6zD
         fd5A==
X-Gm-Message-State: AHQUAubl/wGX0GAofOD+LThqIyQkjtdOTELMETK9WAAIPnc8XPVErnfk
        67B1KDPc5sQI1f8fhmfnKCxsPw==
X-Google-Smtp-Source: AHgI3IYJXPBVK8/oKi2e4yu3mf/HzJGVjbMeFmbWAqJgFTTns7suMUS1K566ACkqu9WFhUM6jAHMYA==
X-Received: by 2002:aa7:9259:: with SMTP id 25mr5219988pfp.221.1551443328369;
        Fri, 01 Mar 2019 04:28:48 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id d5sm30561812pfo.83.2019.03.01.04.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 04:28:47 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 2630F3007CA; Fri,  1 Mar 2019 15:28:44 +0300 (+03)
Date:   Fri, 1 Mar 2019 15:28:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190301122843.a2pwiqejhcbammao@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
 <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
 <20190301114953.GD5156@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301114953.GD5156@rapoport-lnx>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:49:53PM +0200, Mike Rapoport wrote:
> Hi Kirill,
> 
> On Thu, Feb 21, 2019 at 05:57:06PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Feb 21, 2019 at 02:46:18PM +0000, Steven Price wrote:
> > > On 21/02/2019 14:28, Kirill A. Shutemov wrote:
> > > > On Thu, Feb 21, 2019 at 11:34:52AM +0000, Steven Price wrote:
> > > >> From: James Morse <james.morse@arm.com>
> > > >>
> > > >> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> > > >> we may come across the exotic large mappings that come with large areas
> > > >> of contiguous memory (such as the kernel's linear map).
> > > >>
> > > >> For architectures that don't provide p?d_large() macros, provided a
> > > >> does nothing default.
> > > > 
> > > > Nak, sorry.
> > > > 
> > > > Power will get broken by the patch. It has pmd_large() inline function,
> > > > that will be overwritten by the define from this patch.
> > > > 
> > > > I believe it requires more ground work on arch side in general.
> > > > All architectures that has huge page support has to provide these helpers
> > > > (and matching defines) before you can use it in a generic code.
> > > 
> > > Sorry about that, I had compile tested on power, but obviously not the
> > > right config to actually see the breakage.
> > 
> > I don't think you'll catch it at compile-time. It would silently override
> > the helper with always-false.
> 
> Can you explain why the compiler would override the helper define in, e.g.
> arch/powerpc/include/asm/pgtable.h with the generic (0)?

This one will not be overrided, but the other one will. See

arch/powerpc/include/asm/book3s/64/pgtable.h

-- 
 Kirill A. Shutemov
