Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A73C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73542183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368517;
	bh=U/ISEtmAbFDSWDBOws/rt17KURHFkUzg6AxUwn+wHWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/jObikVSOY+teH8tidZaXRKxDbQsltIw7MvX5fPMvruz56Qpo0RrLzxV/L3PNEx8
	 x9sTBhIRwbIIBTjB1wPgWGc5zl74mMraL4wm+BMatzlkL9XHJ6RmVmMvz590SYdT42
	 FoVZ10ejGMPjBwbFDdUnU/S8gUTCpQwDkKhKbR+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfDDJB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbfDDJBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:01:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A3A21741;
        Thu,  4 Apr 2019 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368513;
        bh=U/ISEtmAbFDSWDBOws/rt17KURHFkUzg6AxUwn+wHWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuBTu8IeLDoJpv74emDbF3332G95ccewUokiXLtwSdzCNS6K4TGpv7cLhZRORSria
         MOIQKNYZ8Mv1kJynsjW2+qpRWDvF3nSCn+bQmaRF/KKHmxrsmOHPW4BfrLJiV5vzBD
         SZBaTu7gZk+leMfjNnXh77M87LcoiBHxMiRt1+XI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Fan <nullptr.cpp@gmail.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/187] platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for Lenovo RESCUER R720-15IKBN
Date:   Thu,  4 Apr 2019 10:46:44 +0200
Message-Id: <20190404084606.209141037@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4d9b2864a415fec39150bc13efc730c7eb88711e ]

Commit ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo RESCUER
R720-15IKBN to no_hw_rfkill_list") added
    DMI_MATCH(DMI_BOARD_NAME, "80WW")
for Lenovo RESCUER R720-15IKBN.

But DMI_BOARD_NAME does not match 80WW on Lenovo RESCUER R720-15IKBN,
thus cause Wireless LAN still be hard blocked.

On Lenovo RESCUER R720-15IKBN:
    ~$ cat /sys/class/dmi/id/sys_vendor
    LENOVO
    ~$ cat /sys/class/dmi/id/board_name
    Provence-5R3
    ~$ cat /sys/class/dmi/id/product_name
    80WW
    ~$ cat /sys/class/dmi/id/product_version
    Lenovo R720-15IKBN

So on Lenovo RESCUER R720-15IKBN:
    DMI_SYS_VENDOR should match "LENOVO",
    DMI_BOARD_NAME should match "Provence-5R3",
    DMI_PRODUCT_NAME should match "80WW",
    DMI_PRODUCT_VERSION should match "Lenovo R720-15IKBN".

Fix it, and in according with other entries in no_hw_rfkill_list,
use DMI_PRODUCT_VERSION instead of DMI_BOARD_NAME.

Fixes: ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo RESCUER R720-15IKBN to no_hw_rfkill_list")
Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index d4f1259ff5a2..62d4b94e2531 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -989,7 +989,7 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
 		.ident = "Lenovo RESCUER R720-15IKBN",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_BOARD_NAME, "80WW"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo R720-15IKBN"),
 		},
 	},
 	{
-- 
2.19.1



