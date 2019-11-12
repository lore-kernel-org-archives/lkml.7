Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79203C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5109A2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573597070;
	bh=3aPwM7/Buc2TPWA2LaatjIUsl/IROjYtb51Osl3oQ74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KtuKVVaAwmzwSsO16x1YykjCZesLaK8F1LtHtxNFeLD+iteWcqv08GhmiAG+ZSdZt
	 mcAfS3xFsl2XmFUnEj7OQf5hrWHYHauNhSm8dpdBr+Kb/LQIzKEx/VhCbhL5yTLcJ+
	 VBaoghedk27DK8uSPc2OvIvOW+zrehUJa+ymXGKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLWRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:17:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42201 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLWRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:17:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id s5so72650pfh.9;
        Tue, 12 Nov 2019 14:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2iN/yehd/2GpguMn0OanzUdHqNojDPjN6OvR1ZyuODs=;
        b=Z/wZDWSk5mFf89Fb8/3Y0xGC9fssKtTdmeO8keyTIg22H7rlxPLIHMC9LcW0MrFMtU
         aoONa62BDkTxlUKdrwYrRBXHGPV64cKK1h8QyC88J7qbMTsMqwyj7YwG6/Kdmp59m+F1
         mU1CxEdu72O4uOEMop4UUHJ6PhCI7izpRrguSAhr54JSqM2uqc2JA4BBHmbL7tdvd+Vz
         YfcwSkBs2uJD+B2f3y57Ddso3mgq2BerqL/6DVXJqM1F5gJs/o+eTRhbUmHSWd/trZtG
         n14dvzMfCQU1cbav3DyuR5NQujDemI96/2iM9sk/20YTXAekYsuXZt70dnaqyKEKv3hR
         PXKw==
X-Gm-Message-State: APjAAAUu2UK9lWKwakO09ke/ajkyK6WKTdblniJIHB+EJMIij6sH+bdm
        Uamtswn1JeCCFMVgrVh4miDIYWbu
X-Google-Smtp-Source: APXvYqzmMph9NtFrykVRKlX9bwLyIRf3sdm0HU9U256KmolyB3mrRD4hWUhyWgMjtQQJGTaDNgBAJw==
X-Received: by 2002:a63:3f4e:: with SMTP id m75mr37022515pga.392.1573597066577;
        Tue, 12 Nov 2019 14:17:46 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x20sm21005912pfa.186.2019.11.12.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:17:45 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A6CD8403DC; Tue, 12 Nov 2019 22:17:44 +0000 (UTC)
Date:   Tue, 12 Nov 2019 22:17:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tuowen Zhao <ztuowen@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] video: fbdev: atyfb: only use ioremap_uc() on i386 and
 ia64
Message-ID: <20191112221744.GN11244@42.do-not-panic.com>
References: <20191111192258.2234502-1-arnd@arndb.de>
 <20191112105507.GA7122@lst.de>
 <CAKMK7uEEz1n+zuTs29rbPHU74Dspaib=prpMge63L_-rUk_o4A@mail.gmail.com>
 <20191112140631.GA10922@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112140631.GA10922@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:06:31PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2019 at 02:04:16PM +0100, Daniel Vetter wrote:
> > Wut ... Maybe I'm missing something, but from how we use mtrr in other
> > gpu drivers it's a) either you use MTRR because that's all you got or
> > b) you use pat. Mixing both sounds like a pretty bad idea,

You misread the patch. And indeed there is a bit of complexity involved
here folks should be aware of as .. well, its been a while.

A mix of both MTRR and PAT is not effectively done on the code patch for
the atyb driver. If you have PAT only PAT is used.  If you don't have
PAT a solution is provided to use MTRR.

The goal of the patch really was to help finally avoid direct calls
to MTRR. *This* driver was the *one* crazy exception where we needed
to adddress this with a solution which would work effectively for both
non-PAT and PAT world which had crazy constraints.

So with this out of the way, no direct calls of MTRRs was possible and
there are future possible gains with this for x86. The biggest two were:

  1) Xen didn't have to implement MTRR hypervisor calls out for Linux
     guests. This means Xen guests don't have to enable MTRRs. Any code
     path avoiding such craziness as stop_machine() on each CPU during
     bootup, resume, CPU online and whenever an MTRR is set is a blessing.

  2) We may be closer in the future to getting ioremap_nocache to use
     UC isntead of UC-, this would be a win. x86 ioremap_nocache() does
     not use UC (strong UC), it just uses UC-.

Note though that BIOSes can *only* enable UC by using MTRR directly, fan
control for a system was one use case example that can come up, just as
an example. Ideally your BIOS won't need this. When and how this is done
is platform and BIOS specific though. So effectively, if a BIOS enables
MTRRs the Linux must keep them enabled. If the BIOS disables MTRRs the
kernel keeps them disabled.

> Can you take a look at "mfd: intel-lpss: Use devm_ioremap_uc for MMIO"
> in linux-next, which also looks rather fishy to me?  Can't we use
> the MTRR APIs to override the broken BIOS MTRR setup there as well?

The call there was put to allow precisely for such work around but also
allow the code to work on PAT / non-PAT systems by using the same API.

> With that we could kill ioremap_uc entirely.

ioremap_uc() is a compromise to avoid direct calls to MTRRs, since
ioremap_nocache() is not effectively yet using UC. Whether or not
other archs carry it.

  Luis
