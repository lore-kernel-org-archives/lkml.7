Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A585C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738D62075B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="focYvhDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfJKX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:56:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33043 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfJKX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:56:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so6668348pgc.0;
        Fri, 11 Oct 2019 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B53cihCDlQEMDEXWkPSpWvvJvFe4J1DmTtw67eP/AR8=;
        b=focYvhDusq7k7Sglq+SIQ8pVkuU3dKBEqSJ35alrt50LvSHfrQWxNay7wgpupYLQSG
         6uMdheHpg/2DhAWDIuxvXJrcFjL9nUCd4pKzlZsiZvmX9JpRvn0SSA83m9DC5QNkJGaN
         04lt3hs9g6a/yr/VWcV+/5Z5hpkxBHrSsEzk0uvDU7SY8oIXGbSnX8+B6PVpLiLbsgrY
         zgf/0+fhrHM9kp14pAEz5SG59oEj85K0WxS/wqYKcHoJqNBCVFUMyO+u2fGQHK0Mjwvd
         i29oRue0YJI2wFfoJcUg4IRt9fqMeHklgvR/KLHGzXw8NnUbf7qro7qdHXTdQXX9ynJw
         xE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B53cihCDlQEMDEXWkPSpWvvJvFe4J1DmTtw67eP/AR8=;
        b=GlXt6VCSAJqb1isYmmPfvzorQIjdBRDMleNAnUSEVVHamc6BAOPf8eKsm7UJheTe23
         /rK6XjPJhZfpEqM4hSgH8tdVDBGjnpu0mxMBu99yvUPsM1Yg2Fw4O1VNWU0nC9mrrU/U
         laN3H7FW+V6JCvxDV0pxTWZTDFv2WNC2OnzQc4Lpgig6St/DkScIVfw+n/vsae+sD3Rv
         3Lm1w/a7qE5DfeZHoaVEhHpYFZiHDEd6zYvaKhMeoIgihqmp5zjfFPLWwDD4x6axpsVy
         grebanaamnSNt45WMr4emT9HXxgWsyeZGSX9tV94RKbnQzvBkChSp/8mVAKbk94wbdjC
         3vug==
X-Gm-Message-State: APjAAAX0WkxSJfKW7Kb0dn2KU2eDFUA3IPPT8SkFs4YyqGOpvzb1Qp4q
        uId0c3bnvDyoSAg0S+wwCyI=
X-Google-Smtp-Source: APXvYqykbanmhecTAUKKoCbXPpv7i5TVrqw+8GQSS1J+dImn1y1yvpKb9BgeUI0Fa24oEauLCUbPHw==
X-Received: by 2002:a62:d402:: with SMTP id a2mr19167165pfh.115.1570838158481;
        Fri, 11 Oct 2019 16:55:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g12sm16155270pfb.97.2019.10.11.16.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 16:55:58 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:55:25 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        will@kernel.org, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Add an optional "input-address-size"
 property
Message-ID: <20191011235524.GA20683@Asurada-Nvidia.nvidia.com>
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
 <e99e07c2-88c6-e4d8-af80-c46d36bc6cd0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99e07c2-88c6-e4d8-af80-c46d36bc6cd0@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:16:28AM +0100, Robin Murphy wrote:
> On 2019-10-11 4:46 am, Nicolin Chen wrote:
> > This series of patches add an optional DT property to allow an SoC to
> > specify how many bits being physically connected to its SMMU instance,
> > depending on the SoC design.
> 
> This has come up before, and it doesn't work in general because a single
> SMMU instance can have many master interfaces, with potentially different
> sizes of address bus wired up to each. It's also a conceptually-wrong
> approach anyway, since this isn't a property of the SMMU; it's a property of
> the interconnect(s) upstream of the SMMU.
> 
> IIRC you were working on Tegra - if so, Thierry already has a plan, see this
> thread:
> https://lore.kernel.org/linux-arm-kernel/20190930133510.GA1904140@ulmo/

Thanks for the reply and link!
