Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4851C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F7206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552394838;
	bh=KgX7A4hgP4wSplpoYeRe2VJ7m1ZHhVxRl0Pe25d5sgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=muYQi1u064uTOcKGY08A3gWBywsU884W0ii4yPyayLWIqAejgOCtYy9CANvty4ZHG
	 qO8tOOlZ/KeL0HhT0oFlKagH4B+YAHtoGYMjYkzxpFvPVe3Kosq5788ujAvVZUaVKl
	 zu7/bzXSyqJp2smOV6aKF8VLQW1veKpeqn1kPoCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCLMrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:47:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34009 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:47:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id r19so2351051otn.1;
        Tue, 12 Mar 2019 05:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MhOm9Jw5jygbRXiJsDZtcOr+vMsCYdsTZnYUc0Tsp4I=;
        b=Up5y9ZhA5I4Bl8S2NdtWgZixHNabZc9RWXAKohCzxKu8f2NtXT5ERvr98R2Hd2fLaH
         lsolvo380kil+MRDTO0k+9JQptwlUVArolCYWaMAfpFZFvE00sezyaTFozn4TjHjveko
         UqlDvsUpS3vSL1t0zt2pGyTQPW1FG5jxtLc5VJMocNwpB7c/iW6KkDqnYyPgOkTkR/zU
         PvfCESWIkxlv7UPJZQEleKzntdU7uPTXQCBHCr3vSUqc0d1HqbZBiQOzj+D4M4vbKuh+
         qnP7ht1EiafGwMYN4BsTA/MbLW6D0izKc2pcG6CIyL/lJbs5PBzH54TW3s01G/FUvNzq
         H4Vg==
X-Gm-Message-State: APjAAAVHUP/Ykz9sw/yZ+HtnzNl9KK7JIW7vsKHgLBd2aBXqvDV6fo3Y
        346/Lo0SeB5cmVTtPVKP8g==
X-Google-Smtp-Source: APXvYqy38+3LQylBvyY71XT0y+zPqh5LLNMb0Rf6axYzWkPzhFCE/VuaPysVJEehXYqN7EOOHfO9Sg==
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr24759140otb.208.1552394835615;
        Tue, 12 Mar 2019 05:47:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f43sm3551779otf.23.2019.03.12.05.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:47:14 -0700 (PDT)
Date:   Tue, 12 Mar 2019 07:47:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 armsoc/drivers/bus+gpio 5/5] dt-bindings: gpio:
 Document GPIOs via Moxtet bus
Message-ID: <20190312124714.GA14530@bogus>
References: <20190307125251.724-1-marek.behun@nic.cz>
 <20190307125251.724-6-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307125251.724-6-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 13:52:51 +0100, =?UTF-8?q?Marek=20Beh=C3=BAn?= wrote:
> This patch adds documentation of the device tree bindings for GPIOs
> on the devices connected via Moxtet bus.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/gpio/gpio-moxtet.txt   | 18 ++++++++++++++++++
>  MAINTAINERS                                    |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
