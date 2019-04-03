Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6938CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301A32084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554277267;
	bh=V+sj3i/p2MaPVbeF0654AEWqY46i7iX+fW4X+Z2Fb78=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pLigJZ65q6Nr51jxgI2/PLjncHbMluXT1k/HygHx/kVKlfgKob7/4UgK/p0Mz7Qxj
	 B0QDR4ePwXPOy+RumyedK097MHVz+GSCf9IqSX2rPD6Fi3SJ99WIRn3wgKfpot4jiE
	 uqsZseQeGklhh27zUKf6cx/+zFsEFjvdo+n6a6Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfDCHlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:41:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37705 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:41:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so581314lfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eJhcaO5+3jkfHLT/DENxkvGISSy3IT1Fq/nB45zSdTs=;
        b=GrdxbkHbWfEoi5+vwVPLONt0tf56asHhnziJo5sNa58eH+rZj40W1M5ay4p+E1jKij
         pqykiOV2JhU9gp1Xexn1PJdtBes9WhPa9apK3MlnoCCWsrV4sogfbGnb6HGUFoq9yqzB
         vv+lgXyNXUgL4pKOzJmbiLSjucWxRHYjijJq+QquNEZjiYOGaduOv2+Vow4N5fmt0+0i
         d4X+0YkjjygzOCh/cSXNsJu9bsmdU5AfocOfnVpal7G5A0gJ6OVfKR3BVtRmI4d3oFYp
         Ba/1XdMXD4U05wDKoq1CVWZYAlAN9cPwtzDTr2aLrhJ37EC/B9L5vUdpWFMtgOynB7wP
         xIVQ==
X-Gm-Message-State: APjAAAWijoUkmkwHKD3vZrrOEDSqhL3xhnRCD8lg4u9K0IvgkugLVeHv
        5n1hDJhRxj5ECW7Dfc8yCHs=
X-Google-Smtp-Source: APXvYqx5Phe+tjQL0m27SnKxFs9iFF7GIhMxugJHFJoufoSldRhCOGKLfLKLm/6wyJf+QhXU/gKk7w==
X-Received: by 2002:ac2:4825:: with SMTP id 5mr38171910lft.64.1554277263492;
        Wed, 03 Apr 2019 00:41:03 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x10sm3030482lff.45.2019.04.03.00.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 00:41:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1hBaWS-0001Yt-KP; Wed, 03 Apr 2019 09:41:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] Revert "tty: fix NULL pointer issue when tty_port ops is not set"
Date:   Wed,  3 Apr 2019 09:40:53 +0200
Message-Id: <20190403074053.5961-1-johan@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f4e68d58cf2b20a581759bbc7228052534652673.

TTY drivers using the tty-port abstraction all provide a pointer to a
set of port operations, which specifically cannot be NULL (or we'd find
out at first attempt to open a port).

Revert the recent commit which added unnecessary NULL-checks and whose
commit message indicated that it was fixing a real problem, which it did
not.

Note that even the two tty drivers for virtual devices currently
providing an empty set of operations probably should be implementing at
least some of the callbacks.

Cc: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This reverts a commit that got into -rc3 despite not really fixing
anything.

Johan




 drivers/tty/tty_port.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index a9e12b3bc31d..044c3cbdcfa4 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -325,7 +325,7 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 		if (tty && C_HUPCL(tty))
 			tty_port_lower_dtr_rts(port);
 
-		if (port->ops && port->ops->shutdown)
+		if (port->ops->shutdown)
 			port->ops->shutdown(port);
 	}
 out:
@@ -398,7 +398,7 @@ EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
  */
 int tty_port_carrier_raised(struct tty_port *port)
 {
-	if (!port->ops || !port->ops->carrier_raised)
+	if (port->ops->carrier_raised == NULL)
 		return 1;
 	return port->ops->carrier_raised(port);
 }
@@ -414,7 +414,7 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
-	if (port->ops && port->ops->dtr_rts)
+	if (port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 1);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
@@ -429,7 +429,7 @@ EXPORT_SYMBOL(tty_port_raise_dtr_rts);
  */
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
-	if (port->ops && port->ops->dtr_rts)
+	if (port->ops->dtr_rts)
 		port->ops->dtr_rts(port, 0);
 }
 EXPORT_SYMBOL(tty_port_lower_dtr_rts);
@@ -684,7 +684,7 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 
 	if (!tty_port_initialized(port)) {
 		clear_bit(TTY_IO_ERROR, &tty->flags);
-		if (port->ops && port->ops->activate) {
+		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
 			if (retval) {
 				mutex_unlock(&port->mutex);
-- 
2.21.0

