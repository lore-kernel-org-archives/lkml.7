Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68AD2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keggkYAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfF1GHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:07:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46571 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfF1GHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:07:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so4882726wrw.13;
        Thu, 27 Jun 2019 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuUMir4cdKZVUvRsNPY5rqLX7yjSzNVBKmDh7MZE8Aw=;
        b=keggkYAhhPb2VqnK46kdGtYH1YIPGbhBI+giOQ9eyyYin3as2alRkXETot2V6U4m0z
         /WMg9KBXwxISBlLr9X/4Avs8FgMVS0yD6JuAcGV5yRfpgXeaIAw61hpFjAJvcX6gVgWE
         xr6oesc1E0AYyq6dU1mliftNFnC/g+YDoIgZePY/AsyqvFsnfRA0Yzjt4c7iUaGsMeoU
         vT2zvRguZ7PdJ6cd1gEgihGmYFyK1lLM2s26/ATAOJOcoyWd4VIwngv5tvgQfM/NqEAI
         jRisET2BYf9Lzz5Hu913tdEONve5lnTCqBlGDvD/cOA2wdzJxcPIK87ZyblQ2yFSP/rs
         CPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AuUMir4cdKZVUvRsNPY5rqLX7yjSzNVBKmDh7MZE8Aw=;
        b=ikQBDzb1zCev4hpkufmFUiHabHsQ185FhsemhkZVJjoF16m4HxrCLpctOI4dm/KdhQ
         VsXoNWhyfTn1eoOQDrgtqIRI3nZtm8q2hhJ/tYtC/pwgqXhyINQ3KxzvfaDX6YuowOwV
         2INNuurPHbALCp6QGV3Fh1IVZhXBQKhXIU0uvHKPMmpJ/ljYEhv1yj5HY8TUvKUfj5Yy
         wiVxCDI4p8Fn7RctzAU2SKVIEQRLRBFczk/CbCU5BEzYsxmwPedRthPygKlYcgBy3Kqs
         TKLn5ecur2Mjfq9ZCfeDzzahjykFCsZxhj55/HfjmcmX22tG/bM6sgWOeIiijv6+BEQm
         cAtA==
X-Gm-Message-State: APjAAAVSTKfcui0KQeCv+G2xUjPeHXgnXveIhnvvSX4hJHvsUTTAAMuV
        dUYpT0ZAmcHVso/8vK4+27Q=
X-Google-Smtp-Source: APXvYqwBXpMyMdyhifUzDpY5+dF5LudZPYAoIX+6joiQefSZvLGZjHiX+/1iVan1TJh3esuDztfy7A==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr6509916wrx.206.1561702022249;
        Thu, 27 Jun 2019 23:07:02 -0700 (PDT)
Received: from localhost.localdomain ([41.220.75.172])
        by smtp.gmail.com with ESMTPSA id 5sm2144551wrc.76.2019.06.27.23.07.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 23:07:01 -0700 (PDT)
From:   Sheriff Esseson <sheriffesseson@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org,
        Sheriff Esseson <sheriffesseson@gmail.com>
Subject: [linux-kernel-mentees] [PATCH] Doc : doc-guide : Fix a typo
Date:   Fri, 28 Jun 2019 07:06:48 +0100
Message-Id: <20190628060648.25151-1-sheriffesseson@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the disjunction by replacing "of" with "or".

Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index f96059767..192c36af3 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -359,7 +359,7 @@ Domain`_ references.
   ``monospaced font``.
 
   Useful if you need to use special characters that would otherwise have some
-  meaning either by kernel-doc script of by reStructuredText.
+  meaning either by kernel-doc script or by reStructuredText.
 
   This is particularly useful if you need to use things like ``%ph`` inside
   a function description.
-- 
2.22.0

