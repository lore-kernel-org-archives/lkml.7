Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2A5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D56722CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDjAJEJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbfHWNJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:09:39 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45752 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHWNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:09:33 -0400
Received: by mail-wr1-f49.google.com with SMTP id q12so8561265wrj.12;
        Fri, 23 Aug 2019 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VCD60Jb/+pjJ/5tE2H1gE1kn+YA9VqYcdsUMqOXSco=;
        b=QDjAJEJq6ZcVuSHwU+MBKVsJ+39TQfO5zpnFhyxxytBqnvyL4EtFjYELT9Xf7dCXK5
         5YDBt6H932I+KJgHm0IVNRDSmsC1CnhEt1bf7nJxDgz2DuYJK3EC5xTVUhgZEEmrSaSE
         lkjrPV8lAUp15Kx63HaUvBsveFSORtXGfqlyfxLsxQtpSvDPq5sV41wlKFDz573i6Ka4
         me3obmuVQ6ad/KqBaS/XfDgJ4m5iX/ar6XUszx5NQBeA8FtkODNYJodgCsqKQiv6VAmN
         ZtwFTeLHVRVLtuKlvzluRoLkI7pOPKbBwPvPF09w3fQVMGwGLMahnkYMOfIYYWgaAqUV
         i1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VCD60Jb/+pjJ/5tE2H1gE1kn+YA9VqYcdsUMqOXSco=;
        b=dkmqvYL4c0TFaBZ62BZ0tYrAsydtouiAeVwnAWmWSViMYhk9YIFpnFGJ5LXKYwllkA
         ak5zjoWPlCb/bsRYPZCnOGWafPPt8O0tmOoNI0pf4eTcdzq3mT6MxRuVQQm14qNM/ZlY
         VvTVbQPZkmIIQp+8NHSm2drCm0p6K+bdHdejyWM1J41D/6vfkRRXoQmUEb7/UbL+7/ek
         AWf4QnJpkCk9ZkAVRMfTT9wOIu9NzpNqJ1kvt5nfISMHaNe/12nYhgdnV0tU9pPFdPha
         FDL3QpR45XfeF8cWjQq+mSjczkcTnFUNPc1vQOKO8mJrv8XBWQ2Ywic9pjalIjwnVoGw
         rREw==
X-Gm-Message-State: APjAAAVHv9FabKYdsvRKOomVDJcLp3+uP3uXefvVpj+NX40Dl4wCccx7
        1lUE7wPvcZIMzBMpa6vuahA=
X-Google-Smtp-Source: APXvYqxeasfLg6QmAfYNd5CxvNxF5CTrTfQn9CMhycqaL9NZ/B1NdtGXp9v0usy0mUSJePpK3pFTXA==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr5151794wrq.208.1566565771240;
        Fri, 23 Aug 2019 06:09:31 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id m7sm4359854wmi.18.2019.08.23.06.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Aug 2019 06:09:30 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH 1/3] dt-bindings: Add vendor prefix for Ugoos
Date:   Fri, 23 Aug 2019 17:08:35 +0400
Message-Id: <1566565717-5182-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566565717-5182-1-git-send-email-christianshewitt@gmail.com>
References: <1566565717-5182-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugoos Industrial Co., Ltd. are a manufacturer of ARM based TV Boxes,
Dongles, Digital Signage and Advertisement Solutions [0].

[0] (https://ugoos.com)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbb..d962be9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -965,6 +965,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ugoos,.*":
+    description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
     description: United Western Technologies Corp (UniWest)
   "^upisemi,.*":
-- 
2.7.4

