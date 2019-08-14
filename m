Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FFA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOSnETkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfHNQWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:22:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40625 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:22:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so3410454wrd.7;
        Wed, 14 Aug 2019 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=uzdO+yHR/jswNXYt1APUPkPcgWFUeVIjS1JXB8tO2t4=;
        b=WOSnETkhAGjZPyZR1x7nnqvzmIqEHs6EjXwis2TgzCMCk7/kluyHYoX5pstlJ0NOgd
         Z53GH/QsjNT3p0EP+zTlrUCqcjyd9J12BEJUi4NVuNZwkCW2xa12wS7tx/BsjB9BFeo6
         zH/b2iujpTlTS0ZuzbcfaQjAs1+1a0roWG4YP0Rc6MM4LwCkXgYR7keq1YQjulIJvFKA
         2vpM9zCW1FhtxECsskpVsUvkmm16xMAQ2SEvl+FgQwB7AH5MXHr8KUeZmMrroFFzDAsR
         4Pd45bVJn7VW25FA1FmrjPnXl1DsqX5QELy1P445aBx83tij0YBzRWy85I2TbX3tPuJs
         JkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=uzdO+yHR/jswNXYt1APUPkPcgWFUeVIjS1JXB8tO2t4=;
        b=IhYnuTCxnqAr0RLKTFR7KesYtfUcyapUNNmwbfbTJKjFt0bE6PgFtbTGGBNnK9v77r
         NIIFfNacN5ZXyGs9yDIxCsaGBPPNYPzCfB+s/hH5eq/7BQ9wUUiko4Rimb6PLBElBrLc
         RLg7NansLMsxdE7qBwop2vpnn9+T6DJ3g9uX0hjBhXu01zLP2AQzx+057UUxO2joDYcL
         OApILTGB6c4xBuOyRXv0F2Dp+Q8LfEXUN35saSaTl9X1zimPaVs7vBWUIUW1cNlASEDi
         qoAta5XjYPdkEPhOFUwCSc0nyO0WgtsP8lVYWnuUg6455Tr2dah8vES5+dxmKaZ04Gig
         c1Ew==
X-Gm-Message-State: APjAAAXQSc6GQHfyDf5x9kvHAkRw9NP2ZvizNkVz4H355cvwZFxBopaU
        SGwMMzQBf84kqKB/lzfRH8gi+UHf
X-Google-Smtp-Source: APXvYqxOsIrirQDXJNuCwYZJrfAh7+Vc5YPyCe0aDfXmfiBwTS20tNaMuq7DjVm9362Y4VCfhKPsAA==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr588007wrx.122.1565799756740;
        Wed, 14 Aug 2019 09:22:36 -0700 (PDT)
Received: from 640k.localdomain.com ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id k124sm191620wmk.47.2019.08.14.09.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 09:22:36 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com
Subject: [PATCH 0/3] kvm: selftests: fixes for vmx_set_nested_state_test
Date:   Wed, 14 Aug 2019 18:22:30 +0200
Message-Id: <1565799753-3006-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmx_set_nested_state_test test is failing in the top of the tree, due
to the change in KVM_STATE_NESTED_EVMCS semantics from commit 323d73a8ecad
("KVM: nVMX: Change KVM_STATE_NESTED_EVMCS to signal vmcs12 is copied
from eVMCS", 2019-06-26).  The expected behavior of the kernel has changed
slightly and the test should be changed to match the fix in the kernel.

Paolo

Paolo Bonzini (3):
  selftests: kvm: do not try running the VM in vmx_set_nested_state_test
  selftests: kvm: provide common function to enable eVMCS
  selftests: kvm: fix vmx_set_nested_state_test

 tools/testing/selftests/kvm/include/evmcs.h        |  2 ++
 tools/testing/selftests/kvm/lib/x86_64/vmx.c       | 20 ++++++++++++++
 tools/testing/selftests/kvm/x86_64/evmcs_test.c    | 15 ++--------
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c  | 12 +++-----
 .../kvm/x86_64/vmx_set_nested_state_test.c         | 32 ++++++++++------------
 5 files changed, 42 insertions(+), 39 deletions(-)

-- 
1.8.3.1

