Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BAEC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30EC206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469218;
	bh=WfW8d4aeEG0t7FRFjhEz85O0YvSM8OOhmFuRuzlY88k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xKJoMnzcumEuejJHBe5gOEO94P6/UPQTJv9PUTlS8F4T8RuLZ/KrL9zHEHPxxpYNp
	 ubHONT2S83MZEezH4aMZsrT2bohn31+nSOYXu4/EJaILexw/zrciTmJXlLs7PhdSs/
	 I9epu81UWzlkBc5RIZ8BnCazPd6+Z6lWe2jVDR8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfL0Rxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbfL0Rmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022B522525;
        Fri, 27 Dec 2019 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468571;
        bh=WfW8d4aeEG0t7FRFjhEz85O0YvSM8OOhmFuRuzlY88k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g03klbOLQc3tszFW5V3xUcicWztX0Kwm1Jm9Y9PmsDI4XqPruFvO4+hcLVfEpEIFR
         OfUPBa2uzVBpwDZEndfBaE1JFIJPKRk5rh+lX4KzRh7THZ4NcyndhkmAJmDPpkuJ+8
         m6Tm8vDJGvXPCwliVC8vFFX29eXsJa0+rwzGAg/U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 096/187] ARM: shmobile: defconfig: Restore debugfs support
Date:   Fri, 27 Dec 2019 12:39:24 -0500
Message-Id: <20191227174055.4923-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit fa2cdb1762d15f701b83efa60b04f0d04e71bf89 ]

Since commit 0e4a459f56c32d3e ("tracing: Remove unnecessary DEBUG_FS
dependency"), CONFIG_DEBUG_FS is no longer auto-enabled.  This breaks
booting Debian 9, as systemd needs debugfs:

    [FAILED] Failed to mount /sys/kernel/debug.
    See 'systemctl status sys-kernel-debug.mount' for details.
    [DEPEND] Dependency failed for Local File Systems.
    ...
    You are in emergGive root password for maintenance
    (or press Control-D to continue):

Fix this by enabling CONFIG_DEBUG_FS explicitly.

See also commit 18977008f44c66bd ("ARM: multi_v7_defconfig: Restore
debugfs support").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20191209101327.26571-1-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index c6c70355141c..7e7b678ae153 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -215,4 +215,5 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
-- 
2.20.1

