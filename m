Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623CFC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3224B2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935294;
	bh=0ahWQ9AhpV31pXGOghdJciw1LpUI/KQKn1do30aGqjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bc0o0tDgFjlXZHi6LKgoiCqWo/qs1qZW+1IfWNdsFF5SPsRUtD/FMR+ZfVPDHDPDH
	 l8g+3ULcN6zx/2npMtS8cabHj6efuR1Qz7Og41npw416Ne2rdjD9yRi4ryAE9GT1gS
	 V74xY/9VC4FdsUYw4pyw2jgxJX1tCikBKYy7xccI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfGLMYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfGLMXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:23:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFACB2166E;
        Fri, 12 Jul 2019 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934228;
        bh=0ahWQ9AhpV31pXGOghdJciw1LpUI/KQKn1do30aGqjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=06pQny0vAIA2MOnvj+6lOApGvWyIca7DF2Fhs5n9gjJCK8TKK8WVPSLD4T0PB0Uso
         SovtxYRDXS5l9H+ReqCIC3/mo3g8kwFU7G/LFhR3MQ7N487QmXPYIdTa6R6KZV6C9T
         MINeb4VE4epiuxkmbwoDyCBem/KAAQkePujRXB10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 77/91] drivers/usb/typec/tps6598x.c: fix 4CC cmd write
Date:   Fri, 12 Jul 2019 14:19:20 +0200
Message-Id: <20190712121625.937102695@linuxfoundation.org>
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
@@ -111,7 +111,7 @@ tps6598x_block_read(struct tps6598x *tps
 }
 
 static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
-				void *val, size_t len)
+				const void *val, size_t len)
 {
 	u8 data[TPS_MAX_LEN + 1];
 
@@ -157,7 +157,7 @@ static inline int tps6598x_write64(struc
 static inline int
 tps6598x_write_4cc(struct tps6598x *tps, u8 reg, const char *val)
 {
-	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
+	return tps6598x_block_write(tps, reg, val, 4);
 }
 
 static int tps6598x_read_partner_identity(struct tps6598x *tps)


