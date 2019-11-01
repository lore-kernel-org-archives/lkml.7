Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D63CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8396E20650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B12Obcd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfKAOvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:51:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39672 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfKAOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:51:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1Emgab177701;
        Fri, 1 Nov 2019 14:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=nGNBEJDch3Fb1hcyWxzKpmeeNUrixQaYxfvmOjhwZ7Q=;
 b=B12Obcd5aCXe1B6pres9tgUw8b9PDsx8kbAtwAnM64iuhhEm2gzIqPgoMIm1VBOEJfY5
 6DftQp9m3KHqNuTJFY+Mjj1VYzfnF2SLI7hZ2nVmH7cO7yede6/5JwyWfeR4gpJyi09w
 0LHoDquzr0Lc4o6q/NhNQlsSMpZwxrIHkQwSVniSCXIc4ZRvWDNsgBPevbIeYg9cYP8g
 BDLgIJNsKfmFgIjQ4q0bfEMFRmNPI33cApn0XpXTmfu684BhnBmRL4FMISQBIVezooCH
 lq+8dpHkDUJpXqxYrPvJNb61tVCGQ/AyX24wUNXEHV9/fTXV+fthONzJlHiZNITgc7Fm hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vxwhg29wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 14:51:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1EmMrD084671;
        Fri, 1 Nov 2019 14:51:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vykw3fqaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 14:51:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA1EpP9D012233;
        Fri, 1 Nov 2019 14:51:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 07:51:24 -0700
Date:   Fri, 1 Nov 2019 17:51:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix potential infinite loop because
 loop counter being too small
Message-ID: <20191101145117.GB10409@kadam>
References: <20191101142604.17610-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101142604.17610-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 02:26:04PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the for-loop counter i is a u8 however it is being checked
> against a maximum value priv->ieee80211->LinkDetectInfo.SlotNum which is a
> u16. Hence there is a potential wrap-around of counter i back to zero if
> priv->ieee80211->LinkDetectInfo.SlotNum is greater than 255.  Fix this by
> making i a u16.
> 
> Addresses-Coverity: ("Infinite loop")
> Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 48f1591ed5b4..fd91b7c5ca81 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -3210,7 +3210,7 @@ static void rtl819x_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
>  			     u32 *TotalRxDataNum)
>  {
>  	u16			SlotIndex;
> -	u8			i;
> +	u16			i;

The iterator "i" should just be an int unless we know that it needs to
be an unsigned long long.

regards,
dan carpenter

