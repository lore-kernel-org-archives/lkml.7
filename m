Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA0CCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E232086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfJ2Eyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:54:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727621AbfJ2Eyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:54:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9T3KQl9114144
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 00:54:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vx9mxrdwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 00:54:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 29 Oct 2019 04:54:34 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Oct 2019 04:54:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9T4sUYt53936348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 04:54:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F46F4C04A;
        Tue, 29 Oct 2019 04:54:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0BFE4C052;
        Tue, 29 Oct 2019 04:54:26 +0000 (GMT)
Received: from [9.199.48.187] (unknown [9.199.48.187])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Oct 2019 04:54:26 +0000 (GMT)
Subject: Re: [PATCH v6 0/7] Powerpc/Watchpoint: Few important fixes
To:     christophe.leroy@c-s.fr
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191017093204.7511-1-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 29 Oct 2019 10:24:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017093204.7511-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102904-0028-0000-0000-000003B09A31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102904-0029-0000-0000-00002472D968
Message-Id: <10cce8b1-8142-39d3-cd91-58b85dac7c8c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=685 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/19 3:01 PM, Ravi Bangoria wrote:
> v5: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198069.html
> 
> v5->v6:
>   - patch 6/7: mpe reported that the perf-hwbreak.c doesn't compile with older
>     gcc:
>          perf-hwbreak.c:182:2: error: dereferencing type-punned pointer will
>          break strict-aliasing rules [-Werror=strict-aliasing]
>              temp16 = *((__u16 *)target);
>              ^
>     Fixed that.
> 

Hi Christophe, Are you ok with the series wrt 8xx?

