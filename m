Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BBEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD562064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xedxqpcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441257AbfIXOMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:12:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45938 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfIXOMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:12:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OE9thY048021;
        Tue, 24 Sep 2019 14:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=AkqHICb3Rv9Y4nE27Lsc42IJ4riOSFUvurUNqZZ440Y=;
 b=XedxqpcmhIQo9c73WDaxFGaxa0Bp0wmxoyhW99yubHUWE8nNv1MStzP8D0+7Q6FPsxpH
 noBDVZw2bRaxzHk616czB4vPFgRxOEPGMHk9rEYLlVk33f6z0Y/HOnFXSu2+8MnHel2W
 Hx6Leu3at1OyPw7gDQb/cxOk05tonHy5u3bwPRq9fxj7qoEQlBsafzw+riz4Yj42ZVZC
 kj8Y+n7I9JNb3OuoLBW1RFb027bUH/Gfroq9Ve6cGlht/jX620dTZCXs2TH+NXkObaNK
 RpOAIdUg4RiXeP8en+RPu5/1jsEl8tXl5vB5ub0kRnHcpa1XedfD3ABM8k5nDDUIHXGI rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v5btpxcb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 14:11:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OEBBLq022074;
        Tue, 24 Sep 2019 14:11:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v6yvns3du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 14:11:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8OEBBVj026601;
        Tue, 24 Sep 2019 14:11:11 GMT
Received: from [10.154.189.242] (/10.154.189.242)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 07:11:11 -0700
Subject: Re: [RFC] mm: Proactive compaction
To:     Vlastimil Babka <vbabka@suse.cz>, Nitin Gupta <nigupta@nvidia.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "jannh@google.com" <jannh@google.com>, "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "janne.huttunen@nokia.com" <janne.huttunen@nokia.com>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>
References: <20190816214413.15006-1-nigupta@nvidia.com>
 <87634ddc-8bfd-8311-46c4-35f7dc32d42f@suse.cz>
 <7bbd5322ed7a7fcb349c83952f8fc17448cd07d8.camel@nvidia.com>
 <71d7fba0-bd6f-3ac5-1fd8-9a8ff6fc6b8b@suse.cz>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <d33fce4d-6018-0235-5391-debc8974eda5@oracle.com>
Date:   Tue, 24 Sep 2019 08:11:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <71d7fba0-bd6f-3ac5-1fd8-9a8ff6fc6b8b@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 7:39 AM, Vlastimil Babka wrote:
> On 9/20/19 1:37 AM, Nitin Gupta wrote:
>> On Tue, 2019-08-20 at 10:46 +0200, Vlastimil Babka wrote:
>>>
>>> That's a lot of control knobs - how is an admin supposed to tune them=
 to
>>> their
>>> needs?
>>
>>
>> Yes, it's difficult for an admin to get so many tunable right unless
>> targeting a very specific workload.
>>
>> How about a simpler solution where we exposed just one tunable per-nod=
e:
>>    /sys/.../node-x/compaction_effort
>> which accepts [0, 100]
>>
>> This parallels /proc/sys/vm/swappiness but for compaction. With this
>> single number, we can estimate per-order [low, high] watermarks for ex=
ternal
>> fragmentation like this:
>>  - For now, map this range to [low, medium, high] which correponds to =
specific
>> low, high thresholds for extfrag.
>>  - Apply more relaxed thresholds for higher-order than for lower order=
s.
>>
>> With this single tunable we remove the burden of setting per-order exp=
licit
>> [low, high] thresholds and it should be easier to experiment with.
>=20
> What about instead autotuning by the numbers of allocations hitting
> direct compaction recently? IIRC there were attempts in the past (mysel=
f
> included) and recently Khalid's that was quite elaborated.
>=20

I do think the right way forward with this longstanding problem is to
take the burden of managing free memory away from end user and let the
kernel autotune itself to the demands of workload. We can start with a
simpler algorithm in the kernel that adapts to workload and refine it as
we move forward. As long as initial implementation performs at least as
well as current free page management, we have a workable path for
improvements. I am moving the implementation I put together in kernel to
a userspace daemon just to test it out on larger variety of workloads.
It is more limited in userspace with limited access to statistics the
algorithm needs to perform trend analysis so I would rather be doing
this in the kernel.

--
Khalid

