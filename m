Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD90C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A796A2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfLDWY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:24:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbfLDWY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:24:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4MIHlX124444;
        Wed, 4 Dec 2019 17:24:13 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnqn667xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 17:24:13 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB4MJtGp029131;
        Wed, 4 Dec 2019 22:24:12 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 2wkg27bf8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 22:24:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4MOBlM19071374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 22:24:11 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C329BE056;
        Wed,  4 Dec 2019 22:24:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0347FBE05A;
        Wed,  4 Dec 2019 22:24:10 +0000 (GMT)
Received: from localhost (unknown [9.41.179.251])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 22:24:10 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH 0/3] pseries: Track and expose idle PURR and SPURR ticks
In-Reply-To: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
Date:   Wed, 04 Dec 2019 16:24:10 -0600
Message-ID: <87r21ju3ud.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=725
 priorityscore=1501 suspectscore=1 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> On PSeries LPARs, the data centers planners desire a more accurate
> view of system utilization per resource such as CPU to plan the system
> capacity requirements better. Such accuracy can be obtained by reading
> PURR/SPURR registers for CPU resource utilization.
>
> Tools such as lparstat which are used to compute the utilization need
> to know [S]PURR ticks when the cpu was busy or idle. The [S]PURR
> counters are already exposed through sysfs.  We already account for
> PURR ticks when we go to idle so that we can update the VPA area. This
> patchset extends support to account for SPURR ticks when idle, and
> expose both via per-cpu sysfs files.

Does anything really want to use PURR instead of SPURR? Seems like we
should expose only SPURR idle values if possible.
