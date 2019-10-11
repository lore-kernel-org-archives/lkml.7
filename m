Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ED0C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CBD2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="fJdjRRKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfJKOuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:50:25 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:12326 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1570805422;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=sMiKGuiF2YezpnT4vgqzX5dkBuSmAKROGnapumqa/ak=;
        b=fJdjRRKFvNXZ+rUSI6uhRhCauryplCZrv2NS4hr5xH/hvafhyLFlCHBXlX1JiskA5W
        EXv2nRuVU2I5hEKm+Y2rUGPxr9erCLo1gbWzNKnFZ9RIb2iCnz/hpJzzMBE9DDX/yjqH
        294wP65EKlRS6Gy2fWNWorL0kBa6BD5VslAf7qQ+SehP3QUZe75BgHXTdNi0mz84nNv+
        9GJ8XcS4+1dHnRLa+OLBfV/OMXKiZG6GDqllPlKwTOMERZAV6SrOV/On2txymGktNo1l
        1PyGKM8QroDeMGJJI4yyveMqyfSFpl/aQxhanFUH0PDGzGKh1Ka1gBKkqoMDQOkawI/p
        EDuQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJBG388B1M="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id L0811cv9BEoLR0p
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 11 Oct 2019 16:50:21 +0200 (CEST)
Date:   Fri, 11 Oct 2019 16:50:15 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: extcon: sm5502: USB-HOST (OTG) detection not working
Message-ID: <20191011145015.GA127238@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

after getting interrupts working on my Samsung Galaxy A5 (2015),
I am now trying to make the extcon device detect USB-HOST=1
when I plug in an USB OTG adapter.

At the moment, the driver can sucessfully detect:
  - USB=1 + SDP=1 when I detect the phone to a PC
  - DCP=1 when I connect it to an AC charger
but it does not set USB-HOST=1 when I connect the USB OTG adapter.

It seems to be a problem in the sm5502 driver, since I do get an
SM5502_IRQ_INT1_ATTACH interrupt when I plug in the USB OTG adapter.

In this case, SM5502 reports:
    SM5502_REG_ADC = 0x00 (SM5502_MUIC_ADC_GROUND)
    SM5502_REG_DEV_TYPE1 = 0x80 (SM5502_REG_DEV_TYPE1_USB_OTG_MASK)

However, at the moment the sm5502 driver ignores all attach events with
SM5502_REG_ADC == SM5502_MUIC_ADC_GROUND:

	/*
	 * If ADC is SM5502_MUIC_ADC_GROUND(0x0), external cable hasn't
	 * connected with to MUIC device.
	 */
	cable_type = adc & SM5502_REG_ADC_MASK;
	if (cable_type == SM5502_MUIC_ADC_GROUND)
		return SM5502_MUIC_ADC_GROUND;

However, I definitely have a cable attached in this case...

The sm5502 driver seems to expect SM5502_REG_ADC == SM5502_MUIC_ADC_OPEN.
Any idea why my hardware reports ADC_GROUND for the USB OTG adapter
instead of ADC_OPEN?

Confusingly, the driver used in the original downstream kernel of
the Samsung Galaxy A5 [1] calls ADC = 0x00 "ADC_OTG" instead of
"ADC_GROUND".
So getting ADC = 0x00 may not be entirely unexpected here...

Thanks in advance,
Stephan

[1]: https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/SM-A500FU/drivers/misc/sm5502.c#L195
