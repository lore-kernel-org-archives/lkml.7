Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABECC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C19F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YBY+JuSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfHVIJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:09:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60858 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfHVIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:09:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M89Ehm064504;
        Thu, 22 Aug 2019 08:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=qys3SBVljwg3jKlIyMl5SvReoKqkq2nisQb3LkrhQDw=;
 b=YBY+JuSIibdufBFGTGBEgKeO7zKlER3pUamqGDq3xDajOKHNIq5nhzqUBYtVcnhk1RCp
 Q30fJtYCTPsEzVAlQcHfX5LkylbdSuSfGrlf81F7l56p00v0c/9C50RRUjliblVvDuB8
 XohbH+d1fvIHOTImncpt7lWtTDatfNqJueWrUy75E/mpgWzXsockNmLKyM5BJc5k2vlx
 HKu3PszAXfUJ6uKYFG640vYL6e7yDcIfM1C9hDRe2S3NnpatzFZpecSNLrdKNNGZL0Nb
 wsJ8eoe1aGOa417n+H1ZcJlNeH9bOR9VGzRQ5IfHsUKD9ZggCqtbKLlASvG3eirBuVx1 kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ue90turmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:09:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7M88xxL047033;
        Thu, 22 Aug 2019 08:09:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ugj7rcmw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 08:09:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7M88s8g016428;
        Thu, 22 Aug 2019 08:08:55 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 01:08:54 -0700
Date:   Thu, 22 Aug 2019 11:08:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Chuang <jerry-chuang@realtek.com>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: Added Realtek rtl8192u driver to staging - static analysis
 report.
Message-ID: <20190822080848.GF4451@kadam>
References: <cb1222a8-4c67-8fac-f1d9-755e97699caa@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb1222a8-4c67-8fac-f1d9-755e97699caa@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 07:18:39PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis of linux-next picked up an issue with the following commit:
> 
> commit 8fc8598e61f6f384f3eaf1d9b09500c12af47b37
> Author: Jerry Chuang <jerry-chuang@realtek.com>
> Date:   Tue Nov 3 07:17:11 2009 -0200
> 
>     Staging: Added Realtek rtl8192u driver to staging
> 
> In drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c we have:
> 
> CID 48331 (#1 of 1): Unused value (UNUSED_VALUE) assigned_pointer
> 
> Assigning value from ieee->crypt[ieee->tx_keyidx] to crypt here, but
> that stored value is not used.
> 
> 746        crypt = ieee->crypt[ieee->tx_keyidx];
> 747        if (encrypt)
> 748                beacon_buf->capability |=
> cpu_to_le16(WLAN_CAPABILITY_PRIVACY);

Earlir in the function we have:

   695          crypt = ieee->crypt[ieee->tx_keyidx];
   696  
   697          encrypt = ieee->host_encrypt && crypt && crypt->ops &&
   698                  ((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
   699          /* HT ralated element */

So the "crypt" assignment is dublicate and should definitely be removed.
The "if (encrypt) " check looks correct and it sort of matches what we
do in ieee80211_assoc_resp().

   840          encrypt = crypt && crypt->ops;
   841  
   842          if (encrypt)
   843                  assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
   844  

So let's leave it as-is, just delete the crypt assignment.  If you want,
you can send this patch and I can give you a Reviewed-by tag or if you
want I can send the patch and give you Reported-by credit.

regards,
dan carpenter

