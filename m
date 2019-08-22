Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B35DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BBC2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="BaOC3oua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbfHVS0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:26:35 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:28743 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfHVS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1566498393;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=D8f21wrkwoSmqG1E2CBqYfuuNLvzEmuTl0g11Sr5KvM=;
        b=BaOC3ouaDR+wr3wVFvGwm1AvhrRVnvwi+pYd/98zNt4PHWb8/wYs1esVq0z9KRn/GK
        91qEHRs1s80W/fdW0yd52aKF0RVPda7SI5vJP1GEvlIMpz0ilcHzUmNC5tj1fRqyXQyU
        CdqDutQvoNZeF5K1z/ImDA/SDssIJggA0UGKC46twmQbPpElHxpli3De2HDOBsUg4Mfi
        ofSx1Xzd3soLyW7NVhvGAHbbOqZA0dfnU+ZcguO0oJJtXELz2vOQN61Xk9lg+1LjQrtu
        1JnHc2E2nP2waoEWtAu9nEGMZTADRfDccOsYr3Bkox6ipzgrqbkqVt8wMJE0E6v8vook
        SxNA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266HpF+ORJDZbzyYBhreg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.26.1 DYNA|AUTH)
        with ESMTPSA id g064fdv7MIQWgtO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 22 Aug 2019 20:26:32 +0200 (CEST)
Date:   Thu, 22 Aug 2019 20:26:24 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Disabling MFD sub-devices through the device tree
Message-ID: <20190822182624.GA2640@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking for a way to disable a MFD sub-device through the device
tree. Setting status = "disabled" for the device node does not seem to
have any effect when mfd_add_devices() is used.

For MFD sub-devices, this was discussed before in [1].
However, as far as I can tell it was never actually fixed.
I was thinking about simply skipping creation of the platform device if
the device node is set to disabled, e.g.:

--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -174,6 +174,9 @@ static int mfd_add_device(struct device *parent, int id,
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
+				if (!of_device_is_available(np))
+					goto fail_alias;
+
 				pdev->dev.of_node = np;
 				pdev->dev.fwnode = &np->fwnode;
 				break;

But I believe this would introduce a rather ugly bug in
mfd_remove_devices() if the first sub-device is set to disabled:
It iterates over the children devices to find the base address of the
allocated "usage count" array, which is then used to free it.
If the first sub-device is missing, it would free the wrong address.

(At the moment, the MFD core seems to be built on the assumption that
all the children devices are actually created...)

A different approach I have seen in the kernel is to add a check to
of_device_is_available() in the device drivers of the MFD sub-devices.
e.g. drivers/power/supply/axp20x_*.c all check of_device_is_available()
as first thing in their probe() method, and abort probing with -ENODEV
otherwise.

On the other hand, duplicating that check in each and every driver
that you may want to disable eventually doesn't sound like a great idea.
Especially because this is not necessary if the devices are registered
directly through the device tree.

What do you think?

Thanks,
Stephan

[1]: https://www.spinics.net/lists/arm-kernel/msg366309.html
