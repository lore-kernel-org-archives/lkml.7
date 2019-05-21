Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE1C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6B12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="K5Zz3WIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfEUOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:51:53 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40542 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfEUOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1558450308; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=b6cNyZTTMg6XoewfuupHh0Xe//2fA9yI3hOT3hVf6/g=;
        b=K5Zz3WIVZN/9klmA/YfwJX9tXnR/lB1SGYiASFWOjRpC9BHydEzTeUnFW6CoVGEYWD8atn
        SMw9BEctrNMjGn3d7SO+MeA06yLEk124HQafjCjdOvFZf1BHd9VRRBSugLJzgQCBx+/she
        z7DJkJKrgACm1VxMmr3qKxx185k76Zg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me
Subject: Ingenic Timer/Counter Unit (TCU) patchset v12
Date:   Tue, 21 May 2019 16:51:28 +0200
Message-Id: <20190521145141.9813-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the V12 of my patchset to add support for the Timer/Counter Unit
(TCU) present on the JZ47xx SoCs from Ingenic.

This patchset is much shorter at only 13 patches vs. 27 patches in V11;
the remaining patches will be sent in parallel (if applicable) or as a
follow-up patchset once this one is merged.

In V11 the clocksource maintainers weren't happy with the size of the
ingenic-timer driver, which included clocks and irqchip setup code.
On the other hand, devicetree maintainers wanted one single node for
the TCU hardware since it's effectively just one hardware block.

In this patchset the functionality is cut in four different drivers:
a MFD one to provide the regmap, probe the children and which provides
several API functions; a clocks driver; a irqchip driver; a clocksource
driver. All these drivers work with the same regmap, have the same
compatible strings, and will probe _with the same devicetree node_.

Regards,
-Paul


