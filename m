Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B68C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE4222CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MryI/zTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfHUXCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:02:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35499 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbfHUXCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:02:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so2470134pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TmDOJvhPrJk/RAKywvPdX5bKVeeqGQtRvXF6G/yD7Ts=;
        b=MryI/zTQcpw1Y7z90icizIK6FBIzgHejqlorJGJcBuRYuCoQgZfYwz2SHvI14xthV2
         VGpADbJLiy9mh9zsJDWpjh39gVW8n7JdqtcVhowxOmr7akF1xhwC5PxJFMeJrxugq3PV
         8qfD2zsEa7wOrXG0R4PyQWoFwKtiN55x8GLWBrK/kooZEJ9mx5pEj75VZyULtSNPfMeQ
         XNjlA/MaESQuoz7S7VZN+l8AZPr2pu80HCZa4rTPHOlQLO93OyacnVz5IuLw/MdcHW23
         bV2XyPnr8orjJbyHvVyEBNnqjtwMCo5SxkCuUXp09n0F7I0hO0UmsrCggXybhKou3Lx4
         ASng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TmDOJvhPrJk/RAKywvPdX5bKVeeqGQtRvXF6G/yD7Ts=;
        b=lyefWVttVcIMcWf3GSdS663jROc5WNRUOOMxcgjD7jA9KW1nkfaeF2g93PCOUc2MS+
         CZ2Ip1ukL+Q0dmHlrMdHQYLUQCWVcKGcLNPPQq4+RST5GOomzcV+9JLPTF71w3Z5utWc
         xSdgadxorN9nveaQPRvTFeUpt1VYKoQ7FK88/0neIdpclxa25EtZpOpysINTY5TR6Bck
         uh4PmDCNuIyx2Uf/CdrfzrSjr7bPmYPsluqvXvtsPUAFgqHWhN+zyAF4QC+sCLoXJH1Q
         TYuREfLD0IZgcjILNfpZEQiRu2+AiYDyCgLDu7rmHLtYplOm61H34YtgjKLekonRuUxa
         v14Q==
X-Gm-Message-State: APjAAAWIX4JMQazMSh9A/agkLN7aZiHhiqH7hgil9zn4UwUpJ8/Jo074
        fH7fcKR70hirjv0NLVhKy/kjkQ==
X-Google-Smtp-Source: APXvYqxI+UkypCWR85p3O8GUubkvI6VHaPvdHe/3j4/MwZxP7+qRgAA8AxavnktcihBGMVXybm8JGA==
X-Received: by 2002:a62:7d93:: with SMTP id y141mr38186495pfc.164.1566428570694;
        Wed, 21 Aug 2019 16:02:50 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d189sm31101011pfd.165.2019.08.21.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 16:02:50 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:04:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] arm64: dts: qcom: sm8150: Add SM8150 DTS
Message-ID: <20190821230437.GC1892@tuxbook-pro>
References: <20190821184239.12364-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821184239.12364-1-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Aug 11:42 PDT 2019, Vinod Koul wrote:

> This series adds DTS for SM8150, PMIC PM8150, PM8150B, PM8150L and
> the MTP for SM8150.
> 

Applied, with Amit's acks.

> Changes in v4:
>  - Update the address and size cell to 2 and extend ranges and describe DMA
>    space
>  - Fix node location of spmi per sorted address
>  - Add Niklas's review tags
> 
> Changes in v3:
>  - Fix copyright comment style to Linux kernel style
>  - Make property values all hex or decimal
>  - Fix patch titles and logs and make them consistent
>  - Fix line breaks
> 
> Changes in v2:
>  - Squash patches
>  - Fix comments given by Stephen namely, lowercase for hex numbers,
>    making rpmhcc have xo_board as parent, rename pon controller to
>    power-on controller, make pmic nodes as disabled etc.
>  - removed the dependency on clk defines and use raw numbers
> 
> Vinod Koul (8):
>   arm64: dts: qcom: sm8150: Add base dts file
>   arm64: dts: qcom: pm8150: Add base dts file
>   arm64: dts: qcom: pm8150b: Add base dts file
>   arm64: dts: qcom: pm8150l: Add base dts file
>   arm64: dts: qcom: sm8150-mtp: Add base dts file
>   arm64: dts: qcom: sm8150-mtp: Add regulators
>   arm64: dts: qcom: sm8150: Add reserved-memory regions
>   arm64: dts: qcom: sm8150: Add apps shared nodes
> 
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/pm8150.dtsi    |  97 +++++
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi   |  86 +++++
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi   |  80 ++++
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 375 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 482 ++++++++++++++++++++++++
>  6 files changed, 1121 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8150.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8150b.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8150l.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150.dtsi
> 
> -- 
> 2.20.1
> 
