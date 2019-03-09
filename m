Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F04AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EB9206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV7Q2MlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfCISSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:18:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42277 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCISSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:18:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id u7so834857qtg.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2CmTuRNh13ukFfv8JkGzVYuTGuI0E0y8s2qmHbJv9cs=;
        b=TV7Q2MlQkA5ywISJTN/JaxwoibjQs7tnhSlmroLQA3gyTrNX3qk1Trao9Kc0EmtKLd
         zpkGKuuW53YRohHShrbg6QDyrGVLf0bQs59+xXuZBteJC2RYjM6S4p+yvFR26DNpH27R
         6coL0ppPZsjnNWbHcxRIJeUF6ilfgF8x+a3OdA1Ta81mGhlN+fj8UGMs0CI9PUYNJI0b
         I081IIGHrm173YLQ1a93iw5Ip4NsyuTgWaFuxKVgYCDuNbo1C8LhwS4JXVGcGYfbMqhC
         Pc4NAL418s0AOM8Y9BXR/YIL8MrZ/J0SyE1WdSV0l4YS0tK6InDaecYXWgM35IrHQBid
         Abzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2CmTuRNh13ukFfv8JkGzVYuTGuI0E0y8s2qmHbJv9cs=;
        b=kxWjjyGkN6H1GmUkI4MoDxlFD/RigpIzUzEHvITb/lEBbe7exSfrNcpXVOOywf0Vm5
         IMUvgRRGQFCjNJJVfL002jBgVK2/1+H3TRPBHki86IGHMSwYct+kpviDJ6EzISpvm61D
         CvE+B60TnaQKPSZnTmZcdhdtL+GDNnarS7QgwBsrE4Sg/uZWzvuzZ5zsXfdFzzgxBh+0
         fsaczoQmAWaJxsnRLdO9Lf3c2dp3qwTIXSXujYARqvzRCzD3rBrq6SJBKwdFJIT/EC/o
         Ufi3TJBuEMbFqyqkN8DzNUFgVIdIqiNDCnHU/4++WoObIjlpvg2fXWA/0RzGtk38GP0K
         1Myg==
X-Gm-Message-State: APjAAAX74oOTqZuxSnHNubaoBKCnYU3Gq7C/L3Qt7qQxmyvBxVwvry3+
        3mu7Uunpl7ao2tN50T03/mw=
X-Google-Smtp-Source: APXvYqxYSa7qALSG+rbi/EI7/SF39ulbqB0wGBOOXx7OZPlGVQUil4FMCD5MXet4GyquJcrz+etIog==
X-Received: by 2002:ac8:33d7:: with SMTP id d23mr19625341qtb.243.1552155514466;
        Sat, 09 Mar 2019 10:18:34 -0800 (PST)
Received: from localhost.localdomain ([186.141.200.40])
        by smtp.gmail.com with ESMTPSA id v2sm585175qkc.41.2019.03.09.10.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:18:33 -0800 (PST)
From:   Laura Lazzati <laura.lazzati.15@gmail.com>
To:     gregkh@linuxfoundation.org, tsotsos@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Laura Lazzati <laura.lazzati.15@gmail.com>
Subject: [PATCH] staging: octeon-usb octeon-hcd: Fix several typos.
Date:   Sat,  9 Mar 2019 15:18:27 -0300
Message-Id: <20190309181827.9301-1-laura.lazzati.15@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that the comments had several typos such as "aenable", "internaly" and some others.
I fixed them all.

Signed-off-by: Laura Lazzati <laura.lazzati.15@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
index 769c36cf6614..9ed619c93a4e 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.h
+++ b/drivers/staging/octeon-usb/octeon-hcd.h
@@ -1711,7 +1711,7 @@ union cvmx_usbnx_usbp_ctl_status {
 	 *	Indicates an internal error was detected during
 	 *	the BIST sequence.
 	 * @tdata_out: PHY Test Data Out.
-	 *	Presents either internaly generated signals or
+	 *	Presents either internally generated signals or
 	 *	test register contents, based upon the value of
 	 *	test_data_out_sel.
 	 * @siddq: Drives the USBP (USB-PHY) SIDDQ input.
@@ -1737,7 +1737,7 @@ union cvmx_usbnx_usbp_ctl_status {
 	 *	to D+. When an A/B device is acting as a host
 	 *	(downstream-facing port), dp_pulldown and
 	 *	dm_pulldown are enabled. This must not toggle
-	 *	during normal opeartion.
+	 *	during normal operation.
 	 * @dm_pulld: PHY DM_PULLDOWN input to the USB-PHY.
 	 *	This signal enables the pull-down resistance on
 	 *	the D- line. '1' pull down-resistance is connected
@@ -1745,7 +1745,7 @@ union cvmx_usbnx_usbp_ctl_status {
 	 *	to D-. When an A/B device is acting as a host
 	 *	(downstream-facing port), dp_pulldown and
 	 *	dm_pulldown are enabled. This must not toggle
-	 *	during normal opeartion.
+	 *	during normal operation.
 	 * @hst_mode: When '0' the USB is acting as HOST, when '1'
 	 *	USB is acting as device. This field needs to be
 	 *	set while the USB is in reset.
@@ -1784,7 +1784,7 @@ union cvmx_usbnx_usbp_ctl_status {
 	 *	Used to activate BIST in the PHY.
 	 * @tdata_sel: Test Data Out Select.
 	 *	'1' test_data_out[3:0] (PHY) register contents
-	 *	are output. '0' internaly generated signals are
+	 *	are output. '0' internally generated signals are
 	 *	output.
 	 * @taddr_in: Mode Address for Test Interface.
 	 *	Specifies the register address for writing to or
@@ -1797,7 +1797,7 @@ union cvmx_usbnx_usbp_ctl_status {
 	 *	This is a test signal. When the USB Core is
 	 *	powered up (not in Susned Mode), an automatic
 	 *	tester can use this to disable phy_clock and
-	 *	free_clk, then re-eanable them with an aligned
+	 *	free_clk, then re-enable them with an aligned
 	 *	phase.
 	 *	'1': The phy_clk and free_clk outputs are
 	 *	disabled. "0": The phy_clock and free_clk outputs
-- 
2.17.1

