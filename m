Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A0BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AE82085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WXPNfFc7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jQKSqoT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfFZGdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:33:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZGdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:33:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 044406085C; Wed, 26 Jun 2019 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561530797;
        bh=y47EEs3j4rFzzvuVXrP3J8qbvCWGuKExlUyEKd82I3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WXPNfFc7x8o1APQwf2+yUaKgztd49KbSbqeJuRMssVZUx0iomT0YMLRYC13NC5GLJ
         Ro+GVuouTTYIJ797GZL6qLuxapN54wXlOhY1MHI3OWXLLoq5Kg5OLyn47dxZuqt4qz
         iUIFRybXuErG0sEBvtHyyS95+DGdqCoSm4sLg8kQ=
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FB076021C;
        Wed, 26 Jun 2019 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561530796;
        bh=y47EEs3j4rFzzvuVXrP3J8qbvCWGuKExlUyEKd82I3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jQKSqoT+OGc8qK8Cb0iV+ye/w4DWERiv1kTftNL9AIgnn//NI911jxMDig+YJht0O
         YnwT3aDe/XWiP+7Mr36XIL10jnMh3o3aEXDtUm79gOIG39ZLp/q1WVMrtYj0EtvkMO
         3TUP3A5gdmO2R+drNSNvRhjCPL9n1GCgI0NboenE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FB076021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f42.google.com with SMTP id k8so1553038edr.11;
        Tue, 25 Jun 2019 23:33:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWG+ZAZzmRPGYjKkQ7vBlmFPSmz2hCtRO7TAkmlEJs0UFqc/6dp
        a4SFonCIT49qeWlxfPEnYFHKH+NZmvWNDBpJSxc=
X-Google-Smtp-Source: APXvYqzcofv0J7lRvmc0VYLV63Qeh9E/WHjj9IAHvvhUT2XF9QKRxQkifiF3lHlmVsEOxNk/acWViwQ7ifuOVtKvPYA=
X-Received: by 2002:a17:906:6582:: with SMTP id x2mr2509409ejn.2.1561530795089;
 Tue, 25 Jun 2019 23:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
 <20190612071554.13573-4-vivek.gautam@codeaurora.org> <20190614040520.GK22737@tuxbook-pro>
 <3e1f5e03-6448-8730-056d-fc47bdd71b3f@codeaurora.org> <20190618175218.GH4270@fuggles.cambridge.arm.com>
 <CAFp+6iEynLa=Jt_-oAwt4zmzxzhEXtWNCmghz6rFzcpQVGwrMg@mail.gmail.com>
 <20190624170348.7dncuc5qezqeyvq2@willie-the-truck> <CAFp+6iF0TQtAy2JFXk6zjX5GpjeLFesqPZV6ezbDXmc85yvMEA@mail.gmail.com>
 <20190625133924.fqq3y7p3i3fqem5p@willie-the-truck>
In-Reply-To: <20190625133924.fqq3y7p3i3fqem5p@willie-the-truck>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 26 Jun 2019 12:03:02 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH-KzX7x1j8AAuKJcOP6v=fyP-yLvaeeE_Ly3oueu_ngg@mail.gmail.com>
Message-ID: <CAFp+6iH-KzX7x1j8AAuKJcOP6v=fyP-yLvaeeE_Ly3oueu_ngg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu: Add support to handle Qcom's
 wait-for-safe logic
To:     Will Deacon <will@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 7:09 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 12:34:56PM +0530, Vivek Gautam wrote:
> > On Mon, Jun 24, 2019 at 10:33 PM Will Deacon <will@kernel.org> wrote:
> > > Instead, I think this needs to be part of a separate file that is maintained
> > > by you, which follows on from the work that Krishna is doing for nvidia
> > > built on top of Robin's prototype patches:
> > >
> > > http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/smmu-impl
> >
> > Looking at this branch quickly, it seem there can be separate implementation
> > level configuration file that can be added.
> > But will this also handle separate page table ops when required in future.
>
> Nothing's set in stone, but having the implementation-specific code
> constrain the page-table format (especially wrt quirks) sounds reasonable to
> me. I'm currently waiting for Krishna to respin the nvidia changes [1] on
> top of this so that we can see how well the abstractions are holding up.

Sure. Would you want me to try Robin's branch and take out the qualcomm
related stuff to its own implementation? Or, would you like me to respin this
series so that you can take it in to enable SDM845 boards such as, MTP
and dragonboard to have a sane build - debian, etc. so people benefit
out of it.
Qualcomm stuff is lying in qcom-smmu and arm-smmu and may take some
time to stub out the implementation related details.
Let me know your take.

Thanks & regards
Vivek

>
> I certainly won't merge the stuff until we have a user.
>
> Will
>
> [1] https://lkml.kernel.org/r/1543887414-18209-1-git-send-email-vdumpa@nvidia.com
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
