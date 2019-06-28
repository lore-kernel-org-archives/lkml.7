Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99661C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A22133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfF1Fl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:41:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9790 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfF1FlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:41:25 -0400
X-IronPort-AV: E=Sophos;i="5.63,426,1557180000"; 
   d="scan'208";a="311715816"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 07:41:21 +0200
Date:   Fri, 28 Jun 2019 07:41:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Fuqian Huang <huangfq.daxian@gmail.com>
cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/27] staging: rtl8*: use zeroing allocator rather
 than allocator followed with memset 0
In-Reply-To: <20190628024935.15806-1-huangfq.daxian@gmail.com>
Message-ID: <alpine.DEB.2.21.1906280738460.2703@hadrien>
References: <20190628024935.15806-1-huangfq.daxian@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Jun 2019, Fuqian Huang wrote:

> Use zeroing allocator rather than allocator followed with memset 0.

Maybe it would be better to just change these to the appropriate kmalloc
and kzalloc calls.

You will need to check on whether locks are held to know whether the secon
argument should be GFP_ATOMIC or GFP_KERNEL.  The current code doesn't
address this issue in a correct manner.

You may also want to add some options to your get_maintainer call to not
send patches to everyone who has ever worked on the driver.

julia

>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/staging/rtl8188eu/os_dep/mlme_linux.c     |  3 +--
>  drivers/staging/rtl8712/rtl871x_io.c              |  4 +---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 ++------
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 12 +++---------
>  4 files changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
> index 9db11b16cb93..250acb01d1a9 100644
> --- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
> +++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
> @@ -98,10 +98,9 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
>  	if (authmode == _WPA_IE_ID_) {
>  		RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
>  			 ("rtw_report_sec_ie, authmode=%d\n", authmode));
> -		buff = rtw_malloc(IW_CUSTOM_MAX);
> +		buff = rtw_zmalloc(IW_CUSTOM_MAX);
>  		if (!buff)
>  			return;
> -		memset(buff, 0, IW_CUSTOM_MAX);
>  		p = buff;
>  		p += sprintf(p, "ASSOCINFO(ReqIEs =");
>  		len = sec_ie[1] + 2;
> diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
> index 17dafeffd6f4..87024d6a465e 100644
> --- a/drivers/staging/rtl8712/rtl871x_io.c
> +++ b/drivers/staging/rtl8712/rtl871x_io.c
> @@ -107,13 +107,11 @@ uint r8712_alloc_io_queue(struct _adapter *adapter)
>  	INIT_LIST_HEAD(&pio_queue->processing);
>  	INIT_LIST_HEAD(&pio_queue->pending);
>  	spin_lock_init(&pio_queue->lock);
> -	pio_queue->pallocated_free_ioreqs_buf = kmalloc(NUM_IOREQ *
> +	pio_queue->pallocated_free_ioreqs_buf = kzalloc(NUM_IOREQ *
>  						(sizeof(struct io_req)) + 4,
>  						GFP_ATOMIC);
>  	if ((pio_queue->pallocated_free_ioreqs_buf) == NULL)
>  		goto alloc_io_queue_fail;
> -	memset(pio_queue->pallocated_free_ioreqs_buf, 0,
> -			(NUM_IOREQ * (sizeof(struct io_req)) + 4));
>  	pio_queue->free_ioreqs_buf = pio_queue->pallocated_free_ioreqs_buf + 4
>  			- ((addr_t)(pio_queue->pallocated_free_ioreqs_buf)
>  			& 3);
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index db553f2e4c0b..f8e0723f5d1f 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -1078,12 +1078,10 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
>  	DBG_871X("pairwise =%d\n", pairwise);
>
>  	param_len = sizeof(struct ieee_param) + params->key_len;
> -	param = rtw_malloc(param_len);
> +	param = rtw_zmalloc(param_len);
>  	if (param == NULL)
>  		return -1;
>
> -	memset(param, 0, param_len);
> -
>  	param->cmd = IEEE_CMD_SET_ENCRYPTION;
>  	memset(param->sta_addr, 0xff, ETH_ALEN);
>
> @@ -2167,15 +2165,13 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
>  		{
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
> -			pwep = rtw_malloc(wep_total_len);
> +			pwep = rtw_zmalloc(wep_total_len);
>  			if (pwep == NULL) {
>  				DBG_871X(" wpa_set_encryption: pwep allocate fail !!!\n");
>  				ret = -ENOMEM;
>  				goto exit;
>  			}
>
> -			memset(pwep, 0, wep_total_len);
> -
>  			pwep->KeyLength = wep_key_len;
>  			pwep->Length = wep_total_len;
>
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index e3d356952875..1491d420929c 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -478,14 +478,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		if (wep_key_len > 0) {
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
> -			pwep = rtw_malloc(wep_total_len);
> +			pwep = rtw_zmalloc(wep_total_len);
>  			if (pwep == NULL) {
>  				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
>  				goto exit;
>  			}
>
> -			memset(pwep, 0, wep_total_len);
> -
>  			pwep->KeyLength = wep_key_len;
>  			pwep->Length = wep_total_len;
>
> @@ -2144,12 +2142,10 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
>  	int ret = 0;
>
>  	param_len = sizeof(struct ieee_param) + pext->key_len;
> -	param = rtw_malloc(param_len);
> +	param = rtw_zmalloc(param_len);
>  	if (param == NULL)
>  		return -1;
>
> -	memset(param, 0, param_len);
> -
>  	param->cmd = IEEE_CMD_SET_ENCRYPTION;
>  	memset(param->sta_addr, 0xff, ETH_ALEN);
>
> @@ -3522,14 +3518,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		if (wep_key_len > 0) {
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
> -			pwep = rtw_malloc(wep_total_len);
> +			pwep = rtw_zmalloc(wep_total_len);
>  			if (pwep == NULL) {
>  				DBG_871X(" r871x_set_encryption: pwep allocate fail !!!\n");
>  				goto exit;
>  			}
>
> -			memset(pwep, 0, wep_total_len);
> -
>  			pwep->KeyLength = wep_key_len;
>  			pwep->Length = wep_total_len;
>
> --
> 2.11.0
>
>
