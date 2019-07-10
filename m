Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95473C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D22320693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TeV/n1nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGJCIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:08:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56608 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:08:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6A23nCD077973;
        Wed, 10 Jul 2019 02:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=QZA2CjZZ9LVdMkh8ePwHvOa51+zr25uBOZG1ruA7UzM=;
 b=TeV/n1nkz1ihzRJYIyUqMF2/o6WIoFfhDLIk+oW1cokz1Sp6RJ7B0lP201Sxk48DUhtT
 dXYE1Irsg9HFvPT7wmzcH5weWjYlKZanBCtKyttDm42XX9m+YdKy++qEca0asM7br+hW
 BdAR1v3mFhpiRyHeOczO6jccmqew3VDcCL8MvSMOYD2nwf0yS90S81Y4i96hFNJtf0pS
 SnxZNtZGpM3G1uRA0RHWsKa8GZV97FbVcNmUzlrY+zYL82WJeMVT/lwelyqeyK05avEL
 39J1gPFu4W8VyqoN/jE+V0WAU9CPsAiXzQ4D030pfsZWq4K7X+FNno7fKTNULpivAfXr nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tjk2tqdt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 02:08:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6A27S8P104401;
        Wed, 10 Jul 2019 02:08:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tmwgx7sxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 02:08:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6A28035007870;
        Wed, 10 Jul 2019 02:08:00 GMT
Received: from [192.168.0.8] (/1.180.238.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jul 2019 19:07:59 -0700
Subject: Re: [PATCH v6 4/4] x86/xen: Add "nopv" support for HVM guest
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
References: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
 <1562490908-17882-5-git-send-email-zhenzhong.duan@oracle.com>
 <86b0dbb9-74a7-6883-e6d7-210bd35a6944@oracle.com>
 <6cbd7b78-3d8d-64ae-fd2e-82244dbe6a1e@oracle.com>
 <3d7db7c6-cea3-9dce-0519-a1c600b33273@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <33876a98-9b6b-a1b9-e72f-352c3f95db89@oracle.com>
Date:   Wed, 10 Jul 2019 10:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3d7db7c6-cea3-9dce-0519-a1c600b33273@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907100024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907100024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/9 22:54, Boris Ostrovsky wrote:
> On 7/9/19 12:20 AM, Zhenzhong Duan wrote:
>> -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
>> +static uint32_t __init xen_platform_hvm(void)
>> +{
>> +       uint32_t xen_domain = xen_cpuid_base();
>> +       struct x86_hyper_init *h = &x86_hyper_xen_hvm.init;
>> +
>> +       if (xen_pv_domain())
>> +               return 0;
>> +
>> +       if (xen_pvh_domain() && nopv) {
>> +               /* Guest booting via the Xen-PVH boot entry goes here */
>> +               pr_info("\"nopv\" parameter is ignored in PVH guest\n");
>> +               nopv = false;
>> +       } else if (nopv && xen_domain) {
>> +               /*
>> +                * Guest booting via normal boot entry (like via
>> grub2) goes
>> +                * here.
>> +                *
>> +                * Use interface functions for bare hardware if nopv,
>> +                * xen_hvm_guest_late_init is an exception as we need to
>> +                * detect PVH and panic there.
>> +                */
>> +               memcpy(h, (void *)&x86_init.hyper,
>> sizeof(x86_init.hyper));
>
> And this worked? I'd think it would fail since h points to RO section.
Yes, I have below changes in the patch.

-const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
+struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {

>
>
>> +               memcpy(&x86_hyper_xen_hvm.runtime, (void
>> *)&x86_platform.hyper,
>> +                      sizeof(x86_platform.hyper));
>> +               h->guest_late_init = xen_hvm_guest_late_init;
>
> To me this still doesn't look right --- you are making assumptions about
> x86_platform/x86_init.hyper and I don't think you can assume they have
> not been set to point to another hypervisor, for example.

You mean copy_array() calls in init_hypervisor_platform()? But that 
happens after

detect_hypervisor_vendor() shoose out the prefered hypervisor. In detect 
stage,

x86_platform/x86_init.hyper has default value for bare hardware, or I 
missed something?

Just realized I can use memset to zero instead of memcpy which looks 
more rational.

>
> Would modifying all x86_hyper_xen_hvm's ops (except, I guess,
> xen_hvm_guest_late_init()) to immediately return if nopv is set work?

I think so,  Let me try it.

Zhenzhong

