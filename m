Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5629C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FF2217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfHHLew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:34:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728542AbfHHLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:34:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78BXbJw096184
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 07:34:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8jq8gngv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:34:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 8 Aug 2019 12:34:49 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 12:34:46 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78BYRwq32637370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 11:34:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4083E42042;
        Thu,  8 Aug 2019 11:34:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B22D42045;
        Thu,  8 Aug 2019 11:34:45 +0000 (GMT)
Received: from osiris (unknown [9.152.212.134])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Aug 2019 11:34:44 +0000 (GMT)
Date:   Thu, 8 Aug 2019 13:34:43 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/extmem: Use refcount_t for refcount
References: <20190808071817.6595-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808071817.6595-1-hslester96@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19080811-0028-0000-0000-0000038D3C5B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080811-0029-0000-0000-0000244F3E8A
Message-Id: <20190808113443.GA4331@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=577 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:18:17PM +0800, Chuhong Yuan wrote:
> Reference counters are preferred to use refcount_t instead of
> atomic_t.
> This is because the implementation of refcount_t can prevent
> overflows and detect possible use-after-free.
> So convert atomic_t ref counters to refcount_t.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  arch/s390/mm/extmem.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

