Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DE9C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065AD216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvyDiGzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfGIGtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:49:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33868 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:49:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x696iEeB045896;
        Tue, 9 Jul 2019 06:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ii8UsH5Elf/Y7v3ZXq66I3D5hvstpMiGUJOQc95FiB0=;
 b=dvyDiGzb7aGwx+2hxOPmVTySKjYie1i9xH7dfNFbcJPfLjdpSAm7aRMn8oq0Iwsya1rE
 OjUbPVp2KOWeC79K+ud806gHpv1ZxwyAuPBVAf6R0H7DOASz+piv+7XH42JetUymfSKO
 StgQq5DhSInRnedB0dv3RAClWrhKRr8WWy5MqeJCjAL++LhpnUe7GaDeZvQgCdlOJXIQ
 AQuD5wMi/jQKejUjsnWZGFBii4JAPJDJztf9CVsNuVmYyQCPkGT8uf//joe2S40yIxbN
 iZ3l2unklEOkHAX6T8hyn4kKFJKBjeWkG8Qwv9xa5hs5Rxo0v9uKcpCq2n1bePnohhRL Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tjkkpjakw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 06:48:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x696lbYl023908;
        Tue, 9 Jul 2019 06:48:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tmmh2s7p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 06:48:57 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x696mtca012680;
        Tue, 9 Jul 2019 06:48:56 GMT
Received: from Subhras-MacBook-Pro.local (/103.217.243.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 23:48:55 -0700
Subject: Re: [RFC 0/2] Optimize the idle CPU search
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
References: <20190708045432.18774-1-parth@linux.ibm.com>
 <839c6cc8-b550-3066-d856-3c8a919cc318@oracle.com>
 <708a2726-628c-196b-1fc0-43067e1e740f@linux.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <e688119a-5acd-0304-bb44-62408fc42ca7@oracle.com>
Date:   Tue, 9 Jul 2019 12:18:47 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <708a2726-628c-196b-1fc0-43067e1e740f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/19 11:08 AM, Parth Shah wrote:
>
> On 7/9/19 5:38 AM, Subhra Mazumdar wrote:
>> On 7/8/19 10:24 AM, Parth Shah wrote:
>>> When searching for an idle_sibling, scheduler first iterates to search for
>>> an idle core and then for an idle CPU. By maintaining the idle CPU mask
>>> while iterating through idle cores, we can mark non-idle CPUs for which
>>> idle CPU search would not have to iterate through again. This is especially
>>> true in a moderately load system
>>>
>>> Optimize idle CPUs search by marking already found non idle CPUs during
>>> idle core search. This reduces iteration count when searching for idle
>>> CPUs, resulting in lower iteration count.
>>>
>> I believe this can co-exist with latency-nice? We can derive the 'nr' in
>> select_idle_cpu from latency-nice and use the new mask to iterate.
>>
> I agree, can be done with latency-nice.
>
> Maybe something like below?
> smt = nr_cpus / nr_cores
> nr = smt + (p->latency_nice * (total_cpus-smt) / max_latency_nice)
>
> This limits lower bounds to 1 core and goes through all the cores if
> latency_nice is maximum for a task.
Yes I had similar in mind.
