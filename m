Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9293BC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DD238C4
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNjQm5Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfHaDEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 23:04:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32857 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfHaDEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:04:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id go14so4170354plb.0;
        Fri, 30 Aug 2019 20:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eYb4+6SsdvBfSijyDeAJEqJyXxATKZLhU6gQW/pUAc=;
        b=gNjQm5Dtamz9eBrmYZ8uV7PQ6AYvGvXnal90ibmz0M0hzSlr39EHpOCj5ronLeRZ+L
         MvTDUHMp0l2zzvLWrXu/Hq5ENinizdOR6/dR3PCN0JQdfXRvQHa6TMLG9Y+QBVk2wbIc
         IOLDetBCJjFQD8Fv1/9QWQ+9O2j/E0B4UDB5yiWEYp/T4AhXUCE0hXgIwRu1k58isj7l
         EyhDx3MnqyfWpxYtu1HPuJpMVNCaISZL0shzJf7206xGn9PxQh0z0eQA9vEdXYD06V+f
         qmbz19DBjWilfTgDS/3v8u+U5entQpXORBKJ7OUpHoootbRmhwwtkVaGG47XeM8aHPaC
         4vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eYb4+6SsdvBfSijyDeAJEqJyXxATKZLhU6gQW/pUAc=;
        b=b1Bx6Uz2+WPLDYBtbYLhsG3msZ7aSP4fwev51uXy/41iWVWUSQEn+qx0NPjkmMLPY9
         5BW4pvecu887OhmbNpdSImswOVp2f0Ls2kER7X0YxSWJ50XAAX3T7+jJDsI+KNcEzZH1
         lAlKGpLwWiA3xTOEwpFh2HYWSqP98n51NLk4BDVyJAuk1jGb1UbEV7m7UVwwWb2iWv1r
         9ouKdhE8/KykfwXGZSbpYOqz6hfAEx5fZeHuBniuYfDEOC8Z/EnCDCDKAFixixOBEcrp
         VsafNpNprqWxL74/s/QtpcS0LgkwiTBBqyNdwyk6W0/M8VtqIn3uB7q2DPWrsD07LZPF
         FCRA==
X-Gm-Message-State: APjAAAXCV3jvJLOZ+iF1q/Eylp5cMhCsbdPki5yl5lK5e1sj7gWFjm/X
        /WRcma+82awbyeIRsplhs4DEvB1vezk=
X-Google-Smtp-Source: APXvYqx37ESP3WGLV45DmZKhwMPWYD0yOSFWuZrWapQYBZWi5aZEcWv/g8nJrt/0rVD5qkTTpaXOBA==
X-Received: by 2002:a17:902:e83:: with SMTP id 3mr17731303plx.319.1567220653007;
        Fri, 30 Aug 2019 20:04:13 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
        by smtp.gmail.com with ESMTPSA id d20sm8211024pfo.90.2019.08.30.20.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 20:04:12 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        devicetree@vger.kernel.org, openrisc@lists.librecores.org
Subject: [PATCH 1/2] or1k: dts: Fix ethoc network configuration in or1ksim devicetree
Date:   Sat, 31 Aug 2019 12:03:47 +0900
Message-Id: <20190831030348.6920-2-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190831030348.6920-1-shorne@gmail.com>
References: <20190831030348.6920-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes several issues with the ethoc network device config.

Fisrt off, the compatible property used an obsolete compatibility
string; this caused the initialization to be skipped.  Next, the
register map was not given enough space to allocate ring descriptors,
this caused module initialization to abort.  Finally, we need to mark
this device as big-endian as needed by openrisc.

This was tested by me in qemu, the setup is documented on the qemu wiki:

  https://wiki.qemu.org/Documentation/Platforms/OpenRISC

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/boot/dts/or1ksim.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/dts/or1ksim.dts
index d8aa8309c9d3..c0cb74e52f95 100644
--- a/arch/openrisc/boot/dts/or1ksim.dts
+++ b/arch/openrisc/boot/dts/or1ksim.dts
@@ -49,8 +49,9 @@
 	};
 
 	enet0: ethoc@92000000 {
-		compatible = "opencores,ethmac-rtlsvn338";
-		reg = <0x92000000 0x100>;
+		compatible = "opencores,ethoc";
+		reg = <0x92000000 0x800>;
 		interrupts = <4>;
+		big-endian;
 	};
 };
-- 
2.21.0

