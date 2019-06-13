Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE52C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932D121721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442990;
	bh=+w6dRpNnrCmmmlRULKh/z17yNWgC4fRdHy6w/+up7o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lUep1XKqFH9oH7BVzA0jONvPIxJKuuP2iWUm6LWYU2AZcNUjFsu7wKmEqsPnm7X/u
	 wegJkTh6flV/f9hmIfxUoo1WDdtAimw+4dEotZWKMBbAuouCSwH+6KH13ccyzek0oA
	 XkGL4kebN4tKnfmuLzcqL9s+z7vM/JbnZNyKecxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392142AbfFMQXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731032AbfFMIhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:37:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C1B2064A;
        Thu, 13 Jun 2019 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415072;
        bh=+w6dRpNnrCmmmlRULKh/z17yNWgC4fRdHy6w/+up7o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gwf/e5rDoRmikZ8fUI44X8fMKI2A98AHC5Y61tnEdjoC0u9/P6oFqTYK3CL/tliPF
         q6QVGHGRqq66wrKvK4Pc1gL/q4YXKUN6DUmKqn72Ro8nWjkWIjwx7dhSxI57QCNQ9L
         L4chAsJN1NnHRDoJGAf18/1cCD3bZtsbmQ/N/5Dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 76/81] usb: typec: fusb302: Check vconn is off when we start toggling
Date:   Thu, 13 Jun 2019 10:33:59 +0200
Message-Id: <20190613075654.574970904@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
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
 drivers/staging/typec/fusb302/fusb302.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index 7d9f25db1add..794dbc34973f 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -671,6 +671,8 @@ static int fusb302_set_toggling(struct fusb302_chip *chip,
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



