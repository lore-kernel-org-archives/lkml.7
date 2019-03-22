Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A135C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5F421916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256526;
	bh=tMSYnxgQ5VBSDuc5gFsQRA27e1L1yMOyeBSQb+519dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eM7QYAaC8TLTGRvfEQ/TGxnOOVhYQg9zoWcumrg4XnQDSwGUiKRzg1YGnslbvhH4o
	 DKnAmN5Dy/tDMjgEVyojatqCUnPsCtBhFAomeBzcTG6NWDPrllIpcxTcu2QtXf9cJW
	 0YHRHI4cKkFjzU8a03Z4nZ5bWAtvTo8DDIiK5IGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfCVMIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388380AbfCVMIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41589206C0;
        Fri, 22 Mar 2019 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256522;
        bh=tMSYnxgQ5VBSDuc5gFsQRA27e1L1yMOyeBSQb+519dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1vW1GYGAIcPERnnH92RhefH0s1xcCN7GP9WrIWOblVkQJywvO1euvdw1ZnOF3XWfb
         KUGyK6F/o5YhYN4GnYv9f5m8cVtAA/YrVtod5K1dze4oIljp1O9HE8CpPtvxeYYpZt
         Ptzs5y/sbRz20nmv8hs/nnAQeXf33cDbk5oM0tkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4.19 214/280] serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart
Date:   Fri, 22 Mar 2019 12:16:07 +0100
Message-Id: <20190322111333.527558553@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -130,6 +130,10 @@ static int of_platform_serial_setup(stru
 		port->flags |= UPF_IOREMAP;
 	}
 
+	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. */
+	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
+		port->regshift = 2;
+
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
 		port->regshift = prop;


