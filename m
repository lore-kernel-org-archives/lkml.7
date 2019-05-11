Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F8C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A07217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up8YnEAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfEKH6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 03:58:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45451 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfEKH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 03:58:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so4113814pgi.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQaA5fcRvs5IaqVA9AoxeTKiHpRpWKn2OxP1/dwsWz4=;
        b=Up8YnEAFqQ27j6vsFXS8mDUMbFQj58WAXF+diuSBBfP5dtRoqjcP8pbM0d/BszKOx4
         rhLH88f2b+O3GXwVWOwMwcNm2sbkzash9yuEPgUIMwmKNexrQW+GoOnt8yHHmfoj7wCB
         yDWmiJYAsXHISW5+N9TTLGbWKIPI7VALac9J78ycqsn1SYHPJII6C8ZkUAaZAeAm7UNl
         /cUP0si1Khgzdx+1tTSUCyjbpZeZ60JR7SWJoBiUgs8fUecrHbybefAV4CJ7O29NhKxa
         2phmZE9LRgIX/b934HiGE7NrFBYW2GdXKCKWLaI1q8Mx5epjKX7dA13yY7mfJD5bPKGR
         UpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQaA5fcRvs5IaqVA9AoxeTKiHpRpWKn2OxP1/dwsWz4=;
        b=cB2rILxlANOVVYnWxMk3Wwjx6jOq/IqSnUBicwstoahJH+hg/ZGp3/heq9qZAEJrzj
         CMhEW2+xFyWatBExhM4ccBAEGtH5jNZ9JX0suIMzUOxn5cAYzXJjkpJsa48APcKUhggs
         lyJfQyX2RGz7GvE2vvnFIThZRppY8ROfvxHihpjf8CfhPzbFAhBlQKifgsPwUrwAEIhG
         lwi8CdPlwJ4J+G6NRABS/KEORpamPdIxW+KIKxrXyB6sOZ7YLfkdPKL0TW3czL16o+dw
         VYUKRiQ7aVNN722Ugv05nx42OwHrRmtL5UdVgU+za0ymWmsLH4ZJJx5fzPnsx/KpTOex
         YU8g==
X-Gm-Message-State: APjAAAWwe5fsh+ek0LzuzSqG8oCDMCr+bMVtxX3WShUoeiinD6nHl6vY
        LfXQosqhcqEDgNIbl3Lw2d8=
X-Google-Smtp-Source: APXvYqyA4+E/kRijAqizOl5z6WSpDlb8MgZUtaK+ymaQrNGDYyz9PO5lPtqSpi//yp+ljP4P5zVEDw==
X-Received: by 2002:a62:6f02:: with SMTP id k2mr20548059pfc.136.1557561499736;
        Sat, 11 May 2019 00:58:19 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id c14sm7970466pgl.43.2019.05.11.00.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 00:58:18 -0700 (PDT)
Date:   Sat, 11 May 2019 13:28:13 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: collect return status without variable
Message-ID: <20190511075813.GA17352@hari-Inspiron-1545>
References: <20190510023900.GA4390@hari-Inspiron-1545>
 <20190510105754.GA18105@kadam>
 <20190510172308.GA3075@hari-Inspiron-1545>
 <20190510184011.GE18105@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510184011.GE18105@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 09:40:11PM +0300, Dan Carpenter wrote:
> On Fri, May 10, 2019 at 10:53:08PM +0530, Hariprasad Kelam wrote:
> > On Fri, May 10, 2019 at 01:57:54PM +0300, Dan Carpenter wrote:
> > > On Fri, May 10, 2019 at 08:09:00AM +0530, Hariprasad Kelam wrote:
> > > > diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> > > > index 8a862f7..5dad5ac 100644
> > > > --- a/drivers/staging/wlan-ng/cfg80211.c
> > > > +++ b/drivers/staging/wlan-ng/cfg80211.c
> > > > @@ -231,17 +231,12 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
> > > >  {
> > > >  	struct wlandevice *wlandev = dev->ml_priv;
> > > >  
> > > > -	int err = 0;
> > > > -	int result = 0;
> > > > -
> > > > -	result = prism2_domibset_uint32(wlandev,
> > > > -		DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > > > -		key_index);
> > > > -
> > > > -	if (result)
> > > > -		err = -EFAULT;
> > > > -
> > > > -	return err;
> > > > +	if (prism2_domibset_uint32(wlandev,
> > > > +				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > > > +				   key_index))
> > > > +		return -EFAULT;
> > > > +	else
> > > > +		return 0;
> > > 
> > > We should just preserve the error codes from prism2_domibset_uint32().
> > > 
> > > 	return prism2_domibset_uint32(dev->ml_priv,
> > > 				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > > 				key_index);
> > >
> >    prism2_domibset_uint32 function can return  -ENODEV,-EPERM,-EBUSY if
> >    fail  case.
> > 
> >    If we observe the pattern of calling this function,we can find
> >    
> >    "return -EFAULT on failure and 0 on success".
> > 
> >    Due to this we  can not collect return status directly.
> 
> Yes, I know this code is full of nonsense.
> 
> It shouldn't just always return -EFAULT, it should preserve the correct
> error code.  This is only called from rdev_set_default_key() if you want
> to check the caller.
> 
> regards,
> dan carpenter
 Yes , Caller not particular about -EFAULT,there is no
 need of masking all errors with EFAULT in  fail case. 

 We can directly collect the return status.
 Will  resend the patch with suggested changes

 Thanks,
 Hariprasad k
