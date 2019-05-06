Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E59EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFCD20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153230;
	bh=XViI8siM9t8Km8JK78U5QE8Ny1YHZh50Bn88VtjLptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jsYn9EL47WwOQmLNc8kSDCqleKGgItF5zvI8VpxLsoy7oAE3cKDcPLQ8mDyuhNpcq
	 nah1uIJ1UR5RG1cpKUGN1LBYh2C8SMJpzPHCTSFg+GGn1KEOkE/910RHpd4e6tO/OR
	 QMlBPcyjd4MAXAb1RVULVDtF387IO5Nf7TZESTSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEFOdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfEFOdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:33:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B54204EC;
        Mon,  6 May 2019 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153226;
        bh=XViI8siM9t8Km8JK78U5QE8Ny1YHZh50Bn88VtjLptA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dc0chQWNqmJ4N03Kmtsn5AlIHU2Si2oKC8QQ3UvQlknnrQT/YnOMNqVop8vCqpyO+
         Ijc9oZS4OF49UHcKSihQ1i65JZZIcTu+cqEU3M9cg/b7TFpg6uwMaQOMR9v9s2xTfN
         zFe+9mytNnUth4D1W1pXjyqSxh/NlC4Dmq8VbXek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keijo Vaara <ferdasyn@rocketmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.0 010/122] i2c: Prevent runtime suspend of adapter when Host Notify is required
Date:   Mon,  6 May 2019 16:31:08 +0200
Message-Id: <20190506143055.639569756@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 72bfcee11cf89509795c56b0e40a3785ab00bbdd upstream.

Multiple users have reported their Synaptics touchpad has stopped
working between v4.20.1 and v4.20.2 when using SMBus interface.

The culprit for this appeared to be commit c5eb1190074c ("PCI / PM: Allow
runtime PM without callback functions") that fixed the runtime PM for
i2c-i801 SMBus adapter. Those Synaptics touchpad are using i2c-i801
for SMBus communication and testing showed they are able to get back
working by preventing the runtime suspend of adapter.

Normally when i2c-i801 SMBus adapter transmits with the client it resumes
before operation and autosuspends after.

However, if client requires SMBus Host Notify protocol, what those
Synaptics touchpads do, then the host adapter must not go to runtime
suspend since then it cannot process incoming SMBus Host Notify commands
the client may send.

Fix this by keeping I2C/SMBus adapter active in case client requires
Host Notify.

Reported-by: Keijo Vaara <ferdasyn@rocketmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203297
Fixes: c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Keijo Vaara <ferdasyn@rocketmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-base.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -327,6 +327,8 @@ static int i2c_device_probe(struct devic
 
 		if (client->flags & I2C_CLIENT_HOST_NOTIFY) {
 			dev_dbg(dev, "Using Host Notify IRQ\n");
+			/* Keep adapter active when Host Notify is required */
+			pm_runtime_get_sync(&client->adapter->dev);
 			irq = i2c_smbus_host_notify_to_irq(client);
 		} else if (dev->of_node) {
 			irq = of_irq_get_byname(dev->of_node, "irq");
@@ -431,6 +433,8 @@ static int i2c_device_remove(struct devi
 	device_init_wakeup(&client->dev, false);
 
 	client->irq = client->init_irq;
+	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
+		pm_runtime_put(&client->adapter->dev);
 
 	return status;
 }


