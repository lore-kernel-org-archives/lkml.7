Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6140FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4520833
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="SJfD1ijN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfK2Iyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:54:46 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25842 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfK2Iyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:54:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575017627; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VbuUyWVLcA3vjjxsFAOa42KpNinrA0Z2UKAbiF/TGUWNvy1psCLGPvlUYH2BLVHVgaTtQUkhgAm4aCv7JVGy16ljjm2eNvrdT1SOnuOjHB4NziVn3bZf+rnu81mU3rw3olHU/oYXylbV9x2Wrq0jEqwtak3811bp5JUWoH4Y7uc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1575017627; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=Ib9yy57M4CUyc317FP7hI5XMfKUMRg8FN97gssawUhU=; 
        b=gL81dTw202jX/hv1mxV+e+a0jv4DwHojqd2sJzedQzDmY3pf9ciy1mRdvBmAwX9lF15i2IvRxCPQlVPCz+FmAUH42VfB7QDAiwU0RfaB+rPeKL+EKrZDQxdxGbJqyW4EwYKCvlH/jDnGEWbF/vxCMbozVKW+4XdqGL7Uj1tWwCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=g0mg+hVlUk//TAlvBG/L+ED5htMGwheGbQIKT3HGEIV27UyWz1Yg42k+Sh+7Ia25Xudz6IlpXcYD
    i5ORSH9pAQg8DTSfgfPptqVgXfez5Yu0nAl7qDhVzlkeGqZXOMSM  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1575017627;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=Ib9yy57M4CUyc317FP7hI5XMfKUMRg8FN97gssawUhU=;
        b=SJfD1ijNy9gYj7VHjlhrWFijthQDnslnBzFz/SKEBHC3iRr/D0JqoRQ9LfHm77tF
        10d82NcpDvbuINWKK+fvg3rFRek2YnfTibj2F7deC5uFChnNa7JueaZaJX2aDZLX4aa
        Z9viZDDIsAEiTspjOrqYQc3GfS/G/Xal5WGMiA6Q=
Received: from zhouyanjie-virtual-machine.localdomain (139.207.146.46 [139.207.146.46]) by mx.zohomail.com
        with SMTPS id 1575017626033419.46833655910893; Fri, 29 Nov 2019 00:53:46 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        jhogan@kernel.org, mripard@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, syq@debian.org, ralf@linux-mips.org,
        heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, krzk@kernel.org,
        geert+renesas@glider.be, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Subject: [PATCH v6 09/12] MIPS: X1000: Add rtc DT node.
Date:   Fri, 29 Nov 2019 16:48:50 +0800
Message-Id: <1575017333-29020-10-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
References: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate DT node to probe the rtc driver
using the devicetree.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---

Notes:
    v5:
    New patch.
    
    v5->v6:
    No change.

 arch/mips/boot/dts/ingenic/x1000.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8b8d335..2a0810b 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -69,6 +69,17 @@
 		interrupts = <27 26 25>;
 	};
 
+	rtc: rtc@10003000 {
+		compatible = "ingenic,x1000-rtc", "ingenic,jz4780-rtc";
+		reg = <0x10003000 0x4c>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <32>;
+
+		clocks = <&cgu X1000_CLK_RTCLK>;
+		clock-names = "rtc";
+	};
+
 	pinctrl: pin-controller@10010000 {
 		compatible = "ingenic,x1000-pinctrl";
 		reg = <0x10010000 0x800>;
-- 
2.7.4


