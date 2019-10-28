Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C22BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1A320B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GIY6FWFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfJ1I6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:58:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38859 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbfJ1I6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:58:19 -0400
Received: from [IPv6:2601:646:8600:3281:9f1:c5fc:f434:6a14] ([IPv6:2601:646:8600:3281:9f1:c5fc:f434:6a14])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x9S8kpgE2149778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 28 Oct 2019 01:46:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x9S8kpgE2149778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1572252419;
        bh=Skodpi7nxzjzM78bU7LUUKImk5EIuBVZg2w//InSrlA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=GIY6FWFqmb/JHimgI8SsfdgfiZRpBb8TM+vQmDCQ0kUqXCIe4S/ENEhbqQVuGqto5
         gDJonHp5mnnv6Ju3KmVvKLu+QRoSef5OlryrIP5fvx3DFH+E431DcFy7AONIRcNvZv
         wuuFPG90IHiSRZTdUfVItRzn81mywuogRuHtFk2zf1cmwM9DLcKEzWfbI/IqkzhFiq
         VqhApkc+x4e7aBFZnq28V+oJE5hI4rt3Ooyne4Z2Y1h/TsIDelXli3wQJM1AtTQb0t
         M+xwLznPWjg0KdCruXHQQYKi6cVJajz7FcXAsVqgaj+bZuaxbHLlHlI4/WS/+WR03j
         R1rS8Fx+2oBqA==
Date:   Mon, 28 Oct 2019 01:46:43 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20191025073858.15081-1-jgross@suse.com>
References: <20191025073858.15081-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] xen: issue deprecation warning for 32-bit pv guest
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
From:   hpa@zytor.com
Message-ID: <088E9605-9FFA-42B7-BAB2-89D9DF0756BB@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 25, 2019 12:38:58 AM PDT, Juergen Gross <jgross@suse=2Ecom> wrot=
e:
>Support for the kernel as Xen 32-bit PV guest will soon be removed=2E
>Issue a warning when booted as such=2E
>
>Signed-off-by: Juergen Gross <jgross@suse=2Ecom>
>---
> arch/x86/xen/enlighten_pv=2Ec | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/arch/x86/xen/enlighten_pv=2Ec b/arch/x86/xen/enlighten_pv=2E=
c
>index 58f79ab32358=2E=2E5bfea374a160 100644
>--- a/arch/x86/xen/enlighten_pv=2Ec
>+++ b/arch/x86/xen/enlighten_pv=2Ec
>@@ -117,6 +117,14 @@ static void __init xen_banner(void)
> 	printk(KERN_INFO "Xen version: %d=2E%d%s%s\n",
> 	       version >> 16, version & 0xffff, extra=2Eextraversion,
>	       xen_feature(XENFEAT_mmu_pt_update_preserve_ad) ? "
>(preserve-AD)" : "");
>+
>+#ifdef CONFIG_X86_32
>+	pr_warn("WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
>WARNING!\n"
>+		"Support for running as 32-bit PV-guest under Xen will soon be
>removed\n"
>+		"from the Linux kernel!\n"
>+		"Please use either a 64-bit kernel or switch to HVM or PVH mode!\n"
>+		"WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!\n");
>+#endif
> }
>=20
> static void __init xen_pv_init_platform(void)

And there was much rejoicing=2E

Yaay=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
