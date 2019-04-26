Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5652DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5620B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkLI97PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDZPcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:32:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39045 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDZPcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:32:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so1904449pfo.6;
        Fri, 26 Apr 2019 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TV7e4arOSjGVr5O/MpIFwhDR+m3a+pb7vc7OyqSFiw=;
        b=ZkLI97PGVXUjljAv0yV0kUgyn/Feh28KD3RhRdgXGzw/pUicReSGwLIYM35Q5F0waa
         elIW8sy1qlzdmSOrr8he7Bwm4e+C6io5jZOqxmdHYYf9BHa81l6LIpRe2nRf6RHflNgW
         68ma5HbTBMKXhwMdUzbnw55ez886NEUQWRorw/YlfYIPyzSrmFKZBDWdw6Vt7WBppLCZ
         T7tB8YlHdwc7g5h2J3+rLSWHfXrwAIqp/4OR8mSNCytR7zrw8oXAKisEA6wFdzC73Efs
         RHpeau2P4U4NA3xSjhjwCKh1ZJe4QU2AIJFsMUkHv9qolHIfPKOYN0J69fOJkUx4pHIz
         roiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TV7e4arOSjGVr5O/MpIFwhDR+m3a+pb7vc7OyqSFiw=;
        b=I+s/sZh4up5G4p79EEbxZtvIek5JCZEG6y8XuHS0hFcFuzuz4uY9SdVH1VB8S4B75f
         Flr8HiimiDLliuXYeGIaopzlaJT8SM92IfEnDW08vOzr9TOcxou0WDDfaz6NQOal37DQ
         Ww7iFgVP0iq4wPDfukKsYmxGqN1ginUmeijb7NwOTh69IgUa+QazlMgAksGeC4yjw48i
         DJwKiMnqmPs+eQUVasDzGiRBhAIZ4lXl0R+2+Bvn+0TbJFkVRputVEscbNoM96uEpadH
         HhkuJgM3Vp8MVNpiXzrgV/HYZHZG4AQZkjPg5ny9+Z0iI933gntxhO7zglGgUlsFZlh6
         Lpug==
X-Gm-Message-State: APjAAAWsZpxtnM2tQM+CCsic/MHiK2hZs6jId9sRuqutnK5vXUrIJtmy
        ToCtvCbaN6etVLpcs1N8XLM=
X-Google-Smtp-Source: APXvYqzEct39oa/IBBQsgFGr0paIjtOvIMsz/w2X/JQSv1MPFf2m6xX3FdjoEEpwIzax4TzZZnATJw==
X-Received: by 2002:a65:43c3:: with SMTP id n3mr44144625pgp.375.1556292738558;
        Fri, 26 Apr 2019 08:32:18 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:32:17 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 01/27] Documentation: add Linux x86 docs to Sphinx TOC tree
Date:   Fri, 26 Apr 2019 23:31:24 +0800
Message-Id: <20190426153150.21228-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a index.rst for x86 support. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst     | 1 +
 Documentation/x86/index.rst | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/x86/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..d65dd4934a1a 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,7 @@ implementation.
 .. toctree::
    :maxdepth: 2
 
+   x86/index
    sh/index
 
 Filesystem Documentation
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
new file mode 100644
index 000000000000..7612d3142b2a
--- /dev/null
+++ b/Documentation/x86/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Linux x86 Support
+=================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
-- 
2.20.1

