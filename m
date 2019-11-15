Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89955C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5692920715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="XmFl+gBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKONt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:49:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKONt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:49:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so11055919wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=di5ZAsLuTIIhhKKfoi7B5tnpw3+Xa/5YL8AqSuLLL7k=;
        b=XmFl+gBhZeLvUb2d8jXf3fLeWTwF7ficul6IAAUE8/FP2ZrAMJx5nbXZtMnt+VQn7P
         HNRoFbXyCkjZZrio9veq95E3F2ovlTTTn7oGM2SfYWdZUDKxJd3t/YjtsUJ83XrDjWVQ
         bgZvfAkUuMMe4lE312T1HsV7q7WsWIK3ZhMNQnW4O9aQfmPEXdJbw+SzBWsHwfvrB3Aj
         P1EV0Xp6Eu1pAXoyg+7ycz+gaksmx6S59Q2j/Wr5iTeu03t4DGGJ0d70qWVmZmAAH0Uu
         GzN2jNNPuSOrM4qHQdY/xPZOW2dQ2GeEeWd6s1F3lhKs/+R2aFO2igIqQwgIxwiCqw8h
         xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=di5ZAsLuTIIhhKKfoi7B5tnpw3+Xa/5YL8AqSuLLL7k=;
        b=MFSmTGB5I1LWaaO/xeBV0DLENIiFXTTDZ3HtB+abkZ4ADml+dwAT9TmE9qOmPpNh2n
         Su8TR/a4YR+byPz1gb2Rvdz6XlHpk+c/+3+vI5wZBBcBtF/WJX8LoVGE7AAvGIaFgNka
         D2allZ6SBKyUXYV5faJSHWD2cLO0gkuZZu0kfYSoDFqpDxBhCX4gACCoAv1aVlhiDi7l
         9Cjuhjh+SUKrmDtqp7Kw9nGjCkenoJtdoka+3YH+QXyLOmxAkq9AGv0gO//esTHbkBpk
         60k2yqejfj7vYVUbm1EdYWNjhyx8vGiZQsi2z94QAvJupHuLEGJJdrTvm5lqfM3CIW1f
         wKRw==
X-Gm-Message-State: APjAAAXYsoaIcBXzRYneSz0CTXh+Dp590P7VIkS8ePFhDRC8Hh2pOW+T
        /ISQ3esOdq3GBZymEtO4mgbYO+xh3/QZ36dN
X-Google-Smtp-Source: APXvYqwg/bJ7jthZrm4jSuLYtex5y9Gfpio/AZpih1C9EmMqoxdvlmGaaFhs4tfl5S9cyyD/Yv4z+A==
X-Received: by 2002:adf:e701:: with SMTP id c1mr2185435wrm.166.1573825793847;
        Fri, 15 Nov 2019 05:49:53 -0800 (PST)
Received: from localhost.localdomain (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id f14sm11119906wrv.17.2019.11.15.05.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:49:52 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, patrick.rudolph@9elements.com,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH 0/3] firmware: google: Fix minor bugs
Date:   Fri, 15 Nov 2019 14:48:36 +0100
Message-Id: <20191115134842.17013-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch series fixes 3 independent bugs in the google firmware
drivers.

Patch 1-2 do proper cleanup at kernel module unloading.

Patch 3 adds a check if the optional GSMI SMM handler is actually
present in the firmware and responses to the driver.

Arthur Heymans (2):
  firmware: google: Unregister driver_info on failure and exit in gsmi
  firmware: google: Probe for a GSMI handler in firmware

Patrick Rudolph (1):
  firmware: google: Release devices before unregistering the bus

 drivers/firmware/google/coreboot_table.c |  6 ++++++
 drivers/firmware/google/gsmi.c           | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.21.0

