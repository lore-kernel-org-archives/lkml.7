Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9510CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85D20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyM/hUar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408165AbfJXCF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:05:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43481 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408092AbfJXCF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:05:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so14078845pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=krrbLH/izbJso+nY2MWEzP/yC0vSBP8e2qrV9BbAhd4=;
        b=tyM/hUar8nJGqW6eoyqH5D48DWwB6LKnYQBh1Ixgz10lYm9FvMweNSsvnQ3sF0q6rY
         S0NnE6QAuvhtQrTI8vMu7yggnDtDVM5uyCITrBHHX0zlhA81SpdYyyb3gtu/CpkOTGPG
         37xsExG1CJMMuA/R7GhiwlQmwnrsppky4axHxxQ5duaXMFz57ZPtfEhJOR/ly0u6Ey00
         VK9rhtZzUx+fH8WnjpRNcLl1fuOjy3RYjWFCs106jfwYdvhEMevowYbYtY1Z/JHaMDXz
         f9r3MlcVK7AFwIiooGh2oqKe2aG6fmGzWgJbGbZoBpLVLpjseH7sc/NVPeU4w863Hgo8
         wyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=krrbLH/izbJso+nY2MWEzP/yC0vSBP8e2qrV9BbAhd4=;
        b=TA61egXmTdlIVAmk+LBEwHD88OOdceVDDMpUl9EItyAsoBdYlDWVupTi5nN8+12cA6
         gORrQXEAcaIP7lODBiYdNJRwSSwivgmrCjjJ6nGVwnfgY2d9RKtKtOu+yBIsbf/PlscP
         rteByDj7WcjugmWk+587qAEY4EeRVlQuhWiQ689LdqD0euhqgs9iJh7QKu+iwOuM8Flp
         XPwKg4OInXMR0AEZ0YuHfLhQM3YttfPodRPAcXqLIp0tskY1SAKmSWND6Zn6XGLInYjt
         G9YYx7gLpkSAEA4UIcLyikpYcUZ5rMM3fMOX2vjGxd0gMxjIazK9yugclhqv96QeCs02
         sX0w==
X-Gm-Message-State: APjAAAVosC+QVk+6ZTdLm8DN/0N8mm/MFxqyDvyOn+CSLvl1kYtBy1RE
        klF5d4y3verafFltIc2s9TPp5g==
X-Google-Smtp-Source: APXvYqy3USe+tw1G80ZfxrTnh6puU0Uahh6n0QZWoj5S+kT2l2RC5bEHRYhf2wTcVEKQNpxsmBxclg==
X-Received: by 2002:aa7:9a0c:: with SMTP id w12mr14337523pfj.81.1571882758201;
        Wed, 23 Oct 2019 19:05:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v9sm24093974pfe.109.2019.10.23.19.05.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 19:05:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     arnd@arndb.de
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, orsonzhai@gmail.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH v2] MAINTAINERS: Update the Spreadtrum SoC maintainer
Date:   Thu, 24 Oct 2019 10:05:10 +0800
Message-Id: <a48483d13243450ecf3b777d49e741b6367f2c6b.1571881956.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change my email address, and add more Spreadtrum SC27xx series PMIC
drivers to maintain.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add a regex pattern instead of listing each of sc27xx drivers.
 - Update the commit message.
---
 MAINTAINERS |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..228b386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2327,11 +2327,13 @@ F:	drivers/edac/altera_edac.
 
 ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
-M:	Baolin Wang <baolin.wang@linaro.org>
+M:	Baolin Wang <baolin.wang7@gmail.com>
 M:	Chunyan Zhang <zhang.lyra@gmail.com>
 S:	Maintained
 F:	arch/arm64/boot/dts/sprd
 N:	sprd
+N:	sc27xx
+N:	sc2731
 
 ARM/STI ARCHITECTURE
 M:	Patrice Chotard <patrice.chotard@st.com>
-- 
1.7.9.5

