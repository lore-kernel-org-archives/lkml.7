Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBBC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAE5206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="L3eytFXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfJHOcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:32:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35372 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:32:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id v8so15845179eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=njSAfvEWqpgoU0gYs1bEj0p7fhAAPMVQsZ7cyfhOXFg=;
        b=L3eytFXDAeIwpwarvxe0IxbMkPQ+dIYA4tTHLo5Yw8fOEGweyFLbK2Xr3UlZMWoFhY
         VG9gE0gzprlJFzonnB3Dj922G288bBaQNi7WJHMg876FS4rT/+T8mkW9ZotgP09VZW+f
         TGcxwNXlIBtuKmQf7Wjg4Iwn73QP4qB8NuZqeiPQ8W8FK/7sYS6bN8fUjhS4+IsgfQUN
         1Gl3s5FqC/FQE5etDdbLM/iBAuhJE6VXrajmBUr/OO4vI8ScKNYDniM2Yks0vck5VNTa
         EEuIYW09UqkOTc3dzF1TuYOzFbJAOoiRZ64sW2/mMcJHn+v4yPrZlC+RN5Y+wkwLYq6/
         Hh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=njSAfvEWqpgoU0gYs1bEj0p7fhAAPMVQsZ7cyfhOXFg=;
        b=sNZoQBnWiST2v4Ym8XWalEqXK14TKF+NRmzhHeugoVqGKjPoX9jodebm6Oy2P7nFp/
         dpEiHMH5AQe+9GLMYZf6MaRfS4XD3a+udhNnXxlIJMVMqh1kV54OwFeaGuBGdLHUALmk
         4WDPkABCMRD6jPsdlGkRUWR76rJng6kuWQWzLQ1jdDQ9Ug/Pg9v1kFMuXzNQWGBf4kJZ
         Pd9Bh/5ME9pxzbJt4DT+5mD7gJVJwLMH0gLOkWPN0EKuY5IN+47grBbMshJH++XeI33H
         C9dSfoTtBXY2O/zTB/LjDRhcXoquq4obMwEh44Q1LhTj4+lOvNeyjNg4kQ6Le2jEuDdN
         H6hg==
X-Gm-Message-State: APjAAAWTPSwb0yrawg/u9NkdbO5hPv4AwDDopa+qwTAUjF+SF8ZEu7+U
        lM+hwbcRttRwRJB21spEowXmaw==
X-Google-Smtp-Source: APXvYqz6cvRMCxdLmtCQ2khfDe1iPEqAmLGkZ2CXZc2kazAbmaHM4vhnZ63e2XgGI3JqNjExeBFVDw==
X-Received: by 2002:aa7:d995:: with SMTP id u21mr34410415eds.271.1570545153868;
        Tue, 08 Oct 2019 07:32:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i30sm3938992ede.32.2019.10.08.07.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 07:32:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5440710170F; Tue,  8 Oct 2019 17:32:32 +0300 (+03)
Date:   Tue, 8 Oct 2019 17:32:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Justin He (Arm Technology China)" <Justin.He@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20191008143232.e7r4auxwlcllvlqh@box>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-4-justin.he@arm.com>
 <20191001125413.mhxa6qszwnuhglky@willie-the-truck>
 <DB7PR08MB3082563BD18482E5D541F019F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
 <20191008123943.j7q6dlu2qb2az6xa@willie-the-truck>
 <DB7PR08MB30828D5469EA39EA0825B809F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB30828D5469EA39EA0825B809F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 12:58:57PM +0000, Justin He (Arm Technology China) wrote:
> Hi Will
> 
> > -----Original Message-----
> > From: Will Deacon <will@kernel.org>
> > Sent: 2019年10月8日 20:40
> > To: Justin He (Arm Technology China) <Justin.He@arm.com>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Mark Rutland
> > <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>; Marc
> > Zyngier <maz@kernel.org>; Matthew Wilcox <willy@infradead.org>; Kirill A.
> > Shutemov <kirill.shutemov@linux.intel.com>; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; Punit Agrawal <punitagrawal@gmail.com>; Thomas
> > Gleixner <tglx@linutronix.de>; Andrew Morton <akpm@linux-
> > foundation.org>; hejianet@gmail.com; Kaly Xin (Arm Technology China)
> > <Kaly.Xin@arm.com>; nd <nd@arm.com>
> > Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF
> > is cleared
> > 
> > On Tue, Oct 08, 2019 at 02:19:05AM +0000, Justin He (Arm Technology
> > China) wrote:
> > > > -----Original Message-----
> > > > From: Will Deacon <will@kernel.org>
> > > > Sent: 2019年10月1日 20:54
> > > > To: Justin He (Arm Technology China) <Justin.He@arm.com>
> > > > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Mark Rutland
> > > > <Mark.Rutland@arm.com>; James Morse <James.Morse@arm.com>;
> > Marc
> > > > Zyngier <maz@kernel.org>; Matthew Wilcox <willy@infradead.org>;
> > Kirill A.
> > > > Shutemov <kirill.shutemov@linux.intel.com>; linux-arm-
> > > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > > > mm@kvack.org; Punit Agrawal <punitagrawal@gmail.com>; Thomas
> > > > Gleixner <tglx@linutronix.de>; Andrew Morton <akpm@linux-
> > > > foundation.org>; hejianet@gmail.com; Kaly Xin (Arm Technology China)
> > > > <Kaly.Xin@arm.com>
> > > > Subject: Re: [PATCH v10 3/3] mm: fix double page fault on arm64 if
> > PTE_AF
> > > > is cleared
> > > >
> > > > On Mon, Sep 30, 2019 at 09:57:40AM +0800, Jia He wrote:
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index b1ca51a079f2..1f56b0118ef5 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
> > > > >  					2;
> > > > >  #endif
> > > > >
> > > > > +#ifndef arch_faults_on_old_pte
> > > > > +static inline bool arch_faults_on_old_pte(void)
> > > > > +{
> > > > > +	return false;
> > > > > +}
> > > > > +#endif
> > > >
> > > > Kirill has acked this, so I'm happy to take the patch as-is, however isn't
> > > > it the case that /most/ architectures will want to return true for
> > > > arch_faults_on_old_pte()? In which case, wouldn't it make more sense
> > for
> > > > that to be the default, and have x86 and arm64 provide an override?
> > For
> > > > example, aren't most architectures still going to hit the double fault
> > > > scenario even with your patch applied?
> > >
> > > No, after applying my patch series, only those architectures which don't
> > provide
> > > setting access flag by hardware AND don't implement their
> > arch_faults_on_old_pte
> > > will hit the double page fault.
> > >
> > > The meaning of true for arch_faults_on_old_pte() is "this arch doesn't
> > have the hardware
> > > setting access flag way, it might cause page fault on an old pte"
> > > I don't want to change other architectures' default behavior here. So by
> > default,
> > > arch_faults_on_old_pte() is false.
> > 
> > ...and my complaint is that this is the majority of supported architectures,
> > so you're fixing something for arm64 which also affects arm, powerpc,
> > alpha, mips, riscv, ...
> 
> So, IIUC, you suggested that:
> 1. by default, arch_faults_on_old_pte() return true
> 2. on X86, let arch_faults_on_old_pte() be overrided as returning false
> 3. on arm64, let it be as-is my patch set.
> 4. let other architectures decide the behavior. (But by default, it will set
> pte_young)
> 
> I am ok with that if no objections from others.
> 
> @Kirill A. Shutemov Do you have any comments? Thanks

Sounds sane to me.

-- 
 Kirill A. Shutemov
