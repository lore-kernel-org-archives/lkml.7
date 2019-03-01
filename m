Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DDE2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XL4pegDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfCAOVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:21:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34912 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbfCAOVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:21:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so27895829qtk.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EUUs3LNFAaKHMETr2fU5c4ctC/rfaPesGA2Y9uePxyI=;
        b=XL4pegDt02QxO47umZ4m9BxVx4M0b7LtcYYXt+KoGucZF9eBwAXz0RMBkbHFh/Soje
         fl7F63DRdLES8p88ieLGs/UvsZGGwIzQPF2/+zV4W1iKf3EBrv2UxgQrbcS85QYPcl2T
         Zy+1VHFj8mPP9EGQhL970Z5d7hBTwjy/hFZJm6f8YC3rR2aad3wC0z6t2rJkbh5QhO1k
         T9HzhW7Kd+JVp0CACnsO0ulIjdwsa8gYJeMIwCVazIjh1VLjMnaBK06FBCog7Miegrn7
         W2BhKD/md0u2/0QlaTDUZIiZFJV+lnZrK7zJolTtlUf/XdM8IA+gUopPlwt+NPMAy9S1
         cRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EUUs3LNFAaKHMETr2fU5c4ctC/rfaPesGA2Y9uePxyI=;
        b=X3DX5PWlx9ZUfMpDueDxKqNmWh0BFM4+wNMdOanOTtmajrxh2uXoMlxPYb1ZBCzc3J
         OQtlvb3vlhdPg0t1WzwwhoCrNK91kSl8qOVcdPXAd1DRqYAHMQSf9rmT5Tfvq8OElGXd
         50N0UzQzz3+DWmzTVlu3mlQnMVR+Q/Pdby8wnoliuI92IXEBhNTaXAezchGqhFz6Kwad
         kjvbx1be40jjXmW3Y60hIWn1vX38/49ekrauVkKBgxR5dvbSYEgYsy+8CbT/No6o5x9v
         DrAXiIouiQVpKS+nOCnZWKZZamSY7KggEoHPgtSD8oIo4nACahWLX0QXrpwI7s6vmSXy
         taWA==
X-Gm-Message-State: APjAAAVchAWCNqhJXehnuIr8zBU1cT+9zvLlw/97iXJD74gXLN6Sb/q0
        tjX4Bcw/5NVqVzE7kiX3g+L00w==
X-Google-Smtp-Source: APXvYqzELWawwCnip9FOUA+7LIn0MK7kwll1EGvfP0DW2Fkdg98c4eXqvP19Uj2N1CovMa6phNHmgQ==
X-Received: by 2002:a0c:d237:: with SMTP id m52mr3906179qvh.219.1551450061046;
        Fri, 01 Mar 2019 06:21:01 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p127sm11396151qke.97.2019.03.01.06.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 06:21:00 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     hch@lst.de, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] powerpc/mm: fix "section_base" set but not used
Date:   Fri,  1 Mar 2019 09:20:40 -0500
Message-Id: <20190301142040.94204-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 24b6d4164348 ("mm: pass the vmem_altmap to vmemmap_free")
removed a line in vmemmap_free(),

altmap = to_vmem_altmap((unsigned long) section_base);

but left a variable no longer used.

arch/powerpc/mm/init_64.c: In function 'vmemmap_free':
arch/powerpc/mm/init_64.c:277:16: error: variable 'section_base' set but
not used [-Werror=unused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: improve the commit message.

 arch/powerpc/mm/init_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a5091c034747..a4c155af1597 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -274,7 +274,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 
 	for (; start < end; start += page_size) {
 		unsigned long nr_pages, addr;
-		struct page *section_base;
 		struct page *page;
 
 		/*
@@ -290,7 +289,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 			continue;
 
 		page = pfn_to_page(addr >> PAGE_SHIFT);
-		section_base = pfn_to_page(vmemmap_section_start(start));
 		nr_pages = 1 << page_order;
 		base_pfn = PHYS_PFN(addr);
 
-- 
2.17.2 (Apple Git-113)

