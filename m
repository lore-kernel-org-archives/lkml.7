Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2E1C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED966216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OCuEESWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfGIGso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:48:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfGIGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:48:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x696iJWS139709;
        Tue, 9 Jul 2019 06:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bKPTYTYFDEM18GaVLlsonaaA8WdGe2vNwwhUnfVmTxo=;
 b=OCuEESWGRH6TLz9bsEuOM4kbfoSXjg8POFgn1nevaxmmB5b8zQfW8vbJTvo1ZMgKPHSg
 1LZGJkmfuc4/c3Yli6nq/+117hNGkvOXnPMUP5BW0XhPMVgmWmmixkBG5ZRlnJ7cg+Ws
 WIo9QFzzbYJncNiP2CPXwZ1hTYKFkg3FqPfGdBIF+KTorskIn3NHXo+dLHkXiP97a6RF
 TbPViBmFrfAVqrL/Ix9cJqUI5C/ntroDl4Hoq+3jqFdx6VXwOxBGtjTEtIQGDBmyQQWT
 nj1LDht+PxyHf6FpYTECqrSS/B1BBWcoYnZhi7rcHlMvi1UTV9AICFDGTL8nGbB+jGr+ pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tjk2tjbct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 06:48:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x696ghJF165121;
        Tue, 9 Jul 2019 06:46:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tjgrtwq7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 06:46:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x696jw2a021969;
        Tue, 9 Jul 2019 06:45:58 GMT
Received: from Subhras-MacBook-Pro.local (/103.217.243.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 23:45:58 -0700
Subject: Re: [RFC 0/2] Optimize the idle CPU search
To:     Peter Zijlstra <peterz@infradead.org>,
        Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org
References: <20190708045432.18774-1-parth@linux.ibm.com>
 <20190708080836.GW3402@hirez.programming.kicks-ass.net>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <ebbe2d76-c8b5-e52f-897b-7bcbfe0d820a@oracle.com>
Date:   Tue, 9 Jul 2019 12:15:53 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708080836.GW3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9312 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090081
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


On 7/8/19 1:38 PM, Peter Zijlstra wrote:
> On Mon, Jul 08, 2019 at 10:24:30AM +0530, Parth Shah wrote:
>> When searching for an idle_sibling, scheduler first iterates to search for
>> an idle core and then for an idle CPU. By maintaining the idle CPU mask
>> while iterating through idle cores, we can mark non-idle CPUs for which
>> idle CPU search would not have to iterate through again. This is especially
>> true in a moderately load system
>>
>> Optimize idle CPUs search by marking already found non idle CPUs during
>> idle core search. This reduces iteration count when searching for idle
>> CPUs, resulting in lower iteration count.
> Have you seen these patches:
>
>    https://lkml.kernel.org/r/20180530142236.667774973@infradead.org
>
> I've meant to get back to that, but never quite had the time :/
The most relevant bit of this was folding select_idle_core and
select_idle_cpu. But it may be good to keep them separate as workloads
which just want any idle cpu can find one and break early by disabling
the idle core search. And this can still work with latency-nice which can
moderate both idle core and idle cpu search.

