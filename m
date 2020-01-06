Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282DFC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE62C24677
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBJzqMqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgAFHWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:22:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39478 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgAFHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:22:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so26463548pga.6;
        Sun, 05 Jan 2020 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8KLFzxRxYExyH52H7UNZCg0hoUieXXMXkUll3VBkONU=;
        b=tBJzqMqvW81xzhhOY++dmJPsO+C2SCdvVTWOLS2R81B/WZbgk1QEEwUwAm7sG31F3W
         Vyj9Ib8lVv8qrtILE/9otdMrke7M1xwFzCRG6H8SJJdc46zoxjTw4UyL/ORab3qQMNOa
         oQbbC+ppEUVorJj3P7wKtGKQ95M7HBa4p+oa5StqAvnk93jff0uk98siIsQHaHCxJ6lI
         DRD84Xblo+u0R/y/etC0Px9bcVr1JSEVW+D0XfM7PHRzXlQQDL5qV5230cPcrf7g8B6M
         RircBhj3uQOI8Y/AwlByaL8fOmsRhyrrG8NR2V9qmGwT9hPT1T9iMVPTsrnqN0TWDkWO
         Llew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8KLFzxRxYExyH52H7UNZCg0hoUieXXMXkUll3VBkONU=;
        b=BM572G86IhE1VYzAUSsM0iokec+Ff6knKd37xCUTKL5qCuZ1r/+c93+4ezFcOkh1yz
         6SwGwUVLSUBy0ovhNVeDLBDB60HEcQYAppl9CoAyCZX+l8fZZmwBwGSb/OLav5p4MkO0
         Tjk6hzqvmdCkHSSCLhZGM8LGUlBK324ZnmN1tiWNpHBuoeRSJPcTSHiEKO9RICjJs9px
         UDtQss8SqU0gcoZ1EwCBv4ow3bwWlUUrqjulstfolGpY2Xl9HpTLM5ABxA0xg4MZj+Hp
         zAG4plYS1xaUPeVGZ0ak3dkwm0ncpT8X+VPnZcnwcefVhh+VsGob6aQjVHV3eQCkXfpF
         acqw==
X-Gm-Message-State: APjAAAV9wrFu/hQ+53bJhiJktYGaR3fiix2JjySLt0t9KLGNG2XYhMfs
        X7dXnD7A0BKb1drUUlJbmkg=
X-Google-Smtp-Source: APXvYqxGI0VqXHfMLjgwAZ7JrhQE+GkLaOoQF2ExXhEiq632t3uetPaHYvplKcMmbeH+wE17YIGkOg==
X-Received: by 2002:a63:3750:: with SMTP id g16mr110918924pgn.413.1578295359855;
        Sun, 05 Jan 2020 23:22:39 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.131])
        by smtp.gmail.com with ESMTPSA id q8sm72968137pgg.92.2020.01.05.23.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 23:22:39 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v1 3/3] tty: documentation: abi: add ttyvs null modem driver sysfs nodes
Date:   Mon,  6 Jan 2020 12:51:55 +0530
Message-Id: <7d7c949890c4bdb12ecc9f8b15a5c0a69b7604a8.1578235515.git.gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
References: <cover.1578235515.git.gupt21@gmail.com>
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
References: <cover.1578235515.git.gupt21@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ttyvs driver exposes sysfs files to emulate various serial
port events. This commit document these files.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 .../ABI/testing/sysfs-devices-virtual-tty_ttyvs        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs

diff --git a/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs b/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
new file mode 100644
index 0000000..69b04e0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
@@ -0,0 +1,18 @@
+What:		/sys/devices/virtual/tty/ttyvsN/event
+Date:		January 2020
+Contact:	Rishi Gupta <gupt21@gmail.com>
+KernelVersion:	5.5
+Description:
+		The ttyvs driver will emulate serial port event; parity error,
+		framing error, overrun error, asserting or de-asserting break
+		conditions and ring indication when user space application
+		writes an event code on this sysfs file.
+
+What:		/sys/devices/virtual/tty/ttyvsN/faultycable
+Date:		January 2020
+Contact:	Rishi Gupta <gupt21@gmail.com>
+KernelVersion:	5.5
+Description:
+		The ttyvs driver will emulate as if the cable is faulty; i.e.
+		data sent will not be received when user space application
+		writes 1 on this file. Write 0 to disable this emulation.
-- 
2.7.4

