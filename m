Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B5C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0622720848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="hGSWBt9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCAVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:47:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35663 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:47:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so12032002pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 13:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QLCw7MLhv4h+6kZHr+YJjXn0K/KcoNEB426LxMvC9t4=;
        b=hGSWBt9cAdoYKR8uVW3ACUTxEx7wtlE60eK1bM2uTil9ubZCqf1Wf4S344xhrLinwn
         arwPrWLf+QkEgzLfkeRh3iRLMq4wHabZSRbd2FHG63IJve9loprZQw6hIVrrlYyenA6N
         iY/Jgo/gd+Bqq1dHmKaUB4U9WOSUra/Ub86v+r0lIsJWUe3nTXYixZnvjvg1OkZcvDCz
         HHl/8kmucKICv41ZcYbQ5MPuOLF9cLjBHgCE5BBKhVroNkG0Lg/d3d4qSfNJGH5M+N6a
         /eRdV+kYHzMGV2ip20Wsx7EWopJCbw9dyBrSiRDn6Eh/DvIdyY6cDUvtMZKnknv1JMJR
         AMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QLCw7MLhv4h+6kZHr+YJjXn0K/KcoNEB426LxMvC9t4=;
        b=jeEAAI1nW8zd7+lzrrA3SIJY2dnIrm/WiNirM4+SHkxAP9mKxRBDRo/yeVFPl2lCBN
         gP7E42Kjzj2/9Ocr1Onu09rT0bnEv0p/+4/fYtthXIoHxZZQVimktsp0JUJpuCDNgdBQ
         wqGHacXTTwTYT0OqBZ+Saf512Sx1dyx6P2hX464UVMzFX8GBphF5VsBxKBQhuLMLDRUh
         u3vwClMTHLv5rFP7Cf38picHnHVy5qZXnA/oVYo0zPf/gnEEjy3kBxk+DGWOzHX4yLVR
         llFBmHStkf7wyRwpdXl3gUH160ug0Ddoit1MxTJLSJl2CAKQpZut+Rz9SYRIaJFOB9Ty
         RIMg==
X-Gm-Message-State: APjAAAVmLJozpdlAAojf3Po4xqajjsJJ9zC2f5MGSjf+f9hl0JxWS8q9
        TbaNdJoJUZqWb25XSZlqjrlg8g==
X-Google-Smtp-Source: APXvYqzRjAIshow/vWlG/VpbnTSdya8ANavzF7Zh8+rWVITXx71CANEIMI3B9wQRqGWL9XMWXcSzsQ==
X-Received: by 2002:a65:46cd:: with SMTP id n13mr6894716pgr.221.1551476840156;
        Fri, 01 Mar 2019 13:47:20 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id g3sm30177184pfo.125.2019.03.01.13.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 13:47:19 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C391F3007CA; Sat,  2 Mar 2019 00:47:15 +0300 (+03)
Date:   Sat, 2 Mar 2019 00:47:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 03/34] arm: mm: Add p?d_large() definitions
Message-ID: <20190301214715.hyzy5tevvwgki4w5@kshutemo-mobl1>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-4-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227170608.27963-4-steven.price@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:05:37PM +0000, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information will be provided by the
> p?d_large() functions/macros.
> 
> For arm, we already provide most p?d_large() macros. Add a stub for PUD
> as we don't have huge pages at that level.

We do not have PUD for 2- and 3-level paging. Macros from generic header
should cover it, shouldn't it?

-- 
 Kirill A. Shutemov
