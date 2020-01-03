Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718BAC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DC221734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AVBQvJs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgACQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:26:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38242 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgACQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:26:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so42978799wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuPXHvUieOmI5Quzb1wPB6cX8GScS9645pKcrDEMVR0=;
        b=AVBQvJs49csGx2cdaeh5gmzw6Urii3kTtSyLmvLNi8gpVnaPQrbqs0ZY45KCIz6EC/
         C7RTEpgo77kCamXGyms333DcRTTHK0t3d+FkSC7lRW6R2yAo1bU+VYVYQrh15JxLZjFJ
         MuToaslvZw7Jtf2t/LLiH67L5GSUT2SzX2v4oFRtpk8hx4kmcAbZD1tjzOYwWDFbsl/U
         gSzTD7KiTKWxXbY5zWGhMcZhVoTHrTagHR4uj58CrjbwmtXM5qH42ph2GDpaL1aGFo2A
         8zXyJlNuNISbDnnP4yeBhSHj5p0ap31ktsXFF4udaFwBhIzhi9C+ydlsrhVJuMispf9J
         iKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuPXHvUieOmI5Quzb1wPB6cX8GScS9645pKcrDEMVR0=;
        b=aIjFMHYUy+GE0jojTekBWOrXVanJfgAE+VBzKM01gb1zfQ1LcJhX0+Jr95rHs0W4cm
         GokfqKCYfJhJCr99moEKfqAcv9iMHmKBcwRGviI8chBOluzGFSejuWqGeXvxhJbLl0ot
         RyQRdq740mGFc9R7jLGj1r2jYXrUI3jXtqHH6PDPtFAMMJWH72ZEshuYodwah7FEnOsA
         HuqdtXYlYPN5JLPGT3Z6xnf4RgbMBpYiQwIohi7fKuGzpktRle/GKaoutTVQxzX9+RHn
         ScnqhjDA7EQLZLPsItaumF5v4vjDBVkgB6dREsG54lEITaHHESJPDtU1TLzw4qlRRm0W
         zyZA==
X-Gm-Message-State: APjAAAWPtm7aPQcCtuuXx4DRxsXO2A+COjiNkyunoHtM8+wRTPgRiXlL
        c8oA8LkCZvi3m62YgV2P1MFFnA==
X-Google-Smtp-Source: APXvYqywRWOLXJTVexW1vEFrIxddF8NF9xPYtArFe6KifUVJASSItqf4NTiWw0Ldz6UjN1VmdQKlBQ==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr86888598wrm.278.1578068795065;
        Fri, 03 Jan 2020 08:26:35 -0800 (PST)
Received: from radium.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x14sm12564234wmj.42.2020.01.03.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 08:26:34 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: iommu: Add binding for MediaTek MT8167 IOMMU
Date:   Fri,  3 Jan 2020 17:26:31 +0100
Message-Id: <20200103162632.109553-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds IOMMU binding documentation for the MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index ce59a505f5a4..eee9116cf9bb 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -60,6 +60,7 @@ Required properties:
 	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
 	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
 						     generation one m4u HW.
+	"mediatek,mt8167-m4u" for mt8167 which uses generation two m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
 	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
 - reg : m4u register base and size.
-- 
2.25.0.rc0

