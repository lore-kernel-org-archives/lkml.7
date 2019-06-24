Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623EEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCE220645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371479;
	bh=x7VfQFfgk8E9omygdCv9dSD4u/vHVPh7i1fyCCVFDXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=duzYMCpbEffCImT+HsARraEiGH5se2uTcjc0lFIueHJ54XkVqnzyfUlzqu+MEaAob
	 ILQIt8qcQnDbaVLw40SuPK6zPftWPzJHHBx9fTbW0QMCIWwVpMHZ6g2bqww+SxQkIx
	 VRdA+juKJGByilgyZk6eGryBlS9b98pIiUM8S5AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfFXKR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbfFXKRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:17:08 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01695205C9;
        Mon, 24 Jun 2019 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371427;
        bh=x7VfQFfgk8E9omygdCv9dSD4u/vHVPh7i1fyCCVFDXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zyl2EaZJlgrs8GI91sNsOloVIuvGVxCVRjsbh+qN72rjEtl/GJvzguw4GD7slDBss
         BrRG+eIDlQgO1XAsqgw/5bMBdbXHh73oiSdD6+2mr5YQaqALU5+QaYluN/sJvGsjKZ
         FgU/zgbSKoZ1KXsE3XxgaPu1+eGM0nDZsoxdp6Ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@kernel.org
Subject: [PATCH 5.1 099/121] ARM: mvebu_v7_defconfig: fix Ethernet on Clearfog
Date:   Mon, 24 Jun 2019 17:57:11 +0800
Message-Id: <20190624092325.792383126@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kundrát <jan.kundrat@cesnet.cz>

commit cc538ca4308372e81b824be08561c466b1d73b72 upstream.

Compared to kernel 5.0, patches merged for 5.1 added support for A38x'
PHY guarded by a config option which was not enabled by default. As a
result, there was no eth1 and eth2 on a Solid Run Clearfog Base.

Ensure that A38x PHY is enabled on mvebu.

[gregory: issue appeared in 5.1 not in 5.2 and added Fixes tag]

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: David S. Miller <davem@davemloft.net>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Fixes: a10c1c8191e0 ("net: marvell: neta: add comphy support")
Cc: stable@kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/configs/mvebu_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -131,6 +131,7 @@ CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
 CONFIG_PWM=y
+CONFIG_PHY_MVEBU_A38X_COMPHY=y
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y


