Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72098C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35550206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXRQoSCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfLDS4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:56:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44528 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfLDS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:56:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so278508pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GrTDw7KQHR9Zr6li1nTe2wl4QZFVN56MIBJeTe4Eo8k=;
        b=LXRQoSCXDDzGjopeIkIgLn0pJfsK8cqywHU+y97e1KdZyOyYx/gPKaZyxcIpuPXupx
         ymgBf/yz1Ar9s52nRWKEQViqQDQDRnLWuNuPEMvYiSuJ5ltwTer2wA11zDeygYopmzWC
         AT0a6zOZ5KJ4z90fM1BSRk4BPfgPxlJZtAn7yfhY8qnnYlP69/lnHC/NYnb5RIn5zk6p
         RhpaRjpQyzFafVefqQz1v0JP4ooQTefm8NvFYKqzPrpvYSsnnDyUyqHUGDyBUGvbbNRO
         94IEDAIs9KGpGB1STeLpNZvMzz73MVed+6HZTj/aBiDzpCydD/dbjsiPvi+mpdapgbe7
         yfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GrTDw7KQHR9Zr6li1nTe2wl4QZFVN56MIBJeTe4Eo8k=;
        b=pIdMR/dNbUzq63OhXYYDZB/nc4c+lY08dD+zr6ssM6R7UdPaJPHOxprRp6bx1TbKVQ
         0HGPBycFUpQyt6zOpylCUY7HuKTpCrX/uNP7iVewwvbtgagFKCn5GVl4ECq/MbgeduwD
         F5YMJ3fKANhbpmzUHkEBq8YgDcJDBUMIdTg0NaHJyJyiQs2AsKlG9LMVhm3vIs4vyt/k
         MBBeyq5mzAbbueOo2tKvgNJ7xN1/e0EALX9flpLQ/UHRDtJ46h2TQXz5n5n6QAAIVS19
         90OT1dVYJdQ1j33ewCCZ1zx2vhB2s/gGwkmOnR13E64xNk8O03WswpvX0+EZNfmzU3z/
         t4Qw==
X-Gm-Message-State: APjAAAUAqV5rGuR/t38QzQZvRPUQohHxTET0aWzPqRJro57mzj8VqWdf
        j5+PwmihVEDdc761a7G2cJNH4n0Dw3s=
X-Google-Smtp-Source: APXvYqzldcvtOJEAnDxB1swtWUECL8KXNDu21UIbDRV+iIzG32ZNOnlVsAiwtPDsWhDU9jnDN64qzw==
X-Received: by 2002:a63:ca4d:: with SMTP id o13mr5025430pgi.360.1575485788875;
        Wed, 04 Dec 2019 10:56:28 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id f13sm9160328pfa.57.2019.12.04.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:56:28 -0800 (PST)
Date:   Wed, 04 Dec 2019 10:56:28 -0800 (PST)
X-Google-Original-Date: Wed, 04 Dec 2019 10:56:12 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v5 0/4] Add support for SBI v0.2 
In-Reply-To: <20191126190503.19303-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, alexios.zavras@intel.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        han_mao@c-sky.com, rppt@linux.ibm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-fc56738d-7643-4125-b6f7-486afb948a53@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 11:04:59 PST (-0800), Atish Patra wrote:
> The Supervisor Binary Interface(SBI) specification[1] now defines a
> base extension that provides extendability to add future extensions
> while maintaining backward compatibility with previous versions.
> The new version is defined as 0.2 and older version is marked as 0.1.
>
> This series adds support v0.2 and a unified calling convention
> implementation between 0.1 and 0.2. It also add other SBI v0.2
> functionality defined in [2]. The base support for SBI v0.2 is already
> available in OpenSBI v0.5. This series needs additional patches[3] in
> OpenSBI.
>
> Tested on both BBL, OpenSBI with/without the above patch series.
>
> [1] https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> [2] https://github.com/riscv/riscv-sbi-doc/pull/27
> [3] http://lists.infradead.org/pipermail/opensbi/2019-November/000738.html
>
> Changes from v4->v5
> 1. Fixed few minor comments related to static & inline.
> 2. Make sure that every patch is boot tested individually.
>
> Changes from v3->v4.
> 1. Rebased on top of for-next.
> 2. Fixed issuses with checkpatch --strict.
> 3. Unfied all IPI/fence related functions.
> 4. Added Hfence related SBI calls.
> 5. Moved to function pointer based boot time switch between v01 and v02 calls.
> Changes from v2->v3.
> 1. Moved v0.1 extensions to a new config.
> 2. Added support for relacement extensions of v0.1 extensions.
>
> Changes from v1->v2
> 1. Removed the legacy calling convention.
> 2. Moved all SBI related calls to sbi.c.
> 3. Moved all SBI related macros to uapi.
>
> Atish Patra (4):
> RISC-V: Mark existing SBI as 0.1 SBI.
> RISC-V: Add basic support for SBI v0.2
> RISC-V: Introduce a new config for SBI v0.1
> RISC-V: Implement new SBI v0.2 extensions
>
> arch/riscv/Kconfig           |   6 +
> arch/riscv/include/asm/sbi.h | 177 +++++++-----
> arch/riscv/kernel/Makefile   |   1 +
> arch/riscv/kernel/sbi.c      | 547 ++++++++++++++++++++++++++++++++++-
> arch/riscv/kernel/setup.c    |   2 +
> 5 files changed, 660 insertions(+), 73 deletions(-)

There's a few issues with the implementation, but I think the bigger question
is what do to with the spec.  The SBI stuff sort of snuck in to Linux without
actually having a proper spec written down, so I'm happy to just say "let's
take the 0.2 stuff as soon as it's frozen" as we're at least in a better spot
than with the legacy stuff.  Nominally we'd need to wait for a ratified
specification here, which probably means a 1.0 specification, but that's a way
off and I don't want to just sit around on the legacy stuff.
