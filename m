Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC94C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B4422BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qs5hDsYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGZL2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:28:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37060 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfGZL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:28:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id z28so51232211ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9u9CYuUvpswbH949bqEBTSxc6yUDGnUSUcquJxjAfws=;
        b=Qs5hDsYNRU3XsuhsUT5LoYh9H2yYIMx8duYxg6mWxxWMAUMbImQG+9HQrXaPkuZOWU
         NQ3JDWVRtBVse7vWN0EQedlArPeIP+VdKG/kcW22GMeAK0D8Rvz8puGSqcrmRNxxl1BF
         fZbTCesF+1uP4QoRJYi9h+LByxF/lRIdJoEJKRyKCMGiVK4AWoUclwfptVFmgD7O1xLm
         /WUXnq2XphbPUvCXVip34slPxmd0gU/1DukG9h40JCr+RigFMot1JveTXCyQQhRWmAo1
         3tvAZ1TaMuU8J/twMpxD+F9W9uzynrED2rNHzMAozJZR9YKUn7YY+6p4uTXvYdh5DKkB
         CGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9u9CYuUvpswbH949bqEBTSxc6yUDGnUSUcquJxjAfws=;
        b=mu0Wqc3dP8TBJAKxAZp8uppRaX/jWHCNn0cAIExAbnumsIACcCbA9vP3MUabYqAU6p
         q9driOOuPkHN/RTuP9zInar+GSxWKh4iPvWFeKyOyrr/MHdvScfoe2TbbDlzFBiNLwCC
         NlMiUwCJP+SzS9DMKuqe/mxafyVZSCkrK5nCgKnEcVzWt/cGIX0iKkEuGNpN+r79Cwgr
         vm3uuNoK8SJHnbkIlNVGS3moguuACKu/ywca3/qTrfwxnISszhqvswvlK9/RWfkw/9ce
         kygyfEJuJha66fh0pCCWu1EWsyTssAw4AgA7F8QCe0C3M9K6Fzu40kiuWwA94mCJevz5
         XuRg==
X-Gm-Message-State: APjAAAUlB+lSd8By0k4g15eEkznWcxFFCJjHg4++VZwsNfReeztpcgvh
        i6DuzvK2dJinxGcTvCmQ9/5qHYA24bG9aA==
X-Google-Smtp-Source: APXvYqwQdkpGbyaQOc5x7/xdgJkd0OQT2+j10xmlo8V5RVnCSXizO9kaU/pk141EQCFbvi0220t1Kw==
X-Received: by 2002:a2e:9685:: with SMTP id q5mr34535218lji.227.1564140515726;
        Fri, 26 Jul 2019 04:28:35 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id k23sm5390909ljg.90.2019.07.26.04.28.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:28:35 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] KVM: arm: vgic-v3: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:28:31 +0200
Message-Id: <20190726112831.19878-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warnings
was starting to show up:

../virt/kvm/arm/hyp/vgic-v3-sr.c: In function ‘__vgic_v3_save_aprs’:
../virt/kvm/arm/hyp/vgic-v3-sr.c:351:24: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
../virt/kvm/arm/hyp/vgic-v3-sr.c:352:2: note: here
  case 6:
  ^~~~
../virt/kvm/arm/hyp/vgic-v3-sr.c:353:24: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
../virt/kvm/arm/hyp/vgic-v3-sr.c:354:2: note: here
  default:
  ^~~~~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 virt/kvm/arm/hyp/vgic-v3-sr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index 254c5f190a3d..ccf1fde9836c 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -349,8 +349,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap0r[3] = __vgic_v3_read_ap0rn(3);
 		cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
+		/* Fall through */
 	case 6:
 		cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
+		/* Fall through */
 	default:
 		cpu_if->vgic_ap0r[0] = __vgic_v3_read_ap0rn(0);
 	}
@@ -359,8 +361,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap1r[3] = __vgic_v3_read_ap1rn(3);
 		cpu_if->vgic_ap1r[2] = __vgic_v3_read_ap1rn(2);
+		/* Fall through */
 	case 6:
 		cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
+		/* Fall through */
 	default:
 		cpu_if->vgic_ap1r[0] = __vgic_v3_read_ap1rn(0);
 	}
@@ -382,8 +386,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[3], 3);
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[2], 2);
+		/* Fall through */
 	case 6:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[1], 1);
+		/* Fall through */
 	default:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[0], 0);
 	}
@@ -392,8 +398,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[3], 3);
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[2], 2);
+		/* Fall through */
 	case 6:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[1], 1);
+		/* Fall through */
 	default:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[0], 0);
 	}
-- 
2.20.1

