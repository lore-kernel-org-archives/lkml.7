Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E5CC3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65B3206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmwhJ68b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfHSBgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:36:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37962 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSBgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:36:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so146853plt.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=LSOAA5WYzKw0JvVlfOw/ASbOuyrAtA84sOX9wyeMQQk=;
        b=rmwhJ68bsyBgvRaAN2KzT5g9kG+b9OwIFCFDoEZNKXTlaXBq8OespKeAsa2UGSXMPX
         7us1NQh2WtencQSZrs4QcBmftwAO3G6968wZpjQH/Ul4KSa6+S2En5SDEtStyk8J0KoC
         9vtWESAKBB4cNHBCZT2ChDq/vuSrv18J+Ssp4EhZ5IYIzJrIYbfYxLSdX8d8Wy4s9nmh
         fOXGLIRf6jpRo3TNeBn47J9Y/TVC98rzBXOLBq5+j30tqOzVmPMrh64lraCfcKnJWq+j
         7qVu+DiRlu3TdXPJUxvhyDLnrOlb66whXG/si0XnFKwACEdNUeiRryLQV6FDllsM3n4Q
         XGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=LSOAA5WYzKw0JvVlfOw/ASbOuyrAtA84sOX9wyeMQQk=;
        b=WCGKoP73Slpl7HQIy/mqE9XSil7gADHXgRjCE7rd4X5GoKAWtyOx8th3nIGtd1Qw93
         dvhHuKAOUl+cOZWpRNdsWly3at5an+3RzVLQKbA9VGZbHciU5dEBzc/24/7Gk2WkNkVA
         Al4HL41Sf5/mFYYNT14xUg6Z381CdKpPvvrXbwwowvhTEwCYikr6NroMXeQiwRSJDO7G
         CwO0cw2MStBWXYNREbticp5D29HotjkqV+6NJXhfcuxEjf7br3Ft6rbrDU7KhavTSlTJ
         BtMoHtVSMMKJDA4uAg83bcg5nDtFaqoGrLhkP9Zjq+WEQ/jD3fw8Y3KWTH3fRESOGPL1
         CGQg==
X-Gm-Message-State: APjAAAUkPGEbg+uiXzX+IIUNi76KtN+d8kFvjbr94y/kH7d2UM9cwy7V
        1vv96pc4IVt7+RAwn3dzaHk=
X-Google-Smtp-Source: APXvYqxG/5xLYdDoMuufP03PO6w1afA06ovqP1QxFMYGOHzw7r7TeRUsj7e1a+629jm6Au0LWtVnYA==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr19718912pld.69.1566178581777;
        Sun, 18 Aug 2019 18:36:21 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 16sm24011616pfc.66.2019.08.18.18.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 18:36:21 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Berger <opendmb@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arch : arm : add a criteria for pfn_valid
Date:   Mon, 19 Aug 2019 09:36:09 +0800
Message-Id: <1566178569-5674-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

pfn_valid can be wrong when parsing a invalid pfn whose phys address
exceeds BITS_PER_LONG as the MSB will be trimed when shifted.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 arch/arm/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c2daabb..cc769fa 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -177,6 +177,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
+	phys_addr_t addr = __pfn_to_phys(pfn);
+
+	if (__phys_to_pfn(addr) != pfn)
+		return 0;
+
 	return memblock_is_map_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
-- 
1.9.1

