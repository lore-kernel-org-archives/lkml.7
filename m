Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2713C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891CB2133F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N0n5AeeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDFXOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:14:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35257 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDFXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 19:14:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so3034870pfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=frF4c8dwjqAtQm7fNwHrFIJU5kbbeArN1OCV7ETeQ+A=;
        b=N0n5AeeBuyZPmfGfR4IqRd2JgNdFPd3TBiW8TqLcNt1h5vrST8rVGoeSgx9M4PGCYs
         IOFifl0SCGXtoCemErLvpr08zc8LBcB1esrj0gzX497N8tn/lXlT/TP4QmCCce+3xynH
         m7vaQ8maDu3Q3C+JsCzVNBW4zT7EMlStDEVqGp4ndd99Hg69Xl0hxC4qrwz2i/q+pSRN
         k5kmy8hv7orsO+SQ3RPTlLE5cV+Wd0Rht96GMP0xCq7S2ur10ZzX0K0/p3KRTb6Pnce6
         yLCAPp9+UyIOBzrPjk186+0V2nYL5wwvjB20/3Ac1cjFL/WxSucF0Rld+2Cpec2pEOwB
         cKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=frF4c8dwjqAtQm7fNwHrFIJU5kbbeArN1OCV7ETeQ+A=;
        b=Ul61AJVw3Uenc5z3A0tiLtJGRX4SwFO7UtXqb534rnjpRz6gEv/t7KZNAxNPgfNfeA
         xjDD50j2S4JfIJl1KCBeCBvDop148jF+nARhBOgauxWA10C1iReGdr4amNwSi+weswYq
         HBEumvtl1Y2XtP+rBnSquaMXz/ZjfVjVKL6zL6mZigZvVi6r4/bXA4USJMUzHcGavnO+
         Lr6bU36qEjsxiKzhV+5duuE/LjDLmv1n7S93+fcWb+Exkb0gz8DXF6U5wlNmmu+ryE4s
         im6SjTRnu+hekkoJ4wn22qw1x8cyppkjznI4ce/uirpnHXO7ExDZVFmtHuvaHG7m3RVN
         Mgwg==
X-Gm-Message-State: APjAAAXUiOrfyx7+DXwMBorrF+YuXAPZvUm9fwgRZvYccSeJ2Yr3Ef97
        qoVHyW0BeUuFB/YBj/FtSMofhw==
X-Google-Smtp-Source: APXvYqyNm0WS2gDAuj6dHckm1kMDjqculrY2nMq6qtaMTQyF9OctGiI8gci+qK98/wgivkodd8Ko4A==
X-Received: by 2002:aa7:9ab7:: with SMTP id x23mr1272048pfi.27.1554592474693;
        Sat, 06 Apr 2019 16:14:34 -0700 (PDT)
Received: from localhost ([52.119.120.223])
        by smtp.gmail.com with ESMTPSA id f15sm18564141pgf.18.2019.04.06.16.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 16:14:33 -0700 (PDT)
Date:   Sat, 6 Apr 2019 16:14:32 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 7/7] riscv: dts: add initial board data for the SiFive
 HiFive Unleashed
In-Reply-To: <20181220212618.GA27359@bogus>
Message-ID: <alpine.DEB.2.21.9999.1904061612310.18279@viisi.sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com> <20181215052154.24347-8-paul.walmsley@sifive.com> <20181220212618.GA27359@bogus>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018, Rob Herring wrote:

> On Fri, Dec 14, 2018 at 09:21:54PM -0800, Paul Walmsley wrote:
> > Add initial board data for the SiFive HiFive Unleashed A00.
> > 
> > Currently the data populated in this DT file describes the board
> > DRAM configuration and the external clock sources that supply the
> > PRCI.

...

> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
> > new file mode 100644
> > index 000000000000..0c6afabe69e3
> > --- /dev/null
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: Apache-2.0
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> This should be a single line with: (Apache-2.0 OR GPL-2.0+)

Done.

> > +	model = "SiFive HiFive Unleashed A00 (FU540-C000)"
> > +	compatible = "sifive,hifive-unleashed-a00-fu540",
> > +		"sifive,hifive-unleashed-fu540";
> 
> SoC compatible should be here too.

Done.

> > +	soc {
> > +		hfclk: hfclk {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <33333333>;
> > +			clock-output-names = "hfclk";
> > +		};
> > +		rtcclk: rtcclk {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <1000000>;
> > +			clock-output-names = "rtcclk";
> > +		};
> 
> Are these the clock inputs to the SoC or dummy clocks until you write a 
> proper clock driver? If the former, they should be at the top level. 

Done.


Thanks for your comments; Will send an updated patch set.


- Paul
