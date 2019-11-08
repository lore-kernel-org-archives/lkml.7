Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C9E21D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239996;
	bh=Jcyg7XjWUAWVTdX7CZVkV0MKQtcJLFsqCZ9uBBB3WFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQCv+N/DzDjKGuxhDvRRR/ApJCaIFPkhkRVEhmPfkubDEYLAoB8+5jfwhLwPkp+Xe
	 B4ttzeVcYvq44v9dbPbhs+lY2CVVfHjcwiDR+jwvgYsjBQ165HuFh43VHsw0F4UDPL
	 uhUVHx5EfpSSyMFiwpwNrrpxxj2nJ8jVUtKMAWyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391292AbfKHTGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391270AbfKHTGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:06:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8542245C;
        Fri,  8 Nov 2019 19:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239990;
        bh=Jcyg7XjWUAWVTdX7CZVkV0MKQtcJLFsqCZ9uBBB3WFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVqYfI4p6462nfrO4EVVHfYw1FfhElFNHfc1pXG2XxZPTB4AaSzxpWPyfFG7oRGoj
         UjuSup0h33QL47BKxsDgJ64889gIyIVzuHuYZCqO6qe6b6+/rItmTDtB626NgZGH86
         jeJqa3TpUKDFa01Gl9mN4EAeI31h7mM8SlSUPy/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Michael Moese <mmoese@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 051/140] 8250-men-mcb: fix error checking when get_num_ports returns -ENODEV
Date:   Fri,  8 Nov 2019 19:49:39 +0100
Message-Id: <20191108174908.582744440@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
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
index 02c5aff58a740..8df89e9cd2542 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -72,8 +72,8 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 {
 	struct serial_8250_men_mcb_data *data;
 	struct resource *mem;
-	unsigned int num_ports;
-	unsigned int i;
+	int num_ports;
+	int i;
 	void __iomem *membase;
 
 	mem = mcb_get_resource(mdev, IORESOURCE_MEM);
@@ -88,7 +88,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 	dev_dbg(&mdev->dev, "found a 16z%03u with %u ports\n",
 		mdev->id, num_ports);
 
-	if (num_ports == 0 || num_ports > 4) {
+	if (num_ports <= 0 || num_ports > 4) {
 		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
 			num_ports);
 		return -ENODEV;
@@ -133,7 +133,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 
 static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
 {
-	unsigned int num_ports, i;
+	int num_ports, i;
 	struct serial_8250_men_mcb_data *data = mcb_get_drvdata(mdev);
 
 	if (!data)
-- 
2.20.1



