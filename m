Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86480C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B622075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 03:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLZDzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 22:55:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbfLZDzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:55:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBQ3khKv117624
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 22:55:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x21wdsagr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 22:55:15 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 26 Dec 2019 03:55:13 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Dec 2019 03:55:09 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBQ3t8Xb61407394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Dec 2019 03:55:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D49B252051;
        Thu, 26 Dec 2019 03:55:08 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id B80D75204E;
        Thu, 26 Dec 2019 03:55:06 +0000 (GMT)
Date:   Thu, 26 Dec 2019 09:25:05 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] powerpc/shared: Fix build problem
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191225160626.968-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191225160626.968-1-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19122603-0020-0000-0000-0000039B7E84
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122603-0021-0000-0000-000021F2BB1A
Message-Id: <20191226035505.GB1781@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-25_08:2019-12-24,2019-12-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=837 impostorscore=0 adultscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912260035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [2019-12-25 08:06:26]:

> Since commit 656c21d6af5d ("powerpc/shared: Use static key to detect
> shared processor") and 14c73bd344da ("powerpc/vcpu: Assume dedicated
> processors as non-preempt"), powerpc test builds may fail with the
> following build errors.
> 
> ./arch/powerpc/include/asm/spinlock.h:39:1: error:
> 	type defaults to ???int??? in declaration of ???DECLARE_STATIC_KEY_FALSE???
> ./arch/powerpc/include/asm/spinlock.h: In function ???vcpu_is_preempted???:
> ./arch/powerpc/include/asm/spinlock.h:44:7: error:
> 	implicit declaration of function ???static_branch_unlikely???
> ./arch/powerpc/include/asm/spinlock.h:44:31: error:
> 	???shared_processor??? undeclared
> 
> The offending commits use static_branch_unlikely and shared_processor
> without adding the include file declaring it.

Thanks for reporting but same fix was already posted
http://lkml.kernel.org/r/20191223133147.129983-1-Jason@zx2c4.com


-- 
Thanks and Regards
Srikar Dronamraju

