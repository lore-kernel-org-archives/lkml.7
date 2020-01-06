Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E1C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC56420731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578352237;
	bh=BkZKUX/cpoo7IJJEV3bZ+RToEQBlRYbggq0crq/6d2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o7t2rYf5S2zCU0HhhCs79NWCzlKmq9VlPTKVwblPfu1YKSHshuRiZz2tsoIE6w46i
	 jJw8OMAzh4cE53RdfUfZdn5e+GyFs4tlkeyNBzxPNjKPDnJ8Nsb65P568Ca3TBEVDz
	 Q0uWQPk6fwAG9k6YNKoOT4Ksbyq0Z0UfMl9bG88Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgAFXKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:10:36 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43438 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgAFXKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:10:36 -0500
Received: by mail-yb1-f194.google.com with SMTP id v24so22819995ybd.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 15:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+t1eROLK9g0HiqH07fHsSxCWd48TLqA6FF38j0G2gc=;
        b=QvPvKfU9KCPWNFecyIg0Zgd2SRgCQNNM9322v8uNUiM4BSiGftwOWv2QoBduUWDbOo
         g7ihoA9/LixlOfU6XBxwgfgWUPaumBGfjJCou3dqjLO+1MWHTpdiTJnM75UjODHUYBmu
         2qr686oNqCMY4a0P9A94j5M7Mk1xHj0MjPgpGwyqtblNB3odNFzIrFRUnUn9EHcq6Ug7
         yNmNxp52CEfzBv/xZ61RWyxdAhUBxEi3bJnxQvQUYsEqchAIqIzK3+QJEY6A22rVCjE5
         Q2NuRG+R+gdy4qGx5imIe+Dqrwoid1Qr3DIj0drrrvDfIdQLIw+PhnVoI0AE8qty9+wc
         BHvQ==
X-Gm-Message-State: APjAAAXe6G4McTBl47JtXRCv1LnpAIXh/IHWwA3cV47K0OoiE8Yc2U32
        GWl7pRXWJrwK50QnU2qLRRVdm0g=
X-Google-Smtp-Source: APXvYqysxpj1g8iYldNlywPZQ9sD1f9Pt98LPWbsi6wr6Duo31W0HztGeumerKJ7DKCGgz6AbfRrUQ==
X-Received: by 2002:a25:c42:: with SMTP id 63mr56039180ybm.375.1578352235164;
        Mon, 06 Jan 2020 15:10:35 -0800 (PST)
Received: from rob-hp-laptop ([172.58.110.146])
        by smtp.gmail.com with ESMTPSA id i127sm28202574ywe.65.2020.01.06.15.10.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 15:10:35 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 17:03:01 -0600
Date:   Mon, 6 Jan 2020 17:03:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manaf@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: tsens: Add configuration in
 yaml
Message-ID: <20200106230301.GA12602@bogus>
References: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org>
 <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 18:59:29 +0530, Rajeshwari wrote:
> Added configuration in dt-bindings for SC7180.
> 
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
