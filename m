Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E09C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF64621D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239676;
	bh=9CtT65Z849232WiDVbFzdI/KWnr+z2wOnr7nMlIbsiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZW2PYoqnvMkB85FEh6i7FivliX/l2lyoMBgKLaOB1xDeoi+IrmQuGfoykYUeFzhtc
	 v5UQoKJ7/oNQfWvXVR9yEbH3Z2y/f/gWl/TdjJi58NI9k4Ow7k1PUxow1rhFFgyBfB
	 u5a12mlhReH+4GpvnEIilKLv9Jr6PlE1xSjUBRok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbfKHTBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733084AbfKHTBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:01:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9FC21D7B;
        Fri,  8 Nov 2019 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239670;
        bh=9CtT65Z849232WiDVbFzdI/KWnr+z2wOnr7nMlIbsiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfLZ174tYgXWPotyao2TBWUcsnaMldOwOLGBeTzTCXqi+HGsfUZx4X/weYYCPBANl
         3l7ZXPeAZpTooNS6xbo1Q3iyZxED3Wp7Q9CA9aORMhbcWetBBvz6a0Wo2tindHWMGt
         2oFWghjBsa+/QXK9Dsh+t/5Cj5tMOO/uNfjBFZ5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Michael Moese <mmoese@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 21/79] 8250-men-mcb: fix error checking when get_num_ports returns -ENODEV
Date:   Fri,  8 Nov 2019 19:50:01 +0100
Message-Id: <20191108174756.985647000@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



