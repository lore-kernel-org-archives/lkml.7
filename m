Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDD2C46478
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F82C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725158;
	bh=4R9xE//JHGJ1vw7+0iy2R7DeOTab/RL6Ghnrqyhpi0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7NY0Z9dhihBQG3tlTPmBF7dgChtMy3HR/f6dNpgshmNH/Jn6SqPR6/QX6w+QaZXa
	 u71dlfD792so2jACy2FyBrKXyQomABQSRBdATy9uX2fDcJcAOuZMVwMrzlb/8k6rKx
	 hqmz1xDSdr4M01xzZr9LOaQ1+xv3rOvALMq4QvOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfF1Mch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:32:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfF1Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U+qp50zrWERJm0m8k2at/IVwV9GB1pFaVI5ce0ubCIY=; b=eJJJfTne03dWsyHX8ilZMao9Ts
        Swzk3DmUMDo/6FmCR0idGbzrNIWHkUmuWJJJx1rNas5pr6G62mAjunP/7/tn48K+toP3MnuXNDe0G
        GxRwb/+KfFzyjE7vSfQnJuZo0Ma8L8sNXzEisoXXleKKDepf4zF/SXoF60GeXZaSfr/6yiH4B6wu0
        rcNBxgE5NHRhG9QqwTSanohZ34yt86smaS1ple+9CGfuC228Y+xfloUMrWFT/9kb8717AwkUSX/kY
        sHhxiF5wk+2eKBFCeEcCO08kgO0t28GkQdtqiQ3ULmm5BYbFoSOBkIlnF0rJPSBzLpbsgPuxrUR3L
        QOpnpvCw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1T-00054q-Su; Fri, 28 Jun 2019 12:30:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005R4-0C; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH 02/39] docs: rapidio: add it to the driver API
Date:   Fri, 28 Jun 2019 09:29:55 -0300
Message-Id: <2262235851f12c9ce1a61b06af48375950b31203.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually a subsystem description, with contains both
kAPI and uAPI.

While it should ideally be slplit, let's place it at driver-api,
as most things are related to kAPI and driver-specific info.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/index.rst                   | 1 +
 Documentation/{driver-api => admin-guide}/rapidio.rst | 0
 Documentation/driver-api/index.rst                    | 2 +-
 Documentation/{ => driver-api}/rapidio/index.rst      | 2 --
 Documentation/{ => driver-api}/rapidio/mport_cdev.rst | 0
 Documentation/{ => driver-api}/rapidio/rapidio.rst    | 0
 Documentation/{ => driver-api}/rapidio/rio_cm.rst     | 0
 Documentation/{ => driver-api}/rapidio/sysfs.rst      | 0
 Documentation/{ => driver-api}/rapidio/tsi721.rst     | 0
 drivers/rapidio/Kconfig                               | 2 +-
 10 files changed, 3 insertions(+), 4 deletions(-)
 rename Documentation/{driver-api => admin-guide}/rapidio.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/index.rst (94%)
 rename Documentation/{ => driver-api}/rapidio/mport_cdev.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/rapidio.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/rio_cm.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/sysfs.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/tsi721.rst (100%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 8001917ee012..0066b198cad4 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -61,6 +61,7 @@ configure specific aspects of kernel behavior to your liking.
    parport
    md
    module-signing
+   rapidio
    sysrq
    unicode
    vga-softcursor
diff --git a/Documentation/driver-api/rapidio.rst b/Documentation/admin-guide/rapidio.rst
similarity index 100%
rename from Documentation/driver-api/rapidio.rst
rename to Documentation/admin-guide/rapidio.rst
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 4e503e360860..93c6c9a98c41 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -44,7 +44,7 @@ available subsections can be seen below.
    miscellaneous
    mei/index
    w1
-   rapidio
+   rapidio/index
    s390-drivers
    vme
    80211/index
diff --git a/Documentation/rapidio/index.rst b/Documentation/driver-api/rapidio/index.rst
similarity index 94%
rename from Documentation/rapidio/index.rst
rename to Documentation/driver-api/rapidio/index.rst
index ab7b5541b346..4c5e51a05134 100644
--- a/Documentation/rapidio/index.rst
+++ b/Documentation/driver-api/rapidio/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===========================
 The Linux RapidIO Subsystem
 ===========================
diff --git a/Documentation/rapidio/mport_cdev.rst b/Documentation/driver-api/rapidio/mport_cdev.rst
similarity index 100%
rename from Documentation/rapidio/mport_cdev.rst
rename to Documentation/driver-api/rapidio/mport_cdev.rst
diff --git a/Documentation/rapidio/rapidio.rst b/Documentation/driver-api/rapidio/rapidio.rst
similarity index 100%
rename from Documentation/rapidio/rapidio.rst
rename to Documentation/driver-api/rapidio/rapidio.rst
diff --git a/Documentation/rapidio/rio_cm.rst b/Documentation/driver-api/rapidio/rio_cm.rst
similarity index 100%
rename from Documentation/rapidio/rio_cm.rst
rename to Documentation/driver-api/rapidio/rio_cm.rst
diff --git a/Documentation/rapidio/sysfs.rst b/Documentation/driver-api/rapidio/sysfs.rst
similarity index 100%
rename from Documentation/rapidio/sysfs.rst
rename to Documentation/driver-api/rapidio/sysfs.rst
diff --git a/Documentation/rapidio/tsi721.rst b/Documentation/driver-api/rapidio/tsi721.rst
similarity index 100%
rename from Documentation/rapidio/tsi721.rst
rename to Documentation/driver-api/rapidio/tsi721.rst
diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index 467e8fa06904..677d1aff61b7 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -86,7 +86,7 @@ config RAPIDIO_CHMAN
 	  This option includes RapidIO channelized messaging driver which
 	  provides socket-like interface to allow sharing of single RapidIO
 	  messaging mailbox between multiple user-space applications.
-	  See "Documentation/rapidio/rio_cm.rst" for driver description.
+	  See "Documentation/driver-api/rapidio/rio_cm.rst" for driver description.
 
 config RAPIDIO_MPORT_CDEV
 	tristate "RapidIO /dev mport device driver"
-- 
2.21.0

