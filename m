Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C231C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A220665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfIRRI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:08:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727243AbfIRRI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:08:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8IH22vn038322;
        Wed, 18 Sep 2019 13:08:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3rdbrpk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 13:08:47 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8IH3QWk042500;
        Wed, 18 Sep 2019 13:08:47 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3rdbrpja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 13:08:47 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8IGxX68002888;
        Wed, 18 Sep 2019 17:08:46 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 2v37jw6xmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 17:08:45 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8IH8i9a60293628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:08:44 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DF3E136067;
        Wed, 18 Sep 2019 17:08:44 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3436B136059;
        Wed, 18 Sep 2019 17:08:44 +0000 (GMT)
Received: from localhost (unknown [9.41.179.186])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 17:08:44 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH 0/2] pseries/hotplug: Change the default behaviour of cede_offline
In-Reply-To: <20190918123039.GA12534@in.ibm.com>
References: <1568284541-15169-1-git-send-email-ego@linux.vnet.ibm.com> <87impxr0am.fsf@linux.ibm.com> <20190915074217.GA943@in.ibm.com> <87a7b2rfj0.fsf@linux.ibm.com> <20190918123039.GA12534@in.ibm.com>
Date:   Wed, 18 Sep 2019 12:08:43 -0500
Message-ID: <874l19r0pw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> The accounting problem in tools such as lparstat with
> "cede_offline=on" is affecting customers who are using these tools for
> capacity-planning. That problem needs a fix in the short-term, for
> which Patch 1 changes the default behaviour of cede_offline from "on"
> to "off". Since this patch would break the existing userspace tools
> that use the CPU-Offline infrastructure to fold CPUs for saving power,
> the sysfs interface allowing a runtime change of cede_offline_enabled
> was provided to enable these userspace tools to cope with minimal
> change.

So we would be putting users in the position of choosing between folding
and correct accounting. :-(

Actually how does changing the offline mechanism to stop-self break the
folding utility?
