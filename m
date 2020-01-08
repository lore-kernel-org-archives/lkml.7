Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC5DC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29B3206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEqNeINv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgAHNMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:12:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38396 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgAHNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:12:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so3337718wrh.5;
        Wed, 08 Jan 2020 05:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=DEqNeINvEPFZrR82s01TIr2Z5zkaL3KzinrkHm1nflYyWOneu654e9Kv8RTghk/5tG
         b/tCXXQ9KE8N7j8UszhHK9watAkwfIcQJSejG3KkrerNPYqohgag6wH0rKovU3gFpN4K
         nBFQE/Ilq+OJhly61BsWQu4UFfbdMBeMoRgNEz4Xwa+1SirL6h7A8S1PcUaCeyXpTHs2
         Z21+XkFeje3+Xvp+Aa+Pa7sK6CRon2Hu9BQStwVi5wuMYBsn2s/8zUKkiwpOv+vITCqV
         fFqDRurAcq09zYoIP6Ga87pFNLQ5AnPwkD9kodK4L+GNgKc2gQWKgB/xxFrtJF/Y+Smn
         zAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=q70KyYlVVwuLmNNgrTXbI96+/Cvgo6zfgtmLmg4JzWz4oh3ZSl+CdaLF5WhEzbo19D
         EYkWboo6CYmvNDW6tL4cFOjWTuk/n6tTpsSo+bqiJHZSgS874plrcL/m4lM40CUUyYwn
         6nRCAXl019lw8fWJu3sehmHPpcX2dYkAZwGyY91Od3//4Nu0HmMtwHxc2pcirQng27cD
         Bv6vF1hQ8IKTt/rvrZXhD66O0hhbYQDQoTqgVTlyyu/Rp3fFrpGnNLnhmGa1rf0pTT60
         4e8eEhNY2RNi243OfnlZWQRGh/jWlZZKhECdx8f1Ta2V+uUoLdYrtD24VGaYZUDUUlGj
         2qYQ==
X-Gm-Message-State: APjAAAVZbYDz8IAiD895uq1u4ccqzTdYiPg4YM4Igtg+qOZ/75ymrIus
        V6TYRl4o+E88Hw34zTdRTis=
X-Google-Smtp-Source: APXvYqxj2owmLk2IT33kc+mzFJE9ViqbragwDPdKw11kvr+eaFOqEk6sIhBZPF92jcoV9vAdi2Nv8g==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr4390211wrq.332.1578489169124;
        Wed, 08 Jan 2020 05:12:49 -0800 (PST)
Received: from localhost.localdomain (p5B3F64F6.dip0.t-ipconnect.de. [91.63.100.246])
        by smtp.gmail.com with ESMTPSA id k82sm3875878wmf.10.2020.01.08.05.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 05:12:48 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] MAINTAINERS: Add entry for mpq7920 PMIC driver
Date:   Wed,  8 Jan 2020 14:12:34 +0100
Message-Id: <20200108131234.24128-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108131234.24128-1-sravanhome@gmail.com>
References: <20200108131234.24128-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mpq7920 PMIC driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fd82e674cf4..8a31285b59c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11128,6 +11128,13 @@ S:	Maintained
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
+MONOLITHIC POWER SYSTEM PMIC DRIVER
+M:	Saravanan Sekar <sravanhome@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mpq7920.yaml
+F:	drivers/regulator/mpq7920.c
+F:	drivers/regulator/mpq7920.h
+
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

