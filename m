Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F47C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B8320692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emypeople.us header.i=@emypeople.us header.b="Q/E89Q0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAHAuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:50:54 -0500
Received: from mail.emypeople.net ([216.220.167.73]:32829 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHAuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:50:54 -0500
X-Greylist: delayed 740 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 19:50:53 EST
DKIM-Signature: a=rsa-sha256; t=1578443912; x=1579048712; s=mail; d=emypeople.us; c=relaxed/relaxed; v=1; bh=CvMeBons7S28jmhBTmYc6WWNwdjk4SyzYKXXN9B3/vs=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
   b=Q/E89Q0cycQthkFA97Vx4bbEU/Gzi5/+gb4Y5Jnstad5/8Y5MU4QuUWp+XPS6KzyTsvN+H/5AdAgZXq6bh6dH8zQ3juzXt4dC5aTb9W89mzRJMldHXFVF1iTHQ5RUAVwyqN1g7E0wPtwrYTlhQ0B2l8kgNGuRgp1LQuClv+9gNo=
Received: from [192.168.1.2] ([10.12.2.17])
        by mail.emypeople.net (12.2.0 build 2 RHEL7 x64) with ASMTP id 202001071938317657;
        Tue, 07 Jan 2020 19:38:31 -0500
From:   Edwin Zimmerman <edwin@211mainstreet.net>
Subject: [PATCH] x86/boot: fix cast to pointer compiler warning
To:     x86@kernel.org, Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Edwin Zimmerman <edwin@211mainstreet.net>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Josh Boyer <jwboyer@redhat.com>
Message-ID: <8dd48f03-4d7c-25bb-2a2f-27461c0004ba@211mainstreet.net>
Date:   Wed, 8 Jan 2020 00:38:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cast-to-pointer compiler warning

arch/x86/boot/compressed/acpi.c: In function ‘get_acpi_srat_table’:
arch/x86/boot/compressed/acpi.c:316:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
        ^
Fixes: 41fa1ee9c6d6 ("acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down")
Signed-off-by: Edwin Zimmerman <edwin@211mainstreet.net>
---
arch/x86/boot/compressed/acpi.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 25019d42ae93..5d2568066d58 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -313,7 +313,7 @@ static unsigned long get_acpi_srat_table(void)
* stash this in boot params because the kernel itself may have
* different ideas about whether to trust a command-line parameter.
*/
- rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
+ rsdp = (struct acpi_table_rsdp *)(long)get_cmdline_acpi_rsdp();
if (!rsdp)
rsdp = (struct acpi_table_rsdp *)(long)

-- 
2.17.1

