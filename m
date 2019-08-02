Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196BDC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAB2206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392437AbfHBLpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:45:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388886AbfHBLpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:45:38 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72BfgdC129641
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 07:45:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u4k3ubp8g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:45:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Fri, 2 Aug 2019 12:45:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Aug 2019 12:45:32 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x72BjV7a45285540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 11:45:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA1F442054;
        Fri,  2 Aug 2019 11:45:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6C584204D;
        Fri,  2 Aug 2019 11:45:31 +0000 (GMT)
Received: from [9.152.212.191] (unknown [9.152.212.191])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 11:45:31 +0000 (GMT)
Subject: Re: [PATCH v2 02/10] gcov: Replace strncmp with str_has_prefix
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190802014650.8735-1-hslester96@gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Fri, 2 Aug 2019 13:45:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190802014650.8735-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080211-0028-0000-0000-0000038A610E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080211-0029-0000-0000-0000244AB8FA
Message-Id: <be8f4deb-7e7e-ee5d-a026-a6f5ab5f728a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.2019 03:46, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix
> to substitute such strncmp.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Looks sane!

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

> ---
> Changes in v2:
>   - Revise the description.
> 
>  kernel/gcov/fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
> index e5eb5ea7ea59..67296c1768b4 100644
> --- a/kernel/gcov/fs.c
> +++ b/kernel/gcov/fs.c
> @@ -354,7 +354,7 @@ static char *get_link_target(const char *filename, const struct gcov_link *ext)
>   */
>  static const char *deskew(const char *basename)
>  {
> -	if (strncmp(basename, SKEW_PREFIX, sizeof(SKEW_PREFIX) - 1) == 0)
> +	if (str_has_prefix(basename, SKEW_PREFIX))
>  		return basename + sizeof(SKEW_PREFIX) - 1;
>  	return basename;
>  }
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

