Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA3C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEB720874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XR5LMhR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfFLEeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:34:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbfFLEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:33:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so8827356pfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBsKt2KANme/JOaDCF19p+x3nQ6r/cZjZD0p0XOtcRA=;
        b=XR5LMhR4dWhA49NOiuns+aK4QrV/lto9XTcVrVO75nePd55lQKThU0DWL1/fhyhpPQ
         uZqQ0DJjMLAKLed+Jn1qYvp2NrAf4dmQ6YHWcz3wj8Rchmi6ud/YFwKdG1ttdZExwMWF
         NI2E/s8wUgv+GXSy1jtSQSCGn/o6LO7iy8ktQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBsKt2KANme/JOaDCF19p+x3nQ6r/cZjZD0p0XOtcRA=;
        b=EBCihGdY7YM4KTL3cw2WVvx/eDCxJWK/xoUz9y8gYyiuxewirhr8vZEqDcSFWy7fnF
         0UNGl6RUU8xKdZYZcbx5w9zg7rVAW0UuTAykXSUCpn3BbCxLNwZo9UC4fYE9XaQ436Jw
         6LnZBc1tOT6semAZuhWaYXuMSjNHdmDGSlgyaTw33nJFUD9wUUkV+NfhxbJ6v4ga075l
         avkVTOBB3IDVinmLXetya6zb9hgH1ycibbaPR6bFSCx2VDeulHeqoX4HV639RunFZn+8
         vCL4kZuMOVDBK7NvN1ycp9jQH6x/uM+pDIGSgns+hwCWN+zFJ6//edseQdfA0PkUgUNi
         VEug==
X-Gm-Message-State: APjAAAWuRb55QxjRGO6H+Wpy4T1BYErFtoE13g15ZXvNWVZGI/cuSQpB
        +JW2DI7tYSnMMo26Fb36JsRfxQ==
X-Google-Smtp-Source: APXvYqx/41bl7EzQ/YdXQSxExzoTiwXpf+pMqfvDDMtli/3cshz845GRC+rnDzNoeKjMdXh1FqX72A==
X-Received: by 2002:aa7:8394:: with SMTP id u20mr72672175pfm.252.1560314038527;
        Tue, 11 Jun 2019 21:33:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id k8sm15285998pfi.168.2019.06.11.21.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 21:33:57 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v6 0/3] add support for rng-seed
Date:   Wed, 12 Jun 2019 12:32:56 +0800
Message-Id: <20190612043258.166048-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a chosen node, rng-seed, which is an entropy that can be
passed to kernel called very early to increase initial device
randomness.

Hsin-Yi Wang (3):
  arm64: map FDT as RW for early_init_dt_scan()
  fdt: add support for rng-seed
  arm64: kexec_file: add rng-seed support

 arch/arm64/include/asm/mmu.h           |  2 +-
 arch/arm64/kernel/kaslr.c              |  5 +----
 arch/arm64/kernel/machine_kexec_file.c | 22 +++++++++++++++++++++-
 arch/arm64/kernel/setup.c              |  9 ++++++++-
 arch/arm64/mm/mmu.c                    | 15 +--------------
 drivers/of/fdt.c                       | 10 ++++++++++
 6 files changed, 42 insertions(+), 21 deletions(-)

-- 
2.20.1

