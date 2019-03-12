Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8162147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIXRUEdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCLUSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:18:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52308 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfCLUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:18:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id f65so4062143wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRhLG9kD6ihow+ahvLjtKp4GeQpYxn43CZtd+gLsH6U=;
        b=RIXRUEdjPhbE/WvsJoiw3+oGVuS2o/VuI6LtlNbxpWnbZhGtfosJxck2cTRXjAqcDn
         XA+HtzDTrvH11USp7MteV5JTfboJf8knzCdxIBXjCl7qQxYWh+xOXo+TedkyXQdYB293
         g0cQgIKxhWREI9kpORg7L2jaaU8vkoZujQKtD7FdlmAoM5cWxeqiPGEsD+zLABUzmSjn
         jgbkzhoPiqxENW+pXrhPLZFKIW2vrVs6IbI4/dWGpmyWw+/7Uk2AbABXhUQf4nHhsu4i
         d47yTpb6o9yAOPc4DeJ3/R+aOwGvifijAeW5Cb4pjztVB47IZijTQgUHMtVTCZzU6Xy8
         4D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NRhLG9kD6ihow+ahvLjtKp4GeQpYxn43CZtd+gLsH6U=;
        b=ld3VFhUW9/jgw6HNeCD7tKn4NVl6WIVJeItRy0EqpOC0sFlXmenGLvqna4lQx8Wpy8
         ACHhEfDNLsTB/znjKEJa5kMrs1HQ5nf8vsXmuaJj0QGFuUfMbQOghp2jtubIRkS4S2u7
         7zwTBMLGkrhhVF46yreCGCFXFhNUUf3ssx/BxNtD7a7FST5m07HEwi4FRFKltrxLeSWW
         HMZH04MzNgb6cBm6x1NfxXRiGNkhraXk4wrRzeB0qxZhHVlt1MjPnk84EFUyH4SOmfwj
         clY1bWSfxDPM1KAUz44dD09VeWnp9I9Ig/3pY32Z8lGVt3GtmNImV+DiCrMDClLY12Ei
         PTpQ==
X-Gm-Message-State: APjAAAUkJv19rgI+NLy16HhmtpmMWf8qVxaNzUENKLX0Xm0kTV2qTfRz
        DzYGhldDkYL9Lnas5XDH8Y4bTlqp
X-Google-Smtp-Source: APXvYqx96DiGXjumB1OWz2N30REZQpqUqbZ+wkVG4Rnxt+rF5+di4QS4fKygcOYXpZo+5D6uRuKRZA==
X-Received: by 2002:a1c:2283:: with SMTP id i125mr3601107wmi.24.1552421913609;
        Tue, 12 Mar 2019 13:18:33 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id u17sm31080380wrg.71.2019.03.12.13.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 13:18:32 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 0A3E4114655E; Tue, 12 Mar 2019 21:18:31 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/64s: Include <asm/nmi.h> header file to fix a warning
Date:   Tue, 12 Mar 2019 21:18:23 +0100
Message-Id: <20190312201823.29371-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to include <asm/nmi.h> to provide the following prototype:
hv_nmi_check_nonrecoverable.

Remove the following warning treated as error (W=1):

  arch/powerpc/kernel/traps.c:393:6: error: no previous prototype for 'hv_nmi_check_nonrecoverable' [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a21200c6aaea..1fd45a8650e1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -71,6 +71,7 @@
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
 #include <asm/stacktrace.h>
+#include <asm/nmi.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
-- 
2.20.1

