Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E7C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694972721A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFAKzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 06:55:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfFAKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 06:55:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x51Aq8b2012472
        for <linux-kernel@vger.kernel.org>; Sat, 1 Jun 2019 06:55:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sunvdb2nm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 06:55:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 1 Jun 2019 11:55:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Jun 2019 11:55:37 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x51AtacM57933938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Jun 2019 10:55:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98CEA4C046;
        Sat,  1 Jun 2019 10:55:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59A584C040;
        Sat,  1 Jun 2019 10:55:36 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  1 Jun 2019 10:55:36 +0000 (GMT)
Date:   Sat, 1 Jun 2019 12:55:35 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: mmap base does not depend on ADDR_NO_RANDOMIZE
 personality
References: <20190404061956.25507-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404061956.25507-1-alex@ghiti.fr>
X-TM-AS-GCONF: 00
x-cbid: 19060110-0020-0000-0000-00000342866D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060110-0021-0000-0000-000021959394
Message-Id: <20190601105534.GG3600@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906010081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:19:56AM -0400, Alexandre Ghiti wrote:
> randomize_stack_top() checks for current task flag PF_RANDOMIZE in order
> to use stack randomization and PF_RANDOMIZE is set when
> ADDR_NO_RANDOMIZE is unset, so no need to check for ADDR_NO_RANDOMIZE
> in stack_maxrandom_size.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/s390/mm/mmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 687f2a4d3459..5185ed0a0463 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -24,8 +24,7 @@ static unsigned long stack_maxrandom_size(void)
>  {
>  	if (!(current->flags & PF_RANDOMIZE))
>  		return 0;
> -	if (current->personality & ADDR_NO_RANDOMIZE)
> -		return 0;
> +
>  	return STACK_RND_MASK << PAGE_SHIFT;

Applied, thanks.

