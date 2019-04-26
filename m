Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060BBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFCF2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="bW0/FZAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDZQTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:19:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38366 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDZQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:19:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id s2so2260025vsi.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieCTVXJiyhcOi2/nx53QZYmt0TZMysNwpvj8N+mOnRQ=;
        b=bW0/FZAtgKs+lLeBUBHHdamPAsF5q9m+uVynVFmBl0kvNbv9EX27+Lw3s0b+fIHf3c
         XwL2tu9/p7Hre+5NXU7YPckqVEgqJNsF9lRwe1TnSJBiHhwBe+cRDBt5NYaWrPhNx+48
         BaODMulleGow3zOlDv20XT8KSWVMg4+QLAgKdHGKkXRAXuMiwNId49TK2GVJPE5A8DEr
         KN4Lyiup+KLXiCzsS/MD7MWLoIcZxRfgArGQ1Q/U4dn+AWkqvn/1+G7TIttkSl291ohQ
         l9qxdeDDiOjvHOXw9OJWtPNnMhNCBXsJ1yXyiK/K28FiYpbCxqfBcfhIA3UDbTRK4Iuk
         rqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieCTVXJiyhcOi2/nx53QZYmt0TZMysNwpvj8N+mOnRQ=;
        b=QSzQF1Agov9j14/oU07AiueEcvZwHysAf7dCIiBvhnBDWXEpyCXPA7yCMHwcFgPnOX
         3PcceYsGZnkCjjtLl46bROrMA0FRTPcpupzA8mUJ7qjsz83V+2GVI2mOzqJIpYwydbfA
         B2kuwVyZW7gxX4PBQGil3yxkbwBOd4zOR6IckKvDd7m9eDiJFyD5e+3BhDJu4BVMffAS
         s/DIeRvWj1oFke5hf7NE+A75hVpFEdga0nNMaGpGX2XQJBofc1/th5daru6W1H5xUDY/
         jKDMIhRnvRrUBi6VDVqr84luIPGjeZOTjaHsEZwWgLAhhdADtVtQOBxwZEBjjTozPb6R
         ez1w==
X-Gm-Message-State: APjAAAUhfiYch9mNrlOBSWP+B1egEUBvbIXHVAmsv0Xka9CQY+7d4sZi
        AZRa8q67yUxWwsxEiG4ASIAbdR1oUywMx1HBlswVmw==
X-Google-Smtp-Source: APXvYqwhh1h9syYELJye7Sn4ywz7DMnDEmcbNl+CgjWYaTiFdGczmCIz9QjLEM1Y4oeTfjiBHungy6G+H8P4in3bw8c=
X-Received: by 2002:a67:f256:: with SMTP id y22mr24121680vsm.19.1556295591010;
 Fri, 26 Apr 2019 09:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
 <20190425143847.417033ab@cakuba.netronome.com> <e540b1c192632dfcf4c0367be133c9ca51f33b43.camel@mellanox.com>
 <20190425193737.131be39f@cakuba.netronome.com> <8bb8a789-c189-df07-5d90-fd8f2fa172ca@mellanox.com>
In-Reply-To: <8bb8a789-c189-df07-5d90-fd8f2fa172ca@mellanox.com>
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Fri, 26 Apr 2019 09:19:39 -0700
Message-ID: <CAJpBn1wN67rTM2Gn-nsh0hTjq6OM2m6DS+BGU-HhSQ5ehn95Cw@mail.gmail.com>
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a work
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 6:04 AM Moshe Shemesh <moshe@mellanox.com> wrote:
> On 4/26/2019 5:37 AM, Jakub Kicinski wrote:
> > On Fri, 26 Apr 2019 01:42:34 +0000, Saeed Mahameed wrote:
> >>>> @@ -4813,7 +4831,11 @@ static int
> >>>> devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
> >>>>    if (!reporter)
> >>>>            return -EINVAL;
> >>>>
> >>>> -  return devlink_health_reporter_recover(reporter, NULL);
> >>>> +  if (!reporter->ops->recover)
> >>>> +          return -EOPNOTSUPP;
> >>>> +
> >>>> +  queue_work(devlink->reporters_wq, &reporter->recover_work);
> >>>> +  return 0;
> >>>>   }
> >>>
> >>> So the recover user space request will no longer return the status,
> >>> and
> >>> it will not actually wait for the recover to happen.  Leaving user
> >>> pondering - did the recover run and fail, or did it nor get run
> >>> yet...
> >>>
> >>
> >> wait_for_completion_interruptible_timeout is missing from the design ?
> >
> > Perhaps, but I think its better to avoid the async execution of
> > the recover all together.  Perhaps its better to refcount the
> > reporters on the call to recover_doit?  Or some such.. :)
> >
>
> I tried using refcount instead of devlink lock here. But once I get to
> reporter destroy I wait for the refcount and not sure if I should
> release the reporter after some timeout or have endless wait for
> refcount. Both options seem not good.

Well you should "endlessly" wait.  Why would the refcount not drop,
you have to remove it from the list first, so no new operations can
start, right?
In principle there is no difference between waiting for refcount to
drop, flushing the work, or waiting for the devlink lock if reporter
holds it?
