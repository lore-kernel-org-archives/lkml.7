Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C85C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D93E21835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL7s+/2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfJKRcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:32:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41760 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfJKRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:32:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id q9so12805734wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/9IsMNxXFpzgpaplMTTJNjUfGAJXf9fbcKoKx8v53Q=;
        b=WL7s+/2G59mCB7nzctnOqljGY5l3+vfIxsjDB1xjUGn9W7OrilZecpTx+TJoktRsJd
         f7JyMOJFERcwQZsHG/a5dVTUde/b0hszrKiiZZ8GKnRqPXCEoJb/KNUo14/cWQ/BdLm1
         jdaTdwmL0ywJKU4uWiovnSf4uQfvJu29PyH7yg1oKVjL8Z3arn3tOYdDonL/nBI2bRJl
         NoHsvddfeptwaTpVENqHKY+V+ZxhIgTrzdchtMart28BJJ3+7x1tu8Ty8Mithkz41iFJ
         4jOhLw2A5+zjTcS/ltGBgaJViHohT6TqDcBjdf2P/Yvgy1y5knUFK8QYB8w3LRjV3k4x
         Dc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/9IsMNxXFpzgpaplMTTJNjUfGAJXf9fbcKoKx8v53Q=;
        b=fZ8h7W4gP8mkqBtBUvrq4vFVNI0xmxUluKtmixffQB4DekIiPr6Lm2FIx4TZR0AZTW
         Byvqs9QQbpu51hHn/KW1q48jFKWk2XKcvezMv6tvlGOEHbIyLgpv7ls3t/em4lqV8Oml
         2UcFVlS18JgMvVLxCwI0RjE06kGFAjs8xP/RIKsthPqMHu7sDxLuduiAxZJmEFye/ZDW
         cIqybvLDdwLzl9Zu3tdmujUWhrP8vnpLTi/Uh4/hQpy9lMsVl0847noejce5Z5nCbmXE
         e884CDvp7LntvSffugegnlBOnkChR9eYAXKCm5w3T4vTl2yBsvJxJtzb9pLlTVJsiN3F
         7YNw==
X-Gm-Message-State: APjAAAUpu0cXbT4hyxnOD/zK6fm5ewhfKfQeHUfBKil3Ju1ZdmWTO5m1
        ZeOwqhMPeCYnzvT7u8ClCKI=
X-Google-Smtp-Source: APXvYqymkSwChXeABQJrUI9s4HLxbJ/o1Zyz9uPvLUOLFFmi5YpbAc520SKpMEqYIBYeN7E3WK866Q==
X-Received: by 2002:a5d:6b0a:: with SMTP id v10mr13374449wrw.32.1570815164747;
        Fri, 11 Oct 2019 10:32:44 -0700 (PDT)
Received: from wambui ([197.237.61.225])
        by smtp.gmail.com with ESMTPSA id r140sm13122626wme.47.2019.10.11.10.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 10:32:43 -0700 (PDT)
Date:   Fri, 11 Oct 2019 20:32:38 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [Outreachy kernel] Re: [PATCH v3 1/4] staging: rtl8723bs: Remove
 comparisons to NULL in conditionals
Message-ID: <20191011173238.GA22411@wambui>
Reply-To: 20191011120847.GB1143018@kroah.com
References: <cover.1570712632.git.wambui.karugax@gmail.com>
 <f4752d3a49e02193ed7b47a353e18e56d94b5a68.1570712632.git.wambui.karugax@gmail.com>
 <20191011105404.GA4774@kadam>
 <20191011120717.GA1143018@kroah.com>
 <20191011120847.GB1143018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011120847.GB1143018@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 02:08:47PM +0200, Greg KH wrote:
> On Fri, Oct 11, 2019 at 02:07:17PM +0200, Greg KH wrote:
> > On Fri, Oct 11, 2019 at 01:54:04PM +0300, Dan Carpenter wrote:
> > > On Thu, Oct 10, 2019 at 04:15:29PM +0300, Wambui Karuga wrote:
> > > >  	psetauthparm = rtw_zmalloc(sizeof(struct setauth_parm));
> > > > -	if (psetauthparm == NULL) {
> > > > -		kfree(pcmd);
> > > > +	if (!psetauthparm) {
> > > > +		kfree((unsigned char *)pcmd);
> > > 
> > > This new cast is unnecessary and weird.
> > 
> > Ah, I missed that, good catch.  I'll go drop this patch now.
> 
> And that caused the second patch to get dropped as well.  I'll just drop
> them all, can you redo the whole series please?
> 
> thanks,
> 
> greg k-h
> 
The cast seems to have been removed earlier by Nachammai Karuppiah and
added to staging-testing, but I added it back when I cherry-picked my changes to the new
file. 

Sorry. :(
I can remove the cast and send a new series.
Thanks.

wambui karuga
