Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BBDCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7720874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfJ2LNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:13:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727020AbfJ2LNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:13:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9TAxqka045400;
        Tue, 29 Oct 2019 07:13:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vxjpk3xmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 07:13:21 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9TB0jjZ049636;
        Tue, 29 Oct 2019 07:13:20 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vxjpk3xm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 07:13:20 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9TBAO0A016392;
        Tue, 29 Oct 2019 11:13:19 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2vvds91be4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 11:13:19 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9TBDInd52560190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 11:13:18 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C84842805A;
        Tue, 29 Oct 2019 11:13:18 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7428D28059;
        Tue, 29 Oct 2019 11:13:18 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.37.192])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 11:13:18 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id A873D2E3143; Tue, 29 Oct 2019 16:43:14 +0530 (IST)
Date:   Tue, 29 Oct 2019 16:43:14 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] pseries/hotplug: Change the default behaviour of
 cede_offline
Message-ID: <20191029111314.GC12266@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1571740391-3251-1-git-send-email-ego@linux.vnet.ibm.com>
 <87o8y45sxt.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8y45sxt.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=901 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan,


On Fri, Oct 25, 2019 at 06:03:26PM -0500, Nathan Lynch wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> > This is the v2 of the fix to change the default behaviour of
> > cede_offline.
> 
> OK, but why keep the cede offline behavior at all? Can we remove it? I
> think doing so would allow us to remove all the code that temporarily
> onlines threads for partition migration.

May be I am missing something. But don't we want all the CPUs to come
online and execute the H_JOIN hcall before performing partition
migration? How will this change whether the offlined CPUs are in
H_CEDE or rtas-stop-self?

--
Thanks and Regards
gautham.


