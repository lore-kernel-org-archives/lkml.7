Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E930C218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j5Hjumol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCTKi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:38:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfCTKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:38:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KATIqP031820;
        Wed, 20 Mar 2019 10:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BOs2ZelRjbsnheU+2tZG6JoDo75VRuJc7Q90B0DHEkc=;
 b=j5Hjumolk7mpI0Til9U2mcI6rNsNpNEIsLl3o3Etm6sAl7vZStx4b/YchFtqFCQJhhUT
 KL37aFT6ob3PtoOpNgQ3tbjR+Qt8Gzn6UgnFsgSb88IytS4dipxqwFBDL3SiufYNUBNf
 nAAybYLc8AVc590tK1uMxssjwN4KVdnB6OVcr9EX8aa6L1cXpE3Lt8lKdNqYtrCo/Jn5
 OhjdyyFFrpJ1LcEf3/LzGTiV4dsLPwmKHHZEeoJE06NfhjNwESdFsWUnTpL/u4Eiw7gd
 mG14sOGJ1kcbUnssg+Hqobacp/ZZ6G/1qgh3zHU6zfvXPG6SRJ+a+IyvBUIAfhLGvlAs rA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r8ssrhtkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 10:38:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2KAcGMI006468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 10:38:16 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2KAcFZ6015246;
        Wed, 20 Mar 2019 10:38:15 GMT
Received: from kadam (/10.175.25.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 03:38:14 -0700
Date:   Wed, 20 Mar 2019 13:38:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtlwifi: Fix potential NULL pointer dereference
Message-ID: <20190320103812.GG2202@kadam>
References: <20190313161336.20182-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313161336.20182-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:13:34AM -0500, Aditya Pakki wrote:
> phydm.internal is allocated using kzalloc which is used multiple
> times without a check for NULL pointer. This patch avoids such a
> scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/staging/rtlwifi/phydm/rtl_phydm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/rtlwifi/phydm/rtl_phydm.c b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> index 9930ed954abb..37c7fcb72b65 100644
> --- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> +++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> @@ -181,6 +181,9 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
>  	rtlpriv->phydm.internal =
>  		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
>  
> +	if (!rtlpriv->phydm.internal)

Don't put a blank line between the allocation and the check.  They're

part of the same code and it's weird to double space the code.

regards,
dan carpenter

