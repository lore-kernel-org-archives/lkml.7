Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB4C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE821842
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UotmLHtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfGWHi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:38:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39795 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbfGWHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:38:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so42874417edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7B0kZX39j3W386MkiBK5UtIQjJKLhUJXGNvhcv6FvJM=;
        b=UotmLHtjCylIkscSMrotfIX1/Li5qjbBU2wYwaOu2++8uyWsR2wviLhrtbk9D81NUV
         qfa1fZFnhwaoyKSsCHzf2q6gHNnlF2Q9F6c8BH4WjbNV5Ijw7ivhNnyrmBrOWELPOkXL
         67diRvPht3Ri71Ku1n1tB/k+cTWzW/xAZUqiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7B0kZX39j3W386MkiBK5UtIQjJKLhUJXGNvhcv6FvJM=;
        b=QEK5hyEhr/3oxvFF+afrvUBzuv+K9q/vsBBRBb3Jei2Ij0ECg7PpmA+vcpzxj5MVvD
         7oQX4Ibs74qNgCYSP+Qlgx0b5Yijz1yLjL0mRmIfCbhWvXF4sWV0JQwuP0yizeX9oC9g
         xUeXcghFIjJ6cLHpAa9BBO93zCYFQwJy/IF/PNULWHu5EJlKTv8Gh3LJlzJHb8QPC9HF
         VLMc+n1eS0/VzvPI6kZ6Yg0jfq4K8rmm4SpMRJ8+pdD1NkEyC0ZiZmIV0gPCzuI+AExp
         TGrk7DFfZmuGocIPI4sDgYwvBtwGTMeX0Wtk7lSg0G2P46Nb0l3SLsT+7YKPzhi4VpBV
         iIYg==
X-Gm-Message-State: APjAAAWkteeMVvTz/ramIbnYs70N/TbkRg07ndHZcSqVq/ymc1vTQHDv
        9/6NPSMJv5qdh/NlKKnRQ6Q=
X-Google-Smtp-Source: APXvYqwF4gFYfyab0NSDDcoxUf0q4mq+1/ft/cvJV0XQFBad+3aIdLa/PEUi1UMzB5ntGyuBECBlJw==
X-Received: by 2002:a50:fa05:: with SMTP id b5mr63382580edq.269.1563867503924;
        Tue, 23 Jul 2019 00:38:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm12035831edd.91.2019.07.23.00.38.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 00:38:22 -0700 (PDT)
Date:   Tue, 23 Jul 2019 09:38:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jens Remus <jremus@linux.ibm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] vt: Grab console_lock around con_is_bound in show_bind
Message-ID: <20190723073820.GU15868@phenom.ffwll.local>
Mail-Followup-To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20190718080903.22622-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718080903.22622-1-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Do you plan to pick this up in your console/vt/whatever-fixes branch?
There's no reason for me to route this through drm-fixes.
-Daniel

On Thu, Jul 18, 2019 at 10:09:03AM +0200, Daniel Vetter wrote:
> Not really harmful not to, but also not harm in grabbing the lock. And
> this shuts up a new WARNING I introduced in commit ddde3c18b700 ("vt:
> More locking checks").
> 
> Reported-by: Jens Remus <jremus@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Martin Hostettler <textshell@uchuujin.de>
> Cc: Adam Borowski <kilobyte@angband.pl>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/tty/vt/vt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index ec92f36ab5c4..34aa39d1aed9 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3771,7 +3771,11 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
>  	struct con_driver *con = dev_get_drvdata(dev);
> -	int bind = con_is_bound(con->con);
> +	int bind;
> +
> +	console_lock();
> +	bind = con_is_bound(con->con);
> +	console_unlock();
>  
>  	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
>  }
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
