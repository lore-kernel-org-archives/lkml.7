Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B890C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565CF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441414;
	bh=jLVWDgVeETsgKejl+TYNmBkhZacQwqmmS8UtuiNJ1KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6PKCEhI43OzJ8WHLaaaUlTx1QVez8CfcERFsYJ1+bCnaLoAo01G8H7HMMeGafp/d
	 11YFJULR3jnbjod+y7JggXSI0xhfOo4PsEIhtnpGqncGxLwhFI9c6SBE7JFnOdZKgK
	 FK6pfk07t3Ae66+0dDoTzr46UR13qmFjfkZStPM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbfFMP4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731513AbfFMIu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:50:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE83206BA;
        Thu, 13 Jun 2019 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415857;
        bh=jLVWDgVeETsgKejl+TYNmBkhZacQwqmmS8UtuiNJ1KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkto+JTn5sYZGifIy2tv8LXguYjbSEc3rfeXbmQr3D40in7qsWC/BbsMxDUWGO9o7
         Ud/b7nj6CniC8Oq5whNvYSu9r/yAy54lu8xvEB8ojIUtwTAFO2gWePhazwRpCiSEof
         R8V5Zp6ETPQYCyfK9ajsNSaleT/QztQzMQAUCLZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 147/155] usb: typec: fusb302: Check vconn is off when we start toggling
Date:   Thu, 13 Jun 2019 10:34:19 +0200
Message-Id: <20190613075701.147411322@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 32a155b1a83d6659e2272e8e1eec199667b1897e ]

The datasheet says the vconn MUST be off when we start toggling. The
tcpm.c state-machine is responsible to make sure vconn is off, but lets
add a WARN to catch any cases where vconn is not off for some reason.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/fusb302.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index e9344997329c..d8b128ed08af 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -634,6 +634,8 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
 			return ret;
 		chip->intr_togdone = false;
 	} else {
+		/* Datasheet says vconn MUST be off when toggling */
+		WARN(chip->vconn_on, "Vconn is on during toggle start");
 		/* unmask TOGDONE interrupt */
 		ret = fusb302_i2c_clear_bits(chip, FUSB_REG_MASKA,
 					     FUSB_REG_MASKA_TOGDONE);
-- 
2.20.1



