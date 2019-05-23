Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F191C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC5C2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXdFNh6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbfEWRbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:31:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39072 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfEWRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:31:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so7182014wrl.6;
        Thu, 23 May 2019 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MnmPtd13D8a9dFFGhJ+iINcRL6VlzTwwNXyGnOS9P8s=;
        b=AXdFNh6zjPSns6vq7L/S6ful1yMtAzmegpn26bTknvORaI3URXxBUTv8Xp/k4eubP6
         572Qnk6DlmF8notkypYg3qMKzwyzheEvET23blhLTPjyLZao14XoIgYyaKXRnWJavZbs
         oTgSzsLfWZH6Y5nmN4IBWZ3iwjZP7b7+l0+d1cjHXkanDW36krMMuZDvD6t8uz2O6Bp9
         6OG0It76CRnenkjwAYf2+BSWrn5Ef7LZikxi9id66Q4A5RENR+V3wL4jlgZLNUQHaold
         /BFBmTz7D8g1Nwl5AoOUwKrDoi6NsxhG+FDk20IDm0dxfD9AEU2WTJOKKxq72HMYaH0F
         Jtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MnmPtd13D8a9dFFGhJ+iINcRL6VlzTwwNXyGnOS9P8s=;
        b=D77wuDQuz/MDYxgRd24UPrinC+ITsv1S0SMRM3rqFxOkwChiWiQs9feUrFfGSXnBC3
         hX6xkHR4I8xYpl+TQqOAshil1KcNoRIrVobLgeGuUjocvDIuXXC4oLXPkc9IK5k1PZk6
         idpcQRarqCAyUezE3ykGmX6d1HjcByoa0aJt4CTKbTDvji1T56QcpQFFEoxXHKF+c98/
         TD+P9QM8QuFkINn89iqbjuzwx26Ug3Ig+4KCeIHJzpwSss/Xf4jH1NLSmzK3Sp4T2c2w
         3QUxIso6u1fP5CUg/2RQaEF7Lm+910CNWrEaV74+KBXBDWYdrFfb4pHNzdjWbDh4Nc8B
         ahQQ==
X-Gm-Message-State: APjAAAUBwZpcfdYHlEwr42WlRDCMGJoF0srRLNQfrlJeN4KuEidsheyo
        jQw/oY+wc5Pv5P7eXHYzAng=
X-Google-Smtp-Source: APXvYqyg8dtvzFR12TyR+1NJ1FkLY5vjomXq5yABkYnmStYL0Loj3lA2u14z5zQGYJBYaWvRji7YEA==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr4819351wrn.235.1558632660309;
        Thu, 23 May 2019 10:31:00 -0700 (PDT)
Received: from [10.67.49.213] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a124sm243837wmh.3.2019.05.23.10.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:30:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190523060437.11059-1-peng.fan@nxp.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
Date:   Thu, 23 May 2019 10:30:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523060437.11059-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/22/19 10:50 PM, Peng Fan wrote:
> This is a modified version from Andre Przywara's patch series
> https://lore.kernel.org/patchwork/cover/812997/.
> [1] is a draft implementation of i.MX8MM SCMI ATF implementation that
> use smc as mailbox, power/clk is included, but only part of clk has been
> implemented to work with hardware, power domain only supports get name
> for now.
> 
> The traditional Linux mailbox mechanism uses some kind of dedicated hardware
> IP to signal a condition to some other processing unit, typically a dedicated
> management processor.
> This mailbox feature is used for instance by the SCMI protocol to signal a
> request for some action to be taken by the management processor.
> However some SoCs does not have a dedicated management core to provide
> those services. In order to service TEE and to avoid linux shutdown
> power and clock that used by TEE, need let firmware to handle power
> and clock, the firmware here is ARM Trusted Firmware that could also
> run SCMI service.
> 
> The existing SCMI implementation uses a rather flexible shared memory
> region to communicate commands and their parameters, it still requires a
> mailbox to actually trigger the action.

We have had something similar done internally with a couple of minor
differences:

- a SGI is used to send SCMI notifications/delayed replies to support
asynchronism (patches are in the works to actually add that to the Linux
SCMI framework). There is no good support for SGI in the kernel right
now so we hacked up something from the existing SMP code and adding the
ability to register our own IPI handlers (SHAME!). Using a PPI should
work and should allow for using request_irq() AFAICT.

- the mailbox identifier is indicated as part of the SMC call such that
we can have multiple SCMI mailboxes serving both standard protocols and
non-standard (in the 0x80 and above) range, also they may have different
throughput (in hindsight, these could simply be different channels)

Your patch series looks both good and useful to me, I would just put a
provision in the binding to support an optional interrupt such that
asynchronism gets reasonably easy to plug in when it is available (and
desirable).

> 
> This patch series provides a Linux mailbox compatible service which uses
> smc calls to invoke firmware code, for instance taking care of SCMI requests.
> The actual requests are still communicated using the standard SCMI way of
> shared memory regions, but a dedicated mailbox hardware IP can be replaced via
> this new driver.
> 
> This simple driver uses the architected SMC calling convention to trigger
> firmware services, also allows for using "HVC" calls to call into hypervisors
> or firmware layers running in the EL2 exception level.
> 
> Patch 1 contains the device tree binding documentation, patch 2 introduces
> the actual mailbox driver.
> 
> Please note that this driver just provides a generic mailbox mechanism,
> though this is synchronous and one-way only (triggered by the OS only,
> without providing an asynchronous way of triggering request from the
> firmware).
> And while providing SCMI services was the reason for this exercise, this
> driver is in no way bound to this use case, but can be used generically
> where the OS wants to signal a mailbox condition to firmware or a
> hypervisor.
> Also the driver is in no way meant to replace any existing firmware
> interface, but actually to complement existing interfaces.
> 
> [1] https://github.com/MrVan/arm-trusted-firmware/tree/scmi
> 
> Peng Fan (2):
>   DT: mailbox: add binding doc for the ARM SMC mailbox
>   mailbox: introduce ARM SMC based mailbox
> 
>  .../devicetree/bindings/mailbox/arm-smc.txt        |  96 +++++++++++++
>  drivers/mailbox/Kconfig                            |   7 +
>  drivers/mailbox/Makefile                           |   2 +
>  drivers/mailbox/arm-smc-mailbox.c                  | 154 +++++++++++++++++++++
>  include/linux/mailbox/arm-smc-mailbox.h            |  10 ++
>  5 files changed, 269 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
>  create mode 100644 drivers/mailbox/arm-smc-mailbox.c
>  create mode 100644 include/linux/mailbox/arm-smc-mailbox.h
> 


-- 
Florian
