Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82041C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D569217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558528331;
	bh=qd38iVDFktSHe0ZEFWncQyLWuOgOl9SFrCwsnoUuL9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G7FtJ9zWuC8G6ul9J//Uq9sItJLf/MUsVfFaCZ/Ic7p6h42VahZ5maS3elrRRJdMz
	 zvYOUPa8KqCgu2jmm5MkEwfpqZFNumzz2a+mUAbfiwXcm02yNCKjC4Xl7pSMCeSz9x
	 CtEz1diuBRFLaBfSjE4OkddMN/3Wyw/ZTYoQ+Uss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfEVMcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfEVMcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:32:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26672173C;
        Wed, 22 May 2019 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558528329;
        bh=qd38iVDFktSHe0ZEFWncQyLWuOgOl9SFrCwsnoUuL9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yn8lkUyommXoXyfuvI0H1VxrsWa7yrWlXqpiF8Li1aFlFXE4hkdsqMl5sUqUuY2WH
         Fo/Hb1J+JYAZuAKJBrP1ZLCSHxOPJxuAt3D2m7F3DM9uEF1ohULK+vunO2s/5CcVG4
         g1WsEzh4rb3w/75peEXk/zDnQ6z7kQdtQMaV7LPY=
Date:   Wed, 22 May 2019 14:32:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Anirudh Rayabharam <anirudh.rayabharam@gmail.com>,
        Kimberly Brown <kimbrownkd@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Michael Straube <straube.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: rtl8723bs: core: rtw_ap: fix Unneeded
 variable: "ret". Return "0
Message-ID: <20190522123206.GB24298@kroah.com>
References: <20190521190032.GA7486@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521190032.GA7486@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:30:33AM +0530, Hariprasad Kelam wrote:
> Function "rtw_sta_flush" always returns 0 value.
> So change return type of rtw_sta_flush from int to void.
> 
> Same thing applies for rtw_hostapd_sta_flush
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ------
> Changes v2 -
> 	change return type of rtw_sta_flush
> 
> -----
>  drivers/staging/rtl8723bs/core/rtw_ap.c           | 7 ++-----
>  drivers/staging/rtl8723bs/include/rtw_ap.h        | 2 +-
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 ++--
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 7 +++----
>  4 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index bc02306..19418ea 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -2189,10 +2189,9 @@ u8 ap_free_sta(
>  	return beacon_updated;
>  }
>  
> -int rtw_sta_flush(struct adapter *padapter)
> +void rtw_sta_flush(struct adapter *padapter)
>  {
>  	struct list_head	*phead, *plist;
> -	int ret = 0;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> @@ -2202,7 +2201,7 @@ int rtw_sta_flush(struct adapter *padapter)
>  	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
>  
>  	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
> -		return ret;
> +		return ;

Odd use of a ' ' character here :(

