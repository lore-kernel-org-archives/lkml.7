Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64117C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288A72173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YxOV91lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfC2IYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:24:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43350 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfC2IYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:24:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2T8J0kj098088;
        Fri, 29 Mar 2019 08:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jfRRj1ZUXYnl96/1ovUaMovzR/1JQasnDeyvQcTRGS0=;
 b=YxOV91lYOY7gEQ7lRM7FXZ7MtcFnAdrPJMWqWi26eWPnZjQV99jxtGegFEmPAESXOx2l
 gtjPpduHvzva86HLyPlB0a47catkdyNkLYqov6o3qE4um66cZ0+l+X1yaRvQtZhBaDk1
 1Nr8R4kvJKBNXjqB5LVviUHlccjptDzens984o4I2wcKt414dCZbJEcrdUW624eoDqCX
 W5BFRE1M4uY3phq4tdfO8qp5ZTzZwDuBrmpWNIOqM6l4Pwq/RNYNfEfW4AkiI/a7wZRE
 DFyf6QLLLHNOzUG7hShTHLyRB+8YgctrkAmKkeOcB5uAYsLRSD2J2nTQcQAzMitcW0Q2 mQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2re6g1b0bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 08:24:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2T8OSaW029354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 08:24:29 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2T8ORlH018564;
        Fri, 29 Mar 2019 08:24:28 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 01:24:26 -0700
Date:   Fri, 29 Mar 2019 11:24:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix incorrect mask for
 EEPROMTxPowerLevelCCK setting
Message-ID: <20190329082417.GY32590@kadam>
References: <20190329000244.16528-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329000244.16528-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 12:02:44AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the lower 8 bits of ret are being masked and left
> shifted by 8 bits always leaving a result of zero. The mask
> appears to be incorrect and should probably be 0xff00 instead
> of 0xff.  Fix this.  (Note: not tested).
> 
> Fixes: 16feab644fd1 ("staging: rtl8192u: check return value eprom_read")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index f1eaab337dca..a173884d31c8 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -2454,7 +2454,7 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
>  				ret = eprom_read(dev, (EEPROM_TX_PW_INDEX_CCK >> 1));
>  				if (ret < 0)
>  					return ret;
> -				priv->EEPROMTxPowerLevelCCK = ((u16)ret & 0xff) >> 8;
> +				priv->EEPROMTxPowerLevelCCK = ((u16)ret & 0xff00) >> 8;

I'd say there is a 80-90% chance your fix is correct...

This only affects an older rev of the eeprom I think.  I believe what
happens in the current code is that we set EEPROMTxPowerLevelCCK to
zero.  Then we subtract:

	priv->TxPowerLevelCCK[i] = priv->EEPROMTxPowerLevelOFDM24G[0] + (priv->EEPROMTxPowerLevelCCK - priv->EEPROMTxPowerLevelOFDM24G[1]);

Possibly leading to a high u8 value, then in phy_set_rf8256_cck_tx_power()
it gets capped at 0x24...

regards,
dan carpenter

