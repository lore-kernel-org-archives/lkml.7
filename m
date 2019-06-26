Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F919C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE415204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tUt4+K4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFZI5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:57:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53394 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZI5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:57:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8rcil116343;
        Wed, 26 Jun 2019 08:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YaPgtF90EswJlH1fU2fyf0Fw+Nizkl5Lc5ZtnhAjuMo=;
 b=tUt4+K4OZiE1xDn+pzxpnbMMxlWPd0j/vqTiql26fy29EPe8ATgpA6ym01r3a5DhOb9r
 SdOvCqRM9JmpLvDo1w+uLC0CoUk9VR37S/FBNpejn3haiwftEDXi5o9p5A+QqnP5tmBN
 JzWWFG70odwuvcMIhvKEFQRVmMqw5F5ZFTOqFzEYoYDJb30//yWHyJoPjIgP2TWhLJv5
 wKFDfFa9cG3FBAo/SRDrRPGLOd+Azlgc5d7cVDHPZRgx1xwfFMB+9tWXb3aP4is1s9wy
 WSjxe4DAFO4uZQqTDogHQpjPp6t7N41yd8vK1FlxK+PRZm53AEbSNKc6YcJP0bMtTcZF +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9ps0wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 08:56:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8tVIC005650;
        Wed, 26 Jun 2019 08:56:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acck9x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 08:56:59 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q8upCn025439;
        Wed, 26 Jun 2019 08:56:51 GMT
Received: from [10.191.16.53] (/10.191.16.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:56:51 -0700
Subject: Re: [PATCH v2 5/7] x86/xen: nopv parameter support for HVM guest
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        peterz@infradead.org, srinivas.eeda@oracle.com,
        Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561377779-28036-6-git-send-email-zhenzhong.duan@oracle.com>
 <99a28880-c2bf-e328-ee52-afc782af3b74@suse.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <f5478215-0e1a-8a2a-19ec-378ac5849936@oracle.com>
Date:   Wed, 26 Jun 2019 16:56:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <99a28880-c2bf-e328-ee52-afc782af3b74@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/6/25 20:31, Juergen Gross wrote:
> On 24.06.19 14:02, Zhenzhong Duan wrote:
>> PVH guest needs PV extentions to work, so nopv parameter is ignored
>> for PVH but not for HVM guest.
>>
>> In order for nopv parameter to take effect for HVM guest, we need to
>> distinguish between PVH and HVM guest early in hypervisor detection
>> code. By moving the detection of PVH in xen_platform_hvm(),
>> xen_pvh_domain() could be used for that purpose.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: xen-devel@lists.xenproject.org
>> ---
>>   arch/x86/xen/enlighten_hvm.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
>> index 7fcb4ea..26939e7 100644
>> --- a/arch/x86/xen/enlighten_hvm.c
>> +++ b/arch/x86/xen/enlighten_hvm.c
>> @@ -25,6 +25,7 @@
>>   #include "mmu.h"
>>   #include "smp.h"
>>   +extern bool nopv;
>>   static unsigned long shared_info_pfn;
>>     void xen_hvm_init_shared_info(void)
>> @@ -226,20 +227,24 @@ static uint32_t __init xen_platform_hvm(void)
>>       if (xen_pv_domain())
>>           return 0;
>>   +#ifdef CONFIG_XEN_PVH
>> +    /* Test for PVH domain (PVH boot path taken overrides ACPI 
>> flags). */
>> +    if (!x86_platform.legacy.rtc && x86_platform.legacy.no_vga)
>> +        xen_pvh = true;
>
> Sorry, this won't work, as ACPI tables are scanned only some time later.
Hmm, right. Thanks for point out.
>
> You can test for xen_pvh being true here (for the case where the guest
> has been booted via the Xen-PVH boot entry) and handle that case, but
> the case of a PVH guest started via the normal boot entry (like via
> grub2) and nopv specified is difficult. The only idea I have right now
> would be to use another struct hypervisor_x86 for that case which will
> only be used for Xen HVM/PVH _and_ nopv specified. It should be a copy
> of the bare metal variant, but a special guest_late_init member issuing
> a big fat warning in case PVH is being detected.

After that warning, I guess PVH will run into hang finally? If it's 
true, BUG() is better?

Adding another hypervisor_x86 is a bit redundant, I think of below change.

I'll test it tomorrow. But appreciate your suggestion whether it's 
feasible. Thanks

--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -25,6 +25,7 @@
  #include "mmu.h"
  #include "smp.h"

+extern bool nopv;
  static unsigned long shared_info_pfn;

  void xen_hvm_init_shared_info(void)
@@ -221,11 +222,37 @@ bool __init xen_hvm_need_lapic(void)
         return true;
  }

+static __init void xen_hvm_nopv_guest_late_init(void)
+{
+#ifdef CONFIG_XEN_PVH
+       if (x86_platform.legacy.rtc || !x86_platform.legacy.no_vga)
+               return;
+
+       /* PVH detected. */
+       xen_pvh = true;
+
+       printk(KERN_CRIT "nopv parameter isn't supported in PVH guest\n");
+       BUG();
+#endif
+}
+
+
  static uint32_t __init xen_platform_hvm(void)
  {
         if (xen_pv_domain())
                 return 0;

+       if (xen_pvh_domain() && nopv)
+       {
+       /* guest booting via the Xen-PVH boot entry goes here */
+               printk(KERN_INFO "nopv parameter is ignored in PVH 
guest\n");
+       }
+       else if (nopv)
+       {
+       /* guest booting via normal boot entry (like via grub2) goes here */
+               x86_init.hyper.guest_late_init = 
xen_hvm_nopv_guest_late_init;
+               return 0;
+       }
         return xen_cpuid_base();
  }

@@ -258,4 +285,5 @@ static __init void xen_hvm_guest_late_init(void)
         .init.init_mem_mapping  = xen_hvm_init_mem_mapping,
         .init.guest_late_init   = xen_hvm_guest_late_init,
         .runtime.pin_vcpu       = xen_pin_vcpu,
+       .ignore_nopv            = true,
  };

