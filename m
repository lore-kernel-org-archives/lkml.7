Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0464C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5EC25EBC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFCX6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:58:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60946 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbfFCX6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:58:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53Ng38D003809
        for <linux-kernel@vger.kernel.org>; Mon, 3 Jun 2019 19:58:23 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swadwyfxp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 19:58:23 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Tue, 4 Jun 2019 00:58:22 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 00:58:19 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x53NwIes35455232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jun 2019 23:58:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69B62AC05B;
        Mon,  3 Jun 2019 23:58:18 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31077AC059;
        Mon,  3 Jun 2019 23:58:17 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.191.102])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jun 2019 23:58:17 +0000 (GMT)
Subject: Re: [PATCH v3] scsi: ibmvscsi: Don't use rc uninitialized in
 ibmvscsi_do_work
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org
References: <20190603221941.65432-1-natechancellor@gmail.com>
 <20190603234405.29600-1-natechancellor@gmail.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Mon, 3 Jun 2019 16:58:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190603234405.29600-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060323-2213-0000-0000-00000399A0FF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011210; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01212859; UDB=6.00637416; IPR=6.00993919;
 MB=3.00027171; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-03 23:58:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060323-2214-0000-0000-00005EB16878
Message-Id: <912e3069-8fcc-b9e2-3b11-5d00236d34ee@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=912 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2019 04:44 PM, Nathan Chancellor wrote:
> clang warns:
> 
> drivers/scsi/ibmvscsi/ibmvscsi.c:2126:7: warning: variable 'rc' is used
> uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>         case IBMVSCSI_HOST_ACTION_NONE:
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvscsi.c:2151:6: note: uninitialized use occurs
> here
>         if (rc) {
>             ^~
> 
> Initialize rc in the IBMVSCSI_HOST_ACTION_UNBLOCK case statement then
> shuffle IBMVSCSI_HOST_ACTION_NONE down to the default case statement and
> make it return early so that rc is never used uninitialized in this
> function.
> 
> Fixes: 035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
> Link: https://github.com/ClangBuiltLinux/linux/issues/502
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Suggested-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

