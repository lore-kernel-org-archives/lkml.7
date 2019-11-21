Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDFC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B4A2068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQqPhQps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKUTRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:17:34 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33835 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKUTRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:17:34 -0500
Received: by mail-yb1-f196.google.com with SMTP id k17so1788288ybp.1;
        Thu, 21 Nov 2019 11:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iRr78PF0ayUGDH0lcR09CGwIA4V53aCMn+ho2nN2cbQ=;
        b=vQqPhQpseYcJ0sLp/8WE0kM0lkiX8G95JtDPQME8OxsSyHyzQ+Uf1Djn7vcqOWt4V5
         vDWlKkgE3tmz5EYd51R1FT4UGjbnb3EvEGivXNrhK+T0+by5aSTan66dvodYyOOeRNOX
         TzPUePdqT3oOCE9+mChMlKLdUJ2XngcdKBgJ2MO6fZeDVIbuq0rGz+/YCIBGFGvDlSpI
         FCdNKlVvaE4YgNj3KlQHqkeo72dbMn0zawHico0+uU8pw7JIO6SkYOgwrUn84fvdawgk
         zhT7EVqIZYJw66uYX+kaR7aL5lpqLZZ03JjjlIyZpkYuIeuGKa8OU0ys5vWR2dhEpKJc
         eEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iRr78PF0ayUGDH0lcR09CGwIA4V53aCMn+ho2nN2cbQ=;
        b=l0KkoU2HJMZFeePL1JPtQ1ecE6BL2ox3Oeehp1XkQVvcrAxcEOo+91zRlE8i7VdODC
         mwFz/LF8mUqKI2RxTyp6TZX7Ks9pHK7/t3c1v3RzGe6Xl7B1ys9VPdH+c1qjnK0DS2Nj
         swfOeY9D+jPeScTdMJEtbzgAoHLVrZ9cibQ/sSPRhsAUY/Y8H39VHl495qXtusTYJxJ2
         VqZ73rJvHtvHFbp+QxIyU/fU2/GVO9wrz6d+yptAtj0n1CNhpC4b5nFi1CXHP2oihSUP
         Pthlqm5xhO2owstRlOITnRg0meaWNkLCeXiGt1PQUU4075/9TsagBD+IIZ366haEL+Dq
         Ptsw==
X-Gm-Message-State: APjAAAV9E6EIo1vh44AxcIFFKENk3e2X3sYsi5lmS1JW9FtWX1dZ4dRd
        1ZiYw8OLvfc0JuOXeNLDqWm8cbSd
X-Google-Smtp-Source: APXvYqyYqRocKDIB5b/dML26LA2wgbX0xK9JnlEfJK7WAOQ9oikIfozizrc561mSssjEH5xsOpgziQ==
X-Received: by 2002:a25:9882:: with SMTP id l2mr7019459ybo.435.1574363852952;
        Thu, 21 Nov 2019 11:17:32 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id j144sm1105251ywg.77.2019.11.21.11.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 11:17:32 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>, geert@linux-m68k.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH] of: overlay: add_changeset_property() memory leak
Date:   Thu, 21 Nov 2019 13:16:56 -0600
Message-Id: <1574363816-13981-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

No changeset entries are created for #address-cells and #size-cells
properties, but the duplicated properties are never freed.  This
results in a memory leak which is detected by kmemleak:

 unreferenced object 0x85887180 (size 64):
   backtrace:
     kmem_cache_alloc_trace+0x1fb/0x1fc
     __of_prop_dup+0x25/0x7c
     add_changeset_property+0x17f/0x370
     build_changeset_next_level+0x29/0x20c
     of_overlay_fdt_apply+0x32b/0x6b4
     ...

Fixes: 6f75118800acf77f8 ("of: overlay: validate overlay properties #address-cells and #size-cells")
Reported-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c423e94baf0f..9617b7df7c4d 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -305,7 +305,6 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 {
 	struct property *new_prop = NULL, *prop;
 	int ret = 0;
-	bool check_for_non_overlay_node = false;
 
 	if (target->in_livetree)
 		if (!of_prop_cmp(overlay_prop->name, "name") ||
@@ -318,6 +317,25 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	else
 		prop = NULL;
 
+	if (prop) {
+		if (!of_prop_cmp(prop->name, "#address-cells")) {
+			if (!of_prop_val_eq(prop, overlay_prop)) {
+				pr_err("ERROR: changing value of #address-cells is not allowed in %pOF\n",
+				       target->np);
+				ret = -EINVAL;
+			}
+			return ret;
+
+		} else if (!of_prop_cmp(prop->name, "#size-cells")) {
+			if (!of_prop_val_eq(prop, overlay_prop)) {
+				pr_err("ERROR: changing value of #size-cells is not allowed in %pOF\n",
+				       target->np);
+				ret = -EINVAL;
+			}
+			return ret;
+		}
+	}
+
 	if (is_symbols_prop) {
 		if (prop)
 			return -EINVAL;
@@ -330,33 +348,18 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 		return -ENOMEM;
 
 	if (!prop) {
-		check_for_non_overlay_node = true;
 		if (!target->in_livetree) {
 			new_prop->next = target->np->deadprops;
 			target->np->deadprops = new_prop;
 		}
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
-	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
-		if (!of_prop_val_eq(prop, new_prop)) {
-			pr_err("ERROR: changing value of #address-cells is not allowed in %pOF\n",
-			       target->np);
-			ret = -EINVAL;
-		}
-	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
-		if (!of_prop_val_eq(prop, new_prop)) {
-			pr_err("ERROR: changing value of #size-cells is not allowed in %pOF\n",
-			       target->np);
-			ret = -EINVAL;
-		}
 	} else {
-		check_for_non_overlay_node = true;
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
 	}
 
-	if (check_for_non_overlay_node &&
-	    !of_node_check_flag(target->np, OF_OVERLAY))
+	if (!of_node_check_flag(target->np, OF_OVERLAY))
 		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
 		       target->np, new_prop->name);
 
-- 
Frank Rowand <frank.rowand@sony.com>

