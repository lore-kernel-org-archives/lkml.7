Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC7DECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5484020854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571154879;
	bh=Fb2NOojjVQHheOoEzXHMeupV6KtVnhZr1ZC517QYzc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V0TIFLaISjTn8YB9Ghgf2eVtzQSl0qTr+utzm4VyL9JTXq5XRS5Al7lUreLbymYTO
	 0Cud/qpA8wa7nGkWxwQelPzEGDRTDPihnurX2vkmiF94+G0Qy+Tbijjn+eOIr/0f/N
	 /3W8ZyJUck8P2gqXMvSpWdU6VVKYVsUD/Y9lf4P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbfJOPyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:54:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43468 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbfJOPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:54:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id o44so17347854ota.10;
        Tue, 15 Oct 2019 08:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rV9egUVAST8OIR2Vy9HXV180k6eZjVdltgXDChEOcvU=;
        b=cPQ+OZD3dhkI/H/TMcl72kMh08oJgrGV0No0fhVEFXQifG6axCFu06NCDMXEf63bLQ
         LFaPZMPOipaYlSVQ2a9yII+zczCW1OHJk3NeiFoQdUachjXN9kHP1EF8A4ZWXCTaP9Wn
         RWK8Ck9LYZm+deIsTK/tdBwmqUC06H57lZePbiNclpFHjkJskzEH9XuZbr2PiTJyntiS
         N6b1ZSWJoBQsMvzhn8/78RpZRe9KW+G5S0W7O6Ll2U3EHskrGsrSLUNspTYUWVgTTUIX
         A7l0Cjswfq40RhXgBu7ncAcZX7tHGAC9TURSeQKuZPtnhuI+nQlCKxlbTFX6hm5ia410
         wzKw==
X-Gm-Message-State: APjAAAVvUYGYQzMr4ItcQX01fxrn/MGMXOVAaeE4HXLF16C7Vo2NAoGr
        WPgPkhKYThzFpHJFlEzWbjlFCyE=
X-Google-Smtp-Source: APXvYqx5PEklVj7gQXdlttTQJDeMKkDwquulLzKwtzxeyRpybL2ZzO9JE48NPNfN5OSQLFBx1zsx/A==
X-Received: by 2002:a9d:3e4e:: with SMTP id h14mr30809861otg.198.1571154875408;
        Tue, 15 Oct 2019 08:54:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y137sm6633719oie.53.2019.10.15.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:54:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt: submitting-patches: Document requirements for DT schema
Date:   Tue, 15 Oct 2019 10:54:33 -0500
Message-Id: <20191015155433.25359-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015155433.25359-1-robh@kernel.org>
References: <20191015155433.25359-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the DT submitting-patches.txt with additional requirements for DT
binding schemas. New binding documents should generally use the schema
format and have an explicit license.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/submitting-patches.txt           | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/submitting-patches.txt b/Documentation/devicetree/bindings/submitting-patches.txt
index de0d6090c0fd..98bee6240b65 100644
--- a/Documentation/devicetree/bindings/submitting-patches.txt
+++ b/Documentation/devicetree/bindings/submitting-patches.txt
@@ -15,17 +15,28 @@ I. For patch submitters
      use "Documentation" or "doc" because that is implied. All bindings are
      docs. Repeating "binding" again should also be avoided.
 
-  2) Submit the entire series to the devicetree mailinglist at
+  2) DT binding files are written in DT schema format using json-schema
+     vocabulary and YAML file format. The DT binding files must pass validation
+     by running:
+
+       make dt_binding_check
+
+     See ../writing-schema.rst for more details about schema and tools setup.
+
+  3) DT binding files should be dual licensed. The preferred license tag is
+     (GPL-2.0-only OR BSD-2-Clause).
+
+  4) Submit the entire series to the devicetree mailinglist at
 
        devicetree@vger.kernel.org
 
      and Cc: the DT maintainers. Use scripts/get_maintainer.pl to identify
      all of the DT maintainers.
 
-  3) The Documentation/ portion of the patch should come in the series before
+  5) The Documentation/ portion of the patch should come in the series before
      the code implementing the binding.
 
-  4) Any compatible strings used in a chip or board DTS file must be
+  6) Any compatible strings used in a chip or board DTS file must be
      previously documented in the corresponding DT binding text file
      in Documentation/devicetree/bindings.  This rule applies even if
      the Linux device driver does not yet match on the compatible
@@ -33,7 +44,7 @@ I. For patch submitters
      followed as of commit bff5da4335256513497cc8c79f9a9d1665e09864
      ("checkpatch: add DT compatible string documentation checks"). ]
 
-  5) The wildcard "<chip>" may be used in compatible strings, as in
+  7) The wildcard "<chip>" may be used in compatible strings, as in
      the following example:
 
          - compatible: Must contain '"nvidia,<chip>-pcie",
@@ -42,7 +53,7 @@ I. For patch submitters
      As in the above example, the known values of "<chip>" should be
      documented if it is used.
 
-  6) If a documented compatible string is not yet matched by the
+  8) If a documented compatible string is not yet matched by the
      driver, the documentation should also include a compatible
      string that is matched by the driver (as in the "nvidia,tegra20-pcie"
      example above).
-- 
2.20.1

