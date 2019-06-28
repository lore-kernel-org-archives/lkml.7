Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28834C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65B9208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qsU3sGgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF1BMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:12:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfF1BMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:12:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S18jeH107834;
        Fri, 28 Jun 2019 01:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Fpj98R7YPFrsbU/peaxe9+0g0ucs7pEIaE9mZ7f1KFs=;
 b=qsU3sGgTRtm0+MhQnq8q0HfNsf/LNdBgWJ07izxP+vDNcK0mTVx63SCOXeT7wu/Z+UOm
 CoCTey1kATTT04ZlCbhHn9VOM9t5OSWcquRnlylPcZCfBBaLoJK7BU2b36zZ5O4mGdYH
 RYuTCTrxaEn9ksgSkUCYer6RJrhFyVifTlr/FqkvxmJOCI3CTlFEOK+ASmszIxcRJSDF
 abhw5mGFutwc7oUfA081dCsdMtj4toEL1VGmYFIwy0j/Qqzjys9JRW11mvanoz7PbZtY
 ovpZTt30VTE8Lj7/ZbOxhy7Udq7MqD/BQBZ/PFw5pdPA+BnJV1Gj+4Gcvs1y5Vpo7dIW TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brtk317-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 01:11:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S1BZJj093558;
        Fri, 28 Jun 2019 01:11:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acdj129-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 01:11:53 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5S1Bq7A007346;
        Fri, 28 Jun 2019 01:11:52 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 18:11:51 -0700
Subject: Re: [PATCH v3 6/7] x86/smpboot: introduce per-cpu variable for HT
 siblings
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-7-subhra.mazumdar@oracle.com>
 <alpine.DEB.2.21.1906270844500.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906270853300.32342@nanos.tec.linutronix.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <fb445f4b-e415-d92b-4ca6-f104cb5fc9cb@oracle.com>
Date:   Thu, 27 Jun 2019 18:06:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906270853300.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/26/19 11:54 PM, Thomas Gleixner wrote:
> On Thu, 27 Jun 2019, Thomas Gleixner wrote:
>
>> On Wed, 26 Jun 2019, subhra mazumdar wrote:
>>
>>> Introduce a per-cpu variable to keep the number of HT siblings of a cpu.
>>> This will be used for quick lookup in select_idle_cpu to determine the
>>> limits of search.
>> Why? The number of siblings is constant at least today unless you play
>> silly cpu hotplug games. A bit more justification for adding yet another
>> random storage would be appreciated.
>>
>>> This patch does it only for x86.
>> # grep 'This patch' Documentation/process/submitting-patches.rst
>>
>> IOW, we all know already that this is a patch and from the subject prefix
>> and the diffstat it's pretty obvious that this is x86 only.
>>
>> So instead of documenting the obvious, please add proper context to justify
>> the change.
> Aside of that the right ordering is to introduce the default fallback in a
> separate patch, which explains the reasoning and then in the next one add
> the x86 optimized version.
OK. I will also add the extra optimization for other architectures.

Thanks,
Subhra
>
> Thanks,
>
> 	tglx
