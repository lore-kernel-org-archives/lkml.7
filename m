Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C0C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99052206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556916605;
	bh=kcNsF86h0vzqOQzNgkJjCzF0nga/XfpjftT3dALWrQ0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=JsLtKAeihX55vA6yrIDHdSCvth19RlGu1uEYp7cn2BtsUN3jaEgR2WerJSC7sX9mO
	 HfkM9Z05m9qPu3umUowd0XJZQHH/5NsO0Cnv/fhDBMj8hy8Kd13Q7K6Zbc8udoUspK
	 +QHuIsiRdbJ/AdyEEaPlp+fcn4aXEDsObX/aLYb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfECUuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 16:50:04 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55202 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:50:03 -0400
Received: by mail-wm1-f51.google.com with SMTP id b10so8580198wmj.4;
        Fri, 03 May 2019 13:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3WRefylpHoq+bmA7wobTBIMipAzUtIxZ32oIEUbNhnE=;
        b=TPIpMq3HbAOhfdMbRJU+GqbLr16pSHc22BKzSqjJah8dneY3X41Ms3cST5caLh70Ij
         k/BCu3CnOADUd/FPMt4kc9bkAqm0o1L8XPAJeQwHqImpWar0wKVPeds3TlsGAXDYyuFd
         JV1Hqo+cPsWlYmXCvLqZGpdoF1iuT71nghZFYektRxsR2WD4GihJcgLcPQF8wh4Fy7Tp
         GWs7pK8qiZ/15z6j+G97Ae7UaMo1YIxZ5t1HGS3pz9JdwEjefwg5MoJ3IHUMUetm4J4C
         5tbG6zfApvPPe83pXCiETYVdLrYRB60Nzgz0JmF77SksAUhHhvh2Iu9QsK93h/602y1t
         MtKQ==
X-Gm-Message-State: APjAAAWXa7H5R0aMZX1p39xSvcef+TPyQYko97KC4ecpNwulhiIgVDSP
        CEhphmJi6AzfUA5Dz+P4kfQ=
X-Google-Smtp-Source: APXvYqxklGno0XFB4B8cXBfafnXg63KYZCefaROZACKbwwyBii0hsOJbnj4lXJGrDnQZPPJlsVlyag==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr7539524wmb.110.1556916601167;
        Fri, 03 May 2019 13:50:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.114])
        by smtp.googlemail.com with ESMTPSA id q2sm2204786wrd.48.2019.05.03.13.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 13:50:00 -0700 (PDT)
Date:   Fri, 3 May 2019 22:49:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [BUG BISECT] USB on Exynos4412 fails after usb: dwc2: gadget:
 Replace phyif with phy_utmi_width
Message-ID: <20190503204958.GA12532@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bisect pointed commit 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif
with phy_utmi_width") as reason for failures of USB on Exynos4412,
Odroid U3 board (ARMv7, exynos_defconfig, TFTP boot with nfsroot from
NFSv4):

[    4.333996] usb 1-2: new high-speed USB device number 3 using exynos-ehci
[    4.503942] usb 1-2: device descriptor read/64, error -71
[    4.793970] usb 1-2: device descriptor read/64, error -71
[    4.914748] usb usb1-port2: attempt power cycle
[    6.224267] usb 1-3: new high-speed USB device number 5 using exynos-ehci
[    6.393983] usb 1-3: device descriptor read/64, error -71
[    6.684243] usb 1-3: device descriptor read/64, error -71
[    6.954259] usb 1-3: new high-speed USB device number 6 using exynos-ehci
[    7.123980] usb 1-3: device descriptor read/64, error -71
[    7.413969] usb 1-3: device descriptor read/64, error -71
[    7.534778] usb usb1-port3: attempt power cycle

The boot failure is effect of lack of network adapter (USB, smsc95xx).
Expected:
[    4.285831] usb 1-3: New USB device found, idVendor=0424, idProduct=3503, bcdDevice=a1.a0
[    4.288986] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.299596] hub 1-3:1.0: USB hub found
[    4.300027] hub 1-3:1.0: 3 ports detected
[    5.895541] smsc95xx 1-2:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1

Full kernel log is here:
https://krzk.eu/#/builders/25/builds/1330/steps/14/logs/serial0
https://krzk.eu/#/builders/25/builds/1330

Let me know if you need any more details.

Best regards,
Krzysztof

