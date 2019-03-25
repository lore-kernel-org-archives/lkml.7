Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F84BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F6220848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553546501;
	bh=qlQCobJ74kOPN+Cm8uF1hboYXh3wtgSJO0mT+BUAtbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ItKVytDhk761/E852ZnDA2VpvbWHSQNl1KOXmu31Yh+/Uu3cXrcuPEibRpycX+x66
	 vtF4vB+nn5loVuLQf8wlvRG8E84xUAEX6Sj4maRIBbZd2YkirO++PJ1FYU+9yBVrHk
	 F1s670bnjKYRsfa/GNJBYKt1hbRV4YRdtqXx+CCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfCYUlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:41:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42223 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYUlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:41:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so9374312otd.9;
        Mon, 25 Mar 2019 13:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEIJhCnowKLc/qicSXjeqbetwjwoYIXGmrRiububEYk=;
        b=Mt3hoBY03+k/TQshaSwQIbVZjyCtoJFjyZuabpDsym8j4lGPRZRufAfxhvj0QLCmb8
         xzVn81UOxsZbhaEWoSdpFLz7xfAgSXhKzQAMBLhIg1ZkbJqE6u+OyGC7uHQQ0HTJ4L60
         zqYOeo3bxRWU3oA0wNianWpnBnuqBA8sp9BJdiYQhvbgcgD5o9Cw2zW1pXl0T/RISOHu
         c9gFCgMOjcI9Pe2Qal4Yl9v1g3jbru82mnQt5CCZ7DPZ9RjwVfqobM7CeD0jxuHTN8pK
         +PtzZ+sGuNSi3XdgNJe5guc6ZxII9AgnJrNWmNTodXhRT9tR4VVhoFICNQM8jdodNALX
         KOkg==
X-Gm-Message-State: APjAAAVSiqiTCxZK9gVxVBycAauej9LdrAw5JkeR3swLtETv/vWXErn+
        c05EOK22yxBpkmquw8+juA==
X-Google-Smtp-Source: APXvYqzSJGrHZ2NkjOEPbZxuVCO4Yu6oCV27GouPiU2sH3gieBY8W3lKwTmUJrIcqFBfEW4Cq2z9lA==
X-Received: by 2002:a05:6830:15d2:: with SMTP id j18mr17759913otr.37.1553546498398;
        Mon, 25 Mar 2019 13:41:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e186sm6774151oia.44.2019.03.25.13.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 13:41:37 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:41:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V9 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Message-ID: <20190325204137.GA19824@bogus>
References: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
 <1553218974-20464-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553218974-20464-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:48:05AM +0000, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.

v9? I don't recall seeing any previous versions.

> ---
>  .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> new file mode 100644
> index 0000000..94f1ad5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> @@ -0,0 +1,22 @@
> +Freescale i.MX TPM PWM controller
> +
> +Required properties:
> +- compatible : Should be "fsl,imx-tpm".

Needs to be SoC specific.

> +- reg: Physical base address and length of the controller's registers.
> +- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of the cells format.
> +- clocks : The clock provided by the SoC to drive the PWM.
> +- interrupts: The interrupt for the PWM controller.
> +
> +Note: The TPM counter and period counter are shared between multiple channels, so all channels
> +should use same period setting.
> +
> +Example:
> +
> +pwm0: tpm@40250000 {

pwm@...
