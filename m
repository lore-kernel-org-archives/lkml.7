Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B761C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB4D2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBOsj7eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfGSQmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:42:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56152 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfGSQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:42:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so29386812wmj.5;
        Fri, 19 Jul 2019 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=YsZEdOsF/K+SbyF5Ob0t/bEfZly/5m8KsDZfya2lc+E=;
        b=CBOsj7eow/95iWf7I10qUXRhYATK2l4lGjJTXjB12hOrF15IiIRqnI2w6WMDQZLddR
         a7keXGJfRWWWU+UJXVWHqZ4IUrQ8ihpp0ecAtW8cluqrut9ueULNHA81EOnihxKO7nIH
         44/R0AKFXMv9RsoEBewRWBQ78K4DR5S9J9zlH1FcyAIFyF0ll1DkVM4ylhDvdc7YkXgk
         IYhZBW+sO7Zpp6ls7qsJpSRIDbdWWkYNukCOSTUKvFBJyX3WoiWvGTTUv4zuYRAY+ZLP
         D3XsvaH1nqfH2yCHu+mdblBZ2IPnYaiMgxLfJoavtHrDhSIOMJpf7AcmdbzTEOA0MQQb
         Gtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=YsZEdOsF/K+SbyF5Ob0t/bEfZly/5m8KsDZfya2lc+E=;
        b=cvd6dvW0eoyf9Tmb7iCAkT5eRnW3czDoP7ras4PsubZCdj9HUxW9TV+s7T0nKbPQDq
         OD+MTyhLHWvMs1pIIFUlHMPsrezrllW1myuMFdjUPMCSg/OduOvMWskzBBuDW4wWbEY/
         OykCq/QJCUvGirQ6Pl3fMg8SDi44ijMFhuZ2teoruhq5Nr31++38MGBsMQeFSMgzc/UN
         Xbbh9wuzzM6aHFGHopdEJv0du6ZZhvrJxCDegqP1lPieYUIWnJFdA1Zj2z8udt3cwp1f
         q+w+jtMuly2QsTS/uerzwGmukXeGgArBJlGiVmivyRYQ/bp9SMaSVV96Yzd8P/dXKqe9
         Pz0w==
X-Gm-Message-State: APjAAAXwPBfA7U2qeSwmsfDuyOFjmzMt9IKL5uKiD80CmYwmdGPvadji
        BijhYRPrwYza10lqq8NpP+Eqa6/o94k=
X-Google-Smtp-Source: APXvYqw7MvQcYWwci1/GhKo3mXgxUyuGq2H5oRj6igrNiFMkyuwdJuAON+KZ13xzMovXuPTLjAnOJQ==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr45359917wmg.159.1563554536174;
        Fri, 19 Jul 2019 09:42:16 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id g19sm32764233wmg.10.2019.07.19.09.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:42:15 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: VMX: dump VMCS on failed entry
Date:   Fri, 19 Jul 2019 18:42:12 +0200
Message-Id: <1563554534-46556-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful for debugging, and is ratelimited nowadays.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 69536553446d..c7ee5ead1565 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5829,6 +5829,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
 	}
 
 	if (unlikely(vmx->fail)) {
+		dump_vmcs();
 		vcpu->run->exit_reason = KVM_EXIT_FAIL_ENTRY;
 		vcpu->run->fail_entry.hardware_entry_failure_reason
 			= vmcs_read32(VM_INSTRUCTION_ERROR);
-- 
1.8.3.1

