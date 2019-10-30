Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35150CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBF521835
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451246;
	bh=9CtT65Z849232WiDVbFzdI/KWnr+z2wOnr7nMlIbsiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bo00BDk/jrMZK9lITtJIyyXG3aE8uQflZirpXAoPc3k/R9wSHATc7IYRpq2kie7o7
	 ZEbfEpNTuDoj++VprQ9rdEg6aUs9z6u9EA8jQwaqpIJrEn5JWp9q08j0Ar/YPatXKH
	 eeUdMXZZjLRKd11ZCCrzEhCSTO5e+RfkMK1MEvTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfJ3QAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbfJ3PzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:55:10 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041B820874;
        Wed, 30 Oct 2019 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450909;
        bh=9CtT65Z849232WiDVbFzdI/KWnr+z2wOnr7nMlIbsiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyPM7l8POtF+SjWMhCGgfLWBZSzLp9U3bpEE15kvGDSZMbfxPdVexDD6OD5rhAPMp
         wxjaPsOFImmIn/XoTqK1YLRsW0rWyNbRbSJYXUTHc0vPdgjLoR3M/M0v+a17ne/kYz
         OBl/ED+cLw6MVp/WozwOM2NkVlNiWzkkqKffi3FI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Michael Moese <mmoese@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/38] 8250-men-mcb: fix error checking when get_num_ports returns -ENODEV
Date:   Wed, 30 Oct 2019 11:53:50 -0400
Message-Id: <20191030155406.10109-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155406.10109-1-sashal@kernel.org>
References: <20191030155406.10109-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit f50b6805dbb993152025ec04dea094c40cc93a0c ]

The current checking for failure on the number of ports fails when
-ENODEV is returned from the call to get_num_ports. Fix this by making
num_ports and loop counter i signed rather than unsigned ints. Also
add check for num_ports being less than zero to check for -ve error
returns.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: e2fea54e4592 ("8250-men-mcb: add support for 16z025 and 16z057")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Michael Moese <mmoese@suse.de>
Link: https://lore.kernel.org/r/20191013220016.9369-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 127017cc41d92..057b1eaf6d2eb 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -71,8 +71,8 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 {
 	struct serial_8250_men_mcb_data *data;
 	struct resource *mem;
-	unsigned int num_ports;
-	unsigned int i;
+	int num_ports;
+	int i;
 	void __iomem *membase;
 
 	mem = mcb_get_resource(mdev, IORESOURCE_MEM);
@@ -87,7 +87,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 	dev_dbg(&mdev->dev, "found a 16z%03u with %u ports\n",
 		mdev->id, num_ports);
 
-	if (num_ports == 0 || num_ports > 4) {
+	if (num_ports <= 0 || num_ports > 4) {
 		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
 			num_ports);
 		return -ENODEV;
@@ -132,7 +132,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 
 static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
 {
-	unsigned int num_ports, i;
+	int num_ports, i;
 	struct serial_8250_men_mcb_data *data = mcb_get_drvdata(mdev);
 
 	if (!data)
-- 
2.20.1

