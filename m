Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6333CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6CC2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXxKuD+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfFTTwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:52:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42557 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFTTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:52:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so3812866lje.9;
        Thu, 20 Jun 2019 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4H4GxMclDvVAq723JYHDFWc6hksl9ud+nP2g0Z/0gCg=;
        b=rXxKuD+wOBnhqosxvMYJXMmPxBOV/JL2zZ7pLXea1KitFyKk7c1FTyOm4Di6BUBrsw
         aFpGsAsROLfk2EBCbABqbW27S+iPX2+XWWtiitpP10Ei7PW2P+MYtF+33woS9metPwqm
         g+qNGecWxETr3vETqDmIFDMYL4gvLb32aePP+l61d77drvPtErE0ZYD8EjTYtb8+YRq7
         DH7dYAJUtDBIzfTWm9SNTHkqn9GKVc9/D040XFC5/5vA47DklJ3BV+lD1fG4+Nmpv6pH
         un7OshTVQdgx4sutaQVHxSTuxRcBBfypJ++sD1C1L9e88/NGmEv1TA4F5VBSqvRY6NAs
         9cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4H4GxMclDvVAq723JYHDFWc6hksl9ud+nP2g0Z/0gCg=;
        b=CF5Na2NRP0SVoI9Hk8tJsfNTNfsiXURQsvRK83L1bHpPHUMT3TNVVs9V134xDy803O
         VKV7TAIMBcdj3wVsSgLHdCBPBnyradKiMFA/NuohaLQYRy8muzpJDdwVWX2RvjzioTqW
         MNBF/ZUL5c6I4XuUMQGO2u1Cr3TD/BORFK2m0f1yMBxRH3vwS07Fv9VHO57sBijFeyfz
         aVtx/TKzxai57w45iHMGxq2X8jjn2wAjU8j/Yu+tSjUmem4D2wvTWw4JsUnTXmOC0dC1
         VAQSNFnhWZlgNL/Kz4qrNSYZD0nfhUsrv/5SltDqqlF/NKqK+Z+1TDNEEYCCjUij4WeF
         1sFA==
X-Gm-Message-State: APjAAAX/rsvVV7LkKABQ/hZj1AhcSKoOpUjHlkbi1k9iSz5DZ5v6SDiE
        1fMJqR8gv5PTzpF9k0rZ561LMU9dyydqyg==
X-Google-Smtp-Source: APXvYqya7BBXkKtzUdSgB7JBQXIPFLnUtFzubzm765BAVvS/2T7Gzq4mqoIfn2HYZcuAsXDD99Eslw==
X-Received: by 2002:a2e:124c:: with SMTP id t73mr38012548lje.190.1561060362705;
        Thu, 20 Jun 2019 12:52:42 -0700 (PDT)
Received: from localhost.localdomain (89-64-59-58.dynamic.chello.pl. [89.64.59.58])
        by smtp.gmail.com with ESMTPSA id t17sm74645ljj.55.2019.06.20.12.52.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 12:52:42 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: add entry for sensirion sps30 driver
Date:   Thu, 20 Jun 2019 21:50:11 +0200
Message-Id: <20190620195011.30942-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620195011.30942-1-tduszyns@gmail.com>
References: <20190620195011.30942-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a sensirion sps30 driver maintainer.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1eb971608ac4..dafa02ba161c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14172,6 +14172,12 @@ S:	Maintained
 F:	drivers/misc/phantom.c
 F:	include/uapi/linux/phantom.h
 
+SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
+M:	Tomasz Duszynski <tduszyns@gmail.com>
+S:	Maintained
+F:	drivers/iio/chemical/sps30.c
+F:	Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
+
 SERIAL DEVICE BUS
 M:	Rob Herring <robh@kernel.org>
 L:	linux-serial@vger.kernel.org
-- 
2.22.0

