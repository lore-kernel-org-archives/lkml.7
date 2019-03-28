Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481A92184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nmiT2oT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfC1QuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:50:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49838 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1QuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:50:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SGmUR0190923;
        Thu, 28 Mar 2019 16:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kc79iglCMfenIsPbDHIN6Af3rYkryYC7I/VQ6MfBpQo=;
 b=nmiT2oT8Kq59o3kvt68aLkiZMVOk0nbJBA5VSu1ebD5bRSlPpxAQ7WsP7+55W1+alznx
 nrl4Eex3Zh+2RiZTX4MwexMv7wSIfr/r2AJ7srrPFpoPKb4tec0qzVzKhhYsXaJPvkFR
 rpK6WtwaDw7Nya3x4375J/DRjApd4hhVzWhfQxwo3K/22BNL8Dw1MrfCgGQmooZ2Gd+s
 4amE9huANTv/aFPx5q5FM+N0tISZwIwKjvK3Ahs/Nmu+sVERp99OyDQ5IKg5yO6ATqh+
 H683uI9tGowotqVtYJYZhzHi+9BhJhhrciMINcL9lF8hrAyILpDvj1gsfWTrwH/aDGKW Vw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2re6g17w1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 16:50:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2SGo9FE013350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 16:50:10 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2SGo7TG015478;
        Thu, 28 Mar 2019 16:50:07 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 09:50:07 -0700
Subject: Re: [PATCH] x86/Xen: streamline (and fix) PV CPU enumeration
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <5C9B92EA020000780022227B@prv1-mh.provo.novell.com>
 <2f027b4b-dce2-3e90-dc1b-c824bc8eb355@oracle.com>
 <5C9C8DDC0200007800222606@prv1-mh.provo.novell.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <eda3938f-02a5-e5a2-4718-d75bc488f296@oracle.com>
Date:   Thu, 28 Mar 2019 12:50:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5C9C8DDC0200007800222606@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9209 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 5:03 AM, Jan Beulich wrote:
>>>> On 27.03.19 at 18:07, <boris.ostrovsky@oracle.com> wrote:
>> On 3/27/19 11:12 AM, Jan Beulich wrote:
>>> -
>>> -static void __init xen_filter_cpu_maps(void)
>>> +static void __init _get_smp_config(unsigned int early)
>>>  {
>>>  	int i, rc;
>>>  	unsigned int subtract = 0;
>>>  
>>> -	if (!xen_initial_domain())
>>> +	if (early)
>>>  		return;
>>>  
>>>  	num_processors = 0;
>>
>> Is there a reason to set_cpu_possible() here (not in the diff, but in
>> this routine)? This will be called from setup_arch() before
>> prefill_possible_map(), which will clear and then re-initialize
>> __cpu_possible_mask.
> I don't think it's needed before my change either, so I'd call
> removing this an orthogonal change. As said in the commit
> message, the goal was to leave this function alone as far as
> possible.
>
> Before my patch, xen_filter_cpu_maps() gets called long after
> prefill_possible_map(), and by the purpose of the latter function
> the possible map shouldn't be altered anymore once that has
> run. Adding bits to it is surely not going to have the intended
> effect (setup_per_cpu_areas() has already run), while removing
> bits may have some effect, but comes too late at least for
> setup_per_cpu_areas().

OK. Then it looks like even though your patch changes behavior slightly
(so technically I guess it's not purely a cleanup) this shouldn't makes
any difference at least as far as possible cpu mask is concerned: if we
don't have percpu areas set up we can't do much for that vcpu since it
seems to me xen_vcpu_setup(), for example, won't do well.


>
> And if we were to remove this, I think the CONFIG_HOTPLUG_CPU
> section should go away as well. After all prefill_possible_map()
> also sets nr_cpu_ids. To be honest, it was largely this code
> fragment which made me want not touch the function more than
> necessary: The comment there makes not clear to me at all why
> all of this needs to be in an #ifdef in the first place.

This was introduced by cf405ae612b0 ("xen/smp: Fix crash when booting
with ACPI hotplug CPUs.").

I am not sure this is still relevant. The ACPI hotplug code had changed,
not significantly but sufficiently enough to alter behavior.
acpi_processor_hotadd_init() now fails before it gets a chance to call
arch_register_cpu() for vcpu>dom0_max_vcpus.


>
> Let me know whether you really want me to fold this extra
> cleanup into this patch. If so, I'd then wonder whether the
> set_cpu_present() from xen_pv_smp_prepare_cpus() shouldn't
> be moved here, too. And the fiddling with the possible map
> there looks bogus as well: Bring-up of CPUs past the command
> line option should be avoided at boot time, but they shouldn't
> be excluded from getting brought up later on. Note how
> native_smp_prepare_cpus() ignores its parameter altogether.

Yes, that does look strange.

Given especially xen_pv_smp_prepare_cpus(), I think re-working proper
setting of present/possible masks is well beyond the scope of your
original patch.

-boris
