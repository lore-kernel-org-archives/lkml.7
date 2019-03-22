Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1929D218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 07:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCVHjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:39:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfCVHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 03:39:04 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2M7YD0K043321
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:39:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rctchavt0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:39:02 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 22 Mar 2019 07:38:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 07:38:50 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2M7ctMm47579268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 07:38:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B94DC42042;
        Fri, 22 Mar 2019 07:38:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 343D742045;
        Fri, 22 Mar 2019 07:38:52 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.102.30.3])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 07:38:51 +0000 (GMT)
Subject: Re: [PATCH 0/2] Auto-promotion logic for cpuidle states
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au
References: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Fri, 22 Mar 2019 13:08:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190322062530.7586-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19032207-0008-0000-0000-000002D03C99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032207-0009-0000-0000-0000223C5B90
Message-Id: <6131c0d7-bb2f-04fb-9700-4c6655a1c56e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=665 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this set as this is incomplete. I have resent the patches.

--Abhishek

On 03/22/2019 11:55 AM, Abhishek Goel wrote:
> Currently, the cpuidle governors (menu/ladder) determine what idle state a
> idling CPU should enter into based on heuristics that depend on the idle
> history on that CPU. Given that no predictive heuristic is perfect, there
> are cases where the governor predicts a shallow idle state, hoping that
> the CPU will be busy soon. However, if no new workload is scheduled on
> that CPU in the near future, the CPU will end up in the shallow state.
>
> Motivation
> ----------
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>
> To address this, such lite states need to be autopromoted. The cpuidle-core
> can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.
>
> Experiment
> ----------
> Without this patch -
> It was seen that for a idle system, a cpu may remain in stop0_lite for few
> seconds and then directly goes to a deeper state such as stop2.
>
> With this patch -
> A cpu will not remain in stop0_lite for more than the residency of next
> available state, and thus it will go to a deeper state in conservative
> fashion. Using this, we may spent even less than 20 milliseconds if
> susbsequent stop states are enabled. In the worst case, we may end up
> spending more than a second, as was the case without this patch. The
> worst case will occur in the scenario when no other shallow states are
> enbaled, and only deep states are available for auto-promotion.
>
> Abhishek Goel (2):
>    cpuidle : auto-promotion for cpuidle states
>    cpuidle : Add auto-promotion flag to cpuidle flags
>
>   arch/powerpc/include/asm/opal-api.h |  1 +
>   drivers/cpuidle/Kconfig             |  4 ++++
>   drivers/cpuidle/cpuidle-powernv.c   | 13 +++++++++++--
>   drivers/cpuidle/cpuidle.c           |  3 ---
>   4 files changed, 16 insertions(+), 5 deletions(-)
>

