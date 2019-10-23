Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27774CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0782820640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391260AbfJWMPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:15:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33426 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfJWMPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:15:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so20864232ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z/k85i8nlgEEzJnCRu3J+C4eQIiRFZ+iLahNCa8Diy4=;
        b=SKs0c69BGb1AB0c9O4HHNjhUP4scb1295c+j8eMgzhvodO9rLYBtFe7QqCJ+3gul4U
         z6k11UpJJcHTAgQldSuXHIl1lZNXW7ywqgxoIr/ao7AeoIP3oKHQ055LyCeyWvNGoHdU
         xSxOi6MW1Aw8kwr4n2g4jfL0xGMabh/hdd5DD1fayeiBC0cBDhzvdSMyugmJ9ZCHw1Y+
         hRRPcJKaWq0H3Z7UzIXhObhrfqL38MbWI+tMi3e/WhdZ3iWhEuovdZQEt8NSegmldGfc
         bvggHsEYgWbVLnZMk/unhyjDCvq0giu5NyTEgmEkibqyQ0TCmDxB0O0IUoGZiDptMVmm
         Hn8w==
X-Gm-Message-State: APjAAAVb5c77TYaIK/PRG8RH4CHSDhhTor9y65+7UKtK0uCri0fux4Jl
        +Jb2tz7e3fzQ5QSr2BEYxO2wA+Wdsvg=
X-Google-Smtp-Source: APXvYqxXToY8fUYE7VFS51j5C4zvxqFyTqwoA8S2vJBG+b4z6dI/ijdRo7IbVMtjX/lPT1OKsafsaQ==
X-Received: by 2002:a2e:97ca:: with SMTP id m10mr2904793ljj.190.1571832905573;
        Wed, 23 Oct 2019 05:15:05 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a28sm9162243lfk.29.2019.10.23.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:15:05 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:14:52 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd70528: Add MODULE_ALIAS to allow module auto
 loading
Message-ID: <20191023121452.GA1812@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bd70528 regulator driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell for
regulators is added.

Fixes: 99ea37bd1e7d7 ("regulator: bd70528: Support ROHM BD70528 regulator block")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

I'm not really sure if this is a bug-fix or feature but I guess the
Fixes tag won't harm, right?

 drivers/regulator/bd70528-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 0248a61f1006..ec764022621f 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -286,3 +286,4 @@ module_platform_driver(bd70528_regulator);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 voltage regulator driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd70528-pmic");
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
