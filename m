Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4480FECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F183206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="zcN2XJMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfJKOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:25:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44512 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfJKOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:25:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so12153034wrl.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ossvRx05IYfgmb+L7YK41jCp4qvCD8EACWzotuphPTA=;
        b=zcN2XJMg5UKi+PLY/ousrsreQET2GihDk+a9LgNUqRnwfPKOzbN19csAwvn6uBGssN
         vk8IF2UXIGlC/OrLe6Q4ovQYz4UHPjlstNHm8UxuaoyVQJV9DHT7kzUGy4dekVAgRmRY
         KuHI7BYesaUXSvTBG9dsuQf2+qPwmqiGASEy6JP96BZMpatYP1LDj0X7RWIeCk/H7TP/
         I95AuTt1saj5c/Vjpk8ax2uMxuNVxQOdm4/SzWo+GBOPng86Y5vzBpLB3/eOs7zTgLDb
         Xv0trThcHQwutVzyb1NiqIY4IVLzfvRpFx5Hf1RJxAf8aMFUMk8+C1nVGc/T1Pml784F
         Mtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ossvRx05IYfgmb+L7YK41jCp4qvCD8EACWzotuphPTA=;
        b=gJiUMSX/ZMoGe/hmcFZbhMLjonSXZ4J2Pab6yovNfdsJ37UA9drA5+//ENDGm0rGCm
         iFxg4mArvYNuSGZockHLmU7YkYG0PHk3HKQA1oms9muCy4aPVvJMTzT1e5whOv3Yledg
         9H6oZ6YOUtBWJswmXcBbG/idRwJHaWz0bMHLT0tBMYqoigvT83dZtgVWvkFwqsa27YWb
         sj+JeZQU712ca6238xdlnxIi4QQ1CNU1H/mJWOZv8DWoTkPhJGDkRWd/g7FXVG8bCq5e
         ok2mPhiwg0/vlSliua3tX50cslsq45U9Uk1QP9R5h2UFZAAO6NPUWy3vP9Otlf/EcSPr
         U6rA==
X-Gm-Message-State: APjAAAV2L2c+G0QCV0CmUXSfVHQGyjihpS779iqOXXxXOmr83yrdfdY+
        kL5v7q8uYK0Jtv2CxNVijOcspxCs+ps=
X-Google-Smtp-Source: APXvYqzd4vHEYSX5FZH58LJFaMWX1zLpHxINqxhLSTMGFH6y7mO9Q01jEvFe1wqfEpuTKH+2O/xMMA==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr12942670wrc.251.1570803941488;
        Fri, 11 Oct 2019 07:25:41 -0700 (PDT)
Received: from baileys.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id l13sm9553399wmj.25.2019.10.11.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:25:41 -0700 (PDT)
From:   Joel Colledge <joel.colledge@linbit.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH v3] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is set
Date:   Fri, 11 Oct 2019 16:25:00 +0200
Message-Id: <20191011142500.2339-1-joel.colledge@linbit.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAGNP_+U-5bUysiwLN9fL0+d__GKOc_5Ak9MDKi6EeeSzPCK-Lw@mail.gmail.com>
References: <CAGNP_+U-5bUysiwLN9fL0+d__GKOc_5Ak9MDKi6EeeSzPCK-Lw@mail.gmail.com>
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

The read_u* utility functions now take an offset argument to make them
easier to use.

Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
---
Changes in v3:
- fix some overlong lines and generally make the code more readable by
  pushing the slicing down into the read_u* helper functions

In general, I would consider slicing to be more "pythonic" than passing
around offsets. However, in this case we always want to slice with
(offset, length), rather than (start, end), so the normal slicing syntax
is not very helpful. Rather than writing [a:a+b] everywhere I just
decided to pass the whole buffer and an offset to the read_u* helpers.

 scripts/gdb/linux/dmesg.py | 16 ++++++++++++----
 scripts/gdb/linux/utils.py | 25 +++++++++++++------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index 6d2e09a2ad2f..2fa7bb83885f 100644
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
+            length = utils.read_u16(log_buf, pos + length_offset)
             if length == 0:
                 if log_buf_2nd_half == -1:
                     gdb.write("Corrupted log buffer!\n")
@@ -52,10 +59,11 @@ class LxDmesg(gdb.Command):
                 pos = log_buf_2nd_half
                 continue
 
-            text_len = utils.read_u16(log_buf[pos + 10:pos + 12])
-            text = log_buf[pos + 16:pos + 16 + text_len].decode(
+            text_len = utils.read_u16(log_buf, pos + text_len_offset)
+            text_start = pos + text_offset
+            text = log_buf[text_start:text_start + text_len].decode(
                 encoding='utf8', errors='replace')
-            time_stamp = utils.read_u64(log_buf[pos:pos + 8])
+            time_stamp = utils.read_u64(log_buf, pos + time_stamp_offset)
 
             for line in text.splitlines():
                 msg = u"[{time:12.6f}] {line}\n".format(
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index bc67126118c4..ea94221dbd39 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -92,15 +92,16 @@ def read_memoryview(inf, start, length):
     return memoryview(inf.read_memory(start, length))
 
 
-def read_u16(buffer):
+def read_u16(buffer, offset):
+    buffer_val = buffer[offset:offset + 2]
     value = [0, 0]
 
-    if type(buffer[0]) is str:
-        value[0] = ord(buffer[0])
-        value[1] = ord(buffer[1])
+    if type(buffer_val[0]) is str:
+        value[0] = ord(buffer_val[0])
+        value[1] = ord(buffer_val[1])
     else:
-        value[0] = buffer[0]
-        value[1] = buffer[1]
+        value[0] = buffer_val[0]
+        value[1] = buffer_val[1]
 
     if get_target_endianness() == LITTLE_ENDIAN:
         return value[0] + (value[1] << 8)
@@ -108,18 +109,18 @@ def read_u16(buffer):
         return value[1] + (value[0] << 8)
 
 
-def read_u32(buffer):
+def read_u32(buffer, offset):
     if get_target_endianness() == LITTLE_ENDIAN:
-        return read_u16(buffer[0:2]) + (read_u16(buffer[2:4]) << 16)
+        return read_u16(buffer, offset) + (read_u16(buffer, offset + 2) << 16)
     else:
-        return read_u16(buffer[2:4]) + (read_u16(buffer[0:2]) << 16)
+        return read_u16(buffer, offset + 2) + (read_u16(buffer, offset) << 16)
 
 
-def read_u64(buffer):
+def read_u64(buffer, offset):
     if get_target_endianness() == LITTLE_ENDIAN:
-        return read_u32(buffer[0:4]) + (read_u32(buffer[4:8]) << 32)
+        return read_u32(buffer, offset) + (read_u32(buffer, offset + 4) << 32)
     else:
-        return read_u32(buffer[4:8]) + (read_u32(buffer[0:4]) << 32)
+        return read_u32(buffer, offset + 4) + (read_u32(buffer, offset) << 32)
 
 
 target_arch = None
-- 
2.17.1

