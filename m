Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BE3ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B94C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571165971;
	bh=pp4Fzr1s1sCFJmciNLGtdVV9GCuaesS5JEaco0tMMLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pcfKt44CEVC4kp3lxYltwXANOWFkcN794bX+d2FJER+aT0KNzQtc+p7oaPceJtksD
	 n/HniLPpKXWaLEwk4AuaUbYatlfmrnne7x5v314rraElURnIURY/ar9jKOY1NEih15
	 yyJm1fyJIs6iTOsOOackHgVGs05cF1Ie77rZhc6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfJOS7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 14:59:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41789 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfJOS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:59:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id w65so17777726oiw.8;
        Tue, 15 Oct 2019 11:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71Wb7b/0yCm9bssMx4aB/LI8BIio7aNdnZ8+kJtjPq0=;
        b=H7z5YHMciRS2Md+9wQGN+rIZQbbGK3C4wS0J6P+5dbC/JKL9rsIOyq7p6KKjfS6sgB
         NmA2N3x33qxO+ltFkjnZPmmstFGEYW6HPrmsKxClcp+4/ZyyCpif9BGOXpRhTOgm0AYN
         GgSr/Yw8cIqJZnkziAkgQYpebI1tlnszC25MV8RfPtyzvv6eEtPx0t/PV6xFHm62Z7bz
         4TIpLwVMHvXyOfz3R/kyK8xnd6scyd4Q5j8BB+L5UXgPmzgd+/y1PzuLSb7jW/iA85ec
         Jq70zKA0zwMqBeU0JNh11Etzi9p02e+mWw29cYmbSw5K2zPDLedoGpAmZQeVcSZYfytP
         gNhw==
X-Gm-Message-State: APjAAAUfZSwyXR6htLTVklTmPZ1EJ1AbX8A0QqW/kPg0JGE0Z4u4kGeN
        p40Dh/E9YOPExyNa0vLoLwAcmcc=
X-Google-Smtp-Source: APXvYqzT2LJQzrzNosAbkxBk/0GI7gvyDnwpb0aWZ6ydWCGS4zdvQsjb5mnvTW61pltsIBY83ceZxA==
X-Received: by 2002:aca:3242:: with SMTP id y63mr55005oiy.114.1571165960668;
        Tue, 15 Oct 2019 11:59:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d69sm6593697oig.32.2019.10.15.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:59:19 -0700 (PDT)
Date:   Tue, 15 Oct 2019 13:59:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/7] dt-bindings: interrupt-controller: Add
 brcm,bcm7211-armctrl-ic binding
Message-ID: <20191015185919.GA26464@bogus>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
 <20191001224842.9382-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001224842.9382-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Oct 2019 15:48:37 -0700, Florian Fainelli wrote:
> BCM7211 features a second level interrupt controller similar in nature
> to BCM2836, with a few modifications to the register offsets, document
> that specific compatible string.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../interrupt-controller/brcm,bcm2835-armctrl-ic.txt        | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
