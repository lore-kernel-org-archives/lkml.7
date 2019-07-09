Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BDC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D2A2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qcJzybHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfGIEWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:22:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43360 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIEWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:22:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x694JPS3045691;
        Tue, 9 Jul 2019 04:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mrs5k2SPEkQusZrksvY+z398D7oJTAyXewMSp4Vy1wY=;
 b=qcJzybHFs+0AttndQUiS9GvEgUjJc1DZdfaxD5IhGkC5LKRzmFbJuMkBNzvHbw0xA7cU
 HSHxlVrcIcr7wHU37xY5aFhVbmHNc765zXQS5fO3YATrhj+iFp+TUBnoDUqUyQzXyaU3
 iQnHpCnaTVCznc46ufOOJ525Lz9zTKncjjKZ+cS6ucU28Hz0E196LcI/Ut/pnImAVU1E
 pyinQ9xn/779RH56wQ8KKpegj38ATS/byb1M+J3/aNsrw+t9gVRRhStBRbcinbEals1W
 r/5G4nppFJglHEMXFjNYRJzXYFj+TTgw6lYSp/gqNkAG5KC8JivGeUXDuQzNPOFhX4jb FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tjm9qhrem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 04:20:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x694IKpD006799;
        Tue, 9 Jul 2019 04:20:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tjhpcuc6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 04:20:45 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x694KiPp008688;
        Tue, 9 Jul 2019 04:20:44 GMT
Received: from [10.191.31.108] (/10.191.31.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 21:20:43 -0700
Subject: Re: [PATCH v6 4/4] x86/xen: Add "nopv" support for HVM guest
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
References: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
 <1562490908-17882-5-git-send-email-zhenzhong.duan@oracle.com>
 <86b0dbb9-74a7-6883-e6d7-210bd35a6944@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <6cbd7b78-3d8d-64ae-fd2e-82244dbe6a1e@oracle.com>
Date:   Tue, 9 Jul 2019 12:20:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <86b0dbb9-74a7-6883-e6d7-210bd35a6944@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/8 21:46, Boris Ostrovsky wrote:
> On 7/7/19 5:15 AM, Zhenzhong Duan wrote:
>>   
>> +static uint32_t __init xen_platform_hvm(void)
>> +{
>> +	if (xen_pv_domain())
>> +		return 0;
>> +
>> +	if (xen_pvh_domain() && nopv) {
>> +		/* Guest booting via the Xen-PVH boot entry goes here */
>> +		pr_info("\"nopv\" parameter is ignored in PVH guest\n");
>> +		nopv = false;
>> +	} else if (nopv) {
>> +		/*
>> +		 * Guest booting via normal boot entry (like via grub2) goes
>> +		 * here.
>> +		 */
>> +		x86_init.hyper.guest_late_init = xen_hvm_guest_late_init;
>> +		return 0;
> After staring at this some more I don't think we can do this.
> Hypervisor-specific code should not muck with with x86_init.hyper, it's
> layering violation. That's what init_hypervisor_platform() is for.
Ok, I see.
>
> So we may have to create another hypervisor_x86 ops structure for Xen
> nopv (which I don't find very appealing TBH). Or update
> x86_hyper_xen_hvm and return xen_cpuid_base() instead of zero (but then
> you'd need to update all these structs from __initconst to _init or some
> such). Or something else.

I choose the second. I made below changes, not clear if it's also a 
layering violation

as use x86_init.hyper as source for memcpy. I choose memcpy instead of 
updating

functions pointers one-by-one because if x86_hyper_init interface 
functions extends

in the future we need no changes. Let me know if you prefer updating 
pointers directly.

This isn't a formal patch for review, just want to get answer of above 
question.

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c

index 1756cf7..8416640d 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -231,14 +231,6 @@ bool __init xen_hvm_need_lapic(void)
         return true;
  }

-static uint32_t __init xen_platform_hvm(void)
-{
-       if (xen_pv_domain())
-               return 0;
-
-       return xen_cpuid_base();
-}
-
  static __init void xen_hvm_guest_late_init(void)
  {
  #ifdef CONFIG_XEN_PVH
@@ -250,6 +242,9 @@ static __init void xen_hvm_guest_late_init(void)
         /* PVH detected. */
         xen_pvh = true;

+       if (nopv)
+               panic("\"nopv\" and \"xen_nopv\" parameters are 
unsupported in PVH guest.");
+
         /* Make sure we don't fall back to (default) ACPI_IRQ_MODEL_PIC. */
         if (!nr_ioapics && acpi_irq_model == ACPI_IRQ_MODEL_PIC)
                 acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
@@ -259,7 +254,36 @@ static __init void xen_hvm_guest_late_init(void)
  #endif
  }

-const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
+static uint32_t __init xen_platform_hvm(void)
+{
+       uint32_t xen_domain = xen_cpuid_base();
+       struct x86_hyper_init *h = &x86_hyper_xen_hvm.init;
+
+       if (xen_pv_domain())
+               return 0;
+
+       if (xen_pvh_domain() && nopv) {
+               /* Guest booting via the Xen-PVH boot entry goes here */
+               pr_info("\"nopv\" parameter is ignored in PVH guest\n");
+               nopv = false;
+       } else if (nopv && xen_domain) {
+               /*
+                * Guest booting via normal boot entry (like via grub2) goes
+                * here.
+                *
+                * Use interface functions for bare hardware if nopv,
+                * xen_hvm_guest_late_init is an exception as we need to
+                * detect PVH and panic there.
+                */
+               memcpy(h, (void *)&x86_init.hyper, sizeof(x86_init.hyper));
+               memcpy(&x86_hyper_xen_hvm.runtime, (void 
*)&x86_platform.hyper,
+                      sizeof(x86_platform.hyper));
+               h->guest_late_init = xen_hvm_guest_late_init;
+       }
+       return xen_domain;
+}
+
+struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
         .name                   = "Xen HVM",
         .detect                 = xen_platform_hvm,
         .type                   = X86_HYPER_XEN_HVM,
@@ -268,4 +292,5 @@ static __init void xen_hvm_guest_late_init(void)
         .init.init_mem_mapping  = xen_hvm_init_mem_mapping,
         .init.guest_late_init   = xen_hvm_guest_late_init,
         .runtime.pin_vcpu       = xen_pin_vcpu,
+       .ignore_nopv            = true,
  };


Thanks

Zhenzhong

