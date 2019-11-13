Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B56C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B796222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfKMGnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:43:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37782 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfKMGnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:43:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id d5so1244639ljl.4;
        Tue, 12 Nov 2019 22:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eleBs2EZgeGxIdjnJxRUDgNR0QCEuHcKtl+2MMsiu+k=;
        b=CKLN1WWya4db7NlFWfND/NCsqsaMf+8NB6E27+MwdsNvAxqhP1YL+CheUb9KbyCZi5
         p5fbwidJrCng5XE3vyjjm4O2ciVoDC6nuBwLz3Wqw6F3CS1H/rRPuDe3txKl4iax7A2B
         FACJ1S9ErnK5iWa0ojtK//v2muhOnZhb9COPdLK20VIbNft4y0S2Jd6ex4ueeo1ISgWQ
         92mYSwUVnk//irmXp2eieS3kb8H/niqRbANWH9LYihT71vmf3nD3kxHLFi/Y19cx9s+c
         56jXV+tzcteOODQyIzgQ5wBmAZph/vcyFT4EFpTL+buFbhw42ny6Oo1T5Hc8IPB0Z4ze
         A9Dg==
X-Gm-Message-State: APjAAAWWgOrPxyZlH3aX0AmL5AWs71OZm+JfU/q8XnQnJVpsBaHuja9A
        nK43CXFX09hdT39uJU4ZvBNfD+vauKE=
X-Google-Smtp-Source: APXvYqzfHxLlPwdFw2DoXrFuJQBzFi2hHUa+ERPi2s1nSF9oBLUW98LODz/V3AZQroxmCtcGB1zjZg==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr1279835ljj.114.1573627430381;
        Tue, 12 Nov 2019 22:43:50 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b28sm472234ljp.9.2019.11.12.22.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 22:43:49 -0800 (PST)
Date:   Wed, 13 Nov 2019 08:43:38 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] of: property: Fix documentation for out values
Message-ID: <20191113064338.GA13274@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property fetching functions which return number of successfully fetched
properties should not state that out-values are only modified if 0 is
returned. Fix this. Also, "pointer to return value" is slightly suboptimal
phrase as "return value" commonly refers to value function returns (not via
arguments). Rather use "pointer to found values".

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Changes from v1. Removed statement about modifying arg ptr only upon
successful execution (as requested by Frank). Also changed "pointer to
return value" with "pointer to found values"

 drivers/of/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index d7fa75e31f22..c1dd22ed03f3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -164,7 +164,7 @@ EXPORT_SYMBOL_GPL(of_property_read_u64_index);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to found values.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u8_array);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to found values.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only
@@ -260,7 +260,7 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u16_array);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to return found values.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only
@@ -334,7 +334,7 @@ EXPORT_SYMBOL_GPL(of_property_read_u64);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to found values.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only

base-commit: 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
