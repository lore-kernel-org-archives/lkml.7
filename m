Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DFBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725201;
	bh=Tp1aYAIYfs+mXjhcme24RAxISbz2gVLfttEzx4qwiDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UYFgPMxYy1Q3JL0UjCftrIxTu8s1t5yYAbipnj1KyJGzXAZ/4Qp+WhndqpVIYE6cu
	 4lB8NSYEb9atEKgzc9/dcfxgeaPDX0JsFjNgKshAFfCeVXjZM6Zgx9YvvHeZstiQnv
	 s9KI9jjzuJ4x4EJ7zooJD9BdJKRL0sCGjcXBWDMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfF1MdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:33:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfF1Mai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7MbZA8hMINwLJB+YG9K/YLFBCqsE56YC0IfqYAoULdo=; b=Ue5XoknhidO3GpC3j/2X+b5P5s
        ukhhnPHkX/S47cpwea3376ASb1OYnJSMzF7aMj1TuOx1aYG2RDq2do18JB1LqDzQu7WZQSAcWwhtX
        flgBJX8e1KOHqO3lQrODTuX87Z/oUmc/ieiVPmebU2rGgmp+ZLKPceSqrTa524rXTDfQbqmKDWZ2i
        klyub71V84pU1895p19g1xFQFOnTMKK+d0lWnejtOXCTH+uGE3nulDvPc8mdWJYUzxjbPPx+Cwcie
        7++uDV9oUs99QfPmepCjPwsIgEIGPPbkOFlZjCysQec2lmVA2mq48BDiEHq2hYKAf7UeBl3fK91zw
        +381fjBQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-000552-3P; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005RY-59; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/39] docs: mmc: move it to the driver-api
Date:   Fri, 28 Jun 2019 09:30:01 -0300
Message-Id: <b48cf5642fdef0201ee54392b3edb7b026be650c.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the stuff here is related to the kAPI.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst                   | 1 +
 Documentation/{ => driver-api}/mmc/index.rst         | 2 --
 Documentation/{ => driver-api}/mmc/mmc-async-req.rst | 0
 Documentation/{ => driver-api}/mmc/mmc-dev-attrs.rst | 0
 Documentation/{ => driver-api}/mmc/mmc-dev-parts.rst | 0
 Documentation/{ => driver-api}/mmc/mmc-tools.rst     | 0
 6 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/{ => driver-api}/mmc/index.rst (94%)
 rename Documentation/{ => driver-api}/mmc/mmc-async-req.rst (100%)
 rename Documentation/{ => driver-api}/mmc/mmc-dev-attrs.rst (100%)
 rename Documentation/{ => driver-api}/mmc/mmc-dev-parts.rst (100%)
 rename Documentation/{ => driver-api}/mmc/mmc-tools.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index a8b3634287de..55354eacc8bd 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -44,6 +44,7 @@ available subsections can be seen below.
    miscellaneous
    mei/index
    mtd/index
+   mmc/index
    nvdimm/index
    w1
    rapidio/index
diff --git a/Documentation/mmc/index.rst b/Documentation/driver-api/mmc/index.rst
similarity index 94%
rename from Documentation/mmc/index.rst
rename to Documentation/driver-api/mmc/index.rst
index 3305478ddadb..9aaf64951a8c 100644
--- a/Documentation/mmc/index.rst
+++ b/Documentation/driver-api/mmc/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ========================
 MMC/SD/SDIO card support
 ========================
diff --git a/Documentation/mmc/mmc-async-req.rst b/Documentation/driver-api/mmc/mmc-async-req.rst
similarity index 100%
rename from Documentation/mmc/mmc-async-req.rst
rename to Documentation/driver-api/mmc/mmc-async-req.rst
diff --git a/Documentation/mmc/mmc-dev-attrs.rst b/Documentation/driver-api/mmc/mmc-dev-attrs.rst
similarity index 100%
rename from Documentation/mmc/mmc-dev-attrs.rst
rename to Documentation/driver-api/mmc/mmc-dev-attrs.rst
diff --git a/Documentation/mmc/mmc-dev-parts.rst b/Documentation/driver-api/mmc/mmc-dev-parts.rst
similarity index 100%
rename from Documentation/mmc/mmc-dev-parts.rst
rename to Documentation/driver-api/mmc/mmc-dev-parts.rst
diff --git a/Documentation/mmc/mmc-tools.rst b/Documentation/driver-api/mmc/mmc-tools.rst
similarity index 100%
rename from Documentation/mmc/mmc-tools.rst
rename to Documentation/driver-api/mmc/mmc-tools.rst
-- 
2.21.0

