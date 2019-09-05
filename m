Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158BF20820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfIED4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 23:56:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727544AbfIED4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:56:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x853qFEx172050
        for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2019 23:56:52 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utrp24u0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 23:56:51 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 5 Sep 2019 04:56:50 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 04:56:48 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x853ul1S45285656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 03:56:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21DA811C04A;
        Thu,  5 Sep 2019 03:56:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8491F11C04C;
        Thu,  5 Sep 2019 03:56:45 +0000 (GMT)
Received: from [9.124.31.69] (unknown [9.124.31.69])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 03:56:45 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] Powerpc64/Watchpoint: Don't ignore extraneous
 exceptions
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        mpe@ellerman.id.au
Cc:     mikey@neuling.org, benh@kernel.crashing.org,
        christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, paulus@samba.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190710045445.31037-1-ravi.bangoria@linux.ibm.com>
 <20190710045445.31037-3-ravi.bangoria@linux.ibm.com>
 <1567608022.j44gajn34z.naveen@linux.ibm.com>
Date:   Thu, 5 Sep 2019 09:26:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567608022.j44gajn34z.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090503-0008-0000-0000-000003114319
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090503-0009-0000-0000-00004A2F9A9F
Message-Id: <d0d3619f-3633-54f7-f0a3-563801867c7b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=852 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/19 8:12 PM, Naveen N. Rao wrote:
> Ravi Bangoria wrote:
>> On Powerpc64, watchpoint match range is double-word granular. On
>> a watchpoint hit, DAR is set to the first byte of overlap between
>> actual access and watched range. And thus it's quite possible that
>> DAR does not point inside user specified range. Ex, say user creates
>> a watchpoint with address range 0x1004 to 0x1007. So hw would be
>> configured to watch from 0x1000 to 0x1007. If there is a 4 byte
>> access from 0x1002 to 0x1005, DAR will point to 0x1002 and thus
>> interrupt handler considers it as extraneous, but it's actually not,
>> because part of the access belongs to what user has asked. So, let
>> kernel pass it on to user and let user decide what to do with it
>> instead of silently ignoring it. The drawback is, it can generate
>> false positive events.
> 
> I think you should do the additional validation here, instead of generating false positives. You should be able to read the instruction, run it through analyse_instr(), and then use OP_IS_LOAD_STORE() and GETSIZE() to understand the access range. This can be used to then perform a better match against what the user asked for.

Ok. Let me see how feasible that is.

But patch 1 and 3 are independent of this and can still go in. mpe?

-Ravi

