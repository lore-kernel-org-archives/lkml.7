Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1B7C5B57D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 01:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA9521743
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 01:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjWI+SkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfF3B3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 21:29:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45483 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF3B3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 21:29:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so4781657pfq.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZNWaDjrK6/UUo0Yn+Kol/kvDDH8w6BRoqTUeivhOSU=;
        b=qjWI+SkRFtEm9Wjs9fU3xGLpqIyn6jcDXKelm5OysyaMAqSOxMYNMNgTPjGfNI35ZM
         RFqCNekTWzQxZUnEyFUHB2quWJtkHVapDiazXw9NLHL4KlKmUL2Rb79iceuI1zBHALqJ
         6BpZGsGYgoeKkczSx47GKdWCNG6fnT30exl4OMKr+QD5F+FBn4fnHwydeWJpSmkpga4s
         QABX1ISMgPWXKpNJzKJtp7hbEWzFUjNeQSJlTuUZYigAdshiy3nE6oiKmMslqb3mOHdO
         q/sQpsOHy+RcwHSEZytvmriBo66/qLMHGXTLA0EOOqxUZ2e3VLqD+22hU9sOKNbUHDvN
         d0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZNWaDjrK6/UUo0Yn+Kol/kvDDH8w6BRoqTUeivhOSU=;
        b=rV44YLlUYGeWK/HaS+sS++hNPBuR4NLnaH1p66MYzrDqXLa61HaMIKzpEl6cepO+K4
         GGi3bdBx212PB1dsBdccwWpddDsVYrqNnWRoNi2Ld/WDUfJ9gdtXV6T6jj8NTKdTCAwg
         Yyz/kFj7qCDbX9p3HVAGrlo6oRVRse5SOecTgzNX6ddUeDxg9EWdOoHtElWSi6rfSVhS
         5Kdr0R/B2MTI+slRriKtWCv1ZlIhG2k7iua3Jc25ZpzEykwRLKmT8H6iR1YdZ+DBfgtd
         Q12oOhndcyzserb4IdWQNF+EuelidGCRmw1YmuuAmIyHateEqLL3JSZtaRU/CHDTqpjy
         BlzA==
X-Gm-Message-State: APjAAAWmjKvWHNAmaUvapOwWJHYTZmdI2NP6gAvQYgyQjU2bExRjKUOb
        FtwWU+16fkhlIS12vjslyNE=
X-Google-Smtp-Source: APXvYqybY2U4+o74CvmYUyIniiYmy0ZUjDo2XSRK1J4zPhTOqctVTn2A9UEtOL9mnyS/MBCTW0zVfA==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr22126251pji.136.1561858161574;
        Sat, 29 Jun 2019 18:29:21 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id h4sm5655416pji.24.2019.06.29.18.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 18:29:20 -0700 (PDT)
Date:   Sat, 29 Jun 2019 18:29:18 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] staging/rtl8723bs/hal: fix comparison to
 true/false is error prone
Message-ID: <20190630012917.GA21923@t-1000>
References: <20190629103751.GA15649@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629103751.GA15649@hari-Inspiron-1545>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 04:07:51PM +0530, Hariprasad Kelam wrote:

Hello Hari Prasad,
Please add the recommended reviewers mentioned in the TODO file of 
rtl8723bs directory.

I see the following emails in the TODO file.

Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
Hans de Goede <hdegoede@redhat.com> and Larry Finger
<Larry.Finger@lwfinger.net>

> fix below issues reported by checkpatch
> 
> CHECK: Using comparison to false is error prone
> CHECK: Using comparison to true is error prone
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/hal_btcoex.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> index 66caf34..99e0b91 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
> @@ -290,7 +290,7 @@ static u8 halbtcoutsrc_IsWifiBusy(struct adapter *padapter)
>  	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE) == true) {
>  		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
>  			return true;
> -		if (true == pmlmepriv->LinkDetectInfo.bBusyTraffic)
> +		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
>  			return true;
>  	}
>  
> @@ -310,12 +310,12 @@ static u32 _halbtcoutsrc_GetWifiLinkStatus(struct adapter *padapter)
>  
>  	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE) == true) {
>  		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
> -			if (true == bp2p)
> +			if (bp2p)
>  				portConnectedStatus |= WIFI_P2P_GO_CONNECTED;
>  			else
>  				portConnectedStatus |= WIFI_AP_CONNECTED;
>  		} else {
> -			if (true == bp2p)
> +			if (bp2p)
>  				portConnectedStatus |= WIFI_P2P_GC_CONNECTED;
>  			else
>  				portConnectedStatus |= WIFI_STA_CONNECTED;
> @@ -372,7 +372,7 @@ static u8 halbtcoutsrc_GetWifiScanAPNum(struct adapter *padapter)
>  
>  	pmlmeext = &padapter->mlmeextpriv;
>  
> -	if (GLBtcWiFiInScanState == false) {
> +	if (!GLBtcWiFiInScanState) {
>  		if (pmlmeext->sitesurvey_res.bss_cnt > 0xFF)
>  			scan_AP_num = 0xFF;
>  		else
> @@ -1444,7 +1444,7 @@ void hal_btcoex_IQKNotify(struct adapter *padapter, u8 state)
>  
>  void hal_btcoex_BtInfoNotify(struct adapter *padapter, u8 length, u8 *tmpBuf)
>  {
> -	if (GLBtcWiFiInIQKState == true)
> +	if (GLBtcWiFiInIQKState)
>  		return;
>  
>  	EXhalbtcoutsrc_BtInfoNotify(&GLBtCoexist, tmpBuf, length);
> -- 
> 2.7.4
> 
