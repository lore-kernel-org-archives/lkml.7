Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC13C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5520714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574464380;
	bh=CepkQuP21frhD3M5bGEH+wgBmtdg677AYKpabzXGDaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=be3LpiCOMYuTr8VtGupdnn+yXYxjmUIKUhSZi5neMn0HxiNA8p5DoQcY6cF6mrzUD
	 X+avfKBhgUFOQGzmrOZ2iYRakjO7whtB6YtacrGnTLB5/m7sCtGRxi1M4t1jPhC5tK
	 fr7XldggvdLatrBOSsJDgeqm9dx5JlZL4tJLbGVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKVXM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:12:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35214 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:12:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id a69so810038oib.2;
        Fri, 22 Nov 2019 15:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pZHd4qPrpkrRj44b+aSxMPOvNNYrcXJeIEXw3ri2jN4=;
        b=Bb1FPkatX5NGCnaDxZAUx1wwI7vIPoe+vbGHWk9XNQz2g64MpZWO7t7BA5XbinZWD+
         kGW6sO7+VlmObwdjDb3JzrtYNoUk2vN8IfaebCdu8f1uF196ioJFWkXwBDvwkvgoLT3+
         sGAN/dSbWcb7BK0/gwpDMH9cm/uvrC3gk+S+XD4RLnhEZYhF+/z9bWCyg57pdh6Iwtw0
         xOOrK3qECwI7flkMq1cIJME+1FxwTFEQE7vATbuPfaNseyYMrwZzAl/8ZexbykImn2UB
         VUt/mq5KRNb7ubDrZS+m7lvgKc7TQNUcRfhf5YOAT3AXurWPEGSFEg+gX1Et6i7UnpLH
         TDxw==
X-Gm-Message-State: APjAAAUQ/THYhd+ceA8+awXSPFtENMi6PriOWjad3yX7Y+2fGghHxLWF
        Al3f4cHWlMuxMldjXWzGQQ==
X-Google-Smtp-Source: APXvYqwgXP6YTLu7S+mWgbFuOGJ6V1p3IA54CB/JcxELWUEpCboW4PZofptTGtj8PAEOEyFvdSZyvA==
X-Received: by 2002:a05:6808:b13:: with SMTP id s19mr13964613oij.53.1574464378302;
        Fri, 22 Nov 2019 15:12:58 -0800 (PST)
Received: from localhost ([2607:fb90:bde:716a:c9ec:246b:67b7:9768])
        by smtp.gmail.com with ESMTPSA id y145sm2555787oia.21.2019.11.22.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:12:57 -0800 (PST)
Date:   Fri, 22 Nov 2019 17:12:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        robh+dt@kernel.org, jonathan@marek.ca, ohad@wizery.com,
        mark.rutland@arm.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 03/16] dt-bindings: remoteproc: qcom: Add Q6V5 Modem PIL
 binding for SC7180
Message-ID: <20191122231254.GA10382@bogus>
References: <20191118214250.14002-1-sibis@codeaurora.org>
 <0101016e807856d0-14dc2e21-4406-4150-8ffb-6982e37fc3cb-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e807856d0-14dc2e21-4406-4150-8ffb-6982e37fc3cb-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 21:43:20 +0000, Sibi Sankar wrote:
> Add a new modem compatible string for Qualcomm SC7180 SoCs and introduce
> the "qcom,halt-nav-regs" bindings needed by the modem sub-system running
> on SC7180 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/remoteproc/qcom,q6v5.txt         | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
