Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B78E206DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404332AbfIFCRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:17:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfIFCRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:17:34 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C6F1369CC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 02:17:34 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id r7so3376781pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 19:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aBUS+fgsamAUOZtSEp++jlkJB5YgKT1csWUc+zQUKS4=;
        b=RaUSZubVvzcceJVO+n9BiE36/iLz2Be5c1bdS+Zxkv812Pjz4X/Lhb/3VKGvOQcN5V
         mMH3ySPHTgFG9f10nIoDr6oVKC/Gw5tUOuTG5uUFb4/yUtLmE4ihb0oV6Zsskqx6euf9
         kx2MApAVU3/bTD7YpwD1291kJYacozggJb51XKU8mPVHbGQa79g7hRofETGMB5hDOcrD
         hxgiwiTc25PPFSacZlCv3MuXK24I8yCrjDnnjNcQtDeOWv9xzqUBHFvzrGsdSszLJOl/
         JLaBBnyWUFBX7kp0/RIk/P3tzh1ovDBO29N7Oghvaot6+qKiHCA9Dg3mqV5qV5XAtSoU
         t6cQ==
X-Gm-Message-State: APjAAAUjumksEvuP0tY7fUKfprQ4PuOQiEk5nDnVGX2eyfqGHrmPYkEg
        8b7rP72QIisbO+uGlv2UDRZVTIwRYfHIz8uqqGsPZIKyUER2QemrGZZumibebfEkGCvoZNBVQEa
        v/56iuyLx2b5RkitcUNprJw8p
X-Received: by 2002:a62:e717:: with SMTP id s23mr7759988pfh.71.1567736253143;
        Thu, 05 Sep 2019 19:17:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCQJM/WuwJ79nbWX4bQwimjvaO+Ug+0hsWoiE4Vf9iu3itMcfU3iYer2r464k1bCxIb1dlRA==
X-Received: by 2002:a62:e717:: with SMTP id s23mr7759963pfh.71.1567736252846;
        Thu, 05 Sep 2019 19:17:32 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a11sm8212359pfg.94.2019.09.05.19.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:17:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>, peterx@redhat.com
Subject: [PATCH v4 0/4] KVM: X86: Some tracepoint enhancements
Date:   Fri,  6 Sep 2019 10:17:18 +0800
Message-Id: <20190906021722.2095-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- pick r-b
- swap the last two patches [Sean]

v3:
- use unsigned int for vcpu id [Sean]
- a new patch to fix ple_window type [Sean]

v2:
- fix commit messages, change format of ple window tracepoint [Sean]
- rebase [Wanpeng]

Each small patch explains itself.  I noticed them when I'm tracing
some IRQ paths and I found them helpful at least to me.

Please have a look.  Thanks,

Peter Xu (4):
  KVM: X86: Trace vcpu_id for vmexit
  KVM: X86: Remove tailing newline for tracepoints
  KVM: VMX: Change ple_window type to unsigned int
  KVM: X86: Tune PLE Window tracepoint

 arch/x86/kvm/svm.c     | 16 ++++++++--------
 arch/x86/kvm/trace.h   | 34 ++++++++++++++--------------------
 arch/x86/kvm/vmx/vmx.c | 18 ++++++++++--------
 arch/x86/kvm/vmx/vmx.h |  2 +-
 arch/x86/kvm/x86.c     |  2 +-
 5 files changed, 34 insertions(+), 38 deletions(-)

-- 
2.21.0

