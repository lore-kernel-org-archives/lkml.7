Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DF6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA1E206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TaYsXVxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfFGOQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:16:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37452 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfFGOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:16:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57E92ms025466;
        Fri, 7 Jun 2019 14:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Hfi0+7VYsAALYB8q7Euh/hT95ww348pgA0rjB9PLhgQ=;
 b=TaYsXVxJkJJLdkDTtmWYKlSLWFQDTdhgYboeQym1uofjzV5aA4PowRUIKHclOJ8ZiTRF
 y6zSSxq2zc/yWt488v889EYxqL3R+gXeIntc23M3xJ8R3Lk/Gx5ehJRCZl4jffp89BwL
 i72Mna209K+65md9+pmxlR2nbytCV73EqRltkvBNzZ1vNT6D6jZ8spoSSQiWNqFEKJTd
 F7Lh2+vmI9gDCkWzw+qOUiexNLdml4ffnszAcEYSmay7+5t3iElhKXyf+dvuXnHIV30U
 PRPR96IqF6g97ZJhO8D6Ou5ljoRzYtM2Ze0ouKogQZoTSFBmC9o5TUIxTjXhTXh47KDP IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2suevdxsqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 14:16:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57EG0J2183393;
        Fri, 7 Jun 2019 14:16:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2swngk1r0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 14:16:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x57EFv6Z031922;
        Fri, 7 Jun 2019 14:15:57 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 07:15:57 -0700
Date:   Fri, 7 Jun 2019 17:15:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        colin.king@canonical.com, valdis.kletnieks@vt.edu,
        tiny.windzz@gmail.com
Subject: Re: [PATCH 1/2] staging: rtl8712: r8712_setdatarate_cmd(): Change
Message-ID: <20190607141548.GP31203@kadam>
References: <20190607140658.11932-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607140658.11932-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably you sent this patch unintentionally.  The subject doesn't make
any sort of sense.  :P

On Fri, Jun 07, 2019 at 07:36:57PM +0530, Nishka Dasgupta wrote:
> Change the return values of function r8712_setdatarate_cmd from _SUCCESS
> and _FAIL to 0 and -ENOMEM respectively.
> Change the return type of the function from u8 to int to reflect this.
> Change the call site of the function to check for 0 instead of _SUCCESS.
> (Checking that the return value != 0 is not necessary; the return value
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> itself can simply be passed into the conditional.)
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is obvious.  No need to mention it in the commit message.

> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> index b424b8436fcf..761e2ba68a42 100644
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> @@ -1367,7 +1367,7 @@ static int r8711_wx_set_rate(struct net_device *dev,
>  			datarates[i] = 0xff;
>  		}
>  	}
> -	if (r8712_setdatarate_cmd(padapter, datarates) != _SUCCESS)
> +	if (r8712_setdatarate_cmd(padapter, datarates))
>  		ret = -ENOMEM;
>
>  	return ret;


It would be better to write this like so:

	ret = r8712_setdatarate_cmd(padapter, datarates);
	if (ret)
		return ret;

	return 0;

Or you could write it like:

	return r8712_setdatarate_cmd(padapter, datarates);

Which ever one you prefer is fine.

regards,
dan carpenter

