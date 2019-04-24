Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E737C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C20C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfDXQlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:41:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38319 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbfDXQlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:41:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id g1so11251983qki.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sqL9wKD/SZJdZlnerM3T3x5zYBkHVcaUSYPBUkYViI=;
        b=rVs10fxroqKo0KwLWZAYIt+U38xzvoHo4V5VHwJFq6TGcBQCEaXdPZcHNXES7NRSUr
         82aQRmot4/O95hft3KkgmHWbEEZCxGP0ZHhCQhwOFvEjrn5CHUu2nGjDraokwohDA1Yu
         Gcd2GSzhFGP29dGdqf4SKvGt4PxSl6dz1Q9j2E/bNlMdFLUGfErfn104ihfabQIArUNP
         37LXUMR5prpuUlOxLA6jKm/i4TY8D3yta53P+yIfvosHVlSLHKYDFuF9NIK9kCQVUJXY
         yU1I8cW4N80tcnT6lhrUSSVUU1ARCu3WRbnbf8/AEgF4xugQ2AIAFdxx8UVkzyBKsTeh
         aqEw==
X-Gm-Message-State: APjAAAVAUjEk7OXat75IU9+sQzkmDIy4gbipbegDWZYVrz3QNwRAV8yn
        22dL4AukaE/swSUXCm02+HiQjgRyCGLnWnmo0QdTUg==
X-Google-Smtp-Source: APXvYqx9dPpRLNs/ZmM9syJUTZvS4VFEnNN8RhCpYdGJbaCQ5PNvQKrxEzT0OJBLLHn6mBT27E5tAx6q9VSwC0TE83Y=
X-Received: by 2002:a37:a892:: with SMTP id r140mr18093783qke.285.1556124082730;
 Wed, 24 Apr 2019 09:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
 <CAO-hwJLCL95pAzO9kco2jo2_uCV2=3f5OEf=P=AoB9EpEjFTAw@mail.gmail.com> <43a56e9b-6e44-76b7-efff-fa8996183fbc@nurealm.net>
In-Reply-To: <43a56e9b-6e44-76b7-efff-fa8996183fbc@nurealm.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 24 Apr 2019 18:41:11 +0200
Message-ID: <CAO-hwJK614pzseUsGqH65fCnrm=N7970i4_mqi0m1gdkY=J0ag@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: input: make sure the wheel high resolution
 multiplier is set
To:     James Feeney <james@nurealm.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 5:42 PM James Feeney <james@nurealm.net> wrote:
>
> Hey Benjamin
>
> On 4/24/19 7:30 AM, Benjamin Tissoires wrote:
> > Given that this basically breaks a basic functionality of many
> > Microsoft mice, I went ahead and applied this series to
> > for-5.1/upstream-fixes
>
> Is there some reason that both patches should not be applied immediately, to the 5.0 series?
>
> Or - likely I am uninformed - are the 5.1 patches applied as a set separate from the 5.0 series revisions?

For a patch to be picked up by stable, it first needs to go in Linus'
tree. Currently we are working on 5.1, so any stable patches need to
go in 5.1 first. Then, once they hit Linus' tree, the stable team will
pick them and backport them in the appropriate stable tree.

But distributions can backport them as they wish, so you can make a
request to your distribution to include them ASAP. They are officially
upstream, though yet to be sent to Linus.

Cheers,
Benjamin
