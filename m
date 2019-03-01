Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4450AC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1241C20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LZiJgMy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfCAMah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:30:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42241 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:30:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id v11so6017934plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwN29NY+nAlefSDnECPz319uLNHU3cPMNiJ5hS0ECbw=;
        b=LZiJgMy44t947Rdt3vyKczwDk0n+rpmTMgsgz6v3p24vpWEGB2pZKPqmCOGZSz9Ste
         TpE/+XRwj+R8GJj9HNsRGh9aCTAlliu4V3Esj8kgs9fSnR7dVExFnKuu2guEQvQMjRRu
         STq3OlxsJEazLRzI47N8PXPu8aq5IPILTLh7SC326Xzwby8SW4kdAE3qbZ+Un3TDcf7c
         l05wRG6Nju9RxIzUQK3JQq+eMrYX5ZiH+RY8AR9GG3dJ3zEh4bvYIUSX3Q8hdmur9tKs
         x9hVnxmZbKOtKIquWxPFS+gx/KAw+R6pfeXqsO/iuImeNSMTl1a+tMOOMzqk2HsCjj3w
         0PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwN29NY+nAlefSDnECPz319uLNHU3cPMNiJ5hS0ECbw=;
        b=DiXL48UoMh59TfX69C3SRzgUuBU7lCUEccc3ZGXVSrtZhA6sUN7DSnG3SP9FufXp5T
         vsVc4UZv+gTmB7d0oWcEWMGyygq5sEhK17/F3TwxJ+jSvp1t05d/taQORRApJQ7qgdmb
         7hTmR+yIWzkS9kw7etXeWPUsDEQIFkMBUocjvmFC5LRjHmGau9wXSKgsEPSYn9ixudpx
         y4+NOLSig9B0wK1TIS+ehDOLXAxvaGpcv4Z3va01HCuAhB78wWj9TPVQFoc9U2lY8hN5
         aaHx8HBuNwEQn6Byyw/tXY3BjHYajn7ExXjCbJIgPAp1nXZK7bhxfcxNUOoXCMFctjAb
         K0Cw==
X-Gm-Message-State: APjAAAWhS5UoJaOZ/k0S1a5OyYiZc3OphWB/L/h9fsA/ahGUHITG5+Bx
        /aWheW8YTVeCSDb3RccnkuPJzw==
X-Google-Smtp-Source: APXvYqy6pV25UnwnnU3xX2RrPJ4FcMnfFJ+8Gwik7AdJVp2ntt5m6dL3usGlH10SREOL7aMKG/qKtg==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr5219887plr.340.1551443436539;
        Fri, 01 Mar 2019 04:30:36 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id z189sm9589765pfb.146.2019.03.01.04.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 04:30:36 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 3544C3007CA; Fri,  1 Mar 2019 15:30:32 +0300 (+03)
Date:   Fri, 1 Mar 2019 15:30:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
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
Message-ID: <20190301123031.rw3dswcoaa2x7haq@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
 <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
 <e0c7fc0c-7924-1106-a7a3-fc12136b7b82@arm.com>
 <20190221210618.voyfs5cnafpvgedh@kshutemo-mobl1>
 <20190301115300.GE5156@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301115300.GE5156@rapoport-lnx>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:53:01PM +0200, Mike Rapoport wrote:
> Him Kirill,
> 
> On Fri, Feb 22, 2019 at 12:06:18AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Feb 21, 2019 at 05:16:46PM +0000, Steven Price wrote:
> > > >> Note that in terms of the new page walking code, these new defines are
> > > >> only used when walking a page table without a VMA (which isn't currently
> > > >> done), so architectures which don't use p?d_large currently will work
> > > >> fine with the generic versions. They only need to provide meaningful
> > > >> definitions when switching to use the walk-without-a-VMA functionality.
> > > > 
> > > > How other architectures would know that they need to provide the helpers
> > > > to get walk-without-a-VMA functionality? This looks very fragile to me.
> > > 
> > > Yes, you've got a good point there. This would apply to the p?d_large
> > > macros as well - any arch which (inadvertently) uses the generic version
> > > is likely to be fragile/broken.
> > > 
> > > I think probably the best option here is to scrap the generic versions
> > > altogether and simply introduce a ARCH_HAS_PXD_LARGE config option which
> > > would enable the new functionality to those arches that opt-in. Do you
> > > think this would be less fragile?
> > 
> > These helpers are useful beyond pagewalker.
> > 
> > Can we actually do some grinding and make *all* archs to provide correct
> > helpers? Yes, it's tedious, but not that bad.
> 
> Many architectures simply cannot support non-leaf entries at the higher
> levels. I think letting the use a generic helper actually does make sense.

I disagree.

It's makes sense if the level doesn't exists on the arch.

But if the level exists, it will be less frugile to ask the arch to
provide the helper. Even if it is dummy always-false.

-- 
 Kirill A. Shutemov
