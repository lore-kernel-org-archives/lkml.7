Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED76CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94D1208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390122AbfJ2P3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:29:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389809AbfJ2P3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:29:47 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TFHHVi023631;
        Tue, 29 Oct 2019 11:29:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxqj4sq6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 11:29:35 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9TFHV58025388;
        Tue, 29 Oct 2019 11:29:34 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxqj4sq4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 11:29:34 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9TFPh7a021520;
        Tue, 29 Oct 2019 15:29:33 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 2vvds83jc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 15:29:32 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9TFTVXI56099266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 15:29:31 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22F316E050;
        Tue, 29 Oct 2019 15:29:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEDA86E04C;
        Tue, 29 Oct 2019 15:29:30 +0000 (GMT)
Received: from localhost (unknown [9.41.101.192])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 15:29:30 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] pseries/hotplug: Change the default behaviour of cede_offline
In-Reply-To: <20191029111314.GC12266@in.ibm.com>
References: <1571740391-3251-1-git-send-email-ego@linux.vnet.ibm.com> <87o8y45sxt.fsf@linux.ibm.com> <20191029111314.GC12266@in.ibm.com>
Date:   Tue, 29 Oct 2019 10:29:30 -0500
Message-ID: <87tv7rlgdh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=815 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Fri, Oct 25, 2019 at 06:03:26PM -0500, Nathan Lynch wrote:
>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>> > This is the v2 of the fix to change the default behaviour of
>> > cede_offline.
>> 
>> OK, but why keep the cede offline behavior at all? Can we remove it? I
>> think doing so would allow us to remove all the code that temporarily
>> onlines threads for partition migration.
>
> May be I am missing something. But don't we want all the CPUs to come
> online and execute the H_JOIN hcall before performing partition
> migration? How will this change whether the offlined CPUs are in
> H_CEDE or rtas-stop-self?

The platform considers threads in H_CEDE to be active. It considers
threads that have performed stop-self to be inactive until they have
been restarted. The Thread Join Option section of the PAPR says active
threads must perform the H_JOIN. I have confirmed with hypervisor
development that this implies that the OS needn't involve inactive
threads in the join/suspend sequence.

It isn't quite explicit in the log for 120496ac2d2d ("powerpc: Bring all
threads online prior to migration/hibernation"), but it stands to reason
that using cede for offline is the reason that the code to online all
threads for join/suspend was introduced in the first place.
