Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE86C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB6122CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfHSWel convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:34:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728363AbfHSWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:34:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JMWDfG048623;
        Mon, 19 Aug 2019 18:34:13 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ug2gnvp8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 18:34:13 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JMTvsd014064;
        Mon, 19 Aug 2019 22:34:12 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2ue976h30c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 22:34:12 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JMYBJN52101612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 22:34:11 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5EE3124053;
        Mon, 19 Aug 2019 22:34:11 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89244124052;
        Mon, 19 Aug 2019 22:34:11 +0000 (GMT)
Received: from localhost (unknown [9.41.179.186])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 22:34:11 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/vdso32: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE
In-Reply-To: <d988bf0d-1780-2a0a-4f9d-48d233c32e5f@c-s.fr>
References: <1eb059dcb634c48980e5e43f465aabd3d35ba7f7.1565960416.git.christophe.leroy@c-s.fr> <87tvadru13.fsf@linux.ibm.com> <d988bf0d-1780-2a0a-4f9d-48d233c32e5f@c-s.fr>
Date:   Mon, 19 Aug 2019 17:34:11 -0500
Message-ID: <87r25gss2k.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Hi,
>
> Le 19/08/2019 à 18:37, Nathan Lynch a écrit :
>> Hi,
>> 
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> Benchmark from vdsotest:
>> 
>> I assume you also ran the verification/correctness parts of vdsotest...? :-)
>> 
>
> I did run vdsotest-all. I guess it runs the verifications too ?

It does, but at a quick glance it runs the validation for "only" 1
second per API. It may provide more confidence to allow the validation
to run across several second (tv_sec) transitions, e.g.

vdsotest -d 30 clock-gettime-monotonic-coarse verify

Regardless, I did not see any problem with your patch.
