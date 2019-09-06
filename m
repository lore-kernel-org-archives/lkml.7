Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B20C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EDA214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405809AbfIFPkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:40:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404493AbfIFPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:40:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N49xZ-1iFMyW1Wgz-0103jZ; Fri, 06 Sep 2019 17:39:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: xen: unexport HYPERVISOR_platform_op function
Date:   Fri,  6 Sep 2019 17:39:38 +0200
Message-Id: <20190906153948.2160342-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zYODqMtzhmasPBLMaQkekqWiOvuaPVy3IwkWaKwHTMENneYYT8+
 N9fyWbckJqYWTjYWdmrm2DvtCp7XQn992baONZAioN40gMFhsqvd2U1uMxtDsTxl02EEgMD
 eI5U3yqi2uT9wI5P/PNjLDsH5KfiyfEyZ9ARZbjNSFbQWMW/PWzRcDJcdeASforR6P2aJOa
 oSAzLbOAoDT2OMDOiRvsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hl3snfylLyw=:F4PGuLMuAxxV6jSAERX2I7
 YLHkkVVGb5vPqpurr8Bbn+hyuwWdkNKkzFAUJBpSy+D7WHk7gVxbv9HpCnGGfm6NgtD1zTgjs
 WqyLndj1Q1NoIHOq97vFJK1E5NfCvEK9k2CLN88jTZugyWhrSRmIMpJlo9gYL5VzkBoM13xbe
 L97IBBuATNa8AplaIqCWcHo/WKK4s6PfwNn1IoigBfpbvRJ/4p4vKT4Ps4c9KEMraRxou/4YO
 HQpBTXRVmqZ5/Fu1ubNF1z7SS6+MsybqbmmBf4arM//R+Re4Of7p/AIGwGVb5eNPJfPLMov7o
 eD69Z7Ak+0C5ah/e9vI+a6EOEUGTFWqVmQtCLXjg4CJFXYDrncVnhngBn9tH54hvR3v9cznBt
 XaCRWMr+Wk1XfBylaOur9Ac/fM1lU/GLDeae1pxYrIt/e/YzUGrs6pBa01J2TFxiAfTs7ffR7
 d7k+afrQlghEUPhvATCoVBg0NVG4t25SciaXGLKavc4MvEqWswSslxWMcLPAd+fjqthc+Ujkd
 FpMV7SrwOZ1lhA8UHG+1o8WhALPIVVuIrtZIfRZJty6t9HVahWXkOORwCmjgbZwXrNUuQtjlm
 Z036DeAY4zkrSUKOAdBKSKDJN/Ehwo7WbC6Wzp2cwqUfwFmUF2Mwh+61GjOanrNAM8cOmXUl6
 nTMw3EB8A4ev83/WvVY1UVl6nLC4NaVPP1QI9W5cn3+lUEPOdH5r75jP32GLF7CO36I28uRJX
 j/fBOhn1RJrPYCDLykucNyQcukb/dW7s7RTPh9iJfiYj06Dh2j+AyDwJtTKyqFfirfzZpk8f+
 HvVavFxfxTs0ElAnhWxOzZFZi9GFQsIQ4oeH6iHEPsqKo7oTqE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HYPERVISOR_platform_op() is an inline function and should not
be exported. Since commit 15bfc2348d54 ("modpost: check for
static EXPORT_SYMBOL* functions"), this causes a warning:

WARNING: "HYPERVISOR_platform_op" [vmlinux] is a static EXPORT_SYMBOL_GPL

Remove the extraneous export.

Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/xen/enlighten.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 1e57692552d9..845c528acf24 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -437,7 +437,6 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
-EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vm_assist);
 EXPORT_SYMBOL_GPL(HYPERVISOR_dm_op);
-- 
2.20.0

