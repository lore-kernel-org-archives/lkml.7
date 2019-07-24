Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C794C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EBD22ADC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998319;
	bh=umCl6dFR14+uVHcFjKurp7A+kE3J7+NoohuECceKeLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ciMQOpWj0R3juULb7IoOqfErgR+zs0Ft0w5I7zf9J0t65TqqhDqwveSiz2LXRBC8y
	 y/sWqSIKKYbcL8uJcmnVXoby3I1BryCBwF75Ep8vVRqVH+AVo60A5/V5A1JSk/8yeL
	 tt3os6uHabgEYukEMaJxUNLj90J2wT7cbXUrWb6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405101AbfGXT6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405088AbfGXT6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:58:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B49D206BA;
        Wed, 24 Jul 2019 19:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998312;
        bh=umCl6dFR14+uVHcFjKurp7A+kE3J7+NoohuECceKeLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr3kAImsnppfwqfLAbLS6ZT+kQc1vHvq02/l7g1lrwHadbmKlXVtpcJ9MG0gdaLg3
         Gujvftm1f7Iw4WazJv+A0LjSOUv6NdvSXwjaGygMRV7+z75HzqTBhI58eQb8331T8J
         toOhD218u2Bsgwb1wIAGLI33WkYVVm4hnNH0qzKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.1 321/371] x86/boot: Fix memory leak in default_get_smp_config()
Date:   Wed, 24 Jul 2019 21:21:13 +0200
Message-Id: <20190724191748.088772676@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>

commit e74bd96989dd42a51a73eddb4a5510a6f5e42ac3 upstream.

When default_get_smp_config() is called with early == 1 and mpf->feature1
is non-zero, mpf is leaked because the return path does not do
early_memunmap().

Fix this and share a common exit routine.

Fixes: 5997efb96756 ("x86/boot: Use memremap() to map the MPF and MPC data")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907091942570.28240@chino.kir.corp.google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/mpparse.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -546,17 +546,15 @@ void __init default_get_smp_config(unsig
 			 * local APIC has default address
 			 */
 			mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-			return;
+			goto out;
 		}
 
 		pr_info("Default MP configuration #%d\n", mpf->feature1);
 		construct_default_ISA_mptable(mpf->feature1);
 
 	} else if (mpf->physptr) {
-		if (check_physptr(mpf, early)) {
-			early_memunmap(mpf, sizeof(*mpf));
-			return;
-		}
+		if (check_physptr(mpf, early))
+			goto out;
 	} else
 		BUG();
 
@@ -565,7 +563,7 @@ void __init default_get_smp_config(unsig
 	/*
 	 * Only use the first configuration found.
 	 */
-
+out:
 	early_memunmap(mpf, sizeof(*mpf));
 }
 


