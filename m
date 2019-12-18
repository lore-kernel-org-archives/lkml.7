Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0744C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731A92465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GeUt53t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfLRRAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:00:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45810 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfLRRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:00:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id x1so2115578qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeqKDFdUfnO84ii4lXKLuvBndynJP0TEKYsVVVEnPp8=;
        b=GeUt53t1wbtNOn+ZhJvgbA3cY/cve2xq3FHu81BHiUMPSHVYqvTDRYtILsdcz+b063
         Y07trchcQ03ZhzFyjU5R380xAlvDqA3qsN8Bg5fpFMvYMGUWPJq0ktP0WTUvWU9UK3oE
         mAgYGqED+FtOgZv0u7Kj+7rqULyZILk5yJoQ5YUoSnX04lRmb/3VZByGv+Kv/RsHLBXu
         z4vgpIUWgqhLLqD5CgriLAZjPPONJ41fcSV8OcF+c+8reRKP7+UR97d4WmtSzOFaQ03V
         Wjy2yvPXm2DsJK829IVoqSXuTZYK6PHqdWnrXIqyQcSlRAsZNRP1+0vf+t7m31SLGc6L
         wqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeqKDFdUfnO84ii4lXKLuvBndynJP0TEKYsVVVEnPp8=;
        b=TZfQ80s/KfBA61jiDHHdACh6l9SkOu6oI1hhRDMbvD0lDBkNF4fwmmkpgke1mSg9x4
         YPibwulHdSLLgR7bhdA4x37eXH5LMlpbsjDC3k0jA53DUFKYtJe8fn/ZzwVUVIlwmgSu
         +JTD/xtbVeLN7ExAHylWxCVPAISssW+bMsHoPaM8acvqmrkH+XG0wDabsdHQiWzj4O0K
         DskXdSw/55JGXbDBBcpZuAavG0DDuP/1slP22LmNExdbNaGDZ5Bz+gXRDvv/66tPVmHf
         1kHE8coOTFiOlYkcuPQxI8iRUrPYbIokXifHreFr5sk8MQa7KnDwYJW+UKEXVZSz+CnB
         5rsg==
X-Gm-Message-State: APjAAAU0uUq5CbDwzQmlCDKCy2DSRiHqwiXoXLKMyw5hLCeNT53tFK4f
        OJS91hQ1P2gEnw2S5XMfMZK07Q==
X-Google-Smtp-Source: APXvYqw5jDmu9ZkUqf6ud+pAbFz2CZOEk72YgKgv7/B7c2Mmq+Jz7H0KXBY9oMmm07H3UETri8EpwQ==
X-Received: by 2002:a05:620a:1592:: with SMTP id d18mr3588970qkk.80.1576688420639;
        Wed, 18 Dec 2019 09:00:20 -0800 (PST)
Received: from ovpn-126-98.rdu2.redhat.com ([71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s27sm799362qkm.97.2019.12.18.09.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 09:00:20 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     bhelgaas@google.com
Cc:     jamessewart@arista.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] pci: fix a -Wtype-limits compilation warning
Date:   Wed, 18 Dec 2019 12:00:04 -0500
Message-Id: <20191218170004.5297-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
introduced a compilation warning and a potential infinite loop because
it is no longer possible to be self-terminated as u8 is always less than
256,

In file included from ./include/linux/kernel.h:12,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/x86/include/asm/bug.h:83,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/jump_label.h:250,
                 from ./arch/x86/include/asm/string_64.h:6,
                 from ./arch/x86/include/asm/string.h:5,
                 from ./include/linux/string.h:20,
                 from ./include/linux/uuid.h:12,
                 from ./include/linux/mod_devicetable.h:13,
                 from ./include/linux/pci.h:27,
                 from drivers/pci/search.c:11:
drivers/pci/search.c: In function 'pci_for_each_dma_alias':
./include/linux/bitops.h:30:13: warning: comparison is always true due
to limited range of data type [-Wtype-limits]
       (bit) < (size);     \
             ^
drivers/pci/search.c:46:3: note: in expansion of macro 'for_each_set_bit'
   for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {

Fixed it by using u16 for "devfn" in this occasion.

Fixes: a7d06153eea2 ("PCI: Fix pci_add_dma_alias() bitmask size")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/pci/search.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 9e4dfae47252..42bc44d0e681 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -41,7 +41,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	 * DMA, iterate over that too.
 	 */
 	if (unlikely(pdev->dma_alias_mask)) {
-		u8 devfn;
+		u16 devfn;
 
 		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
-- 
2.21.0 (Apple Git-122.2)

