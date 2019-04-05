Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4025CC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A182171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0oFWKsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDEWrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:47:00 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34595 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDEWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:47:00 -0400
Received: by mail-wr1-f42.google.com with SMTP id p10so9748788wrq.1;
        Fri, 05 Apr 2019 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=3YP95FCrH0qw7nkIWk1Unpm6LTxin3eX9t2UGIw5Qe4=;
        b=F0oFWKsP8FutKwTyKQBW2OMqjX046qcLs24l50IduNHE8tFkV0hcJbZwwWqZcqonWL
         CeMWaFIlVOBMx8TLIQ385ZTvkFvRdb/0o6VcT7D/srcOS3ZV2efKr4BW/+hGooJJHN5n
         8I+I6i9hsqKw9xGuCgi7Xw9dnuqg1AuNs0BDZ9n08BQfHr5jK1uDySB/tfcF3+Yrk474
         Ecys+XZe3YzaryCvlR5TBCKCwAigLBYox4AAtMzpYY+GaJaXjhfV3/5XQmCIx5+wfsek
         gwm0J3KWhPe9nQyKo1iBzEWE9Oal8UVYhX3ZEdqplMC/W9GbA1Uk086ibWKuVdZbwh4R
         UkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=3YP95FCrH0qw7nkIWk1Unpm6LTxin3eX9t2UGIw5Qe4=;
        b=seT9l/vfk7uIwtaFI9TKup2ne/Wbb9tvrLCfqyN0BQLV7w1RlAJ6I3HrhtLVP6gt2g
         y7/6Jn70eRuhD/0MwNdAnevU5vZ9oDVzx9F+eb7WCRz2gsVSDDukMz4e+yVYj3B8hM/w
         kTEIpuMfytxCuZOIfLNXInN+HvA/ij7gDo9AU5CtZdbtvOB0mB89odM9kHxenKtwAiBA
         L7mi2mXWJNRwWvyJhEH/55+LSXXtEsAbVmeYgFmEhEAsXNC7+VZOSaej5FNC1nldCFDb
         Dxmt/r3go6PTOL4TMnLRC+1TvwI8+xPHWs6v+2u51euIVks0dFZd9R4B6YnZckjHz+y/
         Dl4w==
X-Gm-Message-State: APjAAAVHu1SoVKwdzglQBkVCfEYW1h7oG5RJMM7hZiuSzHYLEBcVuzyC
        /tS2xPZpPUz+BTeTevlns8IHB+cw
X-Google-Smtp-Source: APXvYqxIp02m+gPsyNSm3imWs2bxWEAazZEyo21JdzGWGx0a4HcXuEkJfesk0Bl9iaJ68wOoa3aEJw==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr10287932wrr.190.1554504418137;
        Fri, 05 Apr 2019 15:46:58 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 7sm81190791wrc.81.2019.04.05.15.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:46:57 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 0/2] KVM: x86: nVMX bugs
Date:   Sat,  6 Apr 2019 00:46:54 +0200
Message-Id: <1554504416-8720-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix issues with the nested VMX MSR bitmap.  I have already
sent them to Linus.

Paolo

Marc Orr (2):
  KVM: x86: nVMX: close leak of L0's x2APIC MSRs (CVE-2019-3887)
  KVM: x86: nVMX: fix x2APIC VTPR read intercept

 arch/x86/kvm/vmx/nested.c | 74 ++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

-- 
1.8.3.1

