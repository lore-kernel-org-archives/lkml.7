Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4946C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1FD2073F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="HmLpHO4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKXPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 10:00:58 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25823 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKXPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 10:00:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574607579; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Q7zL//9mmnErEUbUr9capCSHc4V62WzVZj3PK3NuM/08x1Uqg1wff03gkAfONPwuSE4DhgDvkbUfuRiLBFgvnysWeb8PeDeK55KD1syeVoaatwDQY567OFThnVRod8haGA+ciD9aWT4XSLsrnkQpctD7eo1oF1+0ahJN86YyA5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574607579; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=1diHSW+QAWIjUcqo1ZVEUtcx+fphCSjBhDZABprx0Hw=; 
        b=AFx2RbGFt+EXrLW/I0BJPiwyD5kHIbvrT1xI4KG94nPBV3FRlgu/QX1X8OBe4+F0a6iGCMkQWGMJjA9hOUq1oE5yE0moW+cBLJQwg67UuXXeXw2ZlXnLSXaDxhwqxo2L7sp8MCIvi66cN02hKIvChQsdYdhn9TkI0jOiPiW6lbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=MvrF6j1JkQBPauAYFtpujoTucglkdDVjSdSLkzOJHF/4G/TGJM4MLsj2qJA32e6kTLR38ayTnmiS
    Gu9C0rcihXnNXTv6HTlwVOJZUHB82/eNL3mP7LV71GTKd978+8La  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574607579;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=1diHSW+QAWIjUcqo1ZVEUtcx+fphCSjBhDZABprx0Hw=;
        b=HmLpHO4Spd8N2+LSm9cYphhSxWsimGscRhmXA3qcpvhso59ZGVdjljg8HSF33JhG
        YpI6JTWQVIUSiONTPrLi6znCOxs2gsZMSX2WL8+4S1xtd1xxVUfs/XfboF/dzogRvFW
        vPB37kxEhAGOsloJNawXQt+BV4MshThuURY0tlM0=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.112.247 [171.221.112.247]) by mx.zohomail.com
        with SMTPS id 1574607577570284.0005795893636; Sun, 24 Nov 2019 06:59:37 -0800 (PST)
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
Subject: [PATCH v3 2/4] dt-bindings: Document yna vendor-prefix.
Date:   Sun, 24 Nov 2019 22:59:00 +0800
Message-Id: <1574607542-25670-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574607542-25670-1-git-send-email-zhouyanjie@zoho.com>
References: <1574607542-25670-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "yna" is an acronym of the "YSH & ATIL".

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---

Notes:
    v1->v2:
    No change.
    
    v2->v3:
    No change.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c..47ddd88 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1054,6 +1054,8 @@ patternProperties:
     description: Xilinx
   "^xunlong,.*":
     description: Shenzhen Xunlong Software CO.,Limited
+  "^yna,.*":
+    description: YSH & ATIL
   "^yones-toptech,.*":
     description: Yones Toptech Co., Ltd.
   "^ysoft,.*":
-- 
2.7.4


