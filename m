Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2798C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B651B21906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH4Z8wwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfIRGO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:14:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40530 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfIRGO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:14:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so3652443pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VLD4T4j6CkFnw+yLOSt4lxWLxJlglbtXkL6PJrDavs=;
        b=DH4Z8wwFPfwMMvrzBvq7aENKUnQTudeD8psgUXMgs8wQbs/3KHt2oQ30ar5PknDbkK
         1Ejs0D3Q5wT+WPpbySeeiCUzvmrlt8k7QMHVu9wxfmw79u6nQBKmsZj9m6bmYYe/9wvi
         BAmQ5sr5esPjfMTGdzbJ+WPOkv6mqJQJfyd1o9D0o+YxgnIEJJKMSmu/T+d0iBdPck+D
         tl4x3u450xj1o0fwmTqEPgq10UFjPQD4IqY43epcbGGAW0fMHANWD7WKOk97uOAFHxyQ
         vBDxi5bZX5pbCZN3ViBmuMYQikDsFXT3gNqsM8IfZPsCWFrcF8tKcNRo5eqiwF2zvlKy
         He0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VLD4T4j6CkFnw+yLOSt4lxWLxJlglbtXkL6PJrDavs=;
        b=czmtiOGoMAorGYMEEChuQGTT+D4zkyvXosznlxzOIgUXnnXvjmEpBw9Dk6cNcJtE1W
         DoBdqkplEnqJaDU+AvV9mctHHE1HMPdIGZUVtUIifmHXq+jwXsuVodTZc8A7CJttlTkL
         xvATLnhBd6Sy+/WnoFmyYM3eM2gRrpqr+1Xw3z621E2k8fUKM0XdtertZtzapLUIfKrd
         ra580QJ0TF8JAX68u3mOHrk8gLnCjYJq1JE3qgYynLEf9oQxcyPQI8zgMtuKkQI+Xkmt
         SSiqwvicQbCMJirruU9IWWdSjwL8xvxxYaiHzmjZUdBxfR1aQlwRmHuf/orvby2hxZhr
         m+3Q==
X-Gm-Message-State: APjAAAXJ331YYnkq+0Y8EZCTGUA1fljSXmcAKblvxC+LxiE0WOGqe5D5
        KiXrSidWyxln5V7A/n5yDnuJLzEY8cY=
X-Google-Smtp-Source: APXvYqwfsvwJhZB79moBclIo4UaUxsph4fJCrX8oQCQXsE0B5QQJdahsPtdE8Lon4onl9hUMl2lXPA==
X-Received: by 2002:a63:2a87:: with SMTP id q129mr2485393pgq.101.1568787295612;
        Tue, 17 Sep 2019 23:14:55 -0700 (PDT)
Received: from aliasgar ([219.65.62.52])
        by smtp.gmail.com with ESMTPSA id f14sm7424905pfq.187.2019.09.17.23.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 23:14:54 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:44:50 +0530
From:   ABC XYZ <aliasgar.surti500@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:staging:rtl8723bs: Removed unneeded variables
Message-ID: <20190918061450.GB8416@aliasgar>
References: <1568730691-954-1-git-send-email-aliasgar.surti500@gmail.com>
 <20190917144432.GB2959@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917144432.GB2959@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 05:44:32PM +0300, Dan Carpenter wrote:
> On Tue, Sep 17, 2019 at 08:01:31PM +0530, Aliasgar Surti wrote:
> > From: Aliasgar Surti <aliasgar.surti500@gmail.com>
> > 
> > coccicheck reported warning for unneeded variable used.
> > 
> > This patch removes the unneeded variables.
> > 
> > Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > index d1b199e..fa3ffc3 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > @@ -2428,8 +2428,7 @@ static  int rtw_drvext_hdl(struct net_device *dev, struct iw_request_info *info,
> >  static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info,
> >  						union iwreq_data *wrqu, char *extra)
> >  {
> > -	int ret = 0;
> > -	return ret;
> > +	return 0;
> >  }
> 
> Just get rid of the whole function.  Replace the pointer in the function
> array with a NULL.
Okay, I will get rid of unneeded functions and replace them with NULL in
function array.

Thanks,
Aliasgar
> 
> regards,
> dan carpenter
> 
