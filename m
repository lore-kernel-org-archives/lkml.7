Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E069FC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A1422CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfHTPmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:42:47 -0400
Received: from sauhun.de ([88.99.104.3]:37528 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHTPmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:42:46 -0400
Received: from localhost (p54B333DC.dip0.t-ipconnect.de [84.179.51.220])
        by pokefinder.org (Postfix) with ESMTPSA id 0D5CE2C3014;
        Tue, 20 Aug 2019 17:42:45 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 0/2] rtc: convert two drivers to devm_i2c_new_dummy_device()
Date:   Tue, 20 Aug 2019 17:42:36 +0200
Message-Id: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was about to simplify the call to i2c_unregister_device() when I
realized that converting to devm_i2c_new_dummy_device() will simplify
the drivers a lot. So I took this approach.

Only build tested, but visually reviewed multiple times.

Wolfram Sang (2):
  rtc: max77686: convert to devm_i2c_new_dummy_device()
  rtc: s35390a: convert to devm_i2c_new_dummy_device()

 drivers/rtc/rtc-max77686.c | 17 +++---------
 drivers/rtc/rtc-s35390a.c  | 54 +++++++++-----------------------------
 2 files changed, 17 insertions(+), 54 deletions(-)

-- 
2.20.1

