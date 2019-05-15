Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52028C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A8F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918789;
	bh=6zO7tVXG4/5IUdBroFzjK/pJRlz3x3muihcqwl8q3JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1uZIzmKfdXb73FBZnkSjtJp7n/6srfwJEvr/VBHN17czcaZ1K1klZW1KkVwRbVaO0
	 +Svf6pp3ozk32aICg9wgBCqO8yfJMEP6wpOWUnJvHo3zE5WxLU4rTLHutjKFaGWn9E
	 Nogyi1xsj30g52Uode9vXnJaztAE9bQnsFPKi3P4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfEOLNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbfEOLNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:13:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4320220862;
        Wed, 15 May 2019 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918785;
        bh=6zO7tVXG4/5IUdBroFzjK/pJRlz3x3muihcqwl8q3JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuLyQmyEZ5yZiR+H8sSdPnFnYAzvk53sLtdR01RXUqwYSfNt5FlfuYr1YtLm5e7J4
         2sU0PFynZgUWmBYBAoHarfKU2phtb0S0fEZMfxVarJB2+ceC2p2Nu2kJX93ck5X9C0
         ZTvjv+/e2VnDzSen4vw8XwL3hJlNpmb0temkfSic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 266/266] powerpc/booke64: set RI in default MSR
Date:   Wed, 15 May 2019 12:56:13 +0200
Message-Id: <20190515090732.014514824@linuxfoundation.org>
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

commit 5266e58d6cd90ac85c187d673093ad9cb649e16d upstream.

Set RI in the default kernel's MSR so that the architected way of
detecting unrecoverable machine check interrupts has a chance to work.
This is inline with the MSR setup of the rest of booke powerpc
architectures configured here.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/reg_booke.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -41,7 +41,7 @@
 #if defined(CONFIG_PPC_BOOK3E_64)
 #define MSR_64BIT	MSR_CM
 
-#define MSR_		(MSR_ME | MSR_CE)
+#define MSR_		(MSR_ME | MSR_RI | MSR_CE)
 #define MSR_KERNEL	(MSR_ | MSR_64BIT)
 #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
 #define MSR_USER64	(MSR_USER32 | MSR_64BIT)


