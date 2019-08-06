Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D62CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16AC2089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HOlMSOQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfHFNRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:17:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHFNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:17:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76DGxNM076457;
        Tue, 6 Aug 2019 13:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TTm/Rs97Etdd6MROEpIhsbZ7ANTdzBesDsj3GyHxpWY=;
 b=HOlMSOQ8Do+NBYhXChz53YQveZz/PTPHee4kkZ/0OEPgSkooxukpjlONSHOGMSeZIMLi
 ubSwAh7iKsHYfTAGJBfMPsh6F0+Ccr3mklXK5N0pq6MPexE73opLjlmYb7VRrz6kYcqj
 vTLxh9XHN/uNWUcIfPs6JTWy2Y5zc61Blal9Np4w6udS+cG5DDE1YhshSfqleHL4R0Ye
 TcYHCb4qp2kW9ene0z/ACUVxkHxlRJVH31hzP6kBq+HP3fQnF0FoPxq06SaNicYlkhyg
 VnS4ugsY2jtAGibB0myMAfli+jtC9vCpLA3/W+djntGnokL7Eei8FdO7fp35ffxsFBp/ CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u52wr61wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 13:17:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76DFAWU161142;
        Tue, 6 Aug 2019 13:17:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u763gr0yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 13:17:31 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x76DHT3Z024412;
        Tue, 6 Aug 2019 13:17:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 06:17:29 -0700
Date:   Tue, 6 Aug 2019 16:17:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: snic: remove redundant assignment to variable ret
Message-ID: <20190806131721.GI1974@kadam>
References: <20190731224950.16818-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731224950.16818-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:49:50PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable ret is being assigned with a value that is never read as
> there is return statement immediately afterwards.  The assignment
> is redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/snic/snic_disc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
> index e9ccfb97773f..d89c75991323 100644
> --- a/drivers/scsi/snic/snic_disc.c
> +++ b/drivers/scsi/snic/snic_disc.c
> @@ -261,8 +261,6 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
>  	tgt = kzalloc(sizeof(*tgt), GFP_KERNEL);
>  	if (!tgt) {
>  		SNIC_HOST_ERR(snic->shost, "Failure to allocate snic_tgt.\n");
> -		ret = -ENOMEM;
> -
>  		return tgt;

Not related to this patch, but it would be nicer to return NULL instead
of tgt.  It's the same but the literal is nicer.  No need for the error
message after a kmalloc failure either.

	tgt = kzalloc(sizeof(*tgt), GFP_KERNEL);
	if (!tgt)
		return NULL;

regards,
dan carpenter

