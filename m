Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4870C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB26820672
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgABG7t convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:59:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgABG7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:59:49 -0500
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1imuSR-0000rC-8y
        for linux-kernel@vger.kernel.org; Thu, 02 Jan 2020 06:59:47 +0000
Received: by mail-pg1-f200.google.com with SMTP id l13so27287370pgt.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 22:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=+4ASNLI8hemylDXAQ26bv8KzwuXrMFomc4dsXqfBlnQ=;
        b=d0wd5cytftD3chjgDGN/+3YDsIRTKVkjvp7uLciVM4ZBY+HTeyS1oErfy3nACOZ7w8
         EZETZ+u+rgL6ZdOkawBWmwUDHBj5jTOKmv4x2hTKp+v159ZeMBXWdWmo4e2inpPfpBu4
         /vohxOB9JrrD1HcwzQXC9i5s2tSpQvAeFN7+FFWZftc/mcGZtzcPfRfR9JVSX3JCOjg4
         odTtpzwGBxzIF5WKToePCGN1zvp0vrNCm+sSJrgv8AO9EOjJz6v4svLUh3TyPy9OFP+3
         JIA/l64N01aQNxL091gRZvwbvPBDB+R4J9Ani4KbYXVkXznlavq1Opj6SIQ7+8AcO7mx
         Oe0g==
X-Gm-Message-State: APjAAAUv3RVP8jM+JXN8kTcDmRGjzwTiPs17cowDW2AQceKvDoPrCIJI
        HNVJPh+RY/jSQceNX+xeiI6Jhh5klrZLPC6lvS3lHCWoeOHsvhFIniXdpWTEGRF4vFGvA13PNaw
        A58/wGyx4oilnlCeJfl9iH0BBiWTxQNxfRdrgF5SIEw==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr87026089pga.176.1577948385890;
        Wed, 01 Jan 2020 22:59:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4u7csTaenM6SHfp5W1eAmF77TctrCSAsskp7RkLMW0KhIV5dmXnThBwvIiiJsX1YvyWbuUA==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr87026049pga.176.1577948385382;
        Wed, 01 Jan 2020 22:59:45 -0800 (PST)
Received: from [10.101.46.91] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id o7sm64953508pfg.138.2020.01.01.22.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jan 2020 22:59:44 -0800 (PST)
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: SFP+ support for 8168fp/8117
Message-Id: <2D8F5FFE-3EC3-480B-9D15-23CACE5556DF@canonical.com>
Date:   Thu, 2 Jan 2020 14:59:42 +0800
Cc:     Linux Netdev List <netdev@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Jason Yen <jason.yen@canonical.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

There's an 8168fp/8117 chip has SFP+ port instead of RJ45, the phy device ID matches "Generic FE-GE Realtek PHY" nevertheless.
The problems is that, since it uses SFP+, both BMCR and BMSR read are always zero, so Realtek phylib never knows if the link is up.

However, the old method to read through MMIO correctly shows the link is up:
static unsigned int rtl8169_xmii_link_ok(struct rtl8169_private *tp)
{
       return RTL_R8(tp, PHYstatus) & LinkStatus;
}

Few ideas here:
- Add a link state callback for phylib like phylink's phylink_fixed_state_cb(). However there's no guarantee that other parts of this chip works.
- Add SFP+ support for this chip. However the phy device matches to "Generic FE-GE Realtek PHY" which may complicate things.

Any advice will be welcome.

Kai-Heng
