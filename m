Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C4C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B9821019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjyQkj7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfELHeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:34:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36534 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfELHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:34:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so5484129pfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 00:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H0+LmogM3GLKaJMU3MRnaarXZWsUodWXuFPSXeKH1WE=;
        b=IjyQkj7xl3GgiPaImDhIyLTEs8iaUpxq/vNMReK1tQpiRGmxbSY8M/8qw0mKutbReA
         j0zUOZ/Y02Zbh7x2VY1JUpt2YAs6Y5qD10oSVpyvC95Zw+I3H0CIE78qnGmXwiH77Jmm
         I29rw4KRLh8k+CNnKP4dP/O1QfW5S4yX8Z5BvMD76uIWM2wYXw/Sq7D6y6LU69R3qkWr
         GHzd5ljrukSOp0igTKdlb0g+CknUwwmnYeff2CCIZpOLEyViQIqTkvOBguz3eV3IlRoG
         kp6AXfarvZsHNqO1rRTaxt5P3mQs0Qp6/CZ7NYGRZe4fVdX+tLASevSx0KM9oYGjr+eA
         iibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H0+LmogM3GLKaJMU3MRnaarXZWsUodWXuFPSXeKH1WE=;
        b=U3SGvrXt/yhvvAElk89mYmJufdR2jikIiFD7BUi3zRtFPDNJuIkUvKDPteMwBxpLCe
         +HPY+4udRNiNHwITDyMXw6OH7qy+A3P5Ic+byGLzVMWz4sr1WoYLhqC4r2KTRridY6gi
         vCBmb4cg/wWquxPwMAfp8ccwHyy6d8uZ6hb5+iswtE73uQlZNN5A46SzGM1pv++w/Exj
         JhVMk31+23JzXVsHYQO6KIlWsJKcDnlUlMcoD1eceV0+Buvctd1SpKxqvADyCypKIQwY
         5SEghZ1R5W8grIe5UHAN/6fWikowCUQJsR51WM7+w+wLdu6BQr5t9gNPR9afb2vJ9E8L
         Y2ng==
X-Gm-Message-State: APjAAAVS+ObrIX9RXbx2FQRIwWQ8quy/fj+AjfkzXCcKAHxvBRcVIl2n
        p3IRf/HjKPuqAmShI4x9LyXE4d9SnfE=
X-Google-Smtp-Source: APXvYqyJPec7nL8A/5g53aYdyvonT/ofsOe9co6ivSncXmsdKS3UBIgAMXcYyNCFwmG/Ji6js3O4gQ==
X-Received: by 2002:a63:7c55:: with SMTP id l21mr466671pgn.121.1557646485754;
        Sun, 12 May 2019 00:34:45 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e123sm5492242pgc.29.2019.05.12.00.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 00:34:44 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH V3 2/5] nvme-trace: Support tracing fabrics commands from host-side
Date:   Sun, 12 May 2019 16:34:10 +0900
Message-Id: <20190512073413.32050-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for tracing fabrics commands detected from
host-side.  We can have trace_nvme_setup_cmd for nvme and nvme fabrics
both even fabrics submission queue entry does not have valid fields in
where nvme's fields are valid.

This patch modifies existing parse_nvme_cmd to have fctype as an
argument to support fabrics command which will be ignored in case of
nvme common case.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/trace.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/trace.h | 41 +++++++++++++++++++++------
 2 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/trace.c b/drivers/nvme/trace.c
index a2c8186d122d..88dfadb68b92 100644
--- a/drivers/nvme/trace.c
+++ b/drivers/nvme/trace.c
@@ -137,6 +137,73 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 	}
 }
 
+static const char *nvme_trace_fabrics_property_set(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 attrib = spc[0];
+	u32 ofst = get_unaligned_le32(spc + 4);
+	u64 value = get_unaligned_le64(spc + 8);
+
+	trace_seq_printf(p, "attrib=%u, ofst=0x%x, value=0x%llx",
+				attrib, ofst, value);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_fabrics_connect(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u16 recfmt = get_unaligned_le16(spc);
+	u16 qid = get_unaligned_le16(spc + 2);
+	u16 sqsize = get_unaligned_le16(spc + 4);
+	u8 cattr = spc[6];
+	u32 kato = get_unaligned_le32(spc + 8);
+
+	trace_seq_printf(p, "recfmt=%u, qid=%u, sqsize=%u, cattr=%u, kato=%u",
+				recfmt, qid, sqsize, cattr, kato);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_fabrics_property_get(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u8 attrib = spc[0];
+	u32 ofst = get_unaligned_le32(spc + 4);
+
+	trace_seq_printf(p, "attrib=%u, ofst=0x%x", attrib, ofst);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p,
+					 u8 fctype, u8 *spc)
+{
+	switch (fctype) {
+	case nvme_fabrics_type_property_set:
+		return nvme_trace_fabrics_property_set(p, spc);
+	case nvme_fabrics_type_connect:
+		return nvme_trace_fabrics_connect(p, spc);
+	case nvme_fabrics_type_property_get:
+		return nvme_trace_fabrics_property_get(p, spc);
+	default:
+		return nvme_trace_fabrics_common(p, spc);
+	}
+}
+
 const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
diff --git a/drivers/nvme/trace.h b/drivers/nvme/trace.h
index acf10c7a5bef..7fbfd6cb815c 100644
--- a/drivers/nvme/trace.h
+++ b/drivers/nvme/trace.h
@@ -57,18 +57,39 @@
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
 		nvme_opcode_name(nvme_cmd_resv_release))
 
-#define show_opcode_name(qid, opcode)					\
-	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
+#define nvme_fabrics_type_name(type)	{ type, #type }
+#define show_fabrics_type_name(type)					\
+	__print_symbolic(type,						\
+		nvme_fabrics_type_name(nvme_fabrics_type_property_set),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_connect),	\
+		nvme_fabrics_type_name(nvme_fabrics_type_property_get))
+
+/*
+ * If not fabrics, fctype will be ignored.
+ */
+#define show_opcode_name(qid, opcode, fctype)				\
+	((opcode != nvme_fabrics_command) ?				\
+		(qid ?							\
+			show_nvm_opcode_name(opcode) :			\
+			show_admin_opcode_name(opcode)) :		\
+		show_fabrics_type_name(fctype))
 
 const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
 		u8 *cdw10);
 const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
 		u8 *cdw10);
+const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p,
+		u8 fctype, u8 *spc);
 
-#define parse_nvme_cmd(qid, opcode, cdw10) 			\
-	(qid ?							\
-	 nvme_trace_parse_nvm_cmd(p, opcode, cdw10) : 		\
-	 nvme_trace_parse_admin_cmd(p, opcode, cdw10))
+/*
+ * If not fabrics, fctype will be ignored.
+ */
+#define parse_nvme_cmd(qid, opcode, fctype, cdw10)			\
+	((opcode != nvme_fabrics_command) ?				\
+		(qid ?							\
+			nvme_trace_parse_nvm_cmd(p, opcode, cdw10) : 	\
+			nvme_trace_parse_admin_cmd(p, opcode, cdw10)) :	\
+		nvme_trace_parse_fabrics_cmd(p, fctype, cdw10))
 
 const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
 #define __print_disk_name(name)				\
@@ -95,6 +116,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__field(u8, flags)
 		__field(u16, cid)
 		__field(u32, nsid)
+		__field(u8, fctype)
 		__field(u64, metadata)
 		__array(u8, cdw10, 24)
 	    ),
@@ -105,6 +127,7 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->flags = cmd->common.flags;
 		__entry->cid = cmd->common.command_id;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
+		__entry->fctype = __entry->nsid & 0xff;
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
 		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
@@ -114,8 +137,10 @@ TRACE_EVENT(nvme_setup_cmd,
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
 		      __entry->qid, __entry->cid, __entry->nsid,
 		      __entry->flags, __entry->metadata,
-		      show_opcode_name(__entry->qid, __entry->opcode),
-		      parse_nvme_cmd(__entry->qid, __entry->opcode, __entry->cdw10))
+		      show_opcode_name(__entry->qid, __entry->opcode,
+					__entry->fctype),
+		      parse_nvme_cmd(__entry->qid, __entry->opcode,
+					__entry->fctype, __entry->cdw10))
 );
 
 TRACE_EVENT(nvme_complete_rq,
-- 
2.17.1

