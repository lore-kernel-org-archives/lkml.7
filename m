Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC68C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC4E2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402953;
	bh=rsLBM3cma18JC08uAkyl2VGiLgFBkK5qXvuZx/pyph4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n3ER91DJyvPlG3vy5PCwmCMXEf343ov43aLbCjUgl3zXrE/qbKhjHa4v2q6Ryv3vp
	 ZzlkVaZbLE/lf6SH0jYqZy+WvsP6Z12Vmoj58wGP7GSihRgzttUMk92oc/cOgRQ0G7
	 AYgkOvPpFqqsFzyymTq2y1CWadloAU6eebQGukdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfKVGJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfKVF5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1701C20659;
        Fri, 22 Nov 2019 05:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402234;
        bh=rsLBM3cma18JC08uAkyl2VGiLgFBkK5qXvuZx/pyph4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioxdETCZ88eV/ef3xk8JFJSYbqa4ARXTWXcolDm+VjQI4gd0Djq1RBh1OfXE8g374
         kEz5u91MzoT3HSwMSVgmTXAw4F+NizKFV8TlyWJyFstYfQmKGUo8yzRAV/QCs+pnQO
         OvfmPfBlMt9RdWr51h0YrJak5xPnVWs5AN+yX6Yw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 079/127] MIPS: BCM63XX: fix switch core reset on BCM6368
Date:   Fri, 22 Nov 2019 00:54:57 -0500
Message-Id: <20191122055544.3299-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 8a38dacf87180738d42b058334c951eba15d2d47 ]

The Ethernet Switch core mask was set to 0, causing the switch core to
be not reset on BCM6368 on boot. Provide the proper mask so the switch
core gets reset to a known good state.

Fixes: 799faa626c71 ("MIPS: BCM63XX: add core reset helper")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/bcm63xx/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
index a2af38cf28a70..64574e74cb236 100644
--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -120,7 +120,7 @@
 #define BCM6368_RESET_DSL	0
 #define BCM6368_RESET_SAR	SOFTRESET_6368_SAR_MASK
 #define BCM6368_RESET_EPHY	SOFTRESET_6368_EPHY_MASK
-#define BCM6368_RESET_ENETSW	0
+#define BCM6368_RESET_ENETSW	SOFTRESET_6368_ENETSW_MASK
 #define BCM6368_RESET_PCM	SOFTRESET_6368_PCM_MASK
 #define BCM6368_RESET_MPI	SOFTRESET_6368_MPI_MASK
 #define BCM6368_RESET_PCIE	0
-- 
2.20.1

