Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F1DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755CF218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8I7Ehj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfC3NOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 09:14:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39864 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbfC3NOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 09:14:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so2341436pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wRGLnm3dJiHQeZRQvCicWtBmbL7zIwl8zDcEjNirSSs=;
        b=P8I7Ehj+1iCRtXhCCxY0hLlSKJr4ZXik4V1fYLtT/J6myzivrFyDKn9j9bQ76gZ8JO
         grJIdXFCPow8OWEbh2vCOgL0W/PrWMY7ou38HPoLhm3+6onS31v2qRt0WeOHxeCofx+p
         OaTViScBoFQPGlIZsoG2c+KlJ4XHJ/NABTMroLPGbLGRQZwdsQ7pKMgn5MxISSfBkYKB
         xjnQANAXOr94y7+qozUh7SR27RZnR4Jj65E4tv7TKu+yTBQ1sR34muSbdrqS8+nfcFQJ
         OvVDIjnRmrz2vNiroR9c4YGQHbpfCB9AIrZC/5ax6DjStVhxxDuedlM8LjlmdstI7+a4
         dovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wRGLnm3dJiHQeZRQvCicWtBmbL7zIwl8zDcEjNirSSs=;
        b=GnQ1NA5LuAx21oPsusvIDxWM15hKpfbDy/8wGikO8hNAC3k4nAjwyPKOskD0kbgUej
         NwUsj23chM49cNzRT+d+M4g4stzyBTmnjy/srUCiLs26KO6Kl0snUlg+VI8Rx67uj4C8
         HhbXo0TSSt7m6UhiXxk5M5Vee27GOU2SpLpWlgAZKLoo1HC2Vqt2hOi5W3KywRwAkb3p
         X8mY6jOOLE5zMC3E5Ci7t10EZ6aL9aWiSJnsnqUCzsliV3sKSVBAAJtepJctTRXBN+EK
         FePrF70V5eAirATK7NvLKZFhUNQ467kXqLRm/9ywnU3SVrJbSMu47Qfg1HDzq59BjY9N
         Q9+Q==
X-Gm-Message-State: APjAAAVETQD4zuFvD1yeaJEscXSPzVBo0Fq9dqn7OBO+yGE+kiSIl1aZ
        THksLEiZ7F1KB5ZdrjzFY4n/9OvO
X-Google-Smtp-Source: APXvYqwWTIe9vE22/ZnVlBihZbURBuigeUD5ni4nt81N+Sw+XYV2g4J7FcsmRME6lPHTcPMXqOHHoA==
X-Received: by 2002:a65:5304:: with SMTP id m4mr6305357pgq.281.1553951645007;
        Sat, 30 Mar 2019 06:14:05 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id s5sm5996023pgv.8.2019.03.30.06.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 06:14:04 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        ard.biesheuvel@linaro.org, f.fainelli@gmail.com,
        logang@deltatee.com, robin.murphy@arm.com, ghackmann@android.com,
        hannes@cmpxchg.org, stefan@agner.ch, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: fix max_mapnr is assigned the wrong value
Date:   Sat, 30 Mar 2019 21:13:46 +0800
Message-Id: <20190330131346.40289-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we not use flat memory, the mem_map will be NULL and
pfn_to_page(max_pfn) is a pointer which is located in kernel space. So
max_mapnr is assigned a very large number(e.g., 0xffffxxxx_xxxxxxxx) - fix
it.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bc02818fa48b..e86c21a44c88 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -535,7 +535,7 @@ void __init mem_init(void)
 	else
 		swiotlb_force = SWIOTLB_NO_FORCE;
 
-	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
+	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
 	free_unused_memmap();
-- 
2.17.1

