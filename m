Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B900C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A80826EBD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFCU3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:29:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbfFCU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:29:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53KLmHe107402;
        Mon, 3 Jun 2019 16:29:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sw9kxjs3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jun 2019 16:29:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x53ESVIQ011007;
        Mon, 3 Jun 2019 14:34:05 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2suh092qdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jun 2019 14:34:05 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x53KT2hU19267592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jun 2019 20:29:02 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDA4FAC060;
        Mon,  3 Jun 2019 20:29:02 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29472AC05E;
        Mon,  3 Jun 2019 20:29:02 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.191.102])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jun 2019 20:29:01 +0000 (GMT)
Subject: Re: linux-next: build warning after merge of the scsi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190531133612.35276ad9@canb.auug.org.au>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-ID: <4029bacf-3b74-b54c-ad52-42a67a6c13f9@linux.vnet.ibm.com>
Date:   Mon, 3 Jun 2019 13:29:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190531133612.35276ad9@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2019 08:36 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the scsi tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_work':
> drivers/scsi/ibmvscsi/ibmvscsi.c:2151:5: warning: 'rc' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (rc) {
>      ^
> drivers/scsi/ibmvscsi/ibmvscsi.c:2121:6: note: 'rc' was declared here
>   int rc;
>       ^~
> 
> Introduced by commit
> 
>   035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
> 

Oof, looks like I didn't compile with pedantic enough options, or just didn't
notice the warning. Declaration should be "int rc = 0;". I can send a follow on
patch.

-Tyrel
