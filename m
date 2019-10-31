Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9141ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D0208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfJaQa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:30:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbfJaQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:30:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VGT3bU075421;
        Thu, 31 Oct 2019 12:30:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w027f2kpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 12:30:18 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9VGT34G075383;
        Thu, 31 Oct 2019 12:30:18 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w027f2knx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 12:30:18 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9VGQC3f010328;
        Thu, 31 Oct 2019 16:30:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 2vxwh68r1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 16:30:17 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VGUDPs61014424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 16:30:13 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 110086E058;
        Thu, 31 Oct 2019 16:30:13 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF39B6E054;
        Thu, 31 Oct 2019 16:30:12 +0000 (GMT)
Received: from localhost (unknown [9.85.136.151])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 16:30:12 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] pseries/hotplug-cpu: Change default behaviour of cede_offline to "off"
In-Reply-To: <1571740391-3251-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1571740391-3251-1-git-send-email-ego@linux.vnet.ibm.com> <1571740391-3251-2-git-send-email-ego@linux.vnet.ibm.com>
Date:   Thu, 31 Oct 2019 11:30:11 -0500
Message-ID: <87k18klvxo.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> Currently on PSeries Linux guests, the offlined CPU can be put to one
> of the following two states:
>    - Long term processor cede (also called extended cede)
>    - Returned to the hypervisor via RTAS "stop-self" call.
>
> This is controlled by the kernel boot parameter "cede_offline=on/off".
>
> By default the offlined CPUs enter extended cede. The PHYP hypervisor
> considers CPUs in extended cede to be "active" since they are still
> under the control fo the Linux guests. Hence, when we change the SMT
> modes by offlining the secondary CPUs, the PURR and the RWMR SPRs will
> continue to count the values for offlined CPUs in extended cede as if
> they are online. This breaks the accounting in tools such as lparstat.
>
> To fix this, ensure that by default the offlined CPUs are returned to
> the hypervisor via RTAS "stop-self" call by changing the default value
> of "cede_offline_enabled" to false.
>
> Fixes: commit 3aa565f53c39 ("powerpc/pseries: Add hooks to put the CPU
> into an appropriate offline state")
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

I'm OK with changing the default as a precursor to removing the code
that implements the cede offline mode.

Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
