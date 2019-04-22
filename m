Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0DEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672A52175B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962579;
	bh=sAT42loiEBT5SpKi7duPEpAEsnnRodxopyhTazZscpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OS3jByPh5+FkY9MBqYaKL0Ze28QRaEyv5gXyqJewwAURuJOENO55M8AMdxd3rNea0
	 spYZF3VHdjR8lsn97v4ApuPdblrjj190vfx6q/vi2WwPS1N+K/3bzPAAS0qezMKcu9
	 wcamTLNTM5F5XuL49dyvadjMRwkgrQFNrJGHXbfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfDVTti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbfDVTte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:49:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDC621738;
        Mon, 22 Apr 2019 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962573;
        bh=sAT42loiEBT5SpKi7duPEpAEsnnRodxopyhTazZscpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17XIhOURVqHAJNYKIBLPxjsvvVpXF84FA8BPTVr7EqeME5Ysdp+pJq49m81Ya5Mgj
         AwhoZ7KseRfh+0dd1eDonv3SLnKwdaTv0KkR9GhN3K6HK//qMgcyaVRIpRPM3Rvrep
         GU0tW3NA7ds1bo6vDKhSkQbutBUBGsBg8pCePdiY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabien Dessenne <fabien.dessenne@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 23/29] tty: fix NULL pointer issue when tty_port ops is not set
Date:   Mon, 22 Apr 2019 15:48:42 -0400
Message-Id: <20190422194848.13049-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194848.13049-1-sashal@kernel.org>
References: <20190422194848.13049-1-sashal@kernel.org>
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
index 7f2f20b74d1d..06ba9dbbd610 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -213,7 +213,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		if (tty && C_HUPCL(tty))
 			tty_port_lower_dtr_rts(port);
 
-		if (port->ops->shutdown)
+		if (port->ops && port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
 out:
@@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
 
 int tty_port_carrier_raised(struct tty_port *port)
 {
-	if (port->ops->carrier_raised == NULL)
+	if (!port->ops || !port->ops->carrier_raised)
 		return 1;
 	return port->ops->carrier_raised(port);
 }
@@ -310,7 +310,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
 
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops && port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 1);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
@@ -326,7 +326,7 @@ EXPORT_SYMBOL(tty_port_raise_dtr_rts);
 
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
-	if (port->ops->dtr_rts)
+	if (port->ops && port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 0);
 }
 EXPORT_SYMBOL(tty_port_lower_dtr_rts);
@@ -582,7 +582,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 
 	if (!tty_port_initialized(port)) {
 		clear_bit(TTY_IO_ERROR, &tty->flags);
-		if (port->ops->activate) {
+		if (port->ops && port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
 			if (retval) {
 				mutex_unlock(&port->mutex);
-- 
2.19.1

