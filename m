Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A9C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216912075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="akhvXEaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbfC0Ggm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:36:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfC0Ggm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:36:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2R6Yfng059993;
        Wed, 27 Mar 2019 06:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=D9n/427Y0ZJaDNYYfd63kTni3Cy9YZP1DNO8fb7PF6E=;
 b=akhvXEaWCUrS/jJ4DO0LonH/wwYfGvzKlHHXU9CubqeKI6iVaSTlvdR/K+SAaoXT97vD
 hvTayQPNBcARrT860d7DyYG3hTyWFR/XcC+0j+Fsq87VDodCl6U8PsI+XtnKyesDmW4/
 zP6WhliggBPnNNnisbncVLOHIWvxP8vxx0rWdG0w2jTJtQDYaUBrAiwayKZXiqoBxPv1
 hXI/Y5lE0i07nm4jsg3pCWi2CPgLrEuQKt70ljgmSFHFmM+S/FY87WK77NTbLTXGeCKr
 vE5qQXo8pnC6XRkCcwqwElG4RdIcfEnSnU03t17kKRA61Yrywdsjh/qPuOvqAAtUEDEd Gw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2re6djemsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 06:36:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2R6aQTJ029701
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 06:36:27 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2R6aJqn012388;
        Wed, 27 Mar 2019 06:36:19 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 23:36:18 -0700
Date:   Wed, 27 Mar 2019 09:36:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: fix line over 80 characters
 warning
Message-ID: <20190327063606.GD32590@kadam>
References: <20190326182309.GA33380@auvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326182309.GA33380@auvm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:55:07PM +0530, Anirudh Rayabharam wrote:
> Shorten the expression by re-using the part that was already computed to

This confused me.  Better to phrase it like:

Shorten the expression by using the "psecuritypriv" pointer.

> fix the line over 80 characters warning reported by checkpatch.pl.
> 
> Signed-off-by: Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 18fabf5ff44b..bc0230672457 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -2336,8 +2336,8 @@ void rtw_ap_restore_network(struct adapter *padapter)
>  			Update_RA_Entry(padapter, psta);
>  			/* pairwise key */
>  			/* per sta pairwise key and settings */
> -			if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
> -				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
> +			if ((psecuritypriv->dot11PrivacyAlgrthm == _TKIP_) ||
> +				(psecuritypriv->dot11PrivacyAlgrthm == _AES_)) {

It's better to align it slightly different as well.  In the kernel we
would normally align the second condition to match the first one.

I probably would have gotten rid of the parenthesis as well.  I don't
like double parenthesis around == because I reserve that for =
assignment conditions.

			if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_ ||
			    psecuritypriv->dot11PrivacyAlgrthm == _AES_) {
				rtw_setstakey_cmd(padapter, psta, true, false);

When you're changing just a couple lines like this you can get away with
making multiple white space changes at the same time because the One
Thing that the patch does is "Clean up a Condition".  There is some
flexibility in the One thing Per Patch rule, but you have to sell it in
the right way.  The patch description would be:

  Checkpatch.pl complains that this line is over 80 characters.  We
  should use the "psecuritypriv" for consistency.  It's not aligned
  properly and there are too many parenthesis.

  This patch just cleans up a condition, it doesn't affect runtime.

regards,
dan carpenter
