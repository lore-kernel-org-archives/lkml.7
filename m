Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCC9C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B172A208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934802;
	bh=LBmyqgbnBKkr9u56Jmv6B6Cb4CS4Txs8SH1cF9sv1D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IMGjqlX1SAK9iODndVJp8J8r6XzjZgr4t/1hgprLm7iHq0nosZHJWTzm1BiRO0kWB
	 HJqiYaykmHkB8r7+F2ftLq9ZhhnRePu8QbXCpVwtmddVOY0eFQSRebiAFZ+KpJpTr0
	 eTZKYdf2P3h4T4IwDHgUZjY6He4EHh0qn6bHg13M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfGLMdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729590AbfGLMdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:33:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F732084B;
        Fri, 12 Jul 2019 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934795;
        bh=LBmyqgbnBKkr9u56Jmv6B6Cb4CS4Txs8SH1cF9sv1D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQxU4CqaM4lo/JV7fY2aHWtUnftCBZT358D7p5zhXAXMfgjH03Elu72AyD5DENYpW
         uPZwWFf81forblds5bKbJ07OxVmJK5CEw2cS8uLF4y+0ftMtIXR6AktpEAU5PAvdb0
         BC8XAkRZUBksBzmml+vhGxxspm1ooXzosZCGNIW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.2 32/61] drivers/usb/typec/tps6598x.c: fix portinfo width
Date:   Fri, 12 Jul 2019 14:19:45 +0200
Message-Id: <20190712121622.324355537@linuxfoundation.org>
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
@@ -41,7 +41,7 @@
 #define TPS_STATUS_VCONN(s)		(!!((s) & BIT(7)))
 
 /* TPS_REG_SYSTEM_CONF bits */
-#define TPS_SYSCONF_PORTINFO(c)		((c) & 3)
+#define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
 
 enum {
 	TPS_PORTINFO_SINK,


