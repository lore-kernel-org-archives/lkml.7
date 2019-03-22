Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF61221873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259585;
	bh=ros8T3V3LXPUlHmN1SzqGOXxm0gbcwDCW6RiZ41HhS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNaNIh4HMK8ObanSy8eRZPNjHNKQznHlmY5yGPkjubUi3/eibbdPjkgR21BtA4okK
	 fRjmrt2Wn4KTi1J5b8+O5vzWDDM+nfOci4HqviZVwetfblO5km8pYH7Y/bJffLktRh
	 +MzBhv63vuyqFIPNlYxE8RJKkSOD5NJNxdXRaDg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfCVM7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731874AbfCVLo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:44:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9FA121971;
        Fri, 22 Mar 2019 11:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255099;
        bh=ros8T3V3LXPUlHmN1SzqGOXxm0gbcwDCW6RiZ41HhS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+ckEvv4sDf+R3SGgr+EKejDBvB0z4Vl+e7NF5XP/ayopFZBfHt1wcYAMfYTKQHgQ
         cT32iWGDVXJoAAzBrq9lwYU/rzYukbGAMX5ziIeqEoxKXVcw/6FKi/ioXwWNCj33K0
         UDZD8D4wTy58pA1gWg56pnf3aHDEigr78jwbdZgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4.9 087/118] serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart
Date:   Fri, 22 Mar 2019 12:15:59 +0100
Message-Id: <20190322111222.790372811@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit f4817843e39ce78aace0195a57d4e8500a65a898 upstream.

There are two other drivers that bind to mrvl,mmp-uart and both of them
assume register shift of 2 bits. There are device trees that lack the
property and rely on that assumption.

If this driver wins the race to bind to those devices, it should behave
the same as the older deprecated driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_of.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -97,6 +97,10 @@ static int of_platform_serial_setup(stru
 	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
 		port->mapbase += prop;
 
+	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. */
+	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
+		port->regshift = 2;
+
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
 		port->regshift = prop;


