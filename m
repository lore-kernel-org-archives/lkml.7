Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2699C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A205C217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NJ3xB0/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEKUra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 16:47:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47704 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfEKUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 16:47:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4BKcxfq138977;
        Sat, 11 May 2019 20:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TATKjhwZHN/z6muIX01mJSP7pI5rbeNwwgu/ed7JqrA=;
 b=NJ3xB0/iG5+EBwd2G0oY6BBq5zwHsuqUssQca7AJiS6/HaxfY6stMCwTlt4sk3vNYUj7
 NmTAIj5qypg7jo4eQ35JD0nb95I4ggm5T/qvVWqB1kism4CSnMO8EsH5r2KiSLTX34/d
 Qf0aIJvoUPyKCpwjIWPvViiduPZmlQn1SBCd42Vmg56dAZ85tfjJEhlZn5AXWuthQEzs
 8FWgeQZsdSUiJm6AgZKdcdNHgWgoZ2Kab3w/f997zzWweOoRiE+CzVoBUS0XG8hiXkBX
 pbpLMxMUbrp1HZz9pSZZs+OBN+LfPSNnu7xvQJJxYgmw77lhWj+8Yw2wM37jyAj2oND+ VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2sdkwd9s2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 20:47:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4BKk4AO155526;
        Sat, 11 May 2019 20:47:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2sdy5u26pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 20:47:21 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4BKlJPU021793;
        Sat, 11 May 2019 20:47:19 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 11 May 2019 13:47:18 -0700
Date:   Sat, 11 May 2019 23:47:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] drivers: staging : wlan-ng : collect return status
 without variable
Message-ID: <20190511204711.GG18105@kadam>
References: <20190511094859.GA21232@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511094859.GA21232@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9254 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905110152
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9254 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905110152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 03:18:59PM +0530, Hariprasad Kelam wrote:
> As caller rdev_set_default_key  not particular about -EFAULT.
> We can preserve the return value of prism2_domibset_uint32.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> -----
> Changes in v2:
>   - remove  masking of original return value with EFAULT
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 5dad5ac..4018fc5 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -231,12 +231,9 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
>  {
>  	struct wlandevice *wlandev = dev->ml_priv;
>  
> -	if (prism2_domibset_uint32(wlandev,
> -				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> -				   key_index))
> -		return -EFAULT;
> -	else
> -		return 0;
> +	return prism2_domibset_uint32(wlandev,
> +				      DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> +				      key_index);
>  }
>  

I'm sorry, this patch can only be applied on top of v1, but we need a
patch which can be applied on top of linux-next without applying v1
first.  (Merge/fold the two patches together and resend).

regards,
dan carpenter

