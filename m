Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17649C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C902467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576788017;
	bh=OxcEyVLofTCzxuXOGkGikJ0167KDc6eiLO/1N8HSvhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dIHvXSF0aE6eMlcNz882qwDL20usPB4VQceL8CwF/pNNCkUzDxUH80/x9ODMb0YNR
	 FpvobwPW/Jn9hct0A9Feltte7JXAEZbY8jTQ+smQSyDd1LhDaHievTFY/TKPwrShPD
	 bbXvxABMiNy01A9Y1Sdbmm0RR0L+63J7yqka1k7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLSUkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:40:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45066 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLSUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:40:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so8746960otp.12;
        Thu, 19 Dec 2019 12:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/DHU6AsWSbmURzWL4fQKKs9PFhhU0IfAdRT8ADEmXqA=;
        b=Ud0/cwFBcmtecASeD0vwjJAdDJsScGp67gaPHQXWuJLLQOCDBDIj8TS5Rurz7lAEzw
         ipD8DLKei7kwmwMVFYd7vaR44+qBV6TShGj16+zoJUwdxSZEsSUCbml/kd3JgYf+kloI
         +nEvyxqhUhxekJDln/YgPZXyYCH0UsLXtd6VEVUfYGx7phUQTqp4O9g7TqXPOMKA1yEN
         zNxhOR60cvNmA0JQDhWQ++hoQkSWNKAsp+KgvzHB+sOkiyrxVogVKo0HToJ89tfFRemr
         dBQE8gvWkYrJr99FtRKi2HJyf7lxL7qyIOXbiCWnO5A0UZMv3S0nVYbiAunU3Bv7fDwB
         y8mw==
X-Gm-Message-State: APjAAAXS21giXUHeWiCKCMlhifZiUeJC6J2Ep22V/zXaIEBv1AavCJoT
        M4+1Ffx36jfh7GUtIuOGMg==
X-Google-Smtp-Source: APXvYqwiBRMoaTCW0PSw0PLMzLzmf1pWoLO2s/QtQLkK7HPuMsS2ihUOut9p7Nlfau6onR9z1CCp1w==
X-Received: by 2002:a05:6830:1db3:: with SMTP id z19mr11363008oti.152.1576788014659;
        Thu, 19 Dec 2019 12:40:14 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id c12sm2377123oic.27.2019.12.19.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:40:13 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:40:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Document BCM7216 RESCAL reset
 controller
Message-ID: <20191219204012.GA4350@bogus>
References: <20191210195903.24127-1-f.fainelli@gmail.com>
 <20191210195903.24127-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210195903.24127-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:59:02AM -0800, Florian Fainelli wrote:
> From: Jim Quinlan <jim2101024@gmail.com>
> 
> BCM7216 has a special purpose RESCAL reset controller for its SATA and
> PCIe0/1 instances. This is a simple reset controller with #reset-cells
> set to 0.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../reset/brcm,bcm7216-pcie-sata-rescal.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.txt

Can you make this DT schema format.
