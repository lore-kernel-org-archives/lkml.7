Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8A92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553729196;
	bh=Kt5WhaLwvc84TMMwvo8c7AoPJ5DrQgfy1yzZHHEL83U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KrNB45Ahvvyg3xXrR/zDQj7lnz6z/v/MSlRnx6bFFp1S1/O+nrqIM7eh9fr0HURq1
	 73kIm3Htbo1Ae8OsPDf+wYt7fsTaCv1UG7pBn9HV7ZXNyMQtz73W3Vo6rHPPcV21h+
	 eiK0B4lNiN4peZHoKU7v8WBFL6eaUlHl7nozR6ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfC0X0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:26:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37480 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfC0X0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:26:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id c16so16609601otn.4;
        Wed, 27 Mar 2019 16:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQfbRX8EJp2T+hqOvLn/A6KiU4EtoBpG3kNcgNvy9lo=;
        b=FcRrxOfTcu9Fa5tO1V12kjxeUGc8pBOr+0ZWT1VAhWhrqpScVeR5Ws6uTdivKYYAZd
         QVyPUJdmJmFqS6ol7rDEtOj0or66kgD08fRFEiHjKYysNCNhj8X/oMkqfG1sLyH49QhH
         lF6QACNHiBqm9r6x6HIsnbncXTjPLD+k6PBVuHx8PltUcYflO8OEh2M6QOT5v8dhZYyO
         K4AI639K/j563OaiuK/2NZd68m3+SyUhpvHLVhv0Hek9anUMGMIH/lYwLW2e11YpDs7o
         7SSfRdqm5eioIP8nR/Oa2xC5mORjRrnHXy/zvbO0euvmQe6a7EMMlYVlVLAy4optltLo
         14+w==
X-Gm-Message-State: APjAAAWhLGia7gcTWMhmSH00w9N+BwBLV35NQZj4splC1DMZ4u9CPzB5
        SmEAts/PVP2Gv6WjXAQWIg==
X-Google-Smtp-Source: APXvYqwy2lumT29QcpPRNGiIrY2K1eEY32EIJ2An9+PqBhdHX10UmGJPHNpsKp9vLnp27qTgG/XgXQ==
X-Received: by 2002:a9d:7847:: with SMTP id c7mr18939604otm.164.1553729194150;
        Wed, 27 Mar 2019 16:26:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d34sm2328321otb.31.2019.03.27.16.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:26:33 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:26:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-qcs404: Add CDSP related clocks and resets
Message-ID: <20190327232632.GA26636@bogus>
References: <20190306055148.10823-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306055148.10823-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 09:51:48PM -0800, Bjorn Andersson wrote:
> Add the clocks and resets need in order to control the Turing
> remoteproc.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/clk/qcom/gcc-qcs404.c               | 90 +++++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-qcs404.h |  5 ++

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 95 insertions(+)
