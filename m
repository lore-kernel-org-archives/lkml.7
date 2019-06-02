Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C0BC46460
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DCE27983
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmVtSjB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFBQfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:35:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38217 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFBQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:35:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so9704887wrs.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWcxgEI3gs42SAaAZOA2b9Y+neLUp9KjqdAC8jB7QHQ=;
        b=PmVtSjB7f/TOFWpB+2Q/vdiDC/y/WjxLBWpT23SHz8vsHy/i5nvOC7GCNJoxb7ltxk
         nvX+h1438RNymOktsMGM8nKRWisn8Hhg4+AeXmHnJdEm/BeY+YR2lQFaaU1wtGIKanp3
         EsOfq1KXs+Ut411etBiUeXsat/FA+CqwB28EAiT6IBOMklhGYQWy/gQGtCWWpTusNwlR
         DDgVKHWKi2XGFF5AFA+e3tzI0isoqevl1mDrbad1aozr6xQgl6pP7O0VaCLL5NRi4BDo
         fVeS/DmoOcKvKG78mYSNOLFywWF3cd3YA5KuI9tT7CmpePhO6FYG6TJ470QjEIdJVIfR
         Ldww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWcxgEI3gs42SAaAZOA2b9Y+neLUp9KjqdAC8jB7QHQ=;
        b=NEcr2qAehDoDWY1L54Chz0rleiOVgYMEqxTT3Wn5Q3l2c2bkcBfpSO5Pg3lWIGctNt
         7tS3Uj0lALTr7gsFZLw5a7k5T97t0Iugj3Aih6Av0nyztsY5BUloO5zobcCc6UmMptS7
         b3IgOO6OM2Td/uKSZA52cWVY0SM8MSmutxNyr8RdsiY2ZXMdN5EKtweVGRT982GN+xHu
         UJQSTlkjhg9doj9DQOEODByus/jHN2wPqmYW5NraaLeZcOv+yKJu4nYTP6NiclL9AM11
         tiNdV/R52gqyKyLlmbvXQGqk2BY6HGNa9ZJ91EX6MWiJrEHKbydncUelZsMJ9yDEGbuy
         BJ4w==
X-Gm-Message-State: APjAAAVhwWOZbUvypTyfN83vt4TT1/Umv5Hmx50nDqJUBcZqK1QRhF0W
        rX0quAdumiSKXsnyVMJlUkk=
X-Google-Smtp-Source: APXvYqx7op/7MpCSPePSRvMMp9c2IfcUO4+YSiAbeshsCOA5pXZyvI9CiP0SAE2kuxE3SH334Wd2KQ==
X-Received: by 2002:adf:8306:: with SMTP id 6mr13626082wrd.155.1559493345342;
        Sun, 02 Jun 2019 09:35:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id c5sm6639273wma.19.2019.06.02.09.35.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 09:35:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove unused definitions from ieee80211.h
Date:   Sun,  2 Jun 2019 18:35:28 +0200
Message-Id: <20190602163528.28495-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190602163528.28495-1-straube.linux@gmail.com>
References: <20190602163528.28495-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MGMT_QUEUE_NUM, ETH_TYPE_LEN and PAYLOAD_TYPE_LEN are defined but
not used in the driver code, so remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/ieee80211.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index d43aa4304ca5..42ee4ebe90eb 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -12,11 +12,6 @@
 #include "wifi.h"
 #include <linux/wireless.h>
 
-#define MGMT_QUEUE_NUM 5
-
-#define ETH_TYPE_LEN		2
-#define PAYLOAD_TYPE_LEN	1
-
 #ifdef CONFIG_88EU_AP_MODE
 
 #define RTL_IOCTL_HOSTAPD (SIOCIWFIRSTPRIV + 28)
-- 
2.21.0

