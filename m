Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A0FC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BFF216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934238;
	bh=43W3IJXwTnhwsItxfOvtq/5NvvS0V1W8cRubBxab6o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5U++YZne9aYRbiEA3wez1jikwu97enTH8fPUmyR7Q9IMoSaVFFo+SdLM5FY98yVo
	 mvYQjs3GzVUqL1F61dyAP94kwXv2xHPA0YLLXMNB6wgOq1WykAa01BG6J45tAMnnFp
	 40QwTg3hh+uZlsP8tPP2tLtBYAQhMFlV9teyzfFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfGLMX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfGLMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:23:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBD321670;
        Fri, 12 Jul 2019 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934225;
        bh=43W3IJXwTnhwsItxfOvtq/5NvvS0V1W8cRubBxab6o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJG+/7bKyfeJkFlsy21Cb36Wy4fA5sD+4uBoIpad1rba4g3ZXV5A9L0i7FsxVYuAl
         boo6tzZSmcPiKAj//kh9y0OztVAxB/4RMrPgw4spqtd8wuU5PMkUXwvNAAaJzvAdlt
         a1u03wuJV39djdUkIPeo9NEJV4q/fJX/NUWjBzbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 76/91] drivers/usb/typec/tps6598x.c: fix portinfo width
Date:   Fri, 12 Jul 2019 14:19:19 +0200
Message-Id: <20190712121625.890370354@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

commit 05da75fc651138e51ff74ace97174349910463f5 upstream.

Portinfo bit field is 3 bits wide, not 2 bits. This led to
a wrong driver configuration for some tps6598x configurations.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tps6598x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -39,7 +39,7 @@
 #define TPS_STATUS_VCONN(s)		(!!((s) & BIT(7)))
 
 /* TPS_REG_SYSTEM_CONF bits */
-#define TPS_SYSCONF_PORTINFO(c)		((c) & 3)
+#define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
 
 enum {
 	TPS_PORTINFO_SINK,


