Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76FCC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879E020717
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p5gaDl7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfEYAAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:00:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfEYAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:00:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ONx1TC017589;
        Fri, 24 May 2019 23:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mYxaTaB4BfCfxzRuaJ3NuA5Kz4LPWPU+aIoam+b5CUo=;
 b=p5gaDl7gb886ZgRhCLD79+fT1q4JqhGzCBzrgiYQn8xn3AEDxQX1vfa22xQnKQXK+LAN
 OwSdZTJW80I9XA4yne1ROjx4FOUE8CnUYAhyWGR2V+lv+WV2AnX0b+OAoUSQRHKQOvj7
 vWm5wx+mcFGdKV3IzpMdYzIxgj43zr6ULA/AylmLYEvplT1oqbPYDurG7auVX3/WyoAG
 nBNJwSb3kdSeSmZ2mnIv2MCu6uwDUWlyKJTEIBphLHdrwzAxAOgnAS6zqYgeoulZE77z
 /FsfHxcqMTB9oL/rcXrlykKesBweFZtribiglKXI8dmeJE8ANu2ILOnfyfstkULXy3Ab Lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2smsk5uqrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 23:59:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ONw3Je172558;
        Fri, 24 May 2019 23:59:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2smshg4dcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 23:59:00 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4ONwvQ9023032;
        Fri, 24 May 2019 23:58:57 GMT
Received: from [10.191.9.152] (/10.191.9.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 23:58:57 +0000
Subject: Re: [5.2-rc1 regression]: nvme vs. hibernation
To:     Jiri Kosina <jikos@kernel.org>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
Date:   Sat, 25 May 2019 07:58:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9267 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Looks this has been discussed in the past.

http://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html

I created a fix for a case but not good enough.

http://lists.infradead.org/pipermail/linux-nvme/2019-April/023277.html

Perhaps people would have better solution.

Dongli Zhang

On 05/25/2019 06:27 AM, Jiri Kosina wrote:
> On Fri, 24 May 2019, Keith Busch wrote:
> 
>>> Something is broken in Linus' tree (4dde821e429) with respec to 
>>> hibernation on my thinkpad x270, and it seems to be nvme related.
>>>
>>> I reliably see the warning below during hibernation, and then sometimes 
>>> resume sort of works but the machine misbehaves here and there (seems like 
>>> lost IRQs), sometimes it never comes back from the hibernated state.
>>>
>>> I will not have too much have time to look into this over weekend, so I am 
>>> sending this out as-is in case anyone has immediate idea. Otherwise I'll 
>>> bisect it on monday (I don't even know at the moment what exactly was the 
>>> last version that worked reliably, I'll have to figure that out as well 
>>> later).
>>
>> I believe the warning call trace was introduced when we converted nvme to
>> lock-less completions. On device shutdown, we'll check queues for any
>> pending completions, and we temporarily disable the interrupts to make
>> sure that queues interrupt handler can't run concurrently.
> 
> Yeah, the completion changes were the primary reason why I brought this up 
> with all of you guys in CC.
> 
>> On hibernation, most CPUs are offline, and the interrupt re-enabling
>> is hitting this warning that says the IRQ is not associated with any
>> online CPUs.
>>
>> I'm sure we can find a way to fix this warning, but I'm not sure that
>> explains the rest of the symptoms you're describing though.
> 
> It seems to be more or less reliable enough for bisect. I'll try that on 
> monday and will let you know.
> 
> Thanks,
> 
