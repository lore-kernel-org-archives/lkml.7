Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D082C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7EA217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563839660;
	bh=plLm20qXc03QTGp6Rcu7R2IU81uZ2myinltsj1fm7l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nc6D/4gHAs8/1KEk86eTDNevzRVBVLK9+7LHoAFv3qiTvZ6pow/pL7GW7Q7Cv7Fml
	 bJbGCLqp2Ck0N8nhmzggtUqp2u7TfIQ8LQjti7q7O+qRbz0Q7tPiPTVyB8RXTndT09
	 clxSM+/QOtKEtvRQicnZO1lI+E+Xyqv6yxrSLqWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbfGVXyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:54:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35442 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfGVXyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:54:14 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so77968344ioo.2;
        Mon, 22 Jul 2019 16:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3nDpavAXEWgNVl6Sk1jx2h/Nm7wVxk6Q4nHCU/rUxqU=;
        b=Hw1HxgwswDTeIMJjEaUBxKNZRVf6K8/M5VoR6UC8SglyKcmZpb1n2UATUYhfCO7b2L
         ua8lXPd3gH2kjAI93622PSQ8PzZp1C0JwdYVhX0A2fVxVpNgZ1Y+szBygfWwwhMF90Fp
         EdAMi1/Qiv3wiKBU5u/0hRjldhGqrYnph4i06WpmDZqB2x5C8G1v3AkafYYi2I2iMRDR
         kCvBbY9gx2zLchZBkzG9cdSe+eJxq+EoLwIFHoZMRVVdpfSEEi903tVs6GEWQFjfQ1mR
         6SBsPGIFaeTbR04dW29vXZ7MEU2KK0SvInlaQC656s8EFxVCAqeagZr7Mg+Dg4ueHqwa
         W6fQ==
X-Gm-Message-State: APjAAAURTy+Nx37BEyNuSEwQTxw1Ac3kV2b0QmUSjkn5KNJrrViNcvK6
        W1l49aA+7kxAF6+Zkc1E+Q==
X-Google-Smtp-Source: APXvYqxn4QaTx3LWjksHATeP2k+L0qFydE43WGakM7TNZ86jroqPmVi5rppxcD2cbLn0NIXyU/riTQ==
X-Received: by 2002:a6b:6d08:: with SMTP id a8mr59973963iod.191.1563839653198;
        Mon, 22 Jul 2019 16:54:13 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id q13sm37476258ioh.36.2019.07.22.16.54.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:54:12 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:54:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        ping.bai@nxp.com, olof@lixom.net, maxime.ripard@bootlin.com,
        jagan@amarulasolutions.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        marcin.juszkiewicz@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/4] dt-bindings: thermal: imx8mm-thermal: Add binding
 doc for i.MX8MM
Message-ID: <20190722235411.GA32006@bogus>
References: <20190704091313.9516-1-Anson.Huang@nxp.com>
 <20190704091313.9516-2-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704091313.9516-2-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Jul 2019 17:13:10 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add thermal binding doc for Freescale's i.MX8MM Thermal Monitoring Unit.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx8mm-thermal.txt        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
