Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D530C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD422084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfKLIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:17:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44363 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLIRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:17:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id z188so4868687lfa.11;
        Tue, 12 Nov 2019 00:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eL10nrIAWoedwqBLA4/hoY9p88x8qlk9u4/3BdzAMXQ=;
        b=V0+Lbibv09k6PKhM2IBhO+mU5M6TVTELjO+BD/YrbZm5cOK8ya00ZfbMBqZ67Dx/ZD
         dpiAl2e31HV2HDjOy37y1qus8dET++CHAFVJGGF9N3awFAz/em0Ka+CDpjq872Ey6gUj
         bQ86CiD7Y1SXUM38N9RnfriAPg4ct28Xzw2RNojfUPF6sF1aBOMnnJTcnu+YM6lEeYqd
         57d/jZ7mpEe1s+R0dAHkPIq8p9ELAUgSFJXv3tuvfrO9J5s3QwaEidNtuQ690vutziRw
         Bc0ZU0UMaR+yYpLjN5PLujB56+y6wBQavbT7/fX1ugAof507v3EndQxvORFnBQduAYpj
         PmNQ==
X-Gm-Message-State: APjAAAUofyicWh1YlnsXukuV/HN4ipUkCqJLTeoO+iSI+EIqOXyBBxw3
        6Nk1z4K6s4sf6tVfZi+s28M=
X-Google-Smtp-Source: APXvYqy++dNA7rn1i/h/1y2eqNpsTch151++qveuGk99u1XQqZB1AoJ0pcKsASlT+VV8066WMMPZrA==
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr850227lfi.70.1573546659468;
        Tue, 12 Nov 2019 00:17:39 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 28sm9104412lfy.38.2019.11.12.00.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 00:17:38 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:17:26 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: property: Fix documentation for out values
Message-ID: <20191112081726.GA8291@localhost.localdomain>
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
returned. Fix this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/of/property.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index d7fa75e31f22..4aae93cdc1ce 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -164,7 +164,8 @@ EXPORT_SYMBOL_GPL(of_property_read_u64_index);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to return value, modified only if return value is
+ *		greater than 0.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only
@@ -212,7 +213,8 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u8_array);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to return value, modified only if return value is
+ *		greater than 0.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only
@@ -260,7 +262,8 @@ EXPORT_SYMBOL_GPL(of_property_read_variable_u16_array);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to return value, modified only if return value is
+ *		greater than 0.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only
@@ -334,7 +337,8 @@ EXPORT_SYMBOL_GPL(of_property_read_u64);
  *
  * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
- * @out_values:	pointer to return value, modified only if return value is 0.
+ * @out_values:	pointer to return value, modified only if return value is
+ *		greater than 0.
  * @sz_min:	minimum number of array elements to read
  * @sz_max:	maximum number of array elements to read, if zero there is no
  *		upper limit on the number of elements in the dts entry but only
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
