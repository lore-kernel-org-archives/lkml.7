Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30874C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CE020663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SsxZW8vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfGAUoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:44:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:44:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61KdMCi173574;
        Mon, 1 Jul 2019 20:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+aeZDe3jwT4xvYHZCTEN4awdr90rYxW4YlVpN9V8bnY=;
 b=SsxZW8vkxaV0FOgr/oB+4IDVriQsdttQulNAKfHz/eIdV3+xXXbuQvbXv+3xUpbRbfZF
 lCnuKifwFQrgRihYoa98czn/XI+0nG7cDvWDaFdMNz+6eHAlw6tq9ecovjA3CHu7CVyJ
 9zw6q7qXKoEG4SPtCY0hzcEVAiO4ERyk+8uScZbJFZn9kGYQvDHqdg9qB1hR9DQluT4N
 J3VlQnTavPWuqBT4msf5qWEEhGNmxmc/aavjCecmKTFmVUOEoSqRs0Q2lXxC6ahREbze
 Baek17LPUNnfj8KKZT3iwwFTwvFubbnYJPT5J8dYLgXHR+hJV2nSXirx2yq1uF0xT1d6 YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2te61dyufg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 20:42:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61Kbsuj160590;
        Mon, 1 Jul 2019 20:42:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tebbjd124-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 20:42:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61KgSHW009452;
        Mon, 1 Jul 2019 20:42:28 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 13:42:27 -0700
Subject: Re: [PATCH v3 5/7] sched: SIS_CORE to disable idle core search
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-6-subhra.mazumdar@oracle.com>
 <0e0f3347-c262-2917-76d7-88dddf4e9122@linux.ibm.com>
 <59ab08d5-8b7c-00b9-230b-7c0b307a675f@oracle.com>
 <be91602a-0243-e094-8c8f-ceed314d10ce@linux.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <12402fea-7b87-8c4d-9485-53f973c38654@oracle.com>
Date:   Mon, 1 Jul 2019 13:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <be91602a-0243-e094-8c8f-ceed314d10ce@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010239
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Also, systems like POWER9 has sd_llc as a pair of core only. So it
>>> won't benefit from the limits and hence also hiding your code in select_idle_cpu
>>> behind static keys will be much preferred.
>> If it doesn't hurt then I don't see the point.
>>
> So these is the result from POWER9 system with your patches:
> System configuration: 2 Socket, 44 cores, 176 CPUs
>
> Experiment setup:
> ===========
> => Setup 1:
> - 44 tasks doing just while(1), this is to make select_idle_core return -1 most times
> - perf bench sched messaging -g 1 -l 1000000
> +-----------+--------+--------------+--------+
> | Baseline  | stddev |    Patch     | stddev |
> +-----------+--------+--------------+--------+
> |       135 |   3.21 | 158(-17.03%) |   4.69 |
> +-----------+--------+--------------+--------+
>
> => Setup 2:
> - schbench -m44 -t 1
> +=======+==========+=========+=========+==========+
> | %ile  | Baseline | stddev  |  patch  |  stddev  |
> +=======+==========+=========+=========+==========+
> |    50 |       10 |    3.49 |      10 |     2.29 |
> +-------+----------+---------+---------+----------+
> |    95 |      467 |    4.47 |     469 |     0.81 |
> +-------+----------+---------+---------+----------+
> |    99 |      571 |   21.32 |     584 |    18.69 |
> +-------+----------+---------+---------+----------+
> |  99.5 |      629 |   30.05 |     641 |    20.95 |
> +-------+----------+---------+---------+----------+
> |  99.9 |      780 |   40.38 |     773 |     44.2 |
> +-------+----------+---------+---------+----------+
>
> I guess it doesn't make much difference in schbench results but hackbench (perf bench)
> seems to have an observable regression.
>
>
> Best,
> Parth
>
If POWER9 sd_llc has only 2 cores, the behavior shouldn't change much with
the select_idle_cpu changes as the limits are 1 and 2 core. Previously the
lower bound was 4 cpus and upper bound calculated by the prop. Now it is
1 core (4 cpus on SMT4) and upper bound 2 cores. Could it be the extra
computation of cpumask_weight causing the regression rather than the
sliding window itself (one way to check this would be hardcode 4 in place
of topology_sibling_weight)? Or is it the L1 cache coherency? I am a bit
suprised because SPARC SMT8 which has more cores in sd_llc and L1 cache per
core showed improvement with Hackbench.

Thanks,
Subhra
