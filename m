Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD7C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D502084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934807;
	bh=IgWL7JR/zNeYKbzq/yT6N7TKzUk4cfGySnj9gWoIP/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9god+4EKlfGvw7h3lLEJC7dcbE2oNbRIujyU4GdE+BuH8tfN6y5bw6EV92rgx7GR
	 nf662NRel7IkptwXiKxbfqQ2DWyEEE9s2j153QI68vMxX3EYfkzj0/yfUum6PzIHU1
	 rSUVhlPAdtvyEEBsZDmsgroUfnmb+V5mwWFi6GhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfGLMdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbfGLMdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:33:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33B48208E4;
        Fri, 12 Jul 2019 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934798;
        bh=IgWL7JR/zNeYKbzq/yT6N7TKzUk4cfGySnj9gWoIP/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gn9RegqyFefh2I8lkQeE1hGO/yrBt1N83rDk0DlvFLMNA37JRYVZC0QcetWf6aDku
         eP/KhGWuBxYdJxc09UxfYYKVZ00FmcdvA/FNRnPDGwqMHpCzif+kmVw6lF0kybz7qQ
         twEUo8On9e4m2AGaJb+ExBUBajc9zLk72eUWUeWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.2 33/61] drivers/usb/typec/tps6598x.c: fix 4CC cmd write
Date:   Fri, 12 Jul 2019 14:19:46 +0200
Message-Id: <20190712121622.374762019@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

commit 2681795b5e7a5bf336537661010072f4c22cea31 upstream.

Writing 4CC commands with tps6598x_write_4cc() already has
a pointer arg, don't reference it when using as arg to
tps6598x_block_write(). Correcting this enforces the constness
of the pointer to propagate to tps6598x_block_write(), so add
the const qualifier there to avoid the warning.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tps6598x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -127,7 +127,7 @@ tps6598x_block_read(struct tps6598x *tps
 }
 
 static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
-				void *val, size_t len)
+				const void *val, size_t len)
 {
 	u8 data[TPS_MAX_LEN + 1];
 
@@ -173,7 +173,7 @@ static inline int tps6598x_write64(struc
 static inline int
 tps6598x_write_4cc(struct tps6598x *tps, u8 reg, const char *val)
 {
-	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
+	return tps6598x_block_write(tps, reg, val, 4);
 }
 
 static int tps6598x_read_partner_identity(struct tps6598x *tps)


