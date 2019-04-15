Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0009C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755AC2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354006;
	bh=olEGL0T2K24uoWv0St+kfvi5eNIrWXMXE1stNziTBFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZ3aOBvjccv8pJeCXJqT6ZLSOg4hZ+ROyQK3pOGPTGKJbj5VpzO/B9KUsyWuTvhAw
	 UIoM1RqOeJxAoZkQe3EwTyHFjWZis99qzuXWSl3NAU5ETC9KaVaKyZETvlq8dzr6fb
	 4JSbhKxraGTIv90VU8EIQ3gruJrY5YIytohMwMlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfDOSqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbfDOSql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7E0218A1;
        Mon, 15 Apr 2019 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354000;
        bh=olEGL0T2K24uoWv0St+kfvi5eNIrWXMXE1stNziTBFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAVgNKiUpk7GfVC/jdpU7kbOCT1e47Ps49sAAy+YtkarhLiYFkfMWf5Kt5zvKQAYV
         eMCH2Gg0mpojXI8dhJd0KsDMlGfX2CwlPAZCHzlbwrTDrmflE/UbMkWicYgDNHwomW
         456gJmixIxUldFo/939dihAe5Yv9LbiUp/6lWSc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 24/76] powerpc/64: Make meltdown reporting Book3S 64 specific
Date:   Mon, 15 Apr 2019 20:43:48 +0200
Message-Id: <20190415183714.021106293@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 406d2b6ae3420f5bb2b3db6986dc6f0b6dbb637b upstream.

In a subsequent patch we will enable building security.c for Book3E.
However the NXP platforms are not vulnerable to Meltdown, so make the
Meltdown vulnerability reporting PPC_BOOK3S_64 specific.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
[mpe: Split out of larger patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 926ed3c38741..2f30fc8ed0a8 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -93,6 +93,7 @@ static __init int barrier_nospec_debugfs_init(void)
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
@@ -125,6 +126,7 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 	return sprintf(buf, "Vulnerable\n");
 }
+#endif
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
-- 
2.19.1



