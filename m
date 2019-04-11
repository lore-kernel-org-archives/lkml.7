Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D782184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY4dI24q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDKIum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:50:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53808 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:50:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so5625787wmj.3;
        Thu, 11 Apr 2019 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUls/Mdz2EbuO9V2IYxfdCRwSf3lMyk3/DyeGY8XXbI=;
        b=eY4dI24qAodV6veKa1cAq11Ls3OlWflsfw97EoOIaZ5dQfzpjEfxoPsr6f1odDbvur
         QQygbPuOERpk60P0yQcL7deULb6QkvZFGtWt6C1Ex6AGNcR6zBYYlFsAWvfqPprPZRh0
         55EcT2c1FJDwuQC9NI56w1NHmRnjJ+bYWZvABq/qf6/mHBMWk3HZqZIOKC4IKYHzbQbx
         bhLE1EyOPyEe8S+94dniu0r67KowrLoaqRsu4stVNNKpmopKWuKpdOrVfBRKDh5GNjbm
         runGA089jkdb28N4clQ5naYP87hUApkDyvHH21cb6VJqcTY0hfJONQ5yX00L7pJtp3hA
         /c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUls/Mdz2EbuO9V2IYxfdCRwSf3lMyk3/DyeGY8XXbI=;
        b=seAtHIXSW/VZEXC9n27Z1fnqUz8KlR/Yrh1bUO7hzmXkl2/swiDDkYeLmaYiOYdnAB
         3AQrJ2kU0BOkqdCsxdy70f2G/dt3HcmqMvGW1uOb8YSZsZ5OYsD1JJ810xONdtM1LrNb
         zFLuiDu6s5kijHO8CzWA9weitTgLA/m/bP3s3yTrPLWfa7LmH9AlMTXYE4nG0DaWtlPq
         T6kmVQt+zVp7vpxsO0rNBBA8wu2EF5q3Tafm5Qyqw8qC/j2rNkUMu1Gr+lGm7GvD882x
         GFAvTm7yRDiVUn/3OVqdjhxPsGvb9hlSL4GiaX/4SOcNDwkxk/6wg/PObUMPb2xVQHu6
         +MSA==
X-Gm-Message-State: APjAAAVmGIaAfPDAN1qt4zsK/0XIBxlYSy7LeGlvq5QNCr+q5+CGMM9i
        P/Up4F5KNjhGJkee8OpTV8KRpur9Qjs=
X-Google-Smtp-Source: APXvYqw+NXkgJ8XpanRLF26Bk4R25mqqDO8gHKdMFZ+gM23jliWVB7SRL4PDJ9r8HM9lLibe9YyYGg==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr5978866wmj.37.1554972638724;
        Thu, 11 Apr 2019 01:50:38 -0700 (PDT)
Received: from macpro-scc.lancs.ac.uk (inc028000049.lancs.ac.uk. [148.88.224.78])
        by smtp.gmail.com with ESMTPSA id g10sm30038182wrq.2.2019.04.11.01.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 01:50:38 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:50:37 +0100
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH RFC 8/8] ARM: dts: exynos: Add ASV tables for
 exynos5422/5800
Message-ID: <20190411085037.c7ksjbxhx2zulr2w@macpro-scc.lancs.ac.uk>
References: <CGME20190404172257epcas1p20d789242a2353dc8e9ffd7f435dc5eee@epcas1p2.samsung.com>
 <20190404171735.12815-1-s.nawrocki@samsung.com>
 <20190404171735.12815-9-s.nawrocki@samsung.com>
 <CANAwSgTPeSZS_Tcy2ucO5OUQjoY1ta5+7TpAer1CHV2tQTOcrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgTPeSZS_Tcy2ucO5OUQjoY1ta5+7TpAer1CHV2tQTOcrw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

I'm using this frequencies on the board since 3 years, without any stability
issues. The kind of worklaod used is intensive CPU-bound benchmarks running 
for 20 mins at least in order to stress the system, I'm studying schedulability
under high thermal constraints.

So, I would say these frequencies are safe by experience.

Best Regards,
Willy


On Thu, Apr 11, 2019 at 01:09:04PM +0530, Anand Moon wrote:
> Hi Sylwester,
> 
> As per my knowledge HK soc introduce this table to support
> overclocking of cpufreq for Odroid XU3 XU4 family for boards.
> 
> ARM Cortex-A15 Quad CPU (Eagle) 1800 to 2000
> ARM Cortex-A7 Quard CPU (Kingfisher) 1400 to 1500
> 
> For Exynos5422  below table
> asv-table-[0-3]  AVS range from 200 to 2100
> asv-table-[100-103] AVS range from 200 to 1500.
> 
> Are these setting stable for this board to cover clock the cpu now.
> 
> Can you also enable support for this clk-exynos5420.c
> For example exynos5800_eglclk_d and exynos5420_kfcclk_d table.
> 
> Also can you update exynos5420.dtsi  following opp table
> For example cluster_a15_opp_table and cluster_a7_opp_table opt binding.
> 
> To make this work synchronously with AVS.
> 
> Best Regards
> -Anand
> 
> On Thu, 4 Apr 2019 at 22:55, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> >
> > This patch ASV (Adaptive Supply Voltage) table entries for
> > Exynos5422/5800 SoC.
> >
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos5.dtsi    |   2 +-
> >  arch/arm/boot/dts/exynos5800.dtsi | 207 ++++++++++++++++++++++++++++++
> >  2 files changed, 208 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> > index 67f9b4504a42..22eb951c614c 100644
> > --- a/arch/arm/boot/dts/exynos5.dtsi
> > +++ b/arch/arm/boot/dts/exynos5.dtsi
> > @@ -35,7 +35,7 @@
> >                 #size-cells = <1>;
> >                 ranges;
> >
> > -               chipid@10000000 {
> > +               chipid: chipid@10000000 {
> >                         compatible = "samsung,exynos4210-chipid";
> >                         reg = <0x10000000 0x100>;
> >                 };
> > diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
> > index 57d3b319fd65..5358865f5c0b 100644
> > --- a/arch/arm/boot/dts/exynos5800.dtsi
> > +++ b/arch/arm/boot/dts/exynos5800.dtsi
> > @@ -16,6 +16,213 @@
> >         compatible = "samsung,exynos5800", "samsung,exynos5";
> >  };
> >
> > +&chipid {
> > +       asv {
> > +               compatible = "samsung,exynos-asv-v1";
> > +               asv-table-0 {
> > +                       /* ARM 0, 1 */
> > +                       samsung,asv-table-size = <20 15>;
> > +                       samsung,asv-table-id = <0x0>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12   ASV13 */
> > +                               <2100 1362500 1362500 1350000 1337500 1325000 1312500 1300000 1275000 1262500 1250000 1237500 1225000 1212500 1200000>,
> > +                               <2000 1312500 1312500 1300000 1287500 1275000 1262500 1250000 1237500 1225000 1237500 1225000 1212500 1200000 1187500>,
> > +                               <1900 1250000 1237500 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1162500 1150000 1137500 1125000 1112500>,
> > +                               <1800 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1112500 1100000 1087500 1075000 1062500>,
> > +                               <1700 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1075000 1062500 1050000 1037500 1025000>,
> > +                               <1600 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1037500 1025000 1012500 1000000  987500>,
> > +                               <1500 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500 1000000  987500  975000  962500  950000>,
> > +                               <1400 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  975000  962500  950000  937500  925000>,
> > +                               <1300 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  962500  950000  937500  925000  912500>,
> > +                               <1200 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  937500  925000  912500  900000  900000>,
> > +                               <1100 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000>,
> > +                               <1000  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 900  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 800  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                    /* ASV0...13 */
> > +                       samsung,asv-common-data = <700 900000>,
> > +                                                 <600 900000>,
> > +                                                 <500 900000>,
> > +                                                 <400 900000>,
> > +                                                 <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +               asv-table-2 {
> > +                       /* ARM 2 */
> > +                       samsung,asv-table-size = <20 15>;
> > +                       samsung,asv-table-id = <0x2>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12  ASV13 */
> > +                               <2100 1362500 1362500 1350000 1337500 1325000 1312500 1300000 1275000 1262500 1250000 1237500 1225000 1212500 1200000>,
> > +                               <2000 1312500 1312500 1312500 1300000 1275000 1262500 1250000 1237500 1225000 1237500 1225000 1212500 1200000 1187500>,
> > +                               <1900 1262500 1250000 1250000 1237500 1212500 1200000 1187500 1175000 1162500 1175000 1162500 1150000 1137500 1125000>,
> > +                               <1800 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1125000 1112500 1100000 1087500 1075000>,
> > +                               <1700 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1087500 1075000 1062500 1050000 1037500>,
> > +                               <1600 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1050000 1037500 1025000 1012500 1000000>,
> > +                               <1500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000 1012500 1000000  987500  975000  962500>,
> > +                               <1400 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  987500  975000  962500  950000  937500>,
> > +                               <1300 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  962500  950000  937500  925000  912500>,
> > +                               <1200 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  937500  925000  912500  900000  900000>,
> > +                               <1100 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000>,
> > +                               <1000  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 900  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 800  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                    /* ASV0...13 */
> > +                       samsung,asv-common-data = <700 900000>,
> > +                                                 <600 900000>,
> > +                                                 <500 900000>,
> > +                                                 <400 900000>,
> > +                                                 <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +               asv-table-3 {
> > +                       /* ARM 3 */
> > +                       samsung,asv-table-size = <20 15>;
> > +                       samsung,asv-table-id = <0x3>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12  ASV13 */
> > +                               <2100 1362500 1362500 1350000 1337500 1325000 1312500 1300000 1275000 1262500 1250000 1237500 1225000 1212500 1200000>,
> > +                               <2000 1312500 1312500 1300000 1287500 1275000 1262500 1250000 1237500 1225000 1237500 1225000 1212500 1200000 1187500>,
> > +                               <1900 1262500 1250000 1237500 1225000 1212500 1200000 1187500 1175000 1162500 1175000 1162500 1150000 1137500 1125000>,
> > +                               <1800 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1125000 1112500 1100000 1087500 1075000>,
> > +                               <1700 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1087500 1075000 1062500 1050000 1037500>,
> > +                               <1600 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1050000 1037500 1025000 1012500 1000000>,
> > +                               <1500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000 1012500 1000000  987500  975000  962500>,
> > +                               <1400 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  987500  975000  962500  950000  937500>,
> > +                               <1300 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  962500  950000  937500  925000  912500>,
> > +                               <1200 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  937500  925000  912500  900000  900000>,
> > +                               <1100 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000>,
> > +                               <1000  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 900  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 800  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                    /* ASV0...13 */
> > +                       samsung,asv-common-data = <700 900000>,
> > +                                                 <600 900000>,
> > +                                                 <500 900000>,
> > +                                                 <400 900000>,
> > +                                                 <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +
> > +               asv-table-4 {
> > +                       /* ARM BIN2 */
> > +                       samsung,asv-table-size = <17 15>;
> > +                       samsung,asv-table-id = <0x4>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12  ASV13 */
> > +                               <1800 1237500 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1150000 1137500 1125000 1112500 1100000>,
> > +                               <1700 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1112500 1100000 1087500 1075000 1062500>,
> > +                               <1600 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1075000 1062500 1050000 1037500 1025000>,
> > +                               <1500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1037500 1025000 1012500 1000000 987500>,
> > +                               <1400 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000 1012500 1000000 987500  975000  962500>,
> > +                               <1300 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000 987500  1000000 987500  975000  962500  950000>,
> > +                               <1200 1062500 1050000 1037500 1025000 1012500 1000000 987500  975000  962500  975000  962500  950000  937500  925000>,
> > +                               <1100 1037500 1025000 1012500 1000000 987500  975000  962500  950000  937500  950000  937500  925000  912500  900000>,
> > +                               <1000 1012500 1000000  987500  975000 962500  950000  937500  925000  912500  925000  912500  900000  900000  900000>,
> > +                               < 900  987500  975000  962500  950000 937500  925000  912500  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 800  962500  950000  937500  925000 912500  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 700  937500  925000  912500  900000 900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                      /* ASV0...13 */
> > +                       samsung,asv-common-data = <600 900000>,
> > +                                                 <500 900000>,
> > +                                                 <400 900000>,
> > +                                                 <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +
> > +
> > +               asv-table-100 {
> > +                       /* KFC 0, 1 */
> > +                       samsung,asv-table-size = <14 15>;
> > +                       samsung,asv-table-id = <0x100>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12  ASV13 */
> > +                               <1500 1300000 1300000 1300000 1287500 1287500 1287500 1275000 1262500 1250000 1237500 1225000 1212500 1200000 1187500>,
> > +                               <1400 1275000 1262500 1250000 1237500 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500>,
> > +                               <1300 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500>,
> > +                               <1200 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500>,
> > +                               <1100 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000>,
> > +                               <1000 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500>,
> > +                               < 900 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000>,
> > +                               < 800 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000>,
> > +                               < 700  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 600  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 500  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                     /* ASV0...13 */
> > +                       samsung,asv-common-data = <400 900000>,
> > +                                                 <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +
> > +               asv-table-102 {
> > +                       /* KFC 2 */
> > +                       samsung,asv-table-size = <14 15>;
> > +                       samsung,asv-table-id = <0x102>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12  ASV13 */
> > +                               <1500 1300000 1300000 1300000 1287500 1287500 1287500 1275000 1262500 1250000 1237500 1225000 1212500 1200000 1187500>,
> > +                               <1400 1275000 1262500 1250000 1237500 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500>,
> > +                               <1300 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500>,
> > +                               <1200 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500>,
> > +                               <1100 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000>,
> > +                               <1000 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500>,
> > +                               < 900 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000>,
> > +                               < 800 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000>,
> > +                               < 700  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 600  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 500  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                     /* ASV0...13 */
> > +                       samsung,asv-common-data = <400 900000>,
> > +                                                 <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +
> > +               asv-table-103 {
> > +                       /* KFC 3 */
> > +                       samsung,asv-table-size = <14 15>;
> > +                       samsung,asv-table-id = <0x103>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12  ASV13 */
> > +                               <1500 1300000 1300000 1300000 1287500 1287500 1287500 1275000 1262500 1250000 1237500 1225000 1212500 1200000 1187500>,
> > +                               <1400 1275000 1262500 1250000 1237500 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500>,
> > +                               <1300 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500>,
> > +                               <1200 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500>,
> > +                               <1100 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000>,
> > +                               <1000 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500>,
> > +                               < 900 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000>,
> > +                               < 800 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000>,
> > +                               < 700  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 600  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 500  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                     /* ASV0...13 */
> > +                       samsung,asv-common-data = <400 900000>,
> > +                                                 <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +
> > +               asv-table-104 {
> > +                       /* KFC BIN2 */
> > +                       samsung,asv-table-size = <12 15>;
> > +                       samsung,asv-table-id = <0x104>;
> > +                       samsung,asv-data =
> > +                                     /* ASV0  ASV1    ASV2    ASV3    ASV4    ASV5    ASV6    ASV7    ASV8    ASV9    ASV10   ASV11   ASV12  ASV13 */
> > +                               <1300 1250000 1237500 1225000 1212500 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500>,
> > +                               <1200 1200000 1187500 1175000 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500>,
> > +                               <1100 1162500 1150000 1137500 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000>,
> > +                               <1000 1125000 1112500 1100000 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500>,
> > +                               < 900 1087500 1075000 1062500 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000>,
> > +                               < 800 1050000 1037500 1025000 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000>,
> > +                               < 700 1012500 1000000  987500  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000>,
> > +                               < 600  975000  962500  950000  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 500  937500  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>,
> > +                               < 400  925000  912500  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000  900000>;
> > +                                                     /* ASV0...13 */
> > +                       samsung,asv-common-data = <300 900000>,
> > +                                                 <200 900000>;
> > +               };
> > +       };
> > +};
> > +
> >  &clock {
> >         compatible = "samsung,exynos5800-clock";
> >  };
> > --
> > 2.17.1
> >
