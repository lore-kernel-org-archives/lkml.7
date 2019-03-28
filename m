Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8500C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A962054F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqJGeNoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfC1Q2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:28:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40076 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfC1Q2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:28:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so11841273pgo.7;
        Thu, 28 Mar 2019 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0KDyQcEZBgZgiPnLs21YbYcjbmUQL/BNKKG2lVW9Tk=;
        b=iqJGeNoKKPFQR0o+fDoj/0LxrLCwYlS/T3gpbBhgAFLH0Gh1hZYQR3OX2a0L7QNDiX
         DA3Cu3/0otvDD32k1AcJ9bmaAZA0/JxkipzubGKfHo8f4Ml7xTfSlAcgoNHU1FWynLqP
         Um6UtmO7NM3xeljbLDlBNDv0IG7VHTzdeTnqi7umfpM/iBp5FPLI3j5XzXGDWESQLeaB
         HccR03dwOAKKM04650GWRazDudn/sBlkaq6UyfKCISKBb/jsEXgBtbW/+WXlmijN6r7L
         LicgfmElTGKcUgi33Ve2HeF+giaRScIV0c5DccvIX0W5RNfZ3Z7MkagPQZet4Bha3fg6
         xLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0KDyQcEZBgZgiPnLs21YbYcjbmUQL/BNKKG2lVW9Tk=;
        b=ov3gOcD0ei6hko4Ilo6gqSY0il273FIjAB/3TkX9f60BJg4pQa4iEd52DHcRSq0M6q
         frtKeUOkOlZFJTRrOmTVL8XQWkOQgXeuGg0rz//lWxcU1w/fKbqz3OJwD2k/xpnq5F4X
         6bVCj9Fc/ZaEe5IsHHVNaygIRxaQFHg5k43BOwyzLuLxK3nCORAg/McLgHo4hrdVMXzM
         3KdlFDDj7eyeM2n5pYem3PjyOBKeqo+RVYgGj/Y3T4wqEyRfXVd1ca+vEYC5QKj1JyeL
         UzOSFYPvj+NfWbhiw0skH8HAEZFdRjeZ5pRswN1j0jE6c8nsicZFKrbsSySgGKeoZAyJ
         sbmA==
X-Gm-Message-State: APjAAAXX+fCJIOfCXyONi3bcIILI8JvNwZbrIXWtucLqNICo8wsyuRJj
        uBQpmZ93eQ+rpJgUvexRyWA=
X-Google-Smtp-Source: APXvYqxeamaAg69aW8GM0uPTXn7oWASaJc+Yg4b9eNS23IA2jHAmnM6xJ6m6XTQ8IjWCT4krp0qR1Q==
X-Received: by 2002:a63:2a09:: with SMTP id q9mr41134111pgq.397.1553790479131;
        Thu, 28 Mar 2019 09:27:59 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:27:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 01/23] Documentation: add Linux ACPI to Sphinx TOC tree
Date:   Fri, 29 Mar 2019 00:26:59 +0800
Message-Id: <20190328162721.26138-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a index.rst for trace subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/index.rst | 6 ++++++
 Documentation/index.rst      | 1 +
 2 files changed, 7 insertions(+)
 create mode 100644 Documentation/acpi/index.rst

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
new file mode 100644
index 000000000000..1e7df5253750
--- /dev/null
+++ b/Documentation/acpi/index.rst
@@ -0,0 +1,6 @@
+=======================================================
+Linux ACPI (Advanced Configuration and Power Interface) 
+=======================================================
+
+.. toctree::
+   :maxdepth: 2
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..e3aa28275894 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -90,6 +90,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   acpi/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1

