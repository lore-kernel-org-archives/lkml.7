Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07787C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B0E2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hzt+iDud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfGJCoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:44:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42749 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGJCoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:44:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so396269plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=6+LJGvw+qjKoO8SZDZ3CnbeCqyYBeV92bc9prl1ddmQ=;
        b=Hzt+iDudzrsOkLAbFzQPF4ucXk+e+dS1MtkefrhpjARbtkPySZkO4PjJ7X3K7n/IER
         34d0otLaIpDweuSre9qtRGsTKofIMhe7/neLDAE+Uas0A5V6pbK3jXaPX4K2Pjo67Uj4
         wU1NifVOAgDX3xJYBlCIE9psPsRdF7IFzc4+COT5iDph1XtFkFhNvPKOUoPI+IK19q0E
         ivRkw7BrYOe/uUCpgWKtHcVzZFbAUl/wlErOctpAreBNdXzAyVcMFcEPmr1SuWteS2kQ
         NkPvfb3d2WUcxttWq6JQzdUc+jJQLMMMVhI58SZaOk1h8x5JyDnPuidFd2KGjKLdNnve
         4N5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=6+LJGvw+qjKoO8SZDZ3CnbeCqyYBeV92bc9prl1ddmQ=;
        b=dmzYB8TL2Mw4NkTJfXvJCV3fJ77izNH/o9PZu1jP8o+mbQGKSc6e2pc63SeX27PoOg
         WxYgne6VLKoHA/Tj1i8D/P8DsxJIpvUDtv6F+75+/314zE5R3QNJDvU4aGAprSSVmTZc
         sBUBnFivta7qviksdoxto/UPWYEEl+EAkDkcatFhQUKYiU0jPAlP/q5gZwPPXuGGP4AK
         5CaOTtw3HC79u3MdpWx7pB8/6UQf0FhlJ9HAIftYim/msC0pb8CN1ew7wlL6Qi7Z5VkP
         5R1O1Yi9F92K2InLAiqaXdsx+7kolzQ62Y6dgwRbu8x9DKGrKujeibmHmxWfFG6TNIJG
         Za1A==
X-Gm-Message-State: APjAAAVdGMSd98Gj4UzX8B1U/MqSWLQvK5iSpoxqkEOBh6Fd+LhV1zpp
        REzyW8kumjNCnDichIeHPuw5Zw==
X-Google-Smtp-Source: APXvYqzOg8rEPuco6fwSJeluxLLtj6pJ6MbzfjL9lhXvq8fqmKHjrof5XeFuQ1s1JzW87T/TC1BWBw==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr33894730plb.299.1562726644795;
        Tue, 09 Jul 2019 19:44:04 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id o2sm349868pgp.74.2019.07.09.19.44.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 19:44:04 -0700 (PDT)
Date:   Tue, 9 Jul 2019 19:44:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [patch] x86/boot: Fix memory leak in default_get_smp_config()
Message-ID: <alpine.DEB.2.21.1907091942570.28240@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When default_get_smp_config() is called with early == 1 and mpf->feature1
is non-zero, mpf is leaked because the return path does not do
early_memunmap().

Fix this and share a common exit routine.

Fixes: 5997efb96756 ("x86/boot: Use memremap() to map the MPF and MPC
data")
Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/kernel/mpparse.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index f1c5eb99d445..7a7055056b0d 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -547,17 +547,15 @@ void __init default_get_smp_config(unsigned int early)
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
 
@@ -566,7 +564,7 @@ void __init default_get_smp_config(unsigned int early)
 	/*
 	 * Only use the first configuration found.
 	 */
-
+out:
 	early_memunmap(mpf, sizeof(*mpf));
 }
 
