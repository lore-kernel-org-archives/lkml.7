Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED73CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4E620828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kGbhfDb0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="imOPGdkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCZGSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:18:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36666 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZGSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:18:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B69D60E3E; Tue, 26 Mar 2019 06:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553581093;
        bh=y9Q2T9KjqES10fg88cgAwaPmNyiRR2VjzNBpap1Fvhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kGbhfDb0aQcouKDu34KUu20OCQ7bS4LnJ/i5q7b0lp4H2FgJ+mg/pp+VBTqeE8nyR
         eGnYzNCsvmcVTvolDKFhtlubVzOmJHjt+37mX0ZUZPG3J9g4+XsNxDz8xGOsrW0P97
         nAaEBCAYxu8NRY+DKYCuRxmv460iXSxrMsF1VjJk=
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05B7860E3E;
        Tue, 26 Mar 2019 06:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553581091;
        bh=y9Q2T9KjqES10fg88cgAwaPmNyiRR2VjzNBpap1Fvhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=imOPGdknXjcrrObSPbCPqHCOM9XFRH8toZUeuJBf1wi2J27pkbj+yRyloyzYej7Hm
         86NBd03Cr8BbYIMTH4lcJhaFAgnw6Ef1snjd/+tVnapI901dnBpW/mofz+mZMeRjp2
         A7/P1X7Pl7yLElBkOzhAEQvywUsWmd58oNc07lHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05B7860E3E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f51.google.com with SMTP id s16so433582edr.3;
        Mon, 25 Mar 2019 23:18:10 -0700 (PDT)
X-Gm-Message-State: APjAAAUB9upPkQxXl2BQPTGylGxLiqeTJeMpgbQNL3+SIyzJn0rWrd19
        j2GKKofcYcDz7Fzhs4ZHMEzIGW7l/JULtSguGWg=
X-Google-Smtp-Source: APXvYqxiM8SQiFh5zydnqLnseAafHRNFYZlDPwfVC7WnqTm8ViPRUMT4Zs7v0beQQV06fb/FSrUOySNBAcldprvRDbU=
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr16005659eje.247.1553581089693;
 Mon, 25 Mar 2019 23:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
 <20190206051335.23799-9-bjorn.andersson@linaro.org> <CAD=FV=UQwsKq1TujmmmR-OiSpMvUp_0b4Vi4Rh9TMGoKgkkkCQ@mail.gmail.com>
 <CAD=FV=Wr7nHWdQFC_+vs5-r_cBGKCsUNZ0mOMMTxdKPe56GUuQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Wr7nHWdQFC_+vs5-r_cBGKCsUNZ0mOMMTxdKPe56GUuQ@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 26 Mar 2019 11:47:58 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFTb2BeZqXfLXD+R7uo+r1oAYBHMrAWKOugtn91KwhwNg@mail.gmail.com>
Message-ID: <CAFp+6iFTb2BeZqXfLXD+R7uo+r1oAYBHMrAWKOugtn91KwhwNg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,


On Thu, Feb 28, 2019 at 2:34 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Feb 26, 2019 at 3:54 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Feb 5, 2019 at 9:13 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > From: Sibi Sankar <sibis@codeaurora.org>
> > >
> > > This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
> > >
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >
> > > Changes since v5:
> > > - None
> > >
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
> > >  1 file changed, 58 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index 560c16616ee6..5c41f6fe3e1b 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -1612,6 +1612,64 @@
> > >                         };
> > >                 };
> > >
> > > +               mss_pil: remoteproc@4080000 {
> > > +                       compatible = "qcom,sdm845-mss-pil";
> > > +                       reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
> > > +                       reg-names = "qdsp6", "rmb";
> >
> > I found that when I disabled IOMMU bypass by booting with
> > "arm-smmu.disable_bypass=y" that I'd get this failure:
> >
> > ---
> >
> > [   13.633776] qcom-q6v5-mss 4080000.remoteproc: MBA booted, loading mpss
> > [   13.647694] arm-smmu 15000000.iommu: Unexpected global fault, this
> > could be serious
> > [   13.660278] arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0
> > 0x00000000, GFSYNR1 0x00000781, GFSYNR2 0x00000000
> > ...
> > [   14.648830] qcom-q6v5-mss 4080000.remoteproc: MPSS header
> > authentication timed out
> > [   14.657141] qcom-q6v5-mss 4080000.remoteproc: port failed halt
> > [   14.664983] remoteproc remoteproc0: can't start rproc
> > 4080000.remoteproc: -110
> >
> > ---
> >
> > Adding "iommus = <&apps_smmu 0x781 0>;" here fixed my problem.  NOTE
> > that I'm no expert on IOMMUs so you should confirm that this is right,
> > but if it is then maybe you could include it in the next spin of the
> > series?  I got the "0x781" just by looking at the value of the GFSYNR1
> > in the above splat.  I wasn't sure what to put for the mask so I put
> > 0x0.
>
> Upon more testing the "iommus" line that I came up with avoids the
> global fault but doesn't actually work.  I just get:
>
> qcom-q6v5-mss 4080000.remoteproc: failed to allocate mdt buffer
>
> I'm hoping someone from Qualcomm can help out here and say how this
> should be solved.  Thanks!

I and Sibi had a chance to look at this, and we could compare things
with MTP sdm845
device as well.

From the 845 block diagram it's clear that one of the MPSS paths goes
through SMMU
and therefore we have the SIDs 0x780 - 0x783 reserved for these streams.
However, it is recommended to use them in a bypass mode (S2CR_TYPE_BYPASS).

On MTP devices, the secure code programs these SIDs in SMMU and, as these
SMRs are marked secure they are not visible to the kernel. Thus kernel wouldn't
overwrite anything.
However, in your case there's no such reservation by the secure code.
In such a case,
we may need to make SMMU aware of these SIDs in the kernel.

And please note that adding "iommus = <&apps_smmu 0x781 0>" to the PIL
device may not
be the correct thing to do, since actual MPSS data streams don't use the SMMU.
So, configuring DMA path via SMMU isn't right.

Thanks & regards
Vivek

>
>
> -Doug



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
