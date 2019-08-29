Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BAC41514
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9002173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 02:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfH2CVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 22:21:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfH2CVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 22:21:31 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3B74811A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:21:30 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id q67so1267336pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 19:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0ntCxjTGtKbzFXJg3nlEr8z4Qg5JGGVYpSbuyABl2w=;
        b=dj8Mfq7XqC5JJRC96U5Z0G94DDL00PV8p7cMtH36AWXV13NVg3W+6zF0N1piDOyz7E
         zhwCTOK8ofw1OhOelHw5s93H/4hUvSyoIrxZnh5HZTF+NfZavkmDFmPvmeMdkVDDiM/M
         FH3bH+Ps/nbcN93+pTSrDL2uClPHLxbG9wls+VRBjdeiknR3tDnxYhrwzxHhYPdyLR5t
         vA0S1U1pYpHkZyNSJGqFMm3BrsUwgx+16XajIf53hG1/FpbwTDw7n3MSkcKX5+L5piZ4
         2nrB+czY1fy87Ohux48e6804VkFI60JgDEOS59NCVcANf73CmC2UgBC1eKAjxbzvuh+K
         1JeQ==
X-Gm-Message-State: APjAAAW/QP5ljmRlaKpGeLeMzAh5SWHOUkyfnmz90xQozBl42TeQw4nb
        uu5tO170ckUy+2SJ1fLWYa6BchFmm5CT7bSoy2/WwlmF/W3mHNb/gsmyVrRYvOh1geC3xgQfJ8n
        lBFTgeGR8bngOeunU5VFRB9wZ
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr7070922plk.53.1567045289860;
        Wed, 28 Aug 2019 19:21:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMezApsFpPfMPo0+CoJhPhtkIA4wIFy3VnvhRI32O80EhZ8+FMosGoBfvA+xbB/1GKt6+MhA==
X-Received: by 2002:a17:902:6a82:: with SMTP id n2mr7070908plk.53.1567045289670;
        Wed, 28 Aug 2019 19:21:29 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j187sm750140pfg.178.2019.08.28.19.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 19:21:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 0/4] KVM: selftests: Introduce VM_MODE_PXXV48_4K
Date:   Thu, 29 Aug 2019 10:21:13 +0800
Message-Id: <20190829022117.10191-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 .../testing/selftests/kvm/include/kvm_util.h  | 16 +++-
 .../selftests/kvm/include/x86_64/processor.h  |  3 +
 .../selftests/kvm/lib/aarch64/processor.c     |  3 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 67 ++++++++++++----
 .../selftests/kvm/lib/x86_64/processor.c      | 30 ++++++-
 6 files changed, 119 insertions(+), 79 deletions(-)

-- 
2.21.0

