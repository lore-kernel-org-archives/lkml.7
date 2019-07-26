Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E386C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0340D22C97
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhHmCUXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGZL23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:28:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34045 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfGZL22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:28:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so51156944ljg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXAXo0fvFfroRZgYWsv3eTIS6UJVzpeVoAbknFGsjMk=;
        b=vhHmCUXbOqW0ShlZ/0VDIpjuqPN+yllwC23Y3r37PVgVfm8QzAufXGqQE2M+e3bBXW
         Sa6agtYW/J24tzUmmzQjuBIoBrEixhf2OJJIwLPQWd9lzYXcR2RWUkVbv4kyj5McBBh8
         VCM3fRX1y9DZW93ANmXw5P15g2/wydbxmnos6SrNyEQldDQEgLri8kEg4Rc43TnBR8aU
         AF47mTvHieO1vcSgJNotQg7LAhRptdA3m/4kyvTmUukb0G6X/fGd+q4RKWD6SqLlU4Ic
         PjQCc0/aPxCrzqEw94q1kEOcur207rRqjYV3LPtB5ntt2FqDgvmoASo8zndwPTG1O1JC
         GTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXAXo0fvFfroRZgYWsv3eTIS6UJVzpeVoAbknFGsjMk=;
        b=pHctYEz6xwlPc84xp4kcnSvMO48R2wGTjowvUBeouQdwFKZcioCGlI25K19GNj4l0t
         J1zQCHWWUnHL4G3tiwucY6cHLU90SSqafuBpb9yb9s0In45GMr3H901gmPEqLphjynsX
         fyJopcJQDony7+SVmB+FZH/ec2QLJCGdOE1iesWhq9ZDCMFgytMaGnmIQTSeX6v3K5Tg
         hwTWBUKfoxSlVqeO0EIIeYBQ6/bCL31mSjVRA6nIeIZdCxP6L0PKnmMkEaiKiv65OkC4
         cIUgqBrnwqEIm8wql+UCtV+085EydmJ4VPUEg5E2jQcYOZycWMZVWDlRkG00R8APIqD5
         7i/w==
X-Gm-Message-State: APjAAAX+eNNBvgVtlhKOSMpfAlM9YaOIi1o02KrYNpv2/Aor2zSQK/Wm
        yW9vwyNoHTSRnuqMV3vJZXpxvg==
X-Google-Smtp-Source: APXvYqxRcpeZfOkhl+kP2goAmuAtJQrE6rFVOEMWhCTxNELXPLbMSsa8XPVrXecSGADSpL4vrWzCFA==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr48094531ljw.76.1564140506079;
        Fri, 26 Jul 2019 04:28:26 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id s26sm10008774ljs.77.2019.07.26.04.28.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:28:25 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will@kernel.org, joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] iommu: arm-smmu-v3: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:28:21 +0200
Message-Id: <20190726112821.19775-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default, commit d93512ef0f0e
("Makefile: Globally enable fall-through warning"), the following
warning was starting to show up:

../drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_write_strtab_ent’:
../drivers/iommu/arm-smmu-v3.c:1189:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    if (disable_bypass)
       ^
../drivers/iommu/arm-smmu-v3.c:1191:3: note: here
   default:
   ^~~~~~~

Rework so that the compiler doesn't warn about fall-through. Make it
clearer by calling 'BUG()' when disable_bypass is set, and always
'break;'

Cc: stable@vger.kernel.org # v4.2+
Fixes: 5bc0a11664e1 ("iommu/arm-smmu: Don't BUG() if we find aborting STEs with disable_bypass")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a9a9fabd3968..8e5f0565996d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1186,8 +1186,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			ste_live = true;
 			break;
 		case STRTAB_STE_0_CFG_ABORT:
-			if (disable_bypass)
-				break;
+			if (!disable_bypass)
+				BUG();
+			break;
 		default:
 			BUG(); /* STE corruption */
 		}
-- 
2.20.1

