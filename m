Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10280C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE110204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962683;
	bh=mWCp05U5pUtYJwU4w6/+5pZYqD2ykZSQwmsZ5TguZts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHAHbXk9ksvukI5ucWunjf3O1aqU3yjOlOVSe88DKFwPOgN30ZJ5zAL/Hz46bPa0K
	 08L09Z+lO+MdCdz5wo8Kxi0yanBjMWPrDPj3CCeSBmXfrFieyBtoPbdPfy57QOMRkv
	 pqNmrfcaXrOKDM8CKnsxTyBJGoPJjWZ5MpFNT11o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfDVTvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbfDVTus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:50:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14ADA2175B;
        Mon, 22 Apr 2019 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962647;
        bh=mWCp05U5pUtYJwU4w6/+5pZYqD2ykZSQwmsZ5TguZts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SwaXw/D8fOUEi5imGAcEO8v38DUIvatw/rqHSK2Kv8BZhfO+mUfNQEC9IQhT6KuQS
         MC30YMLyaLXTAoFG3KwwUIeO2XTragdVjw1h3/QEwoiF4cPbuR34Qn8rY3ERptjk+c
         +0N2iBgvXoiuRE7TYaDVurwPhBx7FeeSk71mLTu0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 11/15] tty: fix NULL pointer issue when tty_port ops is not set
Date:   Mon, 22 Apr 2019 15:50:18 -0400
Message-Id: <20190422195022.13760-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422195022.13760-1-sashal@kernel.org>
References: <20190422195022.13760-1-sashal@kernel.org>
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
index 1b9335796da4..408c220542b9 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -214,7 +214,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		if (tty && C_HUPCL(tty))
 			tty_port_lower_dtr_rts(port);
 
-		if (port->ops->shutdown)
+		if (port->ops && port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
 out:
@@ -294,7 +294,7 @@ EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
 
 int tty_port_carrier_raised(struct tty_port *port)
 {
-	if (port->ops->carrier_raised == NULL)
+	if (!port->ops || !port->ops->carrier_raised)
 		return 1;
 	return port->ops->carrier_raised(port);
 }
@@ -311,7 +311,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
 
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops && port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 1);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
@@ -327,7 +327,7 @@ EXPORT_SYMBOL(tty_port_raise_dtr_rts);
 
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops && port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 0);
 }
 EXPORT_SYMBOL(tty_port_lower_dtr_rts);
@@ -606,7 +606,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 
 	if (!test_bit(ASYNCB_INITIALIZED, &port->flags)) {
 		clear_bit(TTY_IO_ERROR, &tty->flags);
-		if (port->ops->activate) {
+		if (port->ops && port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
 			if (retval) {
 				mutex_unlock(&port->mutex);
-- 
2.19.1

