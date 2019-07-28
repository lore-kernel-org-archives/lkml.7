Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1855C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9147A2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfG1Xd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:33:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfG1Xd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:33:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so9891052wrr.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aaEeKTG5R6Qc1GdziDtQYqZnD5RGAhr5gRU7LI7kaRU=;
        b=aAZAKiI8Ug9vrtrnqJe6JxPmzRpXTs2Ftg673Sx8aMwn+t6fT0+faesHWjyKaN8a0r
         HK+qVUzLCr8mnsAoBPwhB2lM5ZHdmxSl+lb8WNymHmZcHSsUAdmUVTcVRP/FLS2Gki9d
         470ebp1WvdN/6KV/B1wRGhP5yzgWQkdoLfg0aqbPjRY/DDEDG7HePE+BVTIReYgg6kmL
         38yN1h1rDnQJouJYIa9d9cKjfqHNDFY4J7jS/9T75zfp+vxAMDYSAoFwoJFnES88bAL6
         RVrqeVRLt3D9h+d6D5P2vA7ddgwCTfxKLW1Rf+01Ri+6pRt+9Axl50fHooR6ClQmvVN+
         ZzUw==
X-Gm-Message-State: APjAAAVHG1K7Ir57XOg8HrWjzaDmJ77HPP3Iw0yJGNDKvXp/o/W+yL1o
        omOiVowxZKYGlhnY5kFfAeTbQg==
X-Google-Smtp-Source: APXvYqw92NTMBLPsPb4QZTGuO9U/NuPamS1jjyCN0NB7ONLDo7yL5jkx3vA9VzVTsdLSGSGyi5CJjQ==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr44021854wrk.229.1564356836523;
        Sun, 28 Jul 2019 16:33:56 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id c1sm136666630wrh.1.2019.07.28.16.33.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 16:33:55 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: vgic-v3: mark expected switch fall-through
Date:   Mon, 29 Jul 2019 01:33:47 +0200
Message-Id: <20190728233347.7856-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through,
fixes the following warning:

arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c: In function ‘__vgic_v3_save_aprs’:
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:351:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:352:2: note: here
  case 6:
  ^~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:353:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:354:2: note: here
  default:
  ^~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:361:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpu_if->vgic_ap1r[2] = __vgic_v3_read_ap1rn(2);
   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:362:2: note: here
  case 6:
  ^~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:363:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
   ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:364:2: note: here
  default:
  ^~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c: In function ‘__vgic_v3_restore_aprs’:
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:384:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   __vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[2], 2);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:385:2: note: here
  case 6:
  ^~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:386:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   __vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[1], 1);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:387:2: note: here
  default:
  ^~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:394:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   __vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[2], 2);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:395:2: note: here
  case 6:
  ^~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:396:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   __vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[1], 1);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kvm/hyp/../../../../virt/kvm/arm/hyp/vgic-v3-sr.c:397:2: note: here
  default:
  ^~~~~~~

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 virt/kvm/arm/hyp/vgic-v3-sr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
index 254c5f190a3d..622fb4d18c5c 100644
--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -349,8 +349,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap0r[3] = __vgic_v3_read_ap0rn(3);
 		cpu_if->vgic_ap0r[2] = __vgic_v3_read_ap0rn(2);
+		/* fallthrough */
 	case 6:
 		cpu_if->vgic_ap0r[1] = __vgic_v3_read_ap0rn(1);
+		/* fallthrough */
 	default:
 		cpu_if->vgic_ap0r[0] = __vgic_v3_read_ap0rn(0);
 	}
@@ -359,8 +361,10 @@ void __hyp_text __vgic_v3_save_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		cpu_if->vgic_ap1r[3] = __vgic_v3_read_ap1rn(3);
 		cpu_if->vgic_ap1r[2] = __vgic_v3_read_ap1rn(2);
+		/* fallthrough */
 	case 6:
 		cpu_if->vgic_ap1r[1] = __vgic_v3_read_ap1rn(1);
+		/* fallthrough */
 	default:
 		cpu_if->vgic_ap1r[0] = __vgic_v3_read_ap1rn(0);
 	}
@@ -382,8 +386,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[3], 3);
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[2], 2);
+		/* fallthrough */
 	case 6:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[1], 1);
+		/* fallthrough */
 	default:
 		__vgic_v3_write_ap0rn(cpu_if->vgic_ap0r[0], 0);
 	}
@@ -392,8 +398,10 @@ void __hyp_text __vgic_v3_restore_aprs(struct kvm_vcpu *vcpu)
 	case 7:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[3], 3);
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[2], 2);
+		/* fallthrough */
 	case 6:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[1], 1);
+		/* fallthrough */
 	default:
 		__vgic_v3_write_ap1rn(cpu_if->vgic_ap1r[0], 0);
 	}
-- 
2.21.0

