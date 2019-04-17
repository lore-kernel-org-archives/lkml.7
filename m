Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BE9206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555522000;
	bh=9j8CyYJ2zQuXKkSeFJZdiII8gPPzipgvkSiKz46XFRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ozdaea/rB0LrxM8dyLxG4BI5njjz8ahVcyuduUeIlzlUZxQssUO4oz9eoogkwVF+O
	 Oc7Rq1ROMTTEyUvCDUZlHsIJ7ps8GATMd0WIOIDpW0cX16LiIZzN2zdOtpsbWoYQd6
	 TsLQNBlcczzmL7Yu7g2yVhlGVGPRRNmO0CLrdVt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbfDQR0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:26:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36600 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:26:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so4581669wml.1;
        Wed, 17 Apr 2019 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ns0QxnuhAfvDI+e0rO3qV1NnmRx4qtLcXwX4SEWj8w8=;
        b=NcvYWJCyNfLatXmVyDRxLTR3Qx/x7JgxS8jcPHCtBtiN6MPmtGAh7sebTFiQVJAXNk
         Sbm/GqYfFaqfvaPEXTOrurvDwkKnd5zlx2TBIC3kz2Q4om3TP0Y1KaPxiIdippBjXGPT
         mt//zbGrEi8KAnTquF8hj0kCkKK4+MgiTjgN9U5T632osXgyVF0kyOkokSJYhpqPWU7q
         HvdQgIN00S7lvWehKYIDllQwTC97+wEK/qsM7xgShblV1PsGd2t5GKDax19T5iQvivwv
         QGi7KKBjclQM6KMFluz3llgRlzIQ2Zeot4lykjGh7vko0CNZ/xTAD3H/14XuvK6bERiB
         TxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ns0QxnuhAfvDI+e0rO3qV1NnmRx4qtLcXwX4SEWj8w8=;
        b=pYuZG149qnmzTop1skvx8kkGcL9haKa4bv6o7HF/DSiRsm9OVe4hcKyyA0Tq4bAZUv
         ME2TwQ30KiBW8fXKFkOUVa6aJVw39KNMAsRuW08oPE14TnT1IydQHUEyMRb0DFQpIeDM
         Eyjv6dVDSBRRzzOuSR1i1/HyoaMedrRyAnRX2JKX8Wf9Z+i6L0UjgvUKpuZ1o1qkq6n5
         ZHLfFiDaKEg6Qd4pGaTXJnsBW/gsvVisYsNqHF0M8KbEZmKqFABhIl0ouuo8Q09FfCWq
         HlvcrqprLxF6/gHDgJtDXUXsKHwFflV0sLnPWpEiRXRl3bZf6dNrFLYjaD/9dmSMDIlj
         l+Hw==
X-Gm-Message-State: APjAAAX39Pp7VpAwFeRHo05nkJV1FpI7CqQrv7ReX+Y4EOCoaI9N0LSt
        a/OIvuQPFGkKx/MuYH1/NLs=
X-Google-Smtp-Source: APXvYqx0bXa7GoJQLXDLgeOn35F7WmZUbi0CsPk0aTEStD8EU08aO6txiY/M5Pu51pv7jSUwysUxyA==
X-Received: by 2002:a1c:495:: with SMTP id 143mr575729wme.78.1555521996663;
        Wed, 17 Apr 2019 10:26:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x5sm65470238wrt.72.2019.04.17.10.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 10:26:35 -0700 (PDT)
Date:   Wed, 17 Apr 2019 19:26:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        keescook@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>, jcm@redhat.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu <iommu@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-arm-kernel@lists.infradead.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Message-ID: <20190417172632.GA95485@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <nadav.amit@gmail.com> wrote:

> > On Apr 17, 2019, at 10:09 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > 
> > * Khalid Aziz <khalid.aziz@oracle.com> wrote:
> > 
> >>> I.e. the original motivation of the XPFO patches was to prevent execution 
> >>> of direct kernel mappings. Is this motivation still present if those 
> >>> mappings are non-executable?
> >>> 
> >>> (Sorry if this has been asked and answered in previous discussions.)
> >> 
> >> Hi Ingo,
> >> 
> >> That is a good question. Because of the cost of XPFO, we have to be very
> >> sure we need this protection. The paper from Vasileios, Michalis and
> >> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
> >> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
> >> and 6.2.
> > 
> > So it would be nice if you could generally summarize external arguments 
> > when defending a patchset, instead of me having to dig through a PDF 
> > which not only causes me to spend time that you probably already spent 
> > reading that PDF, but I might also interpret it incorrectly. ;-)
> > 
> > The PDF you cited says this:
> > 
> >  "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced 
> >   in many platforms, including x86-64.  In our example, the content of 
> >   user address 0xBEEF000 is also accessible through kernel address 
> >   0xFFFF87FF9F080000 as plain, executable code."
> > 
> > Is this actually true of modern x86-64 kernels? We've locked down W^X 
> > protections in general.
> 
> As I was curious, I looked at the paper. Here is a quote from it:
> 
> "In x86-64, however, the permissions of physmap are not in sane state.
> Kernels up to v3.8.13 violate the W^X property by mapping the entire region
> as “readable, writeable, and executable” (RWX)—only very recent kernels
> (≥v3.9) use the more conservative RW mapping.”

But v3.8.13 is a 5+ years old kernel, it doesn't count as a "modern" 
kernel in any sense of the word. For any proposed patchset with 
significant complexity and non-trivial costs the benchmark version 
threshold is the "current upstream kernel".

So does that quote address my followup questions:

> Is this actually true of modern x86-64 kernels? We've locked down W^X
> protections in general.
>
> I.e. this conclusion:
>
>   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
>    triggering the kernel to dereference it, an attacker can directly
>    execute shell code with kernel privileges."
>
> ... appears to be predicated on imperfect W^X protections on the x86-64
> kernel.
>
> Do such holes exist on the latest x86-64 kernel? If yes, is there a
> reason to believe that these W^X holes cannot be fixed, or that any fix
> would be more expensive than XPFO?

?

What you are proposing here is a XPFO patch-set against recent kernels 
with significant runtime overhead, so my questions about the W^X holes 
are warranted.

Thanks,

	Ingo
