Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1486C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B0E21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfH3Bge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfH3Bgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:36:33 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC07319D335
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:36:32 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id t2so3102870plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 18:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ESp2wQ+ShJ19lwVMIpcld726Rm6S3EhRfyVa4rRVDKo=;
        b=R35+8YJu05TMAn9JBiRkGa9G3ph/jseI/Dn1BSibDPlcBfkwF2eB/XNbtLOqCygw9m
         y7JQ+ri5wzO4P9ItVgWf4ZOH6My5yD9j0icuy0v7bfcqT2wQf4zIYyaUTrvY0KRVDrDY
         mPOP2tK7LqjgdZixIFrwOjCkcGHBOymlfWE001Q7wuMbzPjL5MLaRlsOgnIFe4uRl7h2
         I6Td1J4/Q+bimdp4sAO5Q9QK4Hv6yn8N2w3iTdLtAkVUTfzn4jkdSrVq1+3u58ZA1F8P
         q7kvv6FavVm2/GcOMODT02hJ7K20z8Ol++SswjZRrwGTiOfQVislgt5/Ft1B7fSlpKb/
         nD+g==
X-Gm-Message-State: APjAAAXUo8QF/gsoDuKwg3nHkLYZm7leRfK4FLI1mQVYxspNxv+/+Q84
        9sE4kRr/xiH42QW2BVICQoJdPtgcVguDZSzsgk3C/MNs2XATwShRk7xFs4FQVgvgjr921/1XoS3
        G9Ps/g2GK78v+SeP9wKoSn1zb
X-Received: by 2002:a17:90a:8981:: with SMTP id v1mr12943051pjn.136.1567128992092;
        Thu, 29 Aug 2019 18:36:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyO5H/X/qZw+xcqx4rZ2rlEDXWN/KoGhZsygl5nudPWBd1hzN5yPn8cEHhBKqSIafucm/zQdA==
X-Received: by 2002:a17:90a:8981:: with SMTP id v1mr12943030pjn.136.1567128991881;
        Thu, 29 Aug 2019 18:36:31 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l3sm3426323pjq.24.2019.08.29.18.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 18:36:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>, peterx@redhat.com
Subject: [PATCH v3 0/4] KVM: selftests: Introduce VM_MODE_PXXV48_4K
Date:   Fri, 30 Aug 2019 09:36:15 +0800
Message-Id: <20190830013619.18867-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- pick r-b
- refine DEBUG macro [Drew]

v2:
- pick r-bs
- rebased to master
- fix pa width detect, check cpuid(1):edx.PAE(bit 6)
- fix arm compilation issue [Drew]
- fix indents issues and ways to define macros [Drew]
- provide functions for fetching cpu pa/va bits [Drew]

This series originates from "[PATCH] KVM: selftests: Detect max PA
width from cpuid" [1] and one of Drew's comments - instead of keeping
the hackish line to overwrite guest_pa_bits all the time, this series
introduced the new mode VM_MODE_PXXV48_4K for x86_64 platform.

The major issue is that even all the x86_64 kvm selftests are
currently using the guest mode VM_MODE_P52V48_4K, many x86_64 hosts
are not using 52 bits PA (and in most cases, far less).  If with luck
we could be having 48 bits hosts, but it's more adhoc (I've observed 3
x86_64 systems, they are having different PA width of 36, 39, 48).  I
am not sure whether this is happening to the other archs as well, but
it probably makes sense to bring the x86_64 tests to the real world on
always using the correct PA bits.

A side effect of this series is that it will also fix the crash we've
encountered on Xeon E3-1220 as mentioned [1] due to the
differenciation of PA width.

With [1], we've observed AMD host issues when with NPT=off.  However a
funny fact is that after I reworked into this series, the tests can
instead pass on both NPT=on/off.  It could be that the series changes
vm->pa_bits or other fields so something was affected.  I didn't dig
more on that though, considering we should not lose anything.

[1] https://lkml.org/lkml/2019/8/26/141

Peter Xu (4):
  KVM: selftests: Move vm type into _vm_create() internally
  KVM: selftests: Create VM earlier for dirty log test
  KVM: selftests: Introduce VM_MODE_PXXV48_4K
  KVM: selftests: Remove duplicate guest mode handling

 tools/testing/selftests/kvm/dirty_log_test.c  | 79 +++++--------------
 .../testing/selftests/kvm/include/kvm_util.h  | 18 ++++-
 .../selftests/kvm/include/x86_64/processor.h  |  3 +
 .../selftests/kvm/lib/aarch64/processor.c     |  3 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 67 ++++++++++++----
 .../selftests/kvm/lib/x86_64/processor.c      | 30 ++++++-
 6 files changed, 121 insertions(+), 79 deletions(-)

-- 
2.21.0

