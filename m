Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C348DC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC5221744
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560438043;
	bh=+RGH7CsbT23euwsC8Z1seWVZXoBisf/RNVkevdVcVwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dk6qX+aNdkUX13n/4d0yA7iKmDy5mKVYrGzRSlLjy3wKkgji3XjQ+2kT3gg8dLoc4
	 ohpPYBZAOlZ3nzYJWKY++d2F3j4sB0n2NLZfZOqFB4TuSjS0BRu2h8xV3wzsefTpaB
	 GHkIRLTE+9t26zwUqNyqktLrtMmekp10w7YfRLdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfFMPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:00:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42591 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732577AbfFMOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:42:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so22793790qtk.9;
        Thu, 13 Jun 2019 07:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1RM7GVAGd4N+N3hXFBtvlLtnnqYjb+JcKYi0z7iQ1D8=;
        b=KlxreCzr5Jw9zwiuVWyjRzgmTK9TclKOxS7zAghDjWbByyXLt7E8IVVGeTyIJQo0mv
         qTRVEKievzdFfcxAHQnl+N2SCCmX2S3IDsv7VOy0Il+bi8BaAjnmFT3gFxmtAAIMf1pz
         vhRkDA8lMNB2SivJNyuZ+HNj1fpHdCF308PjbNc0Ddgn4mar3O25q+U00q7lpRbU310v
         RJjy+/MMLJS/hQ/BdLiW97aXeTPHUJY+loM52HTaJXZo+QQUoL4Ur5n/mVKPgA5SkuyT
         lmW7AKo7dD0iMZ6CAAIChzVae5nV/rnT2s/jRFWiT6mGqI/iutJk4dJik4Rxb5t5fce1
         8+IQ==
X-Gm-Message-State: APjAAAWS4gNDRuxdboXuSfvwhoYQdOSat5Fw3ZJZWFzWN0C8dD8mUJ41
        3jQpCGnBTen17aJKMAcB5CitpZc=
X-Google-Smtp-Source: APXvYqyrfme402EkY8/etWmehXPLgpLsf3qabAxX3+DZM331i4k62osIqvn4pshmRekUlNow2eBFJA==
X-Received: by 2002:ac8:27bb:: with SMTP id w56mr13808438qtw.211.1560436935486;
        Thu, 13 Jun 2019 07:42:15 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.243])
        by smtp.googlemail.com with ESMTPSA id d38sm2052810qtb.95.2019.06.13.07.42.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 07:42:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 2/2] dt-bindings: Check the examples against the schemas
Date:   Thu, 13 Jun 2019 08:42:10 -0600
Message-Id: <20190613144210.22181-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613144210.22181-1-robh@kernel.org>
References: <20190613144210.22181-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the binding examples are just built with dtc. dtc recently
gained the support necessary to output the examples in YAML format
(commit 87963ee20693 ("livetree: add missing type markers in generated
overlay properties"). Now just switch the output format and the examples
will be checked against the schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 8a2774b5834b..6b0dfd5c17ba 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -25,7 +25,7 @@ DT_DOCS = $(shell \
 DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
 
 extra-y += $(patsubst $(src)/%.yaml,%.example.dts, $(DT_SCHEMA_FILES))
-extra-y += $(patsubst $(src)/%.yaml,%.example.dtb, $(DT_SCHEMA_FILES))
+extra-y += $(patsubst $(src)/%.yaml,%.example.dt.yaml, $(DT_SCHEMA_FILES))
 
 $(obj)/$(DT_TMP_SCHEMA): $(DT_SCHEMA_FILES) FORCE
 	$(call if_changed,mk_schema)
-- 
2.20.1

