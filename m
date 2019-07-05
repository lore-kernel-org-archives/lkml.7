Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E667C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AEF21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hwq3MtMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfGESzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:55:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42129 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfGESzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:55:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so4965344plb.9;
        Fri, 05 Jul 2019 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SEw+f+WvSmW4ZE4Ix9oVBZdz8BUyqrL3rZLhlP8kF3w=;
        b=Hwq3MtMgrXzlCba1rAUyQnQPYMyf9O41lrJvgv0jf/QiHGgc7QVvrGQgMYq6V2ETEU
         eWa+2HdTM1R/TPYWU6esr2gkb4eBXAVNTBau36JnnfZ1kbg9n5koLiH/Up4Gk0mr9EGP
         7x6jtG0m2kqJDjHo0Eo2CCxd8I4foehy8Nrp8eqQDLeugbKVDhP63nj0EwM7EyC/kFpI
         kZ2HkMmyZmP0Paqz/NzG5GQVXAzzTazVFnDLbseqzDBOG9HpyZG1WwqUILiWgeV99BdD
         t/5fFA+d8UOYxlCuoh32QeYJiUUlIUR5+uysabpmQtyTpsy/MhjonO3FQeiYqeP40jy6
         O3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SEw+f+WvSmW4ZE4Ix9oVBZdz8BUyqrL3rZLhlP8kF3w=;
        b=HVlR49qwS3QS9PQuAYl2dAdEeub+Y5eNIjfSHjn52reH381sXGUi6XP4BJJcZMHbGT
         sXZfcj9KZsDhx9G73bmHyCoPxn12OeOHnbHUi3oHDa5R4X/bc/U9nTcXdvYjzuzTepf4
         QhmA/YvQiYvB64iiTyfkr6MAzR1oGQlrI9G+/p3egwmlNsB75EFgk1luf3nWMp4ubAyv
         cg9oUirxefNy1fIoeO1dZOc3hdO9+Y7DTCzO/vASNlsjNSCXGKFRDpFTBSdyY4NBVtFF
         RPcAirz6tUOWHOJyE86iep6/RRh21uOeehUB2N7RSai4nC1OVMKSE13PttdYAu4VNneP
         nQxw==
X-Gm-Message-State: APjAAAVKNcIrGnnZ/ubm7TjTp3rtihoNGt6qRtAZUpL8Ch+HzhCA3k/l
        R5pLYOiC9AJdMwgoAEJ//uc=
X-Google-Smtp-Source: APXvYqzG0MQIdevaUAq4AnUl9vDE9sY2FiUD//CskItSu3ZLMv6JHfS/Un4WlwTwGx1YysOT3Su+GQ==
X-Received: by 2002:a17:902:b28b:: with SMTP id u11mr7042427plr.11.1562352940444;
        Fri, 05 Jul 2019 11:55:40 -0700 (PDT)
Received: from debian.net.fpt ([2405:4800:58f7:1cb1:98e0:87d3:2c8b:b6ed])
        by smtp.gmail.com with ESMTPSA id j24sm13447599pgg.86.2019.07.05.11.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 11:55:39 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        skhan@linuxfoundation.org, mchehab@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] Documentation: usb: convert usb-help to rst
Date:   Sat,  6 Jul 2019 01:55:19 +0700
Message-Id: <20190705185519.31033-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new index.rst and change usb-help.txt format
to rst.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 Documentation/index.rst                          |  1 +
 Documentation/usb/index.rst                      | 22 ++++++++++++++++++++++
 Documentation/usb/{usb-help.txt => usb-help.rst} |  1 -
 3 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/usb/index.rst
 rename Documentation/usb/{usb-help.txt => usb-help.rst} (97%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index a7566ef62411..4e7498f39063 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -102,6 +102,7 @@ needed).
    vm/index
    bpf/index
    misc-devices/index
+   usb/index
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
new file mode 100644
index 000000000000..5688ceaf0826
--- /dev/null
+++ b/Documentation/usb/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Linux USB Subsystem Documentation
+===================================
+
+.. only:: html
+
+   .. class:: toc-title
+
+        Table of Contents
+
+.. toctree::
+   :maxdepth: 2
+
+   usb-help
+
+.. only:: html and subproject
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/usb/usb-help.txt b/Documentation/usb/usb-help.rst
similarity index 97%
rename from Documentation/usb/usb-help.txt
rename to Documentation/usb/usb-help.rst
index dc23ecd4d802..03abc4e501ae 100644
--- a/Documentation/usb/usb-help.txt
+++ b/Documentation/usb/usb-help.rst
@@ -1,4 +1,3 @@
-==============
 USB references
 ==============
 
-- 
2.11.0

