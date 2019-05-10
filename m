Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E2FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BB21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1dJasqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfEJRXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:23:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39191 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfEJRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:23:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so3323863pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKTqfFOYYmSMRtaxYzh3rDlijcoMoye7aE2PTxLgk+M=;
        b=t1dJasqSSqrY0/mFV00RuccD2sYzP9oFsunitbSpAuSt1fNb9B4gI6obiOEsrvCosV
         XetVN/B4ciIH1wZX1get32F9AQd8t2a9d3gDP6AsPv3LB7INIxqdRgULFZOg05v8SUV2
         KWoVRoYp6OlQIjeJLPPgstr3MrvBzHD8WilxhrUTrcyH4jaP8+SgYt9Pp++Gkn017VTz
         QVFigekAt09Z0tBuJPkW4jcL2JtPYquudkMRHyi5UNokSas+Y3ob+mQxcPk1CLxOGQZw
         jtnaKMmOT+VLV+ndXd/zaRkkQpu4bTgVytF0r6ZcaddFPo5gAeOqVEYO0OBPU4HQwaVd
         Y4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKTqfFOYYmSMRtaxYzh3rDlijcoMoye7aE2PTxLgk+M=;
        b=fkkpfIJcL0itplV05cxX6d7CKyMVubopIKxyW/l99UnSu5upKhp+QdYzTyn9SzM43F
         jmpG79vkeOghNd5psl0BEe7om2VCsyV5bpsmFKL7WHN+9JWBjuXU3BQp4LZlhM2G1HzQ
         Vyk1tagoRhzVzfIG4cGIbTi2pIXWbzf/jGRqPDcQYWsngFQ0PuWG0WZ1chRzvY+NS+8s
         gKh3FyxWorzXhFZLDKM4X3QQil0qtoytNL6BYn+N5tsaQvSsuj3qAz1XzxQKUW65cdAk
         oxb9w94sQpuRyg+ac0zLxYtgDlGhqCpCgYqn04n77oaqCTtT0VT0CuE9MKk2L35wJ+oO
         CMFQ==
X-Gm-Message-State: APjAAAVSDKf9tuZgTh+hvmQ2TIpBBdUUG2S+9+BWDl4wBwLIXtH/xuXQ
        K07aHeJWWcgY/4hj12/4WqA=
X-Google-Smtp-Source: APXvYqz/c5oedmTv7OXut2ZRscRfwnPG32MfuwyJponuIrspwqX1LA8WYBs8p7OnuJHVzPSao12rNA==
X-Received: by 2002:aa7:9206:: with SMTP id 6mr15840843pfo.71.1557508993973;
        Fri, 10 May 2019 10:23:13 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id z9sm6220113pga.92.2019.05.10.10.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 10:23:12 -0700 (PDT)
Date:   Fri, 10 May 2019 22:53:08 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: collect return status without variable
Message-ID: <20190510172308.GA3075@hari-Inspiron-1545>
References: <20190510023900.GA4390@hari-Inspiron-1545>
 <20190510105754.GA18105@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510105754.GA18105@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 01:57:54PM +0300, Dan Carpenter wrote:
> On Fri, May 10, 2019 at 08:09:00AM +0530, Hariprasad Kelam wrote:
> > diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> > index 8a862f7..5dad5ac 100644
> > --- a/drivers/staging/wlan-ng/cfg80211.c
> > +++ b/drivers/staging/wlan-ng/cfg80211.c
> > @@ -231,17 +231,12 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
> >  {
> >  	struct wlandevice *wlandev = dev->ml_priv;
> >  
> > -	int err = 0;
> > -	int result = 0;
> > -
> > -	result = prism2_domibset_uint32(wlandev,
> > -		DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > -		key_index);
> > -
> > -	if (result)
> > -		err = -EFAULT;
> > -
> > -	return err;
> > +	if (prism2_domibset_uint32(wlandev,
> > +				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> > +				   key_index))
> > +		return -EFAULT;
> > +	else
> > +		return 0;
> 
> We should just preserve the error codes from prism2_domibset_uint32().
> 
> 	return prism2_domibset_uint32(dev->ml_priv,
> 				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
> 				key_index);
>
   prism2_domibset_uint32 function can return  -ENODEV,-EPERM,-EBUSY if
   fail  case.

   If we observe the pattern of calling this function,we can find
   
   "return -EFAULT on failure and 0 on success".

   Due to this we  can not collect return status directly.
> regards,
> dan carpenter
> 
