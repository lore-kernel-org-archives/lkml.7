Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62468C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296DC204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558342402;
	bh=Gzdv2G9YQ9dpAcYx/XvqRPmHwUG7jB3vlOP7A7rqhvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JNBvEuhDj4ALa24KmWs5+PLLC6455JG7aLckZwdlY7DAe3tD8laI4vMlMU0g9xdLR
	 9INbrFgJqfSx33caRAMf13owWv2DaLmB3ip9QCfQxGIAp+6gXTtwhnLAkySa2J0sgH
	 /03EXigVyWcMQzJLb+9qiBi+k7dutemjD8WlMNsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbfETIxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfETIxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:53:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87FD8204FD;
        Mon, 20 May 2019 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342400;
        bh=Gzdv2G9YQ9dpAcYx/XvqRPmHwUG7jB3vlOP7A7rqhvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCkQ3Z4lwefkORcLgEFSbGwbj/n7JSpCcbVxZpadh9vkcMEKG1enRAbFz0rtz5jC1
         j16rTI4r9UWWr4H5yAdt6riJYg3bhm5Djc9jh/al+n6NdLGodXtiKoCakXNbCXNIvu
         KYisKGryocGLDKMWLGvhP5lSKPs6e0lO4u2vEor4=
Date:   Mon, 20 May 2019 10:53:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Mamta Shukla <mamtashukla555@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_ap: fix Unneeded variable:
 "ret". Return "0"
Message-ID: <20190520085317.GB19183@kroah.com>
References: <20190519164445.GA5268@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519164445.GA5268@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 10:14:45PM +0530, Hariprasad Kelam wrote:
> This patch fixes below warnings reported by coccicheck
> 
> drivers/staging/rtl8723bs/core/rtw_ap.c:1400:5-8: Unneeded variable:
> "ret". Return "0" on line 1441
> drivers/staging/rtl8723bs/core/rtw_ap.c:2195:5-8: Unneeded variable:
> "ret". Return "0" on line 2205
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index bc02306..a1b5ba4 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -1397,7 +1397,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
>  int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  {
>  	struct list_head	*plist, *phead;
> -	int ret = 0;
>  	struct rtw_wlan_acl_node *paclnode;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
> @@ -1438,7 +1437,7 @@ int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  
>  	DBG_871X("%s, acl_num =%d\n", __func__, pacl_list->num);
>  
> -	return ret;
> +	return 0;
>  }

If this function can never fail, why does it have a return value at all?
Please fix that up instead.

>  
>  u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
> @@ -2192,7 +2191,6 @@ u8 ap_free_sta(
>  int rtw_sta_flush(struct adapter *padapter)
>  {
>  	struct list_head	*phead, *plist;
> -	int ret = 0;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> @@ -2202,7 +2200,7 @@ int rtw_sta_flush(struct adapter *padapter)
>  	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
>  
>  	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
> -		return ret;
> +		return 0;
>  
>  	spin_lock_bh(&pstapriv->asoc_list_lock);
>  	phead = &pstapriv->asoc_list;
> @@ -2227,7 +2225,7 @@ int rtw_sta_flush(struct adapter *padapter)
>  
>  	associated_clients_update(padapter, true);
>  
> -	return ret;
> +	return 0;
>  }

Same here.

thanks,

greg k-h
