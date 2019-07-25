Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D533C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4290F22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfGYMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:04:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45453 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGYMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:04:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so50451626wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqKXeZ90q+N46puvA2cVZOXYv8qzvqZWEskJsjgVdVI=;
        b=Cu9FhminCf0fLCRKh3q85ixu9Wg7uCvi7n7191jv3SkFCPbbNuXzr16bDGfYvMxQwY
         Hntan2Y0zGE+nazwkAK5CBKcBVtNMn9tnD630vWeFwCHK15bd0LK1W62/Fr6jAaahUPu
         eP2Qz1YrJn4zTRRGoo/DEQdfzVAY8uo9LK1Ev+BzF5j4a2NAsTlNPJLqFaegROWmErmJ
         C0AUe2C/RBfHduJp5zQNFhT8i9ku6aRrL82Xatm2L2Kpaf/bE7lzTekHlniWgVGLbMfU
         xuqxLSHPvRAXfj9xK+ckDtiXpZVZ6IH+RFQzDOWxdOiZ8vRWmw1WioME+QwxulRpd01Z
         1KYQ==
X-Gm-Message-State: APjAAAW1VCZsFxNQj/wECbeSDaTFfeYSmHw8Ut6BW4WsnbNZw/7MYBnB
        x1ozzvXFTSxTUy5xxoG7QvX2Xg==
X-Google-Smtp-Source: APXvYqxgacEuljaodY+6UYjxTLGKv2jZYcIqdsid+YgNyuPREeL3/l39SCiPJgslt81tpsrt6sQXbw==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr20540812wru.305.1564056278267;
        Thu, 25 Jul 2019 05:04:38 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j6sm73793424wrx.46.2019.07.25.05.04.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 05:04:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH stable-5.2 0/3] KVM: x86: FPU and nested VMX guest reset fixes
Date:   Thu, 25 Jul 2019 14:04:33 +0200
Message-Id: <20190725120436.5432-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few patches were recently marked for stable@ but commits are not
backportable as-is and require a few tweaks. Here is 5.2 stable backport.

[PATCHes 2/3 of the series apply as-is, I have them here for completeness]

Jan Kiszka (1):
  KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested

Paolo Bonzini (2):
  KVM: nVMX: do not use dangling shadow VMCS after guest reset
  Revert "kvm: x86: Use task structs fpu field for user"

 arch/x86/include/asm/kvm_host.h |  7 ++++---
 arch/x86/kvm/vmx/nested.c       | 10 +++++++++-
 arch/x86/kvm/x86.c              |  4 ++--
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.20.1

