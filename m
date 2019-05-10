Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1188C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E26C2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 10:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1PUmmfN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfEJK6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 06:58:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42142 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfEJK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:58:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AAi5Gx145292;
        Fri, 10 May 2019 10:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=x+Mr1a+VP3Fqs4y3NgBrTiFWV1HAIGfPLgZZGlNX8uU=;
 b=1PUmmfN/O3qFc8wkC6D0KTbSMtbHsUcOVEFhCF5xquGa93Q3ri6k2YDApQbRWigcS8WG
 NGVsYg/Q4gZEooV3HEWY/T9HTEWF5D0OMvSdQqsxUTysMJ9Y2sVP5uDnBttR84yb0O49
 136m5DXlwKO4gJfy8V2FLKBhUz7o5C4VKZiXyN9fvfsWkcYVSoyVWrlpe+IHZwPXYcsJ
 5XmbUVHkucwXjAfTBjkhIGcx4cZI9D3PE7OJOKUnVg6hbm103izBPYTWZfiYuZY+9USd
 7PiXYrYuQ3b5bL0Ys9wACCG8cvjNy8Otz5be4FcZ6E63K1YFAWDr0Ifpw9pOtJl6qg5u fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s94b6gax8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 10:58:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AAv9VW010645;
        Fri, 10 May 2019 10:58:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2schw0bw1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 10:58:04 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4AAw1RV013526;
        Fri, 10 May 2019 10:58:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 03:58:00 -0700
Date:   Fri, 10 May 2019 13:57:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: collect return status without variable
Message-ID: <20190510105754.GA18105@kadam>
References: <20190510023900.GA4390@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510023900.GA4390@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 08:09:00AM +0530, Hariprasad Kelam wrote:
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 8a862f7..5dad5ac 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -231,17 +231,12 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
>  {
>  	struct wlandevice *wlandev = dev->ml_priv;
>  
> -	int err = 0;
> -	int result = 0;
> -
> -	result = prism2_domibset_uint32(wlandev,
> -		DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> -		key_index);
> -
> -	if (result)
> -		err = -EFAULT;
> -
> -	return err;
> +	if (prism2_domibset_uint32(wlandev,
> +				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> +				   key_index))
> +		return -EFAULT;
> +	else
> +		return 0;

We should just preserve the error codes from prism2_domibset_uint32().

	return prism2_domibset_uint32(dev->ml_priv,
				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
				key_index);

regards,
dan carpenter

