Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3C12063F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nP+Bu3nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCNHWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:22:00 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54114 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfCNHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:21:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 6045AC25
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YCPUVPd1aQ7D for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:21:58 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 2EB99B6E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:21:58 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id z22so3619923iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YBr0usQK7wMacqcLascgypxxxEWqIaYE9RG4sZwZRvo=;
        b=nP+Bu3nu4kmGbwCECjTbt7fk9KdIXa7OcUxdZFFZVepyZqG0CecG8wWnU2+D5V5RSs
         uJMzQc5w0FZ0/rCn3hJiQsveWsbQBGlC2aZwxnfnkqlRi4dwKBE5ozU/CyegU56+GzPs
         PrgBGgyy4wslYXwMySDlKptx5iuNKMrUSvXPl8OjW+bAuvWsNv4lgXCsyxr7lIF4qVT1
         R1ON1MOEh+a8lFcyT93DcAdADFrDAIRXidiGlF6JYho7SV0y5jKGViduW2KaS9luHka+
         6mywVQWzhfttfQAGl9C8BhShN2lDKxZuT8xFFq9PHgeWa+V9S8gCsyRut7GcqGO+ltMf
         hytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YBr0usQK7wMacqcLascgypxxxEWqIaYE9RG4sZwZRvo=;
        b=W+BJmvSbCKz0da72lJxVV17Lvt3j6DijieF4DMqcIJlrZuH8fBJ3J8b2Ftxxkmg5SL
         JJF1rKjiqWznNQ9bGfzuJN8eVpJl6HjWEO7MyCHjcPwWhbjNb5xYszKghtjSHWBFEc/E
         dhblalVcFR0Fy1TxCWzyJyndeP7twJ2zD73vWB3GBhQ1af/zNhdHlLjbYKEGlh+WBM3D
         xbSgaMf+qn7CYKnH7iAS4MAix9i2vM+O2JiAoJOwA7N+/5bpskG5z6gI8ABG6FsPC5gC
         I91rSZe56990LDJ21B16PVg6MLW1KFh+Hf5eENKy1lzwptwm728sGrGs5W6mFv734w8j
         9Mrg==
X-Gm-Message-State: APjAAAVmdznCsuDELpKDJIPvPGD9ZTySKDG97v3SgWpue8lyx36ZpTfW
        UTE9TYcJqjt/qGKvoNC5R2I5UBwIXzIAkYdtKUpwLxHnOSbAozxdYfJIEeAGt2I8fX92ePLjE4f
        WoU9WhuQQdsS+R/TJ2W9pCHdrJlrj
X-Received: by 2002:a24:bdcc:: with SMTP id x195mr1192018ite.149.1552548117830;
        Thu, 14 Mar 2019 00:21:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEer2dfTZGDGqdpHwtx5soL+tR30KuNDdECpOXfZelxhWf/LoJEQwfJ0PerUi/pJLz/RjiGw==
X-Received: by 2002:a24:bdcc:: with SMTP id x195mr1192009ite.149.1552548117639;
        Thu, 14 Mar 2019 00:21:57 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id t73sm849490itt.15.2019.03.14.00.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:21:56 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: mxs-auart: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 02:21:51 -0500
Message-Id: <20190314072151.19753-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix returns -ENOMEM to avoid NULL
pointer dereferences.
Multiple places use port.membase.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/serial/mxs-auart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 27235a526cce..4c188f4079b3 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1686,6 +1686,10 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	s->port.mapbase = r->start;
 	s->port.membase = ioremap(r->start, resource_size(r));
+	if (!s->port.membase) {
+		ret = -ENOMEM;
+		goto out_disable_clks;
+	}
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;
-- 
2.17.1

