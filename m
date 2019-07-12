Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E2C742BE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EFF206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RdENEnth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGLNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:30:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:30:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CDTN2F065928;
        Fri, 12 Jul 2019 13:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=a6v2i4o0/d3/tu6OS7p26YjmZ0yJxxNnTxrAorw0AkI=;
 b=RdENEnth5r3rN+092WaWZ4wWZg8o34OFZgo7KFaTbIeiEZAHMAI9DGKMrN36TJx/tqpc
 m9E78XSEKKH3ubCl+hYeOA08aUKmzyJmSM6KQDGLrZZRGFy9ShKjzFbHu3fGY5ad9bLo
 xlv6f322+q0ZnGsy3yzaGJnVk607GKFywlFIIvabc1DnJqJ1f7HLaFMs8+MWeenO9n2V
 oK4bsLFvS3rVg7/zuTbtqr/kllXdtXoWzAYhvdyDX7OSRm8RUAS+2REtFZLSO7NsU9vZ
 5uVzWh3rHlyyjQgmEDoSyZo7HbuTSwhu1sz2zuGqyFbH/8CF4g2QBSy+SoJJQfmAkv1Y Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tjk2u5pxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 13:29:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CDS7Gv038338;
        Fri, 12 Jul 2019 13:29:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tn1j255db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 13:29:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6CDTohJ025527;
        Fri, 12 Jul 2019 13:29:50 GMT
Received: from [10.191.19.109] (/10.191.19.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 06:27:55 -0700
Subject: Re: [PATCH v2] xen/pv: Fix a boot up hang revealed by int3 self test
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, srinivas.eeda@oracle.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <1562832921-20831-1-git-send-email-zhenzhong.duan@oracle.com>
 <20190712120626.GW3402@hirez.programming.kicks-ass.net>
 <a5f5ea4c-f30d-122e-0161-be7b1cb4877c@oracle.com>
 <20190712130916.GR3419@hirez.programming.kicks-ass.net>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <6b47b7d1-b85f-e757-50dd-1e97157fd44d@oracle.com>
Date:   Fri, 12 Jul 2019 21:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190712130916.GR3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/12 21:09, Peter Zijlstra wrote:
> On Fri, Jul 12, 2019 at 09:04:22PM +0800, Zhenzhong Duan wrote:
>> On 2019/7/12 20:06, Peter Zijlstra wrote:
>>> On Thu, Jul 11, 2019 at 04:15:21PM +0800, Zhenzhong Duan wrote:
>>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>>>> index 4722ba2..2138d69 100644
>>>> --- a/arch/x86/xen/enlighten_pv.c
>>>> +++ b/arch/x86/xen/enlighten_pv.c
>>>> @@ -596,7 +596,7 @@ struct trap_array_entry {
>>>>    static struct trap_array_entry trap_array[] = {
>>>>    	{ debug,                       xen_xendebug,                    true },
>>>> -	{ int3,                        xen_xenint3,                     true },
>>>> +	{ int3,                        xen_int3,                        true },
>>>>    	{ double_fault,                xen_double_fault,                true },
>>>>    #ifdef CONFIG_X86_MCE
>>>>    	{ machine_check,               xen_machine_check,               true },
>>> I'm confused on the purpose of trap_array[], could you elucidate me?
>> Used to replace trap handler addresses by Xen specific ones and sanity check
>>
>> if there's an unexpected IST-using fault handler.
> git grep xen_int3, failed me. Where does that symbol come from?

Generated by "xen_pv_trap int3" in arch/x86/xen/xen-asm_64.S

Zhenzhong

