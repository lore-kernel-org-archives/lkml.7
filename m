Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BCEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59F21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhlJ0TKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfKHFUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33715 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfKHFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay6so3300328plb.0;
        Thu, 07 Nov 2019 21:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrSCYYt5uv3Xj+d3we2tNppwdrCJ/ZJWLFSrmqcGBRo=;
        b=MhlJ0TKo/+JKtKDsOMJfCvSVaU7SRAI/53zvs21Uxpqd2fVltgOmhUw2wGVXjJrnf4
         XKChYSHwHr+2kYqjTLmrV2R7V7wvvKZ82xO2FPQUX/lWOj0PEjHJ+l0h0aKSNCVK2NSM
         JnShWoTenORutECEwhFeICjZPtHyKCEhNYuIavPPlGvLOoJFPDcupN4gzFccVChzYtdN
         f9dujcWhBvfV47wkYdlnoVYkhF0XoAaqKTtduVudVSLVSqb/SE2skJhfOLEybAub/SYT
         HewfHo12V3FZo/niFBwJ3Qc9IBaq5lvoIoA2DljwZ8UyF3mgEpLx61nJMdFpjmaivl4A
         Htog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BrSCYYt5uv3Xj+d3we2tNppwdrCJ/ZJWLFSrmqcGBRo=;
        b=aRaLr5SkVVsi7uVh8rWKU2ERogUppNgMmAylYsZ6J2fgh4OcuyYComW8KDGJLKmnWz
         iKX4ctgjOh5n0RkIepjelZrImQ0rrirRJLERqqKGqXXD0bDmZZpgjoDkWOZ/4CPBeNX9
         w50T4W3ayX9nLPdwP10yYuke9qDgpCtUZSz0oJGY0DpYQqQ7NKmnYL3baRCDBYL9JK8C
         OQmW8SnsEHbJ/BypmyAViWldfxpknH/umnfKV5lED3Tz+9Hs2DTlWuUOjpECrvh6Vlp8
         vO1JjHkp4TwEX6CC+eE15sBiCcO52mjVHufQ5d7ugWS9E0GKpYwiQ3rbh0K2KFxrcRhO
         6/GQ==
X-Gm-Message-State: APjAAAUl9MIcAp/0FFQjW8pDZOJ+ytzm4OQ1SFvcUGDqdd4lUcTd6Ua2
        cMcW02waLVLXylotIN85S9M=
X-Google-Smtp-Source: APXvYqyRzZcn8bDT1qTq02KNEt9UXS/4vlqBy54qzIiyqsiCXJfHND9OOB71hNviccEf9bdv8fJSAw==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7mr8100812plb.181.1573190453257;
        Thu, 07 Nov 2019 21:20:53 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:52 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 10/11] fsi: aspeed: Add trace points
Date:   Fri,  8 Nov 2019 15:49:44 +1030
Message-Id: <20191108051945.7109-11-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These trace points help with debugging the FSI master. They show the low
level reads, writes and error states of the master.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: remove unnecessary semicolon
---
 drivers/fsi/fsi-master-aspeed.c          | 22 +++++++
 include/trace/events/fsi_master_aspeed.h | 77 ++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 include/trace/events/fsi_master_aspeed.h

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index d1b83f035483..95e226ac78b9 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -77,6 +77,9 @@ static const u32 fsi_base = 0xa0000000;
 #define XFER_HALFWORD	(BIT(0))
 #define XFER_BYTE	(0)
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/fsi_master_aspeed.h>
+
 #define FSI_LINK_ENABLE_SETUP_TIME	10	/* in mS */
 
 #define DEFAULT_DIVISOR			14
@@ -102,6 +105,8 @@ static int __opb_write(struct fsi_master_aspeed *aspeed, u32 addr,
 
 	status = readl(base + OPB0_STATUS);
 
+	trace_fsi_master_aspeed_opb_write(addr, val, transfer_size, status, reg);
+
 	/* Return error when poll timed out */
 	if (ret)
 		return ret;
@@ -149,6 +154,10 @@ static int __opb_read(struct fsi_master_aspeed *aspeed, uint32_t addr,
 
 	result = readl(base + OPB0_FSI_DATA_R);
 
+	trace_fsi_master_aspeed_opb_read(addr, transfer_size, result,
+			readl(base + OPB0_STATUS),
+			reg);
+
 	/* Return error when poll timed out */
 	if (ret)
 		return ret;
@@ -196,6 +205,19 @@ static int check_errors(struct fsi_master_aspeed *aspeed, int err)
 {
 	int ret;
 
+	if (trace_fsi_master_aspeed_opb_error_enabled()) {
+		__be32 mresp0, mstap0, mesrb0;
+
+		opb_readl(aspeed, ctrl_base + FSI_MRESP0, &mresp0);
+		opb_readl(aspeed, ctrl_base + FSI_MSTAP0, &mstap0);
+		opb_readl(aspeed, ctrl_base + FSI_MESRB0, &mesrb0);
+
+		trace_fsi_master_aspeed_opb_error(
+				be32_to_cpu(mresp0),
+				be32_to_cpu(mstap0),
+				be32_to_cpu(mesrb0));
+	}
+
 	if (err == -EIO) {
 		/* Check MAEB (0x70) ? */
 
diff --git a/include/trace/events/fsi_master_aspeed.h b/include/trace/events/fsi_master_aspeed.h
new file mode 100644
index 000000000000..a355ceacc33f
--- /dev/null
+++ b/include/trace/events/fsi_master_aspeed.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsi_master_aspeed
+
+#if !defined(_TRACE_FSI_MASTER_ASPEED_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSI_MASTER_ASPEED_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(fsi_master_aspeed_opb_read,
+	TP_PROTO(uint32_t addr, size_t size, uint32_t result, uint32_t status, uint32_t irq_status),
+	TP_ARGS(addr, size, result, status, irq_status),
+	TP_STRUCT__entry(
+		__field(uint32_t,  addr)
+		__field(size_t,    size)
+		__field(uint32_t,  result)
+		__field(uint32_t,  status)
+		__field(uint32_t,  irq_status)
+		),
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->result = result;
+		__entry->status = status;
+		__entry->irq_status = irq_status;
+		),
+	TP_printk("addr %08x size %zu: result %08x sts: %08x irq_sts: %08x",
+		__entry->addr, __entry->size, __entry->result,
+		__entry->status, __entry->irq_status
+	   )
+);
+
+TRACE_EVENT(fsi_master_aspeed_opb_write,
+	TP_PROTO(uint32_t addr, uint32_t val, size_t size, uint32_t status, uint32_t irq_status),
+	TP_ARGS(addr, val, size, status, irq_status),
+	TP_STRUCT__entry(
+		__field(uint32_t,    addr)
+		__field(uint32_t,    val)
+		__field(size_t,    size)
+		__field(uint32_t,  status)
+		__field(uint32_t,  irq_status)
+		),
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->val = val;
+		__entry->size = size;
+		__entry->status = status;
+		__entry->irq_status = irq_status;
+		),
+	TP_printk("addr %08x val %08x size %zu status: %08x irq_sts: %08x",
+		__entry->addr, __entry->val, __entry->size,
+		__entry->status, __entry->irq_status
+		)
+	);
+
+TRACE_EVENT(fsi_master_aspeed_opb_error,
+	TP_PROTO(uint32_t mresp0, uint32_t mstap0, uint32_t mesrb0),
+	TP_ARGS(mresp0, mstap0, mesrb0),
+	TP_STRUCT__entry(
+		__field(uint32_t,  mresp0)
+		__field(uint32_t,  mstap0)
+		__field(uint32_t,  mesrb0)
+		),
+	TP_fast_assign(
+		__entry->mresp0 = mresp0;
+		__entry->mstap0 = mstap0;
+		__entry->mesrb0 = mesrb0;
+		),
+	TP_printk("mresp0 %08x mstap0 %08x mesrb0 %08x",
+		__entry->mresp0, __entry->mstap0, __entry->mesrb0
+		)
+	);
+
+#endif
+
+#include <trace/define_trace.h>
-- 
2.24.0.rc1

