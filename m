Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2926CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62CB2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Mc3PJome"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfLLIr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:47:58 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35924 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbfLLIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:47:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id C884A3F6CD;
        Thu, 12 Dec 2019 09:47:55 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="Mc3PJome";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aCEnIeV4ScUj; Thu, 12 Dec 2019 09:47:54 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 4C2F03F6B7;
        Thu, 12 Dec 2019 09:47:51 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 58B18360058;
        Thu, 12 Dec 2019 09:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1576140471; bh=WCmaxQxE246ATYHNdSLCAZVTtLU+QzBOONzmhrSKgp0=;
        h=From:To:Cc:Subject:Date:From;
        b=Mc3PJomeKXRmiQW2ddGpYTi4r2bfKnJZSb0lSqs86LaVAhtgwqyw5BzrMf24Zjx0/
         zQxrf9pKLMxenmVrFb80rXG2yDDfbEab4Mkkk7Afubluix7y+yewt0D1IhZZu4l8rR
         1Ur3y9pp02CROTOoc2iOk0Yb3Eu+JsbjPVvkaODQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v4 0/2] mm, drm/ttm: Fix pte insertion with customized protection
Date:   Thu, 12 Dec 2019 09:47:39 +0100
Message-Id: <20191212084741.9251-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The drm/ttm module is using a modified on-stack copy of the
struct vm_area_struct to be able to set a page protection with customized
caching. Fix that by adding a vmf_insert_mixed_prot() function similar
to the existing vmf_insert_pfn_prot() for use with drm/ttm.

I'd like to merge this through a drm tree.

Changes since v1:
*) Formatting fixes in patch 1
*) Updated commit message of patch 2.
Changes since v2:
*) Moved vmf_insert_mixed_prot() export to patch 2 (Michal Hocko)
*) Documented under which conditions it's safe to use a page protection
   different from struct vm_area_struct::vm_page_prot. (Michal Hocko)
Changes since v3:
*) More documentation regarding under which conditions it's safe to use a
   page protection different from struct vm_area_struct::vm_page_prot. This
   time also in core vm. (Michal Hocko)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>

-- 
2.21.0

