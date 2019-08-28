Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49BFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF71C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfH1H7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfH1H7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:59:09 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B26B683F3D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:59:08 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m25so670773wml.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXBfbXP94FsOpi1v9mBeSf+ahhRJGbCczR40mL5l1g0=;
        b=YWNP4ZYCCkyWCL6ozrbQzxkjos8ATV6bMyVhlqnYPfDXZLSaQyyaCABprvxcb0GcI7
         QlvaM5fsVcfAbX3R/ClNOP36G6eP3DnfEai/OPbVOHlvLX8uWYLVrAQfYgtxrfzaHmcf
         ub6xnxeVQRy+A01rZTjQ+X0LeSP2hi6y8COKvHadXIoPqx7SGYboG+OGf9pBKc3g7sWE
         RrkAiTeTde2fFWyQXT7ucWH5JVt68AIGkVSePFMeF8L8tafJhjyknLDQOpbZWNRcAzAh
         Hr7+udTKOAvw+seTG6JDzL6C/PYz90BlY3CBAP4byZwdwMKhQPju6hFpIxTnNuHPNIrt
         oGHg==
X-Gm-Message-State: APjAAAXW8SpXq7TR87xtU7WIAuWb5CtWScAKaJZhwILf34S3inJVFxpv
        YXmw5oI7CvxEwBPOqg3RDJah6wybZBWn2bAI3QpCfuTAnCBLlzzc+JKVsZ4BGB21cWFlnuvWmUE
        J+pa4hhdu9yPGe3WMuaeGV3mR
X-Received: by 2002:adf:db49:: with SMTP id f9mr2912027wrj.112.1566979147478;
        Wed, 28 Aug 2019 00:59:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6jeOXWHKp2OBmWJFh9i//W4b2alfBLT0xcTCuk+Wnz7ITWniIoIL5zWUQjKwG1rgsfWp0Gg==
X-Received: by 2002:adf:db49:: with SMTP id f9mr2912008wrj.112.1566979147295;
        Wed, 28 Aug 2019 00:59:07 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a190sm2448469wme.8.2019.08.28.00.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:59:06 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH v2 0/2] KVM: x86: don't announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS when it is unavailable
Date:   Wed, 28 Aug 2019 09:59:03 +0200
Message-Id: <20190828075905.24744-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered that hyperv_cpuid test now fails on AMD as it tries to
enable KVM_CAP_HYPERV_ENLIGHTENED_VMCS which is (wrongfully) reported as
available.

Changes since v1:
- This is a v2 for '[PATCH 0/3] KVM: x86: fix a couple of issues with
 Enlightened VMCS enablement' renamed as the first patch of the series
 was already merged.
- Added Jim's Reviewed-by: to PATCH1
- Added missing break in PATCH2 [Jim Mattson, Sean Christopherson] 

Vitaly Kuznetsov (2):
  KVM: x86: svm: remove unneeded nested_enable_evmcs() hook
  KVM: x86: announce KVM_CAP_HYPERV_ENLIGHTENED_VMCS support only when
    it is available

 arch/x86/kvm/svm.c | 9 +--------
 arch/x86/kvm/x86.c | 4 +++-
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
2.20.1

