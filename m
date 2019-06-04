Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B57AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2632F24BF6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559648005;
	bh=OPostoc411XPjd+tuveu7IOuZcwBbBmnSumbimGn8ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bvHTy5b3ddDlyowymmESmcXfjN0LXOzN8T+IA0j84731kF02dR+l7lZjeA1K2Y5u1
	 RlX4WsJtBl3z+5YjTgFJyRuyy2WN0swBHyebx1dhykOZ+mScngbXWIU4R3maGuseES
	 V0kyawt8FnEGElup3A3I9cDb+QhfZAv/aKOhPUt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFDLdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:33:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42018 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfFDLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:33:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id i2so18183499otr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 04:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+q7Ysbwd1XPsPRSOkDxQCRyvRpcAYnJVG/Rfva4DCjI=;
        b=F+jhV6PLqfi/AFKUClfvWTLzJode4OQ6tuVmOG6uh6ii7d9250Hh8WiLNTMzIxa81G
         ZG86k/4kvruBPvLWYPETeDx7q/qPHl+gw10JlHrKsFSdeDR6n/5xeenOo+g5gAZqmRRp
         Qq24/dNsLLKqMoO/rdVRtnXQcEzg4Lu7PCVn9hATamhPzSYjySDha//komFCqpU7OpqK
         aF2dU9FL0/pr6aS4eMGxSS2ikHpsdUoIDB4pp2Mi+UfNiGiWuNf0OgtbdFvMP9jfn9DT
         biyOc88D5OBVosZ73WFs9GquHdUMIPwQPGbAam7axe5j6FLX+Svq7Z0dSd88xWXH2VNM
         PyZg==
X-Gm-Message-State: APjAAAVAdi3Z87/HT8x/vhFmjujSO0DEd6i1JfvLopmR7yjj6W9DWZT6
        pfnUiI6BLiSvcyWzDiGK4aTkbiu3KnXtEb1zm86cotI2
X-Google-Smtp-Source: APXvYqzYaNVQWto5qtisz9QJ5uFinjKQsB8wdidiADdboSs1zOrFp5nbt928QKm0+hkhF2XBtd17sM1yZ87lKiujU9s=
X-Received: by 2002:a9d:3285:: with SMTP id u5mr5151759otb.266.1559648003203;
 Tue, 04 Jun 2019 04:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com> <20190603191041.GD6487@kroah.com>
 <97a6b41f-7b30-54fc-a633-e59895467902@arm.com> <0ed1eb1e-df7f-d531-19ee-8b29ee37ae6d@arm.com>
In-Reply-To: <0ed1eb1e-df7f-d531-19ee-8b29ee37ae6d@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jun 2019 13:33:12 +0200
Message-ID: <CAJZ5v0hOqnBW3Tjo+iBq1BNzXPaebquOQ=Z1Mpvnj+0fSh6WFw@mail.gmail.com>
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 12:55 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 04/06/2019 09:45, Suzuki K Poulose wrote:
> >
> >
> > On 03/06/2019 20:10, Greg KH wrote:
> >> On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
> >>> Add a wrappers to lookup a device by name for a given driver, by various
> >>> generic properties of a device. This can avoid the proliferation of custom
> >>> match functions throughout the drivers.
> >>>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>> ---
> >>>    include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >>>    1 file changed, 44 insertions(+)
> >>
> >> You should put the "here are the new functions that everyone can use"
> >> much earlier in the patch series, otherwise it's hard to dig out.
> >
> > Sure, I will add it in the respective commits.
> >
> >>
> >> And if you send just those as an individual series, and they look good,
> >> I can queue them up now so that everyone else can take the individual
> >> patches through their respective trees.
> >
> > I see. I think I may be able to do that.
>
> The API change patch (i.e, "drivers: Unify the match prototype for
> bus_find_device with class_find_device" ) is tricky and prevents us from doing
> this. So, that patch has to come via your tree as it must be a one shot change.
> And that would make the individual subsystem patches conflict with your tree.
> Also, it would break the builds until the individual subsystem trees are merged
> with your tree with the new API.
>
> So I am not quite sure what the best approach here would be.

It looks like you need to consolidate the prototypes of
bus_find_device() and class_find_device() in the first place, so all
of the changes this depends one need to go into one series and through
the Greg's tree.

Then, you need the new helpers to be defined on top of that and I
would introduce them in another patch series once the first step above
has been completed.

Finally, some code in multiple places needs to be changed to use the
new helpers and that can be done in many smaller steps with individual
changes going in through the respective subsystem trees of theirs.
