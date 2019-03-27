Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76FAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DB42082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohrKx+qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfC0WcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:32:21 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42266 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0WcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:32:20 -0400
Received: by mail-yw1-f65.google.com with SMTP id e76so13769990ywa.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xxrn+6lWKdN3VtMt5DZB0MV+9mf4mrlW0nf2Ywotzgo=;
        b=ohrKx+qnlSUFIC1ZMEbIwHK+2rGlBu80hISTEgyrs87LPx8bcWOqja/vEDHOzJdRP0
         dzTyjIut2rBxMdxy9CVxEnatqsYE8vNc1YFqwKbF0tKqcFxh4h/mPpsDZlvQSq5dCQsy
         NGx30MvyZ688iirhxRL+ZMtpeqtL62B2YW93+MFkfmJospkqh/ELF7jmWaZ6piUIOK6c
         iq3IA25hiBnbWQiD2vvyzup1+Dus6zf2PhpccFrCDT+e5PpgzpLoKFBlHVygzLD0sO22
         bjBkxarjZqVWFFe5bsAIBKofc1Zwh00Gur4KqknLrO9xfwc4Fh7esydiZh7/luV1K0Hx
         d1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xxrn+6lWKdN3VtMt5DZB0MV+9mf4mrlW0nf2Ywotzgo=;
        b=Ny4dB0+D3Xje9zSBOqUa1ILcMRTwbF5TIqjm+j2g3j+x5fa6xNMWIzpd3Qt/vYLzdb
         KGzRjGy21mctTZFHg2Cu+Enb6mcPxoxtXbI/JBSCF/J4/FvezV3xyDh/yKOLBHUvrdOV
         ox9GpEmvVdb/CJwdbmGvxY9+tsJ+06YA7Z9VXnXh0a0dCzmwkHaN6tYTpvOj0TqBdqU4
         CIJue8m3rgQQBxSn86urvsx6FHhSYYfWe4/8omjmgrrktwIm8GVJTtm7UM4LULeGjjW5
         FRYLpw71Re4XIWivEb30PPNfmcoXscfId8tCZ43Q71ipZ1j2XB38e1Dk2sdZNhbO/DvZ
         UN6g==
X-Gm-Message-State: APjAAAVWE2IKipbo17dmcpXQw5d/m8+0aV2D8p9RkxHVDtFIh6GV62vi
        qaGDJx+wsjAWyggIuU0cWvg=
X-Google-Smtp-Source: APXvYqxndipJM908DW2/rLUML4cjFLyGw0MF7St7isY5pxO9tXEPxw8u4XCux988NNSe2u+tuSv8pQ==
X-Received: by 2002:a81:3791:: with SMTP id e139mr33041179ywa.476.1553725939932;
        Wed, 27 Mar 2019 15:32:19 -0700 (PDT)
Received: from gmail.com ([2001:420:302:1320:c57c:411b:6ffb:6a6c])
        by smtp.gmail.com with ESMTPSA id f190sm21101320ywb.98.2019.03.27.15.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:32:19 -0700 (PDT)
Date:   Wed, 27 Mar 2019 15:35:45 -0700
From:   Julius Hemanth P <juliushemanth@gmail.com>
To:     gregkh@linuxfoundation.org, johnfwhitmore@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        juliushemanth@gmail.com
Subject: Re: [PATCH] staging: rtl8192u: ieee80211: ieee80211_wx: add space
 before open brace
Message-ID: <20190327223537.GA4786@gmail.com>
References: <20190327215327.GA2802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327215327.GA2802@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:53:35PM -0700, Julius Hemanth Pitti wrote:
> Fix checkpatch error "ERROR: that open brace { should be on
> the previous line" in ieee80211_wx.c.
> 
> Signed-off-by: Julius Hemanth Pitti <juliushemanth@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> index fa59c71..ebcc642 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> @@ -195,7 +195,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
>  	if (iwe.u.data.length)
>  	    start = iwe_stream_add_point(info, start, stop, &iwe, custom);
>  
> -	if (ieee->wpa_enabled && network->wpa_ie_len){
> +	if (ieee->wpa_enabled && network->wpa_ie_len) {
>  		char buf[MAX_WPA_IE_LEN * 2 + 30];
>  	//	printk("WPA IE\n");
>  		u8 *p = buf;
> @@ -210,7 +210,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
>  		start = iwe_stream_add_point(info, start, stop, &iwe, buf);
>  	}
>  
> -	if (ieee->wpa_enabled && network->rsn_ie_len){
> +	if (ieee->wpa_enabled && network->rsn_ie_len) {
>  		char buf[MAX_WPA_IE_LEN * 2 + 30];
>  
>  		u8 *p = buf;
> @@ -766,15 +766,13 @@ int ieee80211_wx_set_auth(struct ieee80211_device *ieee,
>  	case IW_AUTH_80211_AUTH_ALG:
>  		//printk("======>%s():data->value is %d\n",__func__,data->value);
>  	//	ieee->open_wep = (data->value&IW_AUTH_ALG_OPEN_SYSTEM)?1:0;
> -		if(data->value & IW_AUTH_ALG_SHARED_KEY){
> +		if (data->value & IW_AUTH_ALG_SHARED_KEY) {
>  			ieee->open_wep = 0;
>  			ieee->auth_mode = 1;
> -		}
> -		else if(data->value & IW_AUTH_ALG_OPEN_SYSTEM){
> +		} else if (data->value & IW_AUTH_ALG_OPEN_SYSTEM) {
>  			ieee->open_wep = 1;
>  			ieee->auth_mode = 0;
> -		}
> -		else if(data->value & IW_AUTH_ALG_LEAP){
> +		} else if (data->value & IW_AUTH_ALG_LEAP) {
>  			ieee->open_wep = 1;
>  			ieee->auth_mode = 2;
>  		}
> -- 
> 2.7.4
>
Sorry for typo in commit message, please ignore this patch.
Will send updated one as v2.
