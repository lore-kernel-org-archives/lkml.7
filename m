Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444E5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A552077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127203;
	bh=9k8ODLotvsHYrbyzSEPVeEibquXj27/Djj77894Pods=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tgkrcHfCNxiXsoj0+KHHG+Idv3n7tnh0/NwnzuS0iu4PZJ06IZXpo/Wjey9regW9U
	 xLqTBoUXzEmiylB9BuBm8g/f+w1FNGpfPxYXTc0L9WeWXw46PEQq+DrjA79LEsFv+K
	 0NAYGiaIBtj3fM2XkAlQ43FeVbLJgkAKWuIQBGbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbfDXRdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391467AbfDXRdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:19 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B342077C;
        Wed, 24 Apr 2019 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127198;
        bh=9k8ODLotvsHYrbyzSEPVeEibquXj27/Djj77894Pods=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXkg1T/UWtp+uwwIKsHp/p2brfVMtTFbCaWJ3/btle3I2HwY9g1xL7qhOKeP4fpa8
         31OUCZbT84i25t+QfpTW3Mq+b/kUJlF4NnAVBrDhAKUzFr0n0Hhl8EpnWXo52cLD6v
         8cLTmHVtnbIQXC9JHHl9GhoASozTHwyQBFqgE3YY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 54/96] Input: elan_i2c - add hardware ID for multiple Lenovo laptops
Date:   Wed, 24 Apr 2019 19:09:59 +0200
Message-Id: <20190424170923.430052311@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KT Liao <kt.liao@emc.com.tw>

commit 738c06d0e4562e0acf9f2c7438a22b2d5afc67aa upstream.

There are many Lenovo laptops which need elan_i2c support, this patch adds
relevant IDs to the Elan driver so that touchpads are recognized.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1339,21 +1339,46 @@ static const struct acpi_device_id elan_
 	{ "ELAN0600", 0 },
 	{ "ELAN0601", 0 },
 	{ "ELAN0602", 0 },
+	{ "ELAN0603", 0 },
+	{ "ELAN0604", 0 },
 	{ "ELAN0605", 0 },
+	{ "ELAN0606", 0 },
+	{ "ELAN0607", 0 },
 	{ "ELAN0608", 0 },
 	{ "ELAN0609", 0 },
 	{ "ELAN060B", 0 },
 	{ "ELAN060C", 0 },
+	{ "ELAN060F", 0 },
+	{ "ELAN0610", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
+	{ "ELAN0615", 0 },
+	{ "ELAN0616", 0 },
 	{ "ELAN0617", 0 },
 	{ "ELAN0618", 0 },
+	{ "ELAN0619", 0 },
+	{ "ELAN061A", 0 },
+	{ "ELAN061B", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
+	{ "ELAN061F", 0 },
 	{ "ELAN0620", 0 },
 	{ "ELAN0621", 0 },
 	{ "ELAN0622", 0 },
+	{ "ELAN0623", 0 },
+	{ "ELAN0624", 0 },
+	{ "ELAN0625", 0 },
+	{ "ELAN0626", 0 },
+	{ "ELAN0627", 0 },
+	{ "ELAN0628", 0 },
+	{ "ELAN0629", 0 },
+	{ "ELAN062A", 0 },
+	{ "ELAN062B", 0 },
+	{ "ELAN062C", 0 },
+	{ "ELAN062D", 0 },
+	{ "ELAN0631", 0 },
+	{ "ELAN0632", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };


