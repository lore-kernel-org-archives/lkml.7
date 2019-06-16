Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A27BC31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63389216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 13:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo2EMpLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfFPNLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 09:11:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43298 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfFPNLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 09:11:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so4154885pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxZ+Tk0X6SPqfPiZxIA7txr1wUPFjNoghrc0Yyk1PNQ=;
        b=uo2EMpLfGTxezUo9alrCiGtf8O0ESd4MXXvxtjgAYPYDzHa1MTki5GAz7pVg95r3R0
         i95S8LRgz8CGvAMmc2uUeXOfiWzzWyim2HOzYpcCjs2Tg/zl6zgX7zXSWFrHTNqnqroQ
         hoohG4GAEq0hUcWcV4BU72odZgoqetR1fjxHaQDWWZAHB0PFB8ziq2/ZyVe/K9VNEPAX
         pHk+/Soxafj6+Cl7pNh/FrGE1OzJZgYIN1VbKBsE90g4RdRsCGFnFY7Ugav8c1Oprhsl
         IRpFCCVuOe0yLAjh2cg6XQOuFtrbNEwm+fjnQMk7FxViRCG45cnMrI46PBWMzJkPyu2d
         1JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxZ+Tk0X6SPqfPiZxIA7txr1wUPFjNoghrc0Yyk1PNQ=;
        b=GTBSNqkcjBWBIwT7xKgZo1JPYwAwXXijABGnLvYINm6D0IKjMCtOfyi7ZwChu18Oc3
         5PCyHUk9XpgvLYSKMv28sAM47qsCeMo1dDRw/6ognlVB8VA+ao1WBnP98ciwxop20HjB
         EdJy2eBGD2HALkf+1OfA7+5EYBGPF63H1h3l9vi1o5LAxAS2yll2vvOlWe9sw95qFrxQ
         kPqwIX4izQlQvQzOu+f2Jutbyy7sFCmV65EHLBAEp0KyKdBOkgCUUwYGe3U0SccEeo10
         fFng/KbuvtCVgEZpojd80ckMbnr0qXraTQgY904B9Z4Bgj7em19VN47pdnrsM32QUQH8
         pjEg==
X-Gm-Message-State: APjAAAUg3/1wufmB+tMXdUYX4hfiBaXwMTlJ6BAmgvOURLOUPre+sAs8
        PangpGFDbmO8E1I+iAyVHNI=
X-Google-Smtp-Source: APXvYqx1vNZbmGWsuMR4yX5Z4VKVvPaz584kQ/W9sIQv3cXofMflgQpUVJQ9iTy3eg1okt/QZRoSnw==
X-Received: by 2002:a17:90a:8415:: with SMTP id j21mr20906421pjn.21.1560690710016;
        Sun, 16 Jun 2019 06:11:50 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id b15sm8442262pfi.141.2019.06.16.06.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 06:11:49 -0700 (PDT)
Date:   Sun, 16 Jun 2019 06:11:46 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: Resolve checkpatch error "that
 open brace { should be on the previous line" in the rtl8723 driver
Message-ID: <20190616131145.GA30779@t-1000>
References: <20190615185355.GC10201@kroah.com>
 <1560634159-9015-1-git-send-email-shobhitkukreti@gmail.com>
 <1d668acbce4cc9759cc940f56016dc9437df5441.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d668acbce4cc9759cc940f56016dc9437df5441.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 01:13:11AM -0700, Joe Perches wrote:
> On Sat, 2019-06-15 at 14:29 -0700, Shobhit Kukreti wrote:
> > Cleaned up the code from the following files to get rid of
> > check patch error "that open brace { should be on the previous line"
> 
> It's fine you are modifying brace styles, but:
> 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> > index aa2499f..4631b68 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
> > @@ -46,8 +46,7 @@ void rtw_os_indicate_connect(struct adapter *adapter)
> >  	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
> >  
> >  	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
> > -		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true))
> > -	{
> > +		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
> >  		rtw_cfg80211_ibss_indicate_connect(adapter);
> >  	}
> >  	else
> 
> the else should be on the same line as the close brace
> 
> > @@ -106,8 +105,9 @@ void rtw_reset_securitypriv(struct adapter *adapter)
> >  		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
> >  
> >  	}
> > -	else /* reset values in securitypriv */
> > -	{
> > +	else {
> > +		/* reset values in securitypriv */
> > +
> 
> and here.  etc.  Please change all instances appropriately.
Thank you for the feedback. I intented to do one kind of change in a
patch. This probably would need a patch set. Will edit appropriately. 

Best,
Shobhit Kukreti
> 
> 
