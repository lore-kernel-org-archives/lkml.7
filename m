Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEEECA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D3621783
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV4dprwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfJWAF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:05:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJWAF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:05:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so8697831wrq.5;
        Tue, 22 Oct 2019 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RVKbhGUPx9Rp4t5lnvvSGAoEpsAteMrVsae47CNGU14=;
        b=rV4dprwNkqYCdBGstHoA61ZbChSAvfasMEjznbxr7K8YlZ6b/uCc65hPy+xGsoLfgk
         lIXI860w/KucgAduq4zMJLowbW5NklpuLCq1VTl4xtE5l6jH8XOQE8f9F+l3Jso0P3B+
         iU9V/ExzTp617nC7rcnqjAHqSsAHBSSdwmwBGDFX7Si9Cp+5EfrbaleMqfk9U/wJWdjO
         XWJ7Dha21OzRYq/nP9iK0O/g3AAZl1i7Vn/P9cveEur3J1uXHI/b1e1kpd+S1pDBEGXB
         X8w/CU9k5k0PZXFFgu6qsQEHckF1ficun2aF/ndxVbBXnKcoWwbg37IoqaBa5sEozBX6
         goqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RVKbhGUPx9Rp4t5lnvvSGAoEpsAteMrVsae47CNGU14=;
        b=RT4SO/Gd8Ug7ar/Hh95eYzQjkqBTU2a4ZSLkJ7wzKbFWCYFDOymm1FiZ85yHbkTHTR
         B/qVRyroWlzDisain/7yuEb+4uHBya6qFncJ2n2X7ML0KxTtXFcdbvkglc+YasjqMkMg
         AOprxBXtyo1KJ56hISpphFCV0YrID2FdSp6oKc7sGB9drbsTmPcXXYySSBF5AlOVzUNd
         HuOEqbe86b81SyHN7yBXbsW1BXOKlv38q5oQUVjBXd+p31DcLFgozkWBaLjGdCOluNAP
         FomiPIOr9s3H2t+66ALMTdqkDNMnUeaaAdjBuKC29KQSlocpht9+dvJI0DffGifM76ml
         lirQ==
X-Gm-Message-State: APjAAAU9untCKQrJXklE1pEAygi8VTe+49xBpDLqu27Jfo7NwgFxkqhe
        B+RCuGm9gsNrCgsOvrxcxbXisRG7
X-Google-Smtp-Source: APXvYqyyX1wB2kOZ08WrMc2jMATBMd5XgQO6AIaHwnrUyVWtMDn1LyZ/X+WuzzvPv9A62KSXHBtCzw==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr5775327wrj.345.1571789154654;
        Tue, 22 Oct 2019 17:05:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v10sm18500272wmg.48.2019.10.22.17.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:05:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: [PATCH RFC 0/2] irqchip/gic: Allow the use of SGI interrupts
Date:   Tue, 22 Oct 2019 17:05:45 -0700
Message-Id: <20191023000547.7831-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sending this as RFC so as to gather comments on the approach chosen
here. The Broadcom STB mailbox driver and its firmware in EL3 use a
combination of "smc" for inbound (Linux to monitor) and SGI for outbound
(monitor to Linux) signaling. This mailbox driver can be seen here:

https://github.com/ffainelli/linux/commit/17cc97919f4cd2583d67e624273da8b54b44a4a7

(we may switch to the recently proposed standard arm-smc mailbox driver
proposed by Peng Fang, but we would need interrupt notification anyway).

In our downstream kernel, we have hacked the arch/*/kernel/smp.c code to
permit the installation of custom "IPI" handlers, this is obviously
wrong and absolutely not suitable for usptream.

Here, we allow the GIC to recognize SGI interrupt specified in Device
Tree with a new specifier in the first cell (2) and then we let the
mapping and translation occur provided that we are above the NR_IPI
range.

Immediate problems that I am aware of:

- on ARM (32-bit) NR_IPI does not include IPI_CPU_BACKTRACE, so we could
  (are) be off by one in our check against NR_IPI

Florian Fainelli (3):
  dt-bindings: Define interrupt type for SGI interrupts
  irqchip/gic: Allow the use of SGI interrupts

 .../interrupt-controller/arm,gic.yaml         |   2 +-
 drivers/irqchip/irq-gic.c                     |  41 ++-
 .../interrupt-controller/arm-gic.h            |   1 +
 7 files changed, 313 insertions(+), 16 deletions(-)
 create mode 100644 drivers/mailbox/brcmstb-mailbox.c

-- 
2.17.1

