Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5645AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F382183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNYSLf2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfC2HoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:44:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfC2HoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:44:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2T7dgVV061754;
        Fri, 29 Mar 2019 07:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=sKbpvAUcu6hVFSeuXJXcTusJNjVorQXuArSHdPGJITQ=;
 b=SNYSLf2mmxdaN5x3+OGOs8JVjg8oJXJaRbLW8VWrWf4bzJJ70qhF+K9VGh1OjzIBaTQp
 XkUaHChEsV5/leZSA9Z7cv8bYHjK3EpfRWJISmObH3GujdROLqIgY0Nk4nIY1w8cowUI
 j1Yw/L4FuO7Ex9X5Fg4wNKTr2upB1yvBNV0gbc1PvGfAVAVH06Bt6mq0f9WKtbfXDnFl
 Oz9AG9y+/EsxTffig55kO/ddqY93vL6ibCcGet/+br/9Z37eBGBb3YxuIkGt6hfROnpB
 GLozqlhhxhxNfxr9y8j9hGRHfXqH1ax3Wtdvu47knENA2PcMea6TbHXnEpAGouRRf8ZD hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1js6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 07:43:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2T7hulU007509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 07:43:57 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2T7htpX031965;
        Fri, 29 Mar 2019 07:43:55 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 00:43:54 -0700
Date:   Fri, 29 Mar 2019 10:43:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] n_tty: check for negative and zero space return from
 tty_write_room
Message-ID: <20190329074341.GW32590@kadam>
References: <20190328171005.5822-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328171005.5822-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 05:10:05PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The return from tty_write_room could potentially be negative if
> a tty write_room driver returns an error number (not that any seem
> to do). Rather than just check for a zero return, also check for
> a -ve return. This avoids the unsigned nr being set to a large unsigned
> value on the assignment from variable space and can lead to overflowing
> the buffer buf.  Better to be safe than assume all write_room
> implementations in tty drivers are going to do the right thing.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/tty/n_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 9cdb0fa3c4bf..66630787fbf9 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -550,7 +550,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
>  	mutex_lock(&ldata->output_lock);
>  
>  	space = tty_write_room(tty);
> -	if (!space) {
> +	if (space <= 0) {
>  		mutex_unlock(&ldata->output_lock);
>  		return 0;

Instead of zero we should probably return "space" to preserve the error
code.

regards,
dan carpenter

