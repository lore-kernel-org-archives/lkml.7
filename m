Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A810220675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557922511;
	bh=nQD2RP6IQV12KN5CGMPv+6Od8vaWpd0IIdQBglLgkkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rCBYnSxgYY5YhhHVbyiP2oElL9aaBIzxN2GysnLWrC++87/OuG8FEZkfAr54PBkED
	 ajqu0hIsIi482s+InDUClpnFzLT68Opa2XfmdKHhUBwWL5fFD1s34YhQIW3OC58HMi
	 CReZsqDt0U8mCymCXcPCwM9Hu0p7FlpSkBUnM1PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfEOLDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfEOLDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:03:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E8F320881;
        Wed, 15 May 2019 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918224;
        bh=nQD2RP6IQV12KN5CGMPv+6Od8vaWpd0IIdQBglLgkkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvunsdOCOY5vxwzNzpg86ZmXYdZxnQb4dzI17aSiOO68t+/Ay+65mh4pVOdPBBJT9
         /gQgCaEwwryliT5b1BIt3+MDeEpLF1V/E+O+xqWbbYoPP5jK1HOvY4s41Yi4OHUNPY
         HjK47AK8nb+sGtNzzJazsblYdDrcBvrP7/pqek7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 052/266] powerpc/64s: Add new security feature flags for count cache flush
Date:   Wed, 15 May 2019 12:52:39 +0200
Message-Id: <20190515090724.207045865@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit dc8c6cce9a26a51fc19961accb978217a3ba8c75 upstream.

Add security feature flags to indicate the need for software to flush
the count cache on context switch, and for the presence of a hardware
assisted count cache flush.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/security_features.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -59,6 +59,9 @@ static inline bool security_ftr_enabled(
 // Indirect branch prediction cache disabled
 #define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
 
+// bcctr 2,0,0 triggers a hardware assisted count cache flush
+#define SEC_FTR_BCCTR_FLUSH_ASSIST	0x0000000000000800ull
+
 
 // Features indicating need for Spectre/Meltdown mitigations
 
@@ -74,6 +77,9 @@ static inline bool security_ftr_enabled(
 // Firmware configuration indicates user favours security over performance
 #define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
 
+// Software required to flush count cache on context switch
+#define SEC_FTR_FLUSH_COUNT_CACHE	0x0000000000000400ull
+
 
 // Features enabled by default
 #define SEC_FTR_DEFAULT \


