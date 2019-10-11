Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F67C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7C12190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="PXwWQ12r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfJKMZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:25:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfJKMZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:25:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so10236940wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dAeqKC6K8N5cmj43hqb8ltvoAlQKh/8rOuZ6jadV1rQ=;
        b=PXwWQ12ryqAtScNi+fsKIt0TugXL72/xc9tn8VUNg3QrNC9hEXVSGDbf7FI8gJJTJu
         b4/iUyR0aKwuCEfRL35Cl7fNUXUzVUaBDHEkfJhozUd0gdyZf6v0ShUOrhcPeYfDTgLh
         rapPPtaRCJpk6jTJujuvzPDElc4bpE9ziUaqJKaprvFPAeomxQLo5Isw33CYPyF7DLpV
         XtU/wpT1n51kb8V8IfberAtswU3odsVNkvNEB5mi1JPCr0AOT89m6V9u/1ZvbKQQywtm
         BVrqUkD8VG2uGzHd8BPq8wcd3RbwdIqK8+gt1sgEPxFcf+3XwwARMMKks/RrfvphPy3v
         7fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dAeqKC6K8N5cmj43hqb8ltvoAlQKh/8rOuZ6jadV1rQ=;
        b=jrOUOPwV5E9CmfC7WaF+S1lLOo6J1mZByvDlgoV98cx5eLtt2gAIWBUwkZiNryQORF
         JMn8KjmG93q4wiu9FFFoFWb+yWagNqU9KYXOSwQKq+dhNGL7PXN2xoZRzhWS/WIHuUSb
         t5F/7yQGxnxbC3N0p+5r+yTTVQfonhjnz2cex3bM+sHjptqnp6gTyjm12a6PlBmhzjMB
         zqn413J6EZhfEvXkiPTyUCfqFbv3WKFFKPn5RqJYuanp8d+sk+aLHxuOJBU1VRPjYi7+
         4mc4hdHGtB6wnoYN9fSTi0QlQl1rw+VtViPl4dIZj49waEazvU+2z/vI2XQHuMC2QlW5
         gavw==
X-Gm-Message-State: APjAAAUpkwRt7D4Mw/JE1mAiCRo8GOignIakTrBVRrJHJsQnkzx9CQ3F
        Vmg0rcGvIwSsIlw0M6VFWxnHcQ==
X-Google-Smtp-Source: APXvYqyxYzZRXHizqJaH2ICva0jBHO3ev/z1lE9hZ0uo7/8DpmdncsUxaMH3fe+/ASRYpJ35+6mIeg==
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr3094964wmg.10.1570796702317;
        Fri, 11 Oct 2019 05:25:02 -0700 (PDT)
Received: from baileys.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id n15sm9416044wrw.47.2019.10.11.05.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:25:01 -0700 (PDT)
From:   Joel Colledge <joel.colledge@linbit.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Joel Colledge <joel.colledge@linbit.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is set
Date:   Fri, 11 Oct 2019 14:24:08 +0200
Message-Id: <20191011122409.23868-1-joel.colledge@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PRINTK_CALLER is set, struct printk_log contains an
additional member caller_id. This affects the offset of the log text.
Account for this by using the type information from gdb to determine all
the offsets instead of using hardcoded values.

This fixes following error:

  (gdb) lx-dmesg
  Python Exception <class 'ValueError'> embedded null character:
  Error occurred in Python command: embedded null character

Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
---
Changes in v2:
- use type information from gdb instead of hardcoded offsets

Thanks for the idea about using the struct layout info from gdb, Leonard. I can't see any reason we shouldn't use that here, since most of the other commands use it. LxDmesg has used hardcoded offsets since scripts/gdb was introduced, so I assume it just ended up like that during the initial development of the tool. Here is a version of the fix using offsets from gdb.

 scripts/gdb/linux/dmesg.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index 6d2e09a2ad2f..8f5d899029b7 100644
--- a/scripts/gdb/linux/dmesg.py
+++ b/scripts/gdb/linux/dmesg.py
@@ -16,6 +16,8 @@ import sys
 
 from linux import utils
 
+printk_log_type = utils.CachedType("struct printk_log")
+
 
 class LxDmesg(gdb.Command):
     """Print Linux kernel log buffer."""
@@ -42,9 +44,14 @@ class LxDmesg(gdb.Command):
             b = utils.read_memoryview(inf, log_buf_addr, log_next_idx)
             log_buf = a.tobytes() + b.tobytes()
 
+        length_offset = printk_log_type.get_type()['len'].bitpos // 8
+        text_len_offset = printk_log_type.get_type()['text_len'].bitpos // 8
+        time_stamp_offset = printk_log_type.get_type()['ts_nsec'].bitpos // 8
+        text_offset = printk_log_type.get_type().sizeof
+
         pos = 0
         while pos < log_buf.__len__():
-            length = utils.read_u16(log_buf[pos + 8:pos + 10])
+            length = utils.read_u16(log_buf[pos + length_offset:pos + length_offset + 2])
             if length == 0:
                 if log_buf_2nd_half == -1:
                     gdb.write("Corrupted log buffer!\n")
@@ -52,10 +59,11 @@ class LxDmesg(gdb.Command):
                 pos = log_buf_2nd_half
                 continue
 
-            text_len = utils.read_u16(log_buf[pos + 10:pos + 12])
-            text = log_buf[pos + 16:pos + 16 + text_len].decode(
+            text_len = utils.read_u16(log_buf[pos + text_len_offset:pos + text_len_offset + 2])
+            text = log_buf[pos + text_offset:pos + text_offset + text_len].decode(
                 encoding='utf8', errors='replace')
-            time_stamp = utils.read_u64(log_buf[pos:pos + 8])
+            time_stamp = utils.read_u64(
+                log_buf[pos + time_stamp_offset:pos + time_stamp_offset + 8])
 
             for line in text.splitlines():
                 msg = u"[{time:12.6f}] {line}\n".format(
-- 
2.17.1

