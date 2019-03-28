Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96016C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F2420823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CbE698Q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfC1Url (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:47:41 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:34268 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfC1Url (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:47:41 -0400
Received: by mail-wm1-f54.google.com with SMTP id o10so8130062wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tpONjlavF550NKmic2Y1k93QJBkOf1HPbHKeBcY7TQo=;
        b=CbE698Q6MQ7/qD9EYaA9eN6og/aSmQrQiaIqH1rlMlbea9KTtHttQwK4JqIEM0Rgmb
         7j9iezUTd0KscM+C22isyLMVwFrHrj2UoyGoaub94NeEA/rDjtnAXvyxXSSdfL09SmrR
         4+pQrCnqvkAO/+KZ59I8LeVPBX+3m+eiX2IaqjNJLzuZlfCx2IwgrSOdCcgGVXgjKUbC
         VS5LcvxNgTMdK/YJx4LfWrVEAsO0+NsNYH8gQ15nu1aws2FpugXYn4opWAKob0rVQtgG
         +KLFKc0gNxhxq2bfPyXzjnlmbizFoMu7c6HA3EV12WTW4F+uZR0AIHlWl27Wf2LBrjwW
         kXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tpONjlavF550NKmic2Y1k93QJBkOf1HPbHKeBcY7TQo=;
        b=mla4h8N9iefGdrFpGlMDc1ql7T+0XxyET+SCnTOCDJEbUJ3FrW3X6mUxa8tQFuHfa0
         lOq0NQM7nH2Bh0VLu/d5Eek7wOOtQR4K02dtF/JFPHd0gkCtExgScGo+XEvj+LMvlqEm
         0LKtZfAWCsL54VxKRnM2Kwn3mENBaeu9uRsDRp2v786Yd2esBS/8Syg7Yr66zMdEPEED
         JZ1DyDl1QC5BMaM9nbdLnrFU3rK05Flw/RwIk0Ms2E+tHNTgOJdky8wyZwQQcoTzFFVv
         QH49YJ7vFy6tbz0tSgYugsFYKLnTz91mkdLP7rHr2PF714Ls1p5Y4D9n3eJrlZ6j9Rd/
         MkHw==
X-Gm-Message-State: APjAAAUu4ayitbnT48mEy0qv7nDW54T4s+mwzCE6XtxJ4b9w0KlIBfSn
        K4ing9CX5soiHewYWfHZOVA=
X-Google-Smtp-Source: APXvYqwug30bln2Shxd4wIqjvrncOWW1bThOFMoQmXgqpNjyG3CsXEK5xk2eYKcn49FlmtWFUXM/kA==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr1220211wmj.111.1553806059516;
        Thu, 28 Mar 2019 13:47:39 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73999007CF185662A5FF671.dip0.t-ipconnect.de. [2003:dc:d739:9900:7cf1:8566:2a5f:f671])
        by smtp.googlemail.com with ESMTPSA id y9sm257173wrn.18.2019.03.28.13.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:47:38 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] gpio-line-names for Odroid-C1
Date:   Thu, 28 Mar 2019 21:47:20 +0100
Message-Id: <20190328204721.25970-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to what we have on other Amlogic boards this adds the
gpio-line-names to Odroid-C1.
This makes it easy to compare the schematics with the actual .dts
configuration by looking at the debugfs GPIO file.


Martin Blumenstingl (1):
  ARM: dts: meson8b: odroidc1: add the GPIO line names

 arch/arm/boot/dts/meson8b-odroidc1.dts | 52 ++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

-- 
2.21.0

