Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42723C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910220673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121908;
	bh=WbgxNP3QFWxN6WoB3PxWw3/x2rMUsZ0UosLpkH6AAk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iSqy5oh+2BUKiRMh+pGiVnJtYMdPHdVMUpwDb+pBUrRuShdyJIDitegiQfc6gOLZ6
	 MrN1FP5CRgxrK2nM++3XlXZZcyVGXalNGUepRXnN3+qncM4Bdb3RtDYzW5l/11KXOt
	 F6l0jcKSyRME5o0jIm57It0dgV+3szhmJ3N01LeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393226AbfJCQ61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405709AbfJCQsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:48:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF36C2070B;
        Thu,  3 Oct 2019 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121319;
        bh=WbgxNP3QFWxN6WoB3PxWw3/x2rMUsZ0UosLpkH6AAk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQOh18/STuF7C8Oglwo6AI29a1RtPw862w6baBhlBso9V6n9QYEWWF5F8ZC6lZXHD
         Q078LZkhZwXkjhbHGkycWhiMTBoX4FvwoacdlnHf9/5Pg735mUswPohk9xrAbGaeNd
         LRvxZZMg0dexwMNG18N4n773IzxTlqpzolJJzprY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.3 236/344] ARM: omap2plus_defconfig: Fix missing video
Date:   Thu,  3 Oct 2019 17:53:21 +0200
Message-Id: <20191003154603.674004191@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

commit 4957eccf979b025286b39388fd1a60cde601a10a upstream.

When the panel-dpi driver was removed, the simple-panels driver
was never enabled, so anyone who used the panel-dpi driver lost
video, and those who used it inconjunction with simple-panels
would have to manually enable CONFIG_DRM_PANEL_SIMPLE.

This patch makes CONFIG_DRM_PANEL_SIMPLE a module in the same
way the deprecated panel-dpi was.

Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -363,6 +363,7 @@ CONFIG_DRM_OMAP_PANEL_TPO_TD028TTEC1=m
 CONFIG_DRM_OMAP_PANEL_TPO_TD043MTEA1=m
 CONFIG_DRM_OMAP_PANEL_NEC_NL8048HL11=m
 CONFIG_DRM_TILCDC=m
+CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y


