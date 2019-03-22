Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E26AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7E21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NF2eXsO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCVKEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:04:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38516 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfCVKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:04:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id a6so978407lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t6+n4f41N7wv36g1UYXNys6g6DWKroMCT+XJiPmgZs8=;
        b=NF2eXsO+IIaaDSuLXUNIe+TAs0D2e3redoJ13ZxlpYP9iYn0Mk2NqwFUgd4pUuFVyY
         u7hWBtCkMlRcd88DuEf5bRgWduFgt9vYB+3Y1cZIh4SjOM8D3SRI447sK3z6LEMwAK4z
         MdPaytWPspUZyb6VhTM/l7VNFhz5fcD/qdvhwJweJTiAvt/z6gttYcuYRtQwggIPcBA/
         z0liLo08Soz3k3/O3tBe3ce59ULu5Ni7QWZNxFRZ8enAK/NQWEHZ0O3urr1dQ3ztvO5D
         RJ/Ky0mRDuMlZBF0rIKz6qYcQZOtFs12i5ROR+Ff5LUMpiueXgRWW76p0x2yT9mjA9m5
         lXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t6+n4f41N7wv36g1UYXNys6g6DWKroMCT+XJiPmgZs8=;
        b=h+nVqsiz2Pi6UzIStOvDHbg/Lr0AvFhViCqIAfLc/5OW5LW3G3NZAADiCkdi+xc+XW
         Rq6ARiSLbs7WhRsQ0OyGSD2wYJuZFD2mhLDrCNmCcQk0/mhreC9CNjwadD0Dfwd/4u5E
         DYe4hwzVyxjPco5wHP977ed8l14p2GBI0ZRGvRLIr5IBMIoIl6779yizIwqE8ro6eodk
         MFE3Ox+aYCAzjZp3t7GqR5hZsLiEgcCz1us4EgHJ8D7hOaWO7r24DtIVHR2Gay/vbVe1
         4mDm63ki+R1MnCqwsnUk8n70lalIDinJ9gWgLsdeCZC38xSXl+6RaSqhoAgPGlOx2FYD
         Chug==
X-Gm-Message-State: APjAAAXRoUkTlCJQwoE8m0Z5t7aqV1Wz3yPTgphItOaWIew3J26OK+6D
        BmuBya/OHsDf7pGtCgLZ2o8leQ==
X-Google-Smtp-Source: APXvYqyu9SARpOCugOfNE66cWQctj0XoP8YyI1v2eDh+rMtaPFjfHVlwBUqg5OQKqgbrgCfNFPEpQA==
X-Received: by 2002:a19:238f:: with SMTP id j137mr4633040lfj.79.1553249087589;
        Fri, 22 Mar 2019 03:04:47 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id s76sm1550095lfs.32.2019.03.22.03.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Mar 2019 03:04:46 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        georgi.djakov@linaro.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] MAINTAINERS: Add mailing list for the interconnect API
Date:   Fri, 22 Mar 2019 12:04:41 +0200
Message-Id: <20190322100441.6315-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mailing list for patch reviews and discussions related to tuning
the on-chip interconnects. For now i am not expecting a lot of traffic,
so let's use the linux-pm@ list.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

Hi Greg,
Can you please pick this fix for the next possible -rc, so people can
know where to send patches. Thanks!
Georgi

Changes since v1 (https://lore.kernel.org/lkml/20190321155050.25847-1-georgi.djakov@linaro.org/)
- Picked Rafael's Ack.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..186439e7f846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8046,6 +8046,7 @@ F:	drivers/gpio/gpio-intel-mid.c
 
 INTERCONNECT API
 M:	Georgi Djakov <georgi.djakov@linaro.org>
+L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/interconnect/
 F:	Documentation/devicetree/bindings/interconnect/
