Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FD7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E739821872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="idTs7woZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDLFCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:02:49 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40517 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfDLFCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:02:36 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A0FFE891AA;
        Fri, 12 Apr 2019 17:02:31 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1555045351;
        bh=yxYq12tQ+1PP1TKykeYy3zcJNJhG05iavGcQg6WDqvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=idTs7woZA8gaO6GdWYLx+UWLBJkrq/+1wF7hUh56ub5ZA2ILTbthLdHiN9+0xG8Ez
         8eznrZBKl7nsR53+pOXi7Pkh6H0kTJS/r4GcRvfcNOycuNZN2ddqwp8qrXy8G/kF3T
         ofh3fDHBNlP9Hz3zIxZHfJ7YUW649VTl96f+xs9Nfg16X0MVJiOMdcGRwu2+v6oqrU
         diFAYlsOz9LnIUAaPfPtWaGmOZCzYfzLiBE6ydEPfKVKolMEPS1o7/I7QGxMGVhoGZ
         3MGLgxBcgVVzfGKmZxlaanXV5VTDk05gLU3Vf51fl7wRKtvB8v/YxUywlXhEen2zxS
         4taIVqDA+OuuQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cb01be20002>; Fri, 12 Apr 2019 17:02:31 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id BBBD913EF07;
        Fri, 12 Apr 2019 17:02:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 813441E1D9C; Fri, 12 Apr 2019 17:02:26 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/3] spi: Make of_find_spi_controller_by_node visible
Date:   Fri, 12 Apr 2019 17:02:12 +1200
Message-Id: <20190412050213.17698-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the static and add of_find_spi_controller_by_node() to spi.h. Also
move it outside of the CONFIG_OF_DYNAMIC so it is available with just
CONFIG_OF.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi.c       | 7 ++++---
 include/linux/spi/spi.h | 7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 93986f879b09..19929163a45b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3531,16 +3531,14 @@ struct spi_device *of_find_spi_device_by_node(str=
uct device_node *node)
 	return dev ? to_spi_device(dev) : NULL;
 }
 EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
-#endif /* IS_ENABLED(CONFIG_OF) */
=20
-#if IS_ENABLED(CONFIG_OF_DYNAMIC)
 static int __spi_of_controller_match(struct device *dev, const void *dat=
a)
 {
 	return dev->of_node =3D=3D data;
 }
=20
 /* the spi controllers are not using spi_bus, so we find it with another=
 way */
-static struct spi_controller *of_find_spi_controller_by_node(struct devi=
ce_node *node)
+struct spi_controller *of_find_spi_controller_by_node(struct device_node=
 *node)
 {
 	struct device *dev;
=20
@@ -3555,7 +3553,10 @@ static struct spi_controller *of_find_spi_controll=
er_by_node(struct device_node
 	/* reference got in class_find_device */
 	return container_of(dev, struct spi_controller, dev);
 }
+EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
+#endif /* IS_ENABLED(CONFIG_OF) */
=20
+#if IS_ENABLED(CONFIG_OF_DYNAMIC)
 static int of_spi_notify(struct notifier_block *nb, unsigned long action=
,
 			 void *arg)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..e763290767ea 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1334,6 +1334,8 @@ spi_transfer_is_last(struct spi_controller *ctlr, s=
truct spi_transfer *xfer)
 extern struct spi_device *
 of_find_spi_device_by_node(struct device_node *node);
=20
+extern struct spi_controller *
+of_find_spi_controller_by_node(struct device_node *node);
 #else
=20
 static inline struct spi_device *
@@ -1342,6 +1344,11 @@ of_find_spi_device_by_node(struct device_node *nod=
e)
 	return NULL;
 }
=20
+static inline struct spi_controller *
+of_find_spi_controller_by_node(struct device_node *node)
+{
+	return NULL;
+}
 #endif /* IS_ENABLED(CONFIG_OF) */
=20
 /* Compatibility layer */
--=20
2.21.0

