Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A6FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A572147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvnPv69I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfHFAnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:43:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34864 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHFAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:43:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so40514707pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 17:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYdLRgTiTaEkwq/TZiSUO5oNdUrDWrS4gd9VbuyJDUo=;
        b=GvnPv69IFmB8IbaiBxSwEQV1fHBf7SU1hwkpHMlc50QLHaOyjLr66lLyyM38C0J79N
         mpE1XCZqLxTuMwc3cV8Ar0Cont+PCeEsa3m0LWxyR2+53M4I2Iipbz4YDNseSUYzooRO
         eyHPPSKP5obgwPXnsG6ylgfLfhra7DOM+7ZLyn3lz7VR/9vWT9CokuTIzNHllRDFJpNx
         luF2MpOXq977b7svepj1TXTASABiVpHFlneXshw+msa8O0DKn4bZ53Ul4qQdr1KRBW/7
         4o0/3KDmR85hwK20eO1pQYUCawD9R4IKDLxHMbLPocX38FXDeIaSTrxOMqii0Lnf56nJ
         11dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYdLRgTiTaEkwq/TZiSUO5oNdUrDWrS4gd9VbuyJDUo=;
        b=SsG2kdy7zT2nlJpugGibiYeLqPectnBW51RS3Q54gadOMwfgOL9wAR+Io9U4Q026fS
         S4ZRCCHg0OnGShY84qtGRoI4ZVkeQeAaZy4hJGhT0OfUx6VvkgCgMrP0fHL101Y+4rGZ
         TKwimY1Mo+GZ62rgL46C4tq+rQu9I/bwaCUeWMztP7pAJF/foPs0oq9uzqpCwjU7WyYh
         fkrSyX3AdMmDs5/hRl7h9dPKgZeKJFfIgBpEavpn3WJzcBn9FpQtJVO5Avdiy79NPfIS
         dUmx4nnvslT/5wVYqNDXkFIeYj/Q/uleXnjiB+1LgNlLLdk7chz9Fv/TFfmq2CjZMOxr
         8mDQ==
X-Gm-Message-State: APjAAAV7lTZUXPknPHzt0y95Q6ILhpNN4Aa55Hr0kEUGHKXFc9agkYME
        8HQCDg4kbCFRigvGk9Tge4TR6w==
X-Google-Smtp-Source: APXvYqzCQBodSe3VDKyeCm490tzgbXCtdiUT0AQ4LzJiySaQAHLg+jvQQvHwg+w5hRZR21cl7KfYrA==
X-Received: by 2002:a17:90a:26e4:: with SMTP id m91mr395731pje.93.1565052225639;
        Mon, 05 Aug 2019 17:43:45 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z4sm132422580pfg.166.2019.08.05.17.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 17:43:44 -0700 (PDT)
Date:   Mon, 5 Aug 2019 17:43:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH] phy: qcom-qmp: Correct READY_STATUS poll break condition
Message-ID: <20190806004342.GD6470@builder>
References: <20190604232443.3417-1-bjorn.andersson@linaro.org>
 <619d2559-6d88-e795-76e0-3078236933ef@free.fr>
 <20190612172501.GY4814@minitux>
 <3570d880-2b76-88ae-8721-e75cf5acec4c@free.fr>
 <5b252fe6-9435-2aad-d0db-f6170a07b5e9@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b252fe6-9435-2aad-d0db-f6170a07b5e9@free.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Jul 08:50 PDT 2019, Marc Gonzalez wrote:

> On 13/06/2019 11:10, Marc Gonzalez wrote:
> 
> > Here are my observations for a 8998 board:
> > 
> > 1) If I apply only the readl_poll_timeout() fix (not the mask_pcs_ready fixup)
> > qcom_pcie_probe() fails with a timeout in phy_init.
> > => this is in line with your regression analysis.
> > 
> > 2) Your patch also fixes a long-standing bug in UFS init whereby sending
> > lots of information to the console during phy init would lead to an
> > incorrectly diagnosed time-out.
> > 
> > Good stuff!
> > 
> > Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> It looks like this patch fixed UFS, but broke PCIe and USB3 ^_^
> 
> qcom-qmp-phy 1c06000.phy: Registered Qcom-QMP phy
> qcom-qmp-phy c010000.phy: Registered Qcom-QMP phy
> qcom-qmp-phy 1da7000.phy: Registered Qcom-QMP phy
> 
> qcom-qmp-phy 1c06000.phy: BEFORE=000000a6 AFTER=000000a6
> qcom-qmp-phy 1c06000.phy: phy initialization timed-out
> phy phy-1c06000.phy.0: phy init failed --> -110
> qcom-pcie: probe of 1c00000.pci failed with error -110
> 
> qcom-qmp-phy 1da7000.phy: BEFORE=00000040 AFTER=0000000d
> 
> qcom-qmp-phy c010000.phy: BEFORE=69696969 AFTER=b7b7b7b7
> qcom-qmp-phy c010000.phy: phy initialization timed-out
> phy phy-c010000.phy.1: phy init failed --> -110
> dwc3 a800000.dwc3: failed to initialize core: -110
> dwc3: probe of a800000.dwc3 failed with error -110
> 
> 
> Downstream code for PCIe is:
> 
> static bool pcie_phy_is_ready(struct msm_pcie_dev_t *dev)
> {
> 	if (dev->phy_ver >= 0x20) {
> 		if (readl_relaxed(dev->phy + PCIE_N_PCS_STATUS(dev->rc_idx, dev->common_phy)) &	BIT(6))
> 			return false;
> 		else
> 			return true;
> 	}
> 
> 	if (!(readl_relaxed(dev->phy + PCIE_COM_PCS_READY_STATUS) & 0x1))
> 		return false;
> 	else
> 		return true;
> }
> 
> AFAICT:
> PCIe and USB3 QMP PHYs are ready when PHYSTATUS=BIT(6) goes to 0.
> But UFS is ready when PCS_READY=BIT(0) goes to 1.
> 
> 
> Can someone verify that USB3 is broken on 845 with 885bd765963b?
> 

Both USB3 and PCIe still works for me on 845, but you are correct;
PHYSTATUS is ready low, while PCS_READY is ready high.

I posted a patch that attempts to clean up the differences, please give
it a spin (and review).

Regards,
Bjorn
