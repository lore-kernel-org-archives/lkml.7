Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25637C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0083206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJBufUdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfC0GRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:17:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43394 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfC0GRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:17:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so3155730pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5go5OgNTkr9kwYSngNUXmNBPaME9TqXKw/IYsgh97w8=;
        b=kJBufUdYlQ9e+0ElY3qYCQdDQQ8N66kwdgsAs9OAxBkflvdEy4CS8i30t1HCiKpOFt
         9nZgew5YDkxz0Yjb6Pgji4Exu5ZCE3gtAU/5vYSXYiJf4hUwo6oiUgcR81O8iBnIGsWa
         6yy+WY7dnnqphytQNK0pw/h9abpggoC1/YO6pDE87VzwrwRbuO5UJrw+M9YRlasMaDEX
         DLR2H9DWIrGeXK3nIvieOwjrIX1UXtlhyiuQ2M9dsGjt6YQpexDx16Z2Q76Bgir9OSvy
         +4tcl7pJvUFYRhdeX5ceQj4JpehvmujkkrFTUIkYeGmO0GuKBkxaRL/Al41XbejA5f03
         SWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5go5OgNTkr9kwYSngNUXmNBPaME9TqXKw/IYsgh97w8=;
        b=delPHZrm342GLOFv+XYaUGywWJEFfjUpPKXvuMsegOhvF0rLoRhW/N+JJp1+SFE/Dz
         RxyyMl4N1F/YDI94KvoNjeR8lzeS8XMKaNG3kpklLPicQ0L5sWEPlU3kKzkfXiqeFTyd
         IHz+AcHARbCS2FseeoC0bsvVvH/szHa2x4zn4Ed+f5rxaNI3UplW4aIw4e0Iy5Y+lTCZ
         We+EiSvKuCqEl5F7ndhAo+8Zw6Z+CmqoguZBikMT1Gch2H2OhqHeQ3lvvXnCCfWHo75j
         q8BEdgSlo/NT4VjYOnjI84A0iZXsSaN8t5Gy8l981lwQEbr/KMOFDmIRKRxs7Vu9RV3g
         x3GQ==
X-Gm-Message-State: APjAAAUW0pMdlBUInNoggMWgy3XGi3Az3BV9x150QOCam5YBPnjpp9pf
        okSN4g7YhK1V70W3vd3YC7wn2A==
X-Google-Smtp-Source: APXvYqwotSRzPnVrr4Ld14luyLFWvYh4edOMxBZzUHh1yVHvqQXI5sp2rE4HiAMMAdlWsZmDZKKrew==
X-Received: by 2002:a63:94:: with SMTP id 142mr32775762pga.277.1553667420090;
        Tue, 26 Mar 2019 23:17:00 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i16sm29972304pgk.51.2019.03.26.23.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:16:58 -0700 (PDT)
Date:   Tue, 26 Mar 2019 23:16:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 0/3] UFS on APQ8098/MSM8998
Message-ID: <20190327061656.GL27005@builder>
References: <43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Feb 04:16 PST 2019, Marc Gonzalez wrote:

> Hello,
> 
> This series adds support for the UFS host controller on APQ8098/MSM8998-based boards.
> 
> This should be the final rev ;-)
> 
> Differences between v4 and v5:
> - Drop patches that have already been accepted or spun off
> 
> Differences between v3 and v4:
> - Rebase on top of -next
> - Pick up Douglas Anderson's UFSHC doc fix
> - Document 8998 UFSHC binding
> - Improve UFS PHY binding doc
> - Put the UFS DT patch at the end of the series
> 
> Difference between v2 and v3:
> - Add qcom,msm8998-qmp-ufs-phy compat string and match it in the PHY driver
> - Drop vdd-hba-fixed-regulator
> - Write the reg addresses with full 32-bit width
> - Set regulator-allow-set-load only on the 3 rails used by UFS.
> - Revert the patch introducing ufshcd_set_vccq_rail_unused
> 
> Difference between v1 and v2:
> - New patch to add 'regulator-allow-set-load' prop to all vreg nodes
> - Rename rpmcc node to 'clock-controller' + Add Review tags
> - Drop UFS pinctrl gymnastics (not required, probably left enabled in bootloader)
> - Delete GCC_UFS_ICE_CORE_CLK (ICE not used upstream, I think)
> - Fix sizes of ufsphy register areas based on Jeffrey's feedback
> - Hack ufshcd_set_vccq_rail_unused into a NOP to work around lock up + reboot
> 
> 
> Marc Gonzalez (3):
>   dt-bindings: ufs: Add msm8998 compatible string
>   arm64: dts: qcom: msm8998: Allow UFSHC driver to set-load
>   arm64: dts: qcom: msm8998: Add UFS nodes
> 

Picked up with Lee's tested-by.

Thanks,
Bjorn

>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  1 +
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 22 +++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         | 65 +++++++++++++++++++
>  3 files changed, 88 insertions(+)
> 
> -- 
> 2.17.1
