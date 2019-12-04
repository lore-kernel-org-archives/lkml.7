Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8777C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8B6207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irQosFEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLDKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:46:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43773 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfLDKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:46:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so3452439pfe.10;
        Wed, 04 Dec 2019 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FfFA2fx9vKQkK9IXB35RPn6PXJy6DUq2hQ/f9g/q8mg=;
        b=irQosFELQ9MogtzndKRWTSh4IdQpCm0B7RPeZAAeOsWxA4/nkKPY4wrC9q646U0SWg
         rYAhrTUthYM/Pn8MzgXoJoSiBrPdwlrSw27HgWWzXomLmYl6w8ckAmGbfIh3VVN5pTNj
         rzTvCH2wyR+wKu3yEFFD6JKFcC+afGyLmgBK939sYlhyD8k76FbfnKoH1WoF7cAXHPX1
         dq5IIhewOVUWQ9XiVKqiVNNw9ksCqnCG9S9tk4bJaKEcRLJ9Bb9e1yuHbaZLNar01+9Y
         ZWACTWDUwchpJTxj577MeUjtDqjYlMJjD1u5x87Bs5/RgW7VMrZjgoSaee0puIlFYtzL
         HS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FfFA2fx9vKQkK9IXB35RPn6PXJy6DUq2hQ/f9g/q8mg=;
        b=ZLGWla9QXDGPq5mu6jxmSuMLfO0HnQzco3wft051Pn/aFtg59SNdmBbmuNRO07HY2K
         Fy4kgQSDABU7s51rn43HGk4XYqdCAxnfvSExxQZcVRTylk36uMotwxW9ikOFLbZdXyih
         781PYNdrL7oDS9w3HCPFKgXDPpYKoVOGiyFnrLd9lA/mc3ERcIT1rrRMowtNPIZwiEOS
         WRyMDMulzI+kQ2sIIO4nPtCLYgTwninJuVjEVwXhZMkACHBHCKer/ZMjQ3Zq9qDrUQqd
         fS2VvDp9V1uJ9NAr6eOTsC1oiXeYA5E3NsJgVA8/LFdf8IM1JIlqa+hRRm/72LV/PG1I
         1i3w==
X-Gm-Message-State: APjAAAVVEY1/NEq4BmY4K2HiPi5Ah17quznuKgL+F0Jsyf0bzx8qVefe
        aE9X5TZBUFK5z2j71Mn/Eo4=
X-Google-Smtp-Source: APXvYqyivDIvz9YK3RohHzevDM78spQ4qGZqtiStCyPw+L5kyV050nRq6HQWpEPVeoBgX97T0Lo+eg==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr2909488pgi.128.1575456383355;
        Wed, 04 Dec 2019 02:46:23 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:cdb:94ce:3984:ab1:9b44:803])
        by smtp.gmail.com with ESMTPSA id k101sm6160710pjb.5.2019.12.04.02.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 02:46:22 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 2/2] Documentation: kernel-hacking: hacking.rst: Change reference to document namespaces.rst to symbol-namespaces.rst
Date:   Wed,  4 Dec 2019 16:15:54 +0530
Message-Id: <20191204104554.9100-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following documentation build warning:
Warning: Documentation/kernel-hacking/hacking.rst references
a file that doesn't exist: Documentation/kbuild/namespaces.rst

According to the following patch:
https://patchwork.kernel.org/patch/11178727/
(doc: move namespaces.rst from kbuild/ to core-api/)

The file namespaces.rst was moved from kbuild to core-api
and renamed to symbol-namespaces.rst.
Therefore, this patch changes the reference to the document
kbuild/namespaces.rst in hacking.rst to
core-api/symbol-namespaces.rst

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 Documentation/kernel-hacking/hacking.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index a3ddb213a5e1..d62aacb2822a 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -601,7 +601,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-``Documentation/kbuild/namespaces.rst``.
+``Documentation/core-api/symbol-namespaces.rst``.
 
 :c:func:`EXPORT_SYMBOL_NS_GPL()`
 --------------------------------
@@ -610,7 +610,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL_GPL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-``Documentation/kbuild/namespaces.rst``.
+``Documentation/core-api/symbol-namespaces.rst``.
 
 Routines and Conventions
 ========================
-- 
2.17.1

