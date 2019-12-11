Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7050EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467F0222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bpdltt77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfLKUsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:48:37 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45722 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLKUse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:48:34 -0500
Received: by mail-pf1-f201.google.com with SMTP id x21so2833696pfp.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C+6y73EXexRd0hR33vMuaMfO+5uThh3OpWASDclUdXg=;
        b=Bpdltt77InkOqMirGb9hF5cYmu5WGJuJ0I+s7SKo/MEfJ+hx2Gwwknfp4zMiBTWF5v
         KbKS2NW6PiYL2+p90yprg30UiDj51uWLgi/dpDBYgFFz5+ZoopDQK7yjbD+swPEhw6uO
         mDkPxhUFVZdctOJIiSjQ+8YIAO7teNe2UyR6/0grkYqGZuc5hV5FNOPVqul9pWo3ZQ7y
         A1TWZl83lLWARjYcmw8CkdJ98Sk7sznx06fGkfdV1jkSFW+sJ6KCnn6lE72jprhRTgPA
         11t8BFJCfr1kfDEPVgGbHCWebxeb/vfn5S5AKLqH4F6RY5OumAIpOfzrueEQ7Genu8jV
         QTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+6y73EXexRd0hR33vMuaMfO+5uThh3OpWASDclUdXg=;
        b=hAHf3aEWBphRb1lFP/JgyaZRTL+2+SMGsu0A2R1ELw2pjjx3AnFxVyxvUThD+w81/X
         8U7AWwgHXYJYznvyepCGW7P1lTyo1hEsQZOm7r6AAI/YvpmjRUBNvD4VervVSrVu3lH0
         qN1dYIAwRepryIHyn6q77xAG340Tsynsra9QEsd3seYxOyBrEJN8vfg+KlxBjEqcC8rl
         3++Z46pW/gQbKPrNagnBA8u4meTxh9lcjAsGeAfVeJ2Fa+jpkck6NPXoyeAAuhRpdr25
         gjD9G7K21OC3w88Z7hvMMAYA2m955eSKbknVnwb5w7SSsad2Hxu4uVde9K+sm7AJwt+C
         gXiQ==
X-Gm-Message-State: APjAAAVY40WKGYN3i8tsh0AtejjJ1ItMl6ooGuXuXeHI5rlILR6tvHtr
        ZEktrYZdWMExlTh1FCaim+SP8hTmuIv6
X-Google-Smtp-Source: APXvYqxauN2Xtwim1usUncxq4tvoh++Me89sTxe8ma6YZe7/GQCKgFE7FrAPcyLob9kJpl5tHySpflrnNfOA
X-Received: by 2002:a63:e14b:: with SMTP id h11mr6137550pgk.297.1576097314200;
 Wed, 11 Dec 2019 12:48:34 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:47:43 -0800
In-Reply-To: <20191211204753.242298-1-pomonis@google.com>
Message-Id: <20191211204753.242298-4-pomonis@google.com>
Mime-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2 03/13] KVM: x86: Refactor picdev_write() to prevent
 Spectre-v1/L1TF attacks
From:   Marios Pomonis <pomonis@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        Marios Pomonis <pomonis@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a Spectre-v1/L1TF vulnerability in picdev_write().
It replaces index computations based on the (attacked-controlled) port
number with constants through a minor refactoring.

Fixes: commit 85f455f7ddbe ("KVM: Add support for in-kernel PIC emulation")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kvm/i8259.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 8b38bb4868a6..629a09ca9860 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -460,10 +460,14 @@ static int picdev_write(struct kvm_pic *s,
 	switch (addr) {
 	case 0x20:
 	case 0x21:
+		pic_lock(s);
+		pic_ioport_write(&s->pics[0], addr, data);
+		pic_unlock(s);
+		break;
 	case 0xa0:
 	case 0xa1:
 		pic_lock(s);
-		pic_ioport_write(&s->pics[addr >> 7], addr, data);
+		pic_ioport_write(&s->pics[1], addr, data);
 		pic_unlock(s);
 		break;
 	case 0x4d0:
-- 
2.24.0.525.g8f36a354ae-goog

