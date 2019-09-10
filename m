Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACBCC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95052089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kRDXONDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437191AbfIJRs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:48:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437134AbfIJRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:48:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8AHdYwX157279;
        Tue, 10 Sep 2019 17:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=cO4mIuv4/NshJ0bwX5tqD/8OFGeqAT1pBm22YBSrTQ4=;
 b=kRDXONDDGwjsho+0/0pFy6JC+Rw8nzdhZz9/wJLNFU187qBQR8GXQAZvDkHMQNpbXFng
 DqSyPUjaTzlzc9zbnyGGDBiB2vVF0pXG2Z57Fo9L5pPMnf/VKoQq1aQ4a3I5WuHWENpJ
 n0KymjWB39AV8URdQvn6wGHvL/83EOgJsmy5/B2V+osfXlM09bY7QnbrjUhqOKAOK3/X
 SMQatqZKa/LPZJG103xsDb0fuJ8gciRdpQnKt6XndYMENSOru7M2ZcYi37siqwoK1W+0
 gl6MNXxoD7eh6I5Crhyg3izZgiDP7RatkV8nqYDiioKTg26wNDczXFaXnxbGVovz/NUP hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uw1jkd36p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 17:48:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8AHheAV006059;
        Tue, 10 Sep 2019 17:48:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2uwpjw4g6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 17:48:20 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8AHmJ0k000816;
        Tue, 10 Sep 2019 17:48:19 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 10:48:19 -0700
Subject: Re: [Xen-devel] [PATCH] xen/pci: try to reserve MCFG areas earlier
To:     Igor Druzhinin <igor.druzhinin@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com
References: <1567556431-9809-1-git-send-email-igor.druzhinin@citrix.com>
 <5054ad91-5b87-652c-873a-b31758948bd7@oracle.com>
 <e3114d56-51cd-b973-1ada-f6a60a7e99cc@citrix.com>
 <43b7da04-5c42-80d8-898b-470ee1c91ed2@oracle.com>
 <adefac87-c2b3-b67f-fb4d-d763ce920bef@citrix.com>
 <1695c88d-e5ad-1854-cdef-3cd95c812574@oracle.com>
 <4d3bf854-51de-99e4-9a40-a64c581bdd10@citrix.com>
 <bc3da154-d451-02cf-6154-5e0dc721a6e6@oracle.com>
 <c45b8786-5735-a95d-bc40-61372c326037@citrix.com>
 <43e492ff-f967-7218-65c4-d16581fabea3@oracle.com>
 <416ff4b7-3186-f61a-75fa-bcfc968f8117@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <df64cd80-d92e-27ad-b1bc-e58184379e50@oracle.com>
Date:   Tue, 10 Sep 2019 13:48:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <416ff4b7-3186-f61a-75fa-bcfc968f8117@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 5:46 AM, Igor Druzhinin wrote:
> On 10/09/2019 02:47, Boris Ostrovsky wrote:
>> On 9/9/19 5:48 PM, Igor Druzhinin wrote:
>>> On 09/09/2019 20:19, Boris Ostrovsky wrote:
>>>> On 9/8/19 7:37 PM, Igor Druzhinin wrote:
>>>>> On 09/09/2019 00:30, Boris Ostrovsky wrote:
>>>>>> On 9/8/19 5:11 PM, Igor Druzhinin wrote:
>>>>>>> On 08/09/2019 19:28, Boris Ostrovsky wrote:
>>>>>>>> Would it be possible for us to parse MCFG ourselves in pci_xen_init()? I
>>>>>>>> realize that we'd be doing this twice (or maybe even three times since
>>>>>>>> apparently both pci_arch_init()  and acpi_ini() do it).
>>>>>>>>
>>>>>>> I don't thine it makes sense:
>>>>>>> a) it needs to be done after ACPI is initialized since we need to parse
>>>>>>> it to figure out the exact reserved region - that's why it's currently
>>>>>>> done in acpi_init() (see commit message for the reasons why)
>>>>>> Hmm... We should be able to parse ACPI tables by the time
>>>>>> pci_arch_init() is called. In fact, if you look at
>>>>>> pci_mmcfg_early_init() you will see that it does just that.
>>>>>>
>>>>> The point is not to parse MCFG after acpi_init but to parse DSDT for
>>>>> reserved resource which could be done only after ACPI initialization.
>>>> OK, I think I understand now what you are trying to do --- you are
>>>> essentially trying to account for the range inserted by
>>>> setup_mcfg_map(), right?
>>>>
>>> Actually, pci_mmcfg_late_init() that's called out of acpi_init() -
>>> that's where MCFG areas are properly sized. 
>> pci_mmcfg_late_init() reads the (static) MCFG, which doesn't need DSDT parsing, does it? setup_mcfg_map() OTOH does need it as it uses data from _CBA (or is it _CRS?), and I think that's why we can't parse MCFG prior to acpi_init(). So what I said above indeed won't work.
>>
> No, it uses is_acpi_reserved() (it's called indirectly so might be well
> hidden) to parse DSDT to find a reserved resource in it and size MCFG
> area accordingly. 


Right, I see it. Thanks for the explanation.


> setup_mcfg_map() is called for every root bus
> discovered and indeed tries to evaluate _CBA but at this point
> pci_mmcfg_late_init() has already finished MCFG registration for every
> cold-plugged bus (which information is described in MCFG table) so those
> calls are dummy.
>
>>> setup_mcfg_map() is mostly
>>> for bus hotplug where MCFG area is discovered by evaluating _CBA method;
>>> for cold-plugged buses it just confirms that MCFG area is already
>>> registered because it is mandated for them to be in MCFG table at boot time.
>>>
>>>> The other question I have is why you think it's worth keeping
>>>> xen_mcfg_late() as a late initcall. How could MCFG info be updated
>>>> between acpi_init() and late_initcalls being run? I'd think it can only
>>>> happen when a new device is hotplugged.
>>>>
>>> It was a precaution against setup_mcfg_map() calls that might add new
>>> areas that are not in MCFG table but for some reason have _CBA method.
>>> It's obviously a "firmware is broken" scenario so I don't have strong
>>> feelings to keep it here. Will prefer to remove in v2 if you want.
>> Isn't setup_mcfg_map() called before the first xen_add_device() which is where you are calling xen_mcfg_late()?
>>
> setup_mcfg_map() calls are done in order of root bus discovery which
> happens *after* the previous root bus has been enumerated. So the order
> is: call setup_mcfg_map() for root bus 0, find that
> pci_mmcfg_late_init() has finished MCFG area registration, perform PCI
> enumeration of bus 0, call xen_add_device() for every device there, call
> setup_mcfg_map() for root bus X, etc.

Ah, yes. Multiple busses.

If that's the case then why don't we need to call xen_mcfg_late() for
the first device on each bus?

-boris
