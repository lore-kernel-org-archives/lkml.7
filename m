Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462A82184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCTH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:28:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726123AbfCTH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:28:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2K7PfIn058474
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 03:28:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rbh48r33y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 03:28:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 20 Mar 2019 07:27:54 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 07:27:51 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2K7Rted38666352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 07:27:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AD6152051;
        Wed, 20 Mar 2019 07:27:55 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 07EF15204F;
        Wed, 20 Mar 2019 07:27:55 +0000 (GMT)
Date:   Wed, 20 Mar 2019 08:27:48 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Jeff Xie <chongguiguzi@gmail.com>
Cc:     schwidefsky@de.ibm.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mhocko@suse.com, keescook@chromium.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390:tty3270:move spin_lock_bh to spin_lock in tasklet
References: <1553011956-28747-1-git-send-email-chongguiguzi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553011956-28747-1-git-send-email-chongguiguzi@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 19032007-0016-0000-0000-00000265030E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032007-0017-0000-0000-000032C01B0E
Message-Id: <20190320072748.GA3625@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=918 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:12:36AM +0800, Jeff Xie wrote:
> It is unnecessary to call spin_lock_bh in a tasklet.
> 
> Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
> ---
>  drivers/s390/char/tty3270.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index 2b0c36c2..2963396 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -563,7 +563,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
>  	char *input;
>  	int len;
> 
> -	spin_lock_bh(&tp->view.lock);
> +	spin_lock(&tp->view.lock);
>  	/*
>  	 * Two AID keys are special: For 0x7d (enter) the input line
>  	 * has to be emitted to the tty and for 0x6d the screen
> @@ -590,7 +590,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
>  		tp->update_flags = TTY_UPDATE_ALL;
>  		tty3270_set_timer(tp, 1);
>  	}
> -	spin_unlock_bh(&tp->view.lock);
> +	spin_unlock(&tp->view.lock);

I'm not going to take this. There is close to zero benefit, but rather
high cost to review this - just because the function is named *tasklet
doesn't mean it is only called in tasklet / softirq context.

