Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C415C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69EE216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558363740;
	bh=H15j7Rtd+JnMSYCxxSP0t9ZLvourW2F/oEwxmX3HQGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xo5IdgbRqp3YcSCLFv/lAKoIzIRbG+DWc7jH2rwsmG5M47wdlM3JQSimyYV/W1Qxc
	 jvW11lsBJWdYAaPtdgF07s9FOnA0uR91D2PSyGfS2GuiBozqXAHRQFQKGa/Ar4UwT4
	 JGEukN6tmXOmOAarmLwSrRJJlz7qV6eZDcbEmnKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbfETOs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:48:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392027AbfETOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hDOOAZccdv5c6TLt9OaA3W/In2V2uu5fYwLCa8yhixU=; b=aGsvDPgkRNPus1Jl/HeLv04MrW
        /JCze1VtgQwnhNNXMU7B0SBkSnQ6xCdQBqtBBI31NU3vdmZw/V/qiaIEJCPdaqPeMZBh4o+M5yG/B
        m9wp6eREaEKxlaWL33fnuSi1dq0vpvc1MBtl9TO8ikHIhRjEsGbeclqcNBYZ7Jn6gWoGTfSLqE+32
        1MjQrFKMhlzgnQJ3Jys1fmToh/er0IpR0MNqliTP2fvoVYhCmKz/7gh2zErroHEAaQVSq33SFjmAi
        VZQCJPk3oqJKBnWW8mCCg5QxsrC8PJCzZgOKukpzbonlb7wSPpAA8BB6+dGY+yu0nIEV1EGACVmYk
        HbrqxDFg==;
Received: from [179.176.119.151] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSja3-0000HZ-Rg; Mon, 20 May 2019 14:47:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hSjZv-000119-7L; Mon, 20 May 2019 11:47:51 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
Subject: [PATCH 07/10] mfd: madera: point to the right pinctrl binding file
Date:   Mon, 20 May 2019 11:47:36 -0300
Message-Id: <fb47879d405e624374d7d4e099988296ed2af668.1558362030.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558362030.git.mchehab+samsung@kernel.org>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference to Documentation/pinctrl.txt doesn't exist, but
there is an specific binding for the madera driver.

So, point to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/mfd/madera/pdata.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 8dc852402dbb..c7e0658eb74b 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -34,7 +34,8 @@ struct madera_codec_pdata;
  * @micvdd:	    Substruct of pdata for the MICVDD regulator
  * @irq_flags:	    Mode for primary IRQ (defaults to active low)
  * @gpio_base:	    Base GPIO number
- * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
+ * @gpio_configs:   Array of GPIO configurations
+ *		    (See Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt)
  * @n_gpio_configs: Number of entries in gpio_configs
  * @gpsw:	    General purpose switch mode setting. Depends on the external
  *		    hardware connected to the switch. (See the SW1_MODE field
-- 
2.21.0

