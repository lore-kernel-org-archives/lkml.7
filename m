Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654C6218FE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139170;
	bh=rFjbOwInaCRtIEqp2+vlNlmhK2N4L0DteTaakIvjVyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LzmR+/KCsnKj+iS5dcKXnJhK+BoBmOVSGsxAv/HK1yq6tUO+g3czpDsl+fcOqBlWf
	 UaUZH/sSDbVhr/AAjwgW1PTvwSFTpJNgh1hz6fEfXLJ2HOkH+cVquWwJT7u9wUTNbB
	 fX+Wxzzn/IGBelnOTxGN7zWO/aO8H7MSzbOD34SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfDART3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730737AbfDART1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:19:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A29A2133D;
        Mon,  1 Apr 2019 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139165;
        bh=rFjbOwInaCRtIEqp2+vlNlmhK2N4L0DteTaakIvjVyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3HG6HUquNsNJrzxEp7nJMCahe6+gDS0N4LfcDoc/BHA+cTZEkUk/5C4ZNp068pJ4
         LlRdzU2ak3lSH5V4M/IEqpabnOscaY5bz8NltU25iR46XG/yyxN0dncvVy4FmWY8q/
         RlB/PMwF050TTBQlmI8wHqLkUqY3NNwvrycputEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 133/134] usb: typec: class: Dont use port parent for getting mux handles
Date:   Mon,  1 Apr 2019 19:02:49 +0200
Message-Id: <20190401170056.600655791@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 23481121c81d984193edf1532f5e123637e50903 upstream.

It is not possible to use the parent of the port device when
requesting mux handles as the parent may be a multiport USB
Type-C or PD controller. The muxes must be assigned to the
ports, not the controllers.

This will also move the requesting of the muxes after the
port device is initialized.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/usb/typec/class.c |   38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1500,7 +1500,7 @@ typec_port_register_altmode(struct typec
 
 	sprintf(id, "id%04xm%02x", desc->svid, desc->mode);
 
-	mux = typec_mux_get(port->dev.parent, id);
+	mux = typec_mux_get(&port->dev, id);
 	if (IS_ERR(mux))
 		return ERR_CAST(mux);
 
@@ -1540,18 +1540,6 @@ struct typec_port *typec_register_port(s
 		return ERR_PTR(id);
 	}
 
-	port->sw = typec_switch_get(cap->fwnode ? &port->dev : parent);
-	if (IS_ERR(port->sw)) {
-		ret = PTR_ERR(port->sw);
-		goto err_switch;
-	}
-
-	port->mux = typec_mux_get(parent, "typec-mux");
-	if (IS_ERR(port->mux)) {
-		ret = PTR_ERR(port->mux);
-		goto err_mux;
-	}
-
 	switch (cap->type) {
 	case TYPEC_PORT_SRC:
 		port->pwr_role = TYPEC_SOURCE;
@@ -1592,13 +1580,26 @@ struct typec_port *typec_register_port(s
 	port->port_type = cap->type;
 	port->prefer_role = cap->prefer_role;
 
+	device_initialize(&port->dev);
 	port->dev.class = typec_class;
 	port->dev.parent = parent;
 	port->dev.fwnode = cap->fwnode;
 	port->dev.type = &typec_port_dev_type;
 	dev_set_name(&port->dev, "port%d", id);
 
-	ret = device_register(&port->dev);
+	port->sw = typec_switch_get(&port->dev);
+	if (IS_ERR(port->sw)) {
+		put_device(&port->dev);
+		return ERR_CAST(port->sw);
+	}
+
+	port->mux = typec_mux_get(&port->dev, "typec-mux");
+	if (IS_ERR(port->mux)) {
+		put_device(&port->dev);
+		return ERR_CAST(port->mux);
+	}
+
+	ret = device_add(&port->dev);
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
 		put_device(&port->dev);
@@ -1606,15 +1607,6 @@ struct typec_port *typec_register_port(s
 	}
 
 	return port;
-
-err_mux:
-	typec_switch_put(port->sw);
-
-err_switch:
-	ida_simple_remove(&typec_index_ida, port->id);
-	kfree(port);
-
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(typec_register_port);
 


