Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C7FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4BB206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="swQlCevC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfDZCho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:37:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42819 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbfDZChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:37:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so2501378qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Dmt86cvAtAKBxNH5qe3yzo7tNTPBM5j4xs//7OU8lNU=;
        b=swQlCevC/BDwMOtwX1AFdQBwadRT2sG2XrgFaTVYn9D6dWzId9g/6Fcj7xIkx4x4j0
         +vB8SGlksa8DtMmKhE+xOJPt5jC6L+UxNIKnw7LyuFLEMDRBAUh6JHQ9N13EkiGEYLmq
         5Kga85CShqXbIGV+YkqHDbd/fM2aNXCutXPaGI1nCX3YKzDvu7EJlPC6c63/mmXCd13q
         LlhPc4DhtoMgcQM2cJH8kGViTKa5UkGqXeTe3U7Qv6cW/5In2G+QP2dZVp7zLWUT5dA4
         HQ/vsbhrPFJuTTOWEjQQPPP6bSW4246cGD9riC+pMr/572dMEUsIX0F0t1iIwVnJkvc7
         va9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Dmt86cvAtAKBxNH5qe3yzo7tNTPBM5j4xs//7OU8lNU=;
        b=GVIIU4gV8Z+CJVFDVTYrINsGFcV+J4+BiypdYfT1uItnFHcqiLbnbVnc8Wl7410LO7
         R5/QVL94Rn8/ezYM0avnQrVsoDMiZeLbTVj2WJ4J+e+G98gEv8Au7AjUOrbRQFCYW5yZ
         C4tbeOngLSUSudDJf+Pp77U/ZBInqww0EtASnd7JCvtVg0/mF3eSzD4vHesBFPtBuqAV
         3i8Bh0xLCuO8Y338/61rlPZffcah4JfQUyurmJWzvXe0BjbffQRlE1fjXKDYA+nLAJgi
         i3iN3dN9ahgez0t7CCwzJN46i7bU1ISSNJFGotWzcddEMC2SdH8e2jMpobZJxCG0N6zH
         m4Ug==
X-Gm-Message-State: APjAAAXQBxppy0Zu9/8uavgIQL9dWlMAXkNDjgC+M5NRRelyZVLEZtme
        1Eznxr0pnmnFMR3Zk8xoSw/KJdC03aY=
X-Google-Smtp-Source: APXvYqwbeQZy+YtvbvBua5Qp4ztaknJZbk889BorpNYMjQDiRvIks2hVU1yV7v9t/3PjugTYcyU6Lg==
X-Received: by 2002:ac8:2234:: with SMTP id o49mr2911305qto.104.1556246262764;
        Thu, 25 Apr 2019 19:37:42 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id g17sm192646qki.61.2019.04.25.19.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 19:37:42 -0700 (PDT)
Date:   Thu, 25 Apr 2019 19:37:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Message-ID: <20190425193737.131be39f@cakuba.netronome.com>
In-Reply-To: <e540b1c192632dfcf4c0367be133c9ca51f33b43.camel@mellanox.com>
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
        <20190425143847.417033ab@cakuba.netronome.com>
        <e540b1c192632dfcf4c0367be133c9ca51f33b43.camel@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 01:42:34 +0000, Saeed Mahameed wrote:
> > > @@ -4813,7 +4831,11 @@ static int
> > > devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
> > >  	if (!reporter)
> > >  		return -EINVAL;
> > >  
> > > -	return devlink_health_reporter_recover(reporter, NULL);
> > > +	if (!reporter->ops->recover)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	queue_work(devlink->reporters_wq, &reporter->recover_work);
> > > +	return 0;
> > >  }  
> > 
> > So the recover user space request will no longer return the status,
> > and
> > it will not actually wait for the recover to happen.  Leaving user
> > pondering - did the recover run and fail, or did it nor get run
> > yet...
> >   
> 
> wait_for_completion_interruptible_timeout is missing from the design ?

Perhaps, but I think its better to avoid the async execution of 
the recover all together.  Perhaps its better to refcount the 
reporters on the call to recover_doit?  Or some such.. :)
