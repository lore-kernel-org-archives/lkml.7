Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF2FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D2120674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfKHUfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:35:42 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKHUfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:35:41 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MK3mS-1iDApS0zHy-00LVEV; Fri, 08 Nov 2019 21:35:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] powerpc: fix vdso32 for ppc64le
Date:   Fri,  8 Nov 2019 21:34:26 +0100
Message-Id: <20191108203435.112759-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108203435.112759-1-arnd@arndb.de>
References: <20191108203435.112759-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Dqnz/eT1SOuWZ6Nsk7jZrA5JIgvW92857XvPyhhu/MApAgKJOA1
 BSqzR9cR49iuc78Q1Wuwf0uc2LqdFCeF+GpSJDDSjMlUcug174u1+56gDh9aoAZMx1YjAwO
 T8m537fFb4GJkW3yVU2NiAIGc/zHBxrA4aQsCblV6As0b/E7RzWZwmp+Wb67zGD7CJn4a29
 jQARD8KRNeNNsdWXsPuDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z9DAEWseD6Q=:XDnU256Cf828kWUYInolSf
 bjsDcH8IUWm6SRtKEzuDz1LNDsxNapd9Js8NqFeXQKodJibBTVt1CWq3I+eWNf5bEWjqg6Bmo
 GMRgQQ5xAisfdxwtgul9EA23xU+fhq5Xi5w9dj+iS1+k8UVSpB3aGo7foX+IPnXesLPuIsaVS
 Tbkhx7lFVDphXU3OjDCsgfpLKWJ3FZejSwj0JU02BnVeDUFVBGgt7OKzDZILi+NMzFLP4WKiB
 /n9rYAobaDLX01SFxoDZL6gZVkj3ukciNAr/Ctm3TPX9ZBkUK2OyqDEar647XxbJUKLTFu1Hb
 dO+rUeLw1GvDTkjCMJqWKCGY69Tun2ST/EpCSR4ZhHiyb3oFeYH2w4C6G4arYssqHhT/OB2kh
 P0J3cFD5fIwNZ4iqcXrcEI0ytM5HXkkzzrSI+/uzTVmBXuvetwPDzPXUWQ3BhgwYiFavMfkuT
 z+b46AtrRDtvbj0RDFRlkc3DFuutWONgCFmzxY9K5YJenzjYZ0u7LTxWE/xre4O6OLdkEaFFi
 laUvtad1/MwgCwkwsPih8PEvQMcfW3kZw3hISsye7koVjIxZ1wVKPJyaES1yt+yntwlE3qEJ6
 r7AhhCO4cz4rDSDMnjefhHmeFJ9pU0Pb3l4VCVqRtBuUY4PbDibshG30vvhugGw3etkVvG3jI
 OovmDiBnYdLO9/0oE6Y3LFJGHdURs9hFRqdmaDbGDd/FqRCqY9CsuzUpoZpnb8lJEsSk2l3FU
 kDlE+IIQ1Y+GcegVCucCsFjPbmwGw7QN7AxkUc3csQoJue134oShcFM9CUmeUVJeQYKxm9Xcs
 UazpL9KIPfxjFxgJiJFG737jeYRHzVkMr+auvjQQ9FGwwPU0njhI40fbbvHhXLsryweDTofgV
 T+mGT+LC/mQ5+VZnB5kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On little-endian 32-bit application running on 64-bit kernels,
the current vdso would read the wrong half of the xtime seconds
field. Change it to return the lower half like it does on
big-endian.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index becd9f8767ed..4327665ad86f 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -13,7 +13,7 @@
 #include <asm/unistd.h>
 
 /* Offset for the low 32-bit part of a field of long type */
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && defined(CONFIG_CPU_BIG_ENDIAN)
 #define LOPART	4
 #define TSPEC_TV_SEC	TSPC64_TV_SEC+LOPART
 #else
-- 
2.20.0

