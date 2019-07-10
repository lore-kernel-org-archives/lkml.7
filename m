Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C226C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368532064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 06:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGJGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 02:38:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfGJGir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 02:38:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6A6bbtI101578
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:38:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tn7expxcn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 02:38:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 10 Jul 2019 07:38:43 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Jul 2019 07:38:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6A6cdmo42074132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 06:38:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D22FE4203F;
        Wed, 10 Jul 2019 06:38:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD3842047;
        Wed, 10 Jul 2019 06:38:37 +0000 (GMT)
Received: from [9.199.41.185] (unknown [9.199.41.185])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jul 2019 06:38:37 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] Powerpc64/Watchpoint: Don't ignore extraneous
 exceptions
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190710045445.31037-1-ravi.bangoria@linux.ibm.com>
 <20190710045445.31037-3-ravi.bangoria@linux.ibm.com>
 <1f3fd425-3d2f-8d18-eff1-01ca5b605ba0@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 10 Jul 2019 12:08:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1f3fd425-3d2f-8d18-eff1-01ca5b605ba0@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071006-0016-0000-0000-00000290D778
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071006-0017-0000-0000-000032EE8E67
Message-Id: <a49ccbd5-8109-b46e-66a3-c8deda841490@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/19 11:57 AM, Christophe Leroy wrote:
> 
> 
> Le 10/07/2019 à 06:54, Ravi Bangoria a écrit :
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
> Why adding some #ifdefs based on CONFIG_8xx ?

I don't know how 8xx behaves so I'm keeping the current behavior(ignore
extraneous exception) for 8xx.

> 
> I see your commit log mentions 'Powerpc64'. What about BOOK3S/32 ?

Hmm, I should not have mention 64 there. Yes, the change should cover both
Books3S/64 and Book3S/32.

