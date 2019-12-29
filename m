Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3341BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A5521744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642115;
	bh=aai5ilbyK01aPMcM1RzUPG+VItremKQRclN3Rtnusxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/v4NHrc+0WglvHWwY0DfNyypODR+yTCzF2m6eEx+tNV+tGu8ujjyB9xcA99W+6ir
	 smU+6EY8M2cjY9i4x9hVZG0ZoZUCVVZ/C6Q3rqfGs7PegN8iAq/ZJnq2lkfXhSjkNA
	 gI94t9vrWzgItfzmUQSmIDW5gBfX7NGghjj38e2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbfL2RzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:55:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732839AbfL2RzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:55:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC5F206A4;
        Sun, 29 Dec 2019 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642110;
        bh=aai5ilbyK01aPMcM1RzUPG+VItremKQRclN3Rtnusxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQ4rcf4JzcDqhgoi1RUIspYB4AJRD5TqD7fXbPZIR9ZEMtsfZ+yxyWp36MnJAFE4O
         VY/ItMT7xiNhxAKTdwmrH98of/oTi760CQmsPGwAUV6U9Nty5lVVr1Xp5qFEOIFYH5
         BXyz/4/s1hYC7gdLmQJXPY7V2jt7u/aQOM7oPuQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 346/434] crypto: vmx - Avoid weird build failures
Date:   Sun, 29 Dec 2019 18:26:39 +0100
Message-Id: <20191229172724.954896515@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 4ee812f6143d78d8ba1399671d78c8d78bf2817c ]

In the vmx crypto Makefile we assign to a variable called TARGET and
pass that to the aesp8-ppc.pl and ghashp8-ppc.pl scripts.

The variable is meant to describe what flavour of powerpc we're
building for, eg. either 32 or 64-bit, and big or little endian.

Unfortunately TARGET is a fairly common name for a make variable, and
if it happens that TARGET is specified as a command line parameter to
make, the value specified on the command line will override our value.

In particular this can happen if the kernel Makefile is driven by an
external Makefile that uses TARGET for something.

This leads to weird build failures, eg:
  nonsense  at /build/linux/drivers/crypto/vmx/ghashp8-ppc.pl line 45.
  /linux/drivers/crypto/vmx/Makefile:20: recipe for target 'drivers/crypto/vmx/ghashp8-ppc.S' failed

Which shows that we passed an empty value for $(TARGET) to the perl
script, confirmed with make V=1:

  perl /linux/drivers/crypto/vmx/ghashp8-ppc.pl  > drivers/crypto/vmx/ghashp8-ppc.S

We can avoid this confusion by using override, to tell make that we
don't want anything to override our variable, even a value specified
on the command line. We can also use a less common name, given the
script calls it "flavour", let's use that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/vmx/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/vmx/Makefile b/drivers/crypto/vmx/Makefile
index cab32cfec9c4..709670d2b553 100644
--- a/drivers/crypto/vmx/Makefile
+++ b/drivers/crypto/vmx/Makefile
@@ -3,13 +3,13 @@ obj-$(CONFIG_CRYPTO_DEV_VMX_ENCRYPT) += vmx-crypto.o
 vmx-crypto-objs := vmx.o aesp8-ppc.o ghashp8-ppc.o aes.o aes_cbc.o aes_ctr.o aes_xts.o ghash.o
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-TARGET := linux-ppc64le
+override flavour := linux-ppc64le
 else
-TARGET := linux-ppc64
+override flavour := linux-ppc64
 endif
 
 quiet_cmd_perl = PERL $@
-      cmd_perl = $(PERL) $(<) $(TARGET) > $(@)
+      cmd_perl = $(PERL) $(<) $(flavour) > $(@)
 
 targets += aesp8-ppc.S ghashp8-ppc.S
 
-- 
2.20.1



