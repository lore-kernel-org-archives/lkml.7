Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8495FC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F393206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573679150;
	bh=JeLh2TwMb/pxP+eN3XGV0+es0lcAgWbtdoAmHtde6Xk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dhe/4fPLOj+Z/vsULcFrgXkTRwCDea0vWVlIC7oEuY5SRUwFqlLWofPcn+oRmeHuw
	 pseyp/d2pRBVNpS4XDqU8/hleRLJxC5qvQS1pxjFCATuU28N8PIWja3DJjKrvGELgH
	 Hucm+8x0Xo/KApZPbzuf4wp9SV1IgRqa5azWuOYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKMVFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:05:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38053 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfKMVFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:05:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id z25so2925376oti.5;
        Wed, 13 Nov 2019 13:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0gzX/jw1PyFuoIoNGiysmpPTO8xY9NIG/RxfHqGfh2Q=;
        b=j0XRVMyAVnxduF7XvhsyuxvaV3RGztw+iGfM+MwQQEoFovlcqWR5+a7Xc7YsRgC1+2
         JkIdY8cx8NZGYkDV4DCO+rgVJQEvPCHFBES3BNF2Ewcm1Xv516Ed0kglUpsuiv0c8IX4
         EuFb7GYpnM+1HFQ2TCTOLwBjyybMAgEOQ3X3xV069KF+C2B3SvmGmqIcohSyMHhNTjlJ
         /1xRMPbfU1f/9U8b3F2v/hRUxuz/UqqXyuivk6jQaegNBydQwMYhLdF19M1RIyHowj5+
         8MJL3MR1/xvzWVwYgXX+BRAnNdtrL0oN5Mm0A5zSvxFm97ScuhL4RFN2elJzvrL7Cz4X
         7djQ==
X-Gm-Message-State: APjAAAUD+chJxI99Q4yQzBAxQBRHwI9peM1+ZrIouGsWxC1OAgReXtBr
        Yp/ARYTyoGeHRa3FrKTSdK8+s38=
X-Google-Smtp-Source: APXvYqz7oQg0O4T2/+HXv6UGO2bjicLBIrBkWlHRPhWGEMo3z4ZzVUMtEURw7fKgvYuJOMit9S4WJA==
X-Received: by 2002:a05:6830:1f1a:: with SMTP id u26mr2689695otg.75.1573679146408;
        Wed, 13 Nov 2019 13:05:46 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t19sm1109988otr.5.2019.11.13.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:05:45 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] dt-bindings: Improve validation build error handling
Date:   Wed, 13 Nov 2019 15:05:44 -0600
Message-Id: <20191113210544.1894-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Schema errors can cause make to exit before useful information is
printed. This leaves developers wondering what's wrong. It can be
overcome passing '-k' to make, but that's not an obvious solution.
There's 2 scenarios where this happens.

When using DT_SCHEMA_FILES to validate with a single schema, any error
in the schema results in processed-schema.yaml being empty causing a
make error. The result is the specific errors in the schema are never
shown because processed-schema.yaml is the first target built. Simply
making processed-schema.yaml last in extra-y ensures the full schema
validation with detailed error messages happen first.

The 2nd problem is while schema errors are ignored for
processed-schema.yaml, full validation of the schema still runs in
parallel and any schema validation errors will still stop the build when
running validation of dts files. The fix is to not add the schema
examples to extra-y in this case. This means 'dtbs_check' is no longer a
superset of 'dt_binding_check'. Update the documentation to make this
clear.

Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile  | 5 ++++-
 Documentation/devicetree/writing-schema.rst | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 5138a2f6232a..646cb3525373 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -12,7 +12,6 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
 	$(call if_changed,chk_binding)
 
 DT_TMP_SCHEMA := processed-schema.yaml
-extra-y += $(DT_TMP_SCHEMA)
 
 quiet_cmd_mk_schema = SCHEMA  $@
       cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
@@ -26,8 +25,12 @@ DT_DOCS = $(shell \
 
 DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
 
+ifeq ($(CHECK_DTBS),)
 extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
 extra-y += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
+endif
 
 $(obj)/$(DT_TMP_SCHEMA): $(DT_SCHEMA_FILES) FORCE
 	$(call if_changed,mk_schema)
+
+extra-y += $(DT_TMP_SCHEMA)
diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 3fce61cfd649..efcd5d21dc2b 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -133,11 +133,13 @@ binding schema. All of the DT binding documents can be validated using the
 
     make dt_binding_check
 
-In order to perform validation of DT source files, use the `dtbs_check` target::
+In order to perform validation of DT source files, use the ``dtbs_check`` target::
 
     make dtbs_check
 
-This will first run the `dt_binding_check` which generates the processed schema.
+Note that ``dtbs_check`` will skip any binding schema files with errors. It is
+necessary to use ``dt_binding_check`` to get all the validation errors in the
+binding schema files.
 
 It is also possible to run checks with a single schema file by setting the
 ``DT_SCHEMA_FILES`` variable to a specific schema file.
-- 
2.20.1

