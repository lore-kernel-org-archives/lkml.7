Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04817205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P0H0CNbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEGMws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:52:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46556 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:52:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x47Ci14h136728;
        Tue, 7 May 2019 12:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=HJB6jyzrLVpXE0eF23Fp5tuwTCQ10Zf7366gUN/UEMk=;
 b=P0H0CNbK/dJxZxbyAcfx7c4I+kxbEYIgTy++Y/291NpZgdep1YGngVIGyR8p5duIPEhl
 /tpOcMkw0MGIPxrRGfhKXr9C0cb6qHCeY9PWaAquK0yhHD6tvf0l0ePtWjeqUwE4Agbm
 k5NpO+AsjhqSpzVCASgnvC2bAPES2BI1X0Had/oYfPwRO9z+ZAZRDZTw9lskc7pb3SG8
 fgjTYcPr+/OeiTpKAdfNUysVX7z8nwhxP6lj854BTBe5GOqW8/kKC8K/6OmqmWK7CAxy
 HzNVSmSwD1dDy4VX0MN81SsCg2eWbnrhd3oowX6HC9SCnEb/3vbAcTS3x1KuuNbYG4qF Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s94b5w0eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 May 2019 12:52:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x47CnrQ4069032;
        Tue, 7 May 2019 12:50:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2sagytwke2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 May 2019 12:50:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x47CoYeu029182;
        Tue, 7 May 2019 12:50:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 May 2019 05:50:34 -0700
Date:   Tue, 7 May 2019 15:50:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     alexander.shishkin@linux.intel.com, security@kernel.org,
        sasha.levin@oracle.com, gregkh@linuxfoundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, trivial@kernel.org
Subject: Re: stm class: Prevent user-controllable allocations
Message-ID: <20190507125027.GV2239@kadam>
References: <20190507124113.GA659@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507124113.GA659@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905070083
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905070083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 02:41:13PM +0200, Pavel Machek wrote:
> 
> It seems to me that we still allow overflow if count == ~0. We'll then
> allocate 0 bytes but copy ~0 bytes. That does not sound healthy.
> 
> Fixes: f08b18266c7116e2ec6885dd53a928f580060a71
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
> index c7ba8ac..8846fca 100644
> --- a/drivers/hwtracing/stm/core.c
> +++ b/drivers/hwtracing/stm/core.c
> @@ -631,7 +631,7 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
>  	char *kbuf;
>  	int err;
>  
> -	if (count + 1 > PAGE_SIZE)
> +	if (count > PAGE_SIZE - 1)
>  		count = PAGE_SIZE - 1;

The "count" variable should all be checked in vfs_write().  count + off
is checked in rw_verify_area() and count is capped at MAX_RW_COUNT.

#define MAX_RW_COUNT (INT_MAX & PAGE_MASK)

regards,
dan carpenter

