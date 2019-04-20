Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 06:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBB2208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 06:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zii/kmIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDTGur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 02:50:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46114 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTGuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 02:50:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so9214684wrw.13;
        Fri, 19 Apr 2019 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qwkFQXdRYSN4cjcxhcGAtub/O4dXxsLQe0Z6+/RaFWE=;
        b=Zii/kmIJleFmkzupyOw0lKkoLCXWE22+9c4Qca2Q82/RrMK8K8l3SV2/L9vl2ys4qu
         1D2oVzPcGeEPoksC3glAkiAuQryi2+zkUbFoTidY3FEp+8b2rxqiPklkBRagHVzCwTUu
         QpFdrStnu5+QUb3Ay45J3VwlRYhez7+725dJafoJri6AFK8Xfye+NDSK9NU3rr458vUO
         eFeOD5ZoavgkyE8kzSB8gjKy96S09XdsP+8bNq8RXwcfPxLMKLkdsYkkAfu/Q+cTZsDA
         pwPXD6CdJR9uznr70VxHZ6C98LaY+JcKNo+3RJgav9Meob0p3WUIn5bbdvHhCJggI5vu
         +7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qwkFQXdRYSN4cjcxhcGAtub/O4dXxsLQe0Z6+/RaFWE=;
        b=J1LuXk5TTT/EUFvU8oBxPdwrMmHnE6L2L7Ps1alKR21RtI9YHt4vZOehnYSddz8eyz
         shQWvKVviaEsEnqUBC76Ak/UZ9Kp9xBj9ULOHVhBJsg3d1ksLIMvCVZKxSdRGz/cTHCg
         7px+ow7fSRggue+oC7PMmKLMyXOLS4mhGUfcqdMCNdseiAto2Jt5Hr1RrE8dH7pZAU/k
         53kJr/mh7ajT/L0IhKUry1leYOm3Rc+voPNQdE+/k+LQBRD04X+WqI052w5Y7qKRgroK
         GUXINGzUus+5hFekx1+8Wn/RKmzWgvLQY8zRMZdG3bopOyFbtvokkkedj+RRLyw+BrpD
         8dig==
X-Gm-Message-State: APjAAAUYUSJxXpv8w0xQlk/kKPJVQUA4io0K61QQERFBAOaeuelToBvt
        qX5Y1F6V6dlcAQSLtPuj+gs=
X-Google-Smtp-Source: APXvYqw+DniWUQCLeqNpD1e97wy7zEAYBEnKPeXeE98+oWsuq/igmSo1UHOBPnkR/6VtzIq7mlYmYA==
X-Received: by 2002:adf:e443:: with SMTP id t3mr5908550wrm.257.1555743044177;
        Fri, 19 Apr 2019 23:50:44 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id j190sm8718157wmb.19.2019.04.19.23.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 23:50:43 -0700 (PDT)
Date:   Sat, 20 Apr 2019 07:50:42 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: exynos: add CCI-400 PMU nodes support to
 Exynos542x SoCs
Message-ID: <20190420065041.eyynz7ol2uhv3w5g@macpro-scc.lancs.ac.uk>
References: <20190412172545.fkxnpnymhcw7xncc@macpro-scc.lancs.ac.uk>
 <CACfOrNdEpC2vNgCOBXtrW-HjGHNG_6iLAFUCtVoZstGASPtcsA@mail.gmail.com>
 <38dee054-19ce-a545-fb62-dea4d0036c94@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dee054-19ce-a545-fb62-dea4d0036c94@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, many thanks Robin.

Using this, values sound better.
export OMP_NUM_THREADS=2
sudo --preserve-env ./perf stat -a \
  -e armv7_cortex_a7/config=0x11,name=a7_cycles/ \
  -e armv7_cortex_a15/config=0x11,name=a15_cycles/ \
  -e armv7_cortex_a7/config=0x19,name=a7_bus/ \
  -e armv7_cortex_a15/config=0x19,name=a15_bus/ \
  -e CCI_400/config=0xff,name=cci400_cycles/ \
  -e CCI_400/config=0x0,source=4,name=cci400_si_rrq_hs_any_s4/ \
  -e CCI_400/config=0xc,source=4,name=cci400_si_wrq_hs_any_s4/ \
  -e CCI_400/config=0x0,source=3,name=cci400_si_rrq_hs_any_s3/ \
  -e CCI_400/config=0xc,source=3,name=cci400_si_wrq_hs_any_s3/ \
  taskset -c 0,4 /home/user/EnergyManager/temperature_bench_install/bin/cg.x.A 1

[..]
 Performance counter stats for 'system wide':

     6,201,513,834      a7_cycles
     2,781,009,706      a15_cycles
        64,200,721      a7_bus
        60,237,019      a15_bus
     1,158,303,323      cci400_cycles
        11,390,649      cci400_si_rrq_hs_any_s4
         1,253,383      cci400_si_wrq_hs_any_s4
        13,379,256      cci400_si_rrq_hs_any_s3
        13,200,717      cci400_si_wrq_hs_any_s3

       3.685087167 seconds time elapsed


Do you think that I should write a v2 with a better cover letter that shows
how to access this? By the way, I see that you contribute to that driver. I
haven't seen anything about this source=, do you think that it should be
documented somewhere?

Also, 0 and 4 on the interrupts represent GIC_SPI and IRQ_TYPE_LEVEL_HIGH,
I will do a v2 for this. Don't you think that the doc at
Documentation/devicetree/bindings/arm/cci.txt should use this too?

Willy

On Fri, Apr 19, 2019 at 10:18:02PM +0100, Robin Murphy wrote:
> On 2019-04-19 6:53 pm, Willy Wolff wrote:
> > Hi,
> > 
> > This patch can be dropped, as it needs more work.
> > 
> > In fact, the interrupts seems to be wrong. The interrupts suggested by
> > Anand Moon gave the same following results.
> > 
> > export CCI_DEV=CCI_400
> > export OMP_NUM_THREADS=2
> > sudo --preserve-env ./perf stat -a \
> >    -e armv7_cortex_a7/config=0x11,name=a7_cycles/ \
> >    -e armv7_cortex_a15/config=0x11,name=a15_cycles/ \
> >    -e armv7_cortex_a7/config=0x19,name=a7_bus/ \
> >    -e armv7_cortex_a15/config=0x19,name=a15_bus/ \
> >    -e ${CCI_DEV}/config=0xff,name=cci400_cycles/ \
> >    -e ${CCI_DEV}/config=0x0,name=cci400_si_rrq_hs_any/ \
> >    -e ${CCI_DEV}/config=0xc,name=cci400_si_wrq_hs_any/ \
> 
> From the look of those configs, you'll be counting events on slave interface
> 0, which may not even have anything connected anyway. The CPU clusters on a
> CCI-400 will be on slave interfaces 3 and 4, so try something like '-e
> CCI_400/cci400_si_rrq_hs_any,source=4/'.
> 
> The interrupts only matter for counter overflow, so confirming those could
> be done by picking a sufficiently frequent event, counting for long enough
> to capture slightly more than 2^32 of those, then seeing whether the
> overflow accumulates correctly or the count appears to go backwards (and/or
> checking what fired in /proc/interrupts). I believe the cycle counter is
> also 32-bit on CCI, so that should be relatively easy; for the other
> counters beyond the first one it should be feasible to schedule additional
> dummy events before the event of interest in order to trick
> pmu_get_event_idx() into allocating the desired counter for it.
> 
> Robin.
