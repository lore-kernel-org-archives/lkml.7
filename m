Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D2AC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B8921019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558595993;
	bh=UiHyCFXjL7dy8g+ulDW/+CR0M95VuCg7XORYNuE3pCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zQY9KhuWG1JzRIR4RU4Ns5lFDx9QO6sdroR613k5BExCw10/nZQMrzv8DSRFtAnPn
	 /UvzltwtUwrfgj60H1qrRSlzDx1BPh/WcDK18e5h1u21XDZQtoZG3bzaHo7CxefCC0
	 C5wRreqatJXnt1D4OpfaN9XqaEQ+8/XwZIoPJ/M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfEWHTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWHTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:19:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C359220863;
        Thu, 23 May 2019 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558595990;
        bh=UiHyCFXjL7dy8g+ulDW/+CR0M95VuCg7XORYNuE3pCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mf6sUuxrbbuN7C8KpKmxn7e0BOLVyOMzy/QlB6sH4wB7AEAjlJ+1tnn9S237AbrM3
         8Vo2V9HnmAyf1rwOfAvFhkP9D3rguCTUACSPiAj6fJWrUo70BwrtOYVRTm56NrThCT
         0rWo6WIpNXoZaOyz6h7bWMCM1i88PUf6fwTSqYMM=
Date:   Thu, 23 May 2019 09:19:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: core: rtw_mlme_ext: fix warning
 Unneeded variable: "ret"
Message-ID: <20190523071948.GB24998@kroah.com>
References: <20190522175501.GA8383@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522175501.GA8383@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:25:01PM +0530, Hariprasad Kelam wrote:
> This patch fixes below warnings reported by coccicheck
> 
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1888:14-17: Unneeded
> variable: "ret". Return "_FAIL" on line 1920
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:466:5-8: Unneeded
> variable: "res". Return "_SUCCESS" on line 494
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ----
> changes in v2:
> 		change return type of init_mlme_ext_priv() from int to
>                 void
> 		We cant change return type of on_action_spct() it is a
>                 call back function from action_handler.
> 		So directly return _FAIL from this function.
> ----
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ++-------
>  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 2 +-
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c      | 5 -----
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index d110d45..b240a40 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -461,9 +461,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, RT_CHANNEL_
>  	return chanset_size;
>  }
>  
> -int	init_mlme_ext_priv(struct adapter *padapter)
> +void	init_mlme_ext_priv(struct adapter *padapter)
>  {
> -	int	res = _SUCCESS;
>  	struct registry_priv *pregistrypriv = &padapter->registrypriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> @@ -490,9 +489,6 @@ int	init_mlme_ext_priv(struct adapter *padapter)
>  #ifdef DBG_FIXED_CHAN
>  	pmlmeext->fixed_chan = 0xFF;
>  #endif
> -
> -	return res;
> -
>  }
>  
>  void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
> @@ -1885,7 +1881,6 @@ unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
>  
>  unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_frame)
>  {
> -	unsigned int ret = _FAIL;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	u8 *pframe = precv_frame->u.hdr.rx_data;
> @@ -1917,7 +1912,7 @@ unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_fr
>  	}
>  
>  exit:
> -	return ret;
> +	return _FAIL;
>  }
>  
>  unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_frame)
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> index f6eabad..0eb2da5 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> @@ -535,7 +535,7 @@ struct mlme_ext_priv
>  };
>  
>  void init_mlme_default_rate_set(struct adapter *padapter);
> -int init_mlme_ext_priv(struct adapter *padapter);
> +void init_mlme_ext_priv(struct adapter *padapter);
>  int init_hw_mlme_ext(struct adapter *padapter);
>  void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
>  extern void init_mlme_ext_timer(struct adapter *padapter);
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 8a9d838..c2422e5 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -774,11 +774,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>  		goto exit;
>  	}
>  
> -	if (init_mlme_ext_priv(padapter) == _FAIL) {
> -		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("\n Can't init mlme_ext_priv\n"));
> -		ret8 = _FAIL;
> -		goto exit;
> -	}

Why did you delete the call to this function entirely?

Is that ok?  Why?

thanks,

greg k-h
