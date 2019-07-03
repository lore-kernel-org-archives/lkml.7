Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA66C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3EF218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120151;
	bh=PE/QVhnTp/5AVKCVFiyX9YRY4ITgpPq3DNRt3i7m+bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lsVgmx34a/EisdI52xRtDQ+KaKBBtVNuxOI/ptk4bKR/l/uiCopfj+cLjHTQzx9lK
	 D9Bqb/ETrUJnHI4ZXVHa3xa3BYGi5eZpD+7RjdoAWJGNAjHQ0mP2gS+8x8ol39uWt+
	 KmxAusJ1dl2W0Zr+AGwx2rhvfy4UeN8GJGv5JGK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGCCPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfGCCPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A13E21880;
        Wed,  3 Jul 2019 02:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120141;
        bh=PE/QVhnTp/5AVKCVFiyX9YRY4ITgpPq3DNRt3i7m+bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zq6R9zB8eEueOTorzvGn3LGNgNLRbWhPriQD68Gu2xhPxxNdiICf/RbsF/gzDA5l+
         xjvqYgP7gcsNQ6ocrTwUG98vF664RrrdB66x9aVVJZTU+fAL3MScaO4Buac9WFZOzk
         zpDkJ2OzeYrgFqrGVUorVfddO3fGkJpcYuSa5/u8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 17/39] ppp: mppe: Add softdep to arc4
Date:   Tue,  2 Jul 2019 22:14:52 -0400
Message-Id: <20190703021514.17727-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit aad1dcc4f011ea409850e040363dff1e59aa4175 ]

The arc4 crypto is mandatory at ppp_mppe probe time, so let's put a
softdep line, so that the corresponding module gets prepared
gracefully.  Without this, a simple inclusion to initrd via dracut
failed due to the missing dependency, for example.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_mppe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
index 7ccdc62c6052..06d620b10704 100644
--- a/drivers/net/ppp/ppp_mppe.c
+++ b/drivers/net/ppp/ppp_mppe.c
@@ -63,6 +63,7 @@ MODULE_AUTHOR("Frank Cusack <fcusack@fcusack.com>");
 MODULE_DESCRIPTION("Point-to-Point Protocol Microsoft Point-to-Point Encryption support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("ppp-compress-" __stringify(CI_MPPE));
+MODULE_SOFTDEP("pre: arc4");
 MODULE_VERSION("1.0.2");
 
 static unsigned int
-- 
2.20.1

