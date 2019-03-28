Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F20C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411192082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsy+fs9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfC1Q3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:29:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45231 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1Q3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:29:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so10731276pfi.12;
        Thu, 28 Mar 2019 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqOiFe87kzL2XOtOsUGP880EbZ3svZ/Zm7re2TJe6l4=;
        b=Rsy+fs9EcX5gzGSJZ19Tz9qD84xnB6MxyHuYkhCeKbZl1xIBGFEuZRtX4SOyrTUalX
         YXx6UMXLXs/yt0z7sDl90MlvQPA5BRhiv9ULMuzsdqo+kMlF0GXYqUEdY0cO11wWqvLh
         a8axqdXyzdvcF9o5qPN+LKtzi7XK5GXQB2dhVwKWpI0dT03uFkCkUKgjElOMHKK7dyxm
         eTcs7cBswV7lHC8H8v6Lcav0+nRKVLEaO75jMmH9ZlE7hlGgm7a6LsRPA8nh8TWtJwU4
         C/GM85rB+q+LEw9TsqQqCzI3NQQWGELCjsK9uo2gnBaRO1spC06bAmJIKiun9Xa840bx
         liYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqOiFe87kzL2XOtOsUGP880EbZ3svZ/Zm7re2TJe6l4=;
        b=ejEA3G3VNRH7h79hdi3uQGmRPPHQdytvsXf626k8Wqm1vvtiDBeONKo0LX5wG8aUIZ
         paTYcn0Fk43b0zPwOHbPqPqgZyZVk2livFK+64JZr7G5FpMdCaaT8aQGnx7OeMwiOYWS
         WkaJ39y9HqQ1g3aHZL56P2dtRQUQBMdQQhvsnPnAOj+7p5eHgolyfyDshlvTZ4NWUdFQ
         wLQ6BwhhYE3bhTO7jcQd9lmk9SdZLNfHvn+Pb1YpXfE2Mmj+w0VacaTm8Apn9aQ0hd29
         wr6mw5UUJxCEUrI9zZ+04jfYrTRDeFMgwr+4Y9Aou4wfBnq10K5WYUupjSt92x4FvpaQ
         RMMg==
X-Gm-Message-State: APjAAAUp6lrC91zzRWilRTJVKAejnQQhmvGm1riFxfYnuqLmpo8f5u1p
        2RGesgxTVNggKpfYBI5yjwUVCMsN1p4=
X-Google-Smtp-Source: APXvYqxnzqoTMyWOzCddMblCaNpfbD/4mCqcQR1CYahNqa/DMmcOShJCb/Dj1cZOIP+nQ0iRx7ax+A==
X-Received: by 2002:a62:e911:: with SMTP id j17mr42004979pfh.107.1553790547045;
        Thu, 28 Mar 2019 09:29:07 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:29:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 07/23] acpi doc: convert acpi/DSD-properties-rules.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:05 +0800
Message-Id: <20190328162721.26138-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 ...ies-rules.txt => DSD-properties-rules.rst} | 19 ++++++++++---------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (89%)

diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/acpi/DSD-properties-rules.rst
similarity index 89%
rename from Documentation/acpi/DSD-properties-rules.txt
rename to Documentation/acpi/DSD-properties-rules.rst
index 3e4862bdad98..8e018d768c4f 100644
--- a/Documentation/acpi/DSD-properties-rules.txt
+++ b/Documentation/acpi/DSD-properties-rules.rst
@@ -1,8 +1,9 @@
+==================================
 _DSD Device Properties Usage Rules
-----------------------------------
+==================================
 
 Properties, Property Sets and Property Subsets
-----------------------------------------------
+==============================================
 
 The _DSD (Device Specific Data) configuration object, introduced in ACPI 5.1,
 allows any type of device configuration data to be provided via the ACPI
@@ -18,7 +19,7 @@ specific type) associated with it.
 
 In the ACPI _DSD context it is an element of the sub-package following the
 generic Device Properties UUID in the _DSD return package as specified in the
-Device Properties UUID definition document [1].
+Device Properties UUID definition document [1]_.
 
 It also may be regarded as the definition of a key and the associated data type
 that can be returned by _DSD in the Device Properties UUID sub-package for a
@@ -33,14 +34,14 @@ Property subsets are nested collections of properties.  Each of them is
 associated with an additional key (name) allowing the subset to be referred
 to as a whole (and to be treated as a separate entity).  The canonical
 representation of property subsets is via the mechanism specified in the
-Hierarchical Properties Extension UUID definition document [2].
+Hierarchical Properties Extension UUID definition document [2]_.
 
 Property sets may be hierarchical.  That is, a property set may contain
 multiple property subsets that each may contain property subsets of its
 own and so on.
 
 General Validity Rule for Property Sets
----------------------------------------
+=======================================
 
 Valid property sets must follow the guidance given by the Device Properties UUID
 definition document [1].
@@ -73,7 +74,7 @@ suitable for the ACPI environment and consequently they cannot belong to a valid
 property set.
 
 Property Sets and Device Tree Bindings
---------------------------------------
+======================================
 
 It often is useful to make _DSD return property sets that follow Device Tree
 bindings.
@@ -91,7 +92,7 @@ expected to automatically work in the ACPI environment regardless of their
 contents.
 
 References
-----------
+==========
 
-[1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
-[2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
+.. [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+.. [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index dac49d27e841..376e12a65f3f 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -9,4 +9,5 @@ Linux ACPI (Advanced Configuration and Power Interface)
    namespace
    enumeration
    osi
+   DSD-properties-rules
    scan_handlers
-- 
2.20.1

