Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB583C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A391218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962269;
	bh=rrXXp4PphF24lBaeRNQ2aUqDnqBx2R6T+V1WBb5Kd0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AgasAXT+2oIvOfbWbM21SZSrx7LZjSC/SHIGzshJcKVUyCS/E2TqH9r3HjqFl+ZR
	 HC8qz6mIeQ+pNW6RtWzLcMfGVMSY4IRbb1X3+E4hqrugx8gZPMhwCa6oWgj1NE9PgS
	 xaDUAre6VHGv1FYimOMuD551OWkKH70wOazobdH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfDVTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbfDVToV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E41F1218FF;
        Mon, 22 Apr 2019 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962260;
        bh=rrXXp4PphF24lBaeRNQ2aUqDnqBx2R6T+V1WBb5Kd0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cREnGMoJJ7wfjMqWHaNhjGbtXxWcMIjUdD4Ill3v6LYYK0oiV7IsxdiizxkENiNE
         R1DLuC8v+17hu6YkvMS7O6aO0JnUhiHm6XUGZLM3x0IMmShUghsLVXtgzp/NeDT/NH
         MhqhHMjD83V4wjPPNb2zqJuMZbWB0qaDLWIlLj5U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 70/98] tty: fix NULL pointer issue when tty_port ops is not set
Date:   Mon, 22 Apr 2019 15:41:37 -0400
Message-Id: <20190422194205.10404-70-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

[ Upstream commit f4e68d58cf2b20a581759bbc7228052534652673 ]

Unlike 'client_ops' which is initialized to 'default_client_ops', the
port operations 'ops' may be left to NULL.
Check the 'ops' value before checking the 'ops->x' value.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/tty/tty_port.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 044c3cbdcfa4..a9e12b3bc31d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -325,7 +325,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		if (tty && C_HUPCL(tty))
 			tty_port_lower_dtr_rts(port);
 
-		if (port->ops->shutdown)
+		if (port->ops && port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
 out:
@@ -398,7 +398,7 @@ EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
  */
 int tty_port_carrier_raised(struct tty_port *port)
 {
-	if (port->ops->carrier_raised == NULL)
+	if (!port->ops || !port->ops->carrier_raised)
 		return 1;
 	return port->ops->carrier_raised(port);
 }
@@ -414,7 +414,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops && port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 1);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
@@ -429,7 +429,7 @@ EXPORT_SYMBOL(tty_port_raise_dtr_rts);
  */
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops && port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 0);
 }
 EXPORT_SYMBOL(tty_port_lower_dtr_rts);
@@ -684,7 +684,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 
 	if (!tty_port_initialized(port)) {
 		clear_bit(TTY_IO_ERROR, &tty->flags);
-		if (port->ops->activate) {
+		if (port->ops && port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
 			if (retval) {
 				mutex_unlock(&port->mutex);
-- 
2.19.1

