Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1C2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9EE21E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyUcy5z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfHGNyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:54:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35708 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387984AbfHGNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:54:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so40938585plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RoWuMVNmRfMP6twJoSi1+gPLSwhvWNnJuHSrIbb4GeQ=;
        b=eyUcy5z6yfw7W/XYFZBrztR051qXApfEiFeV/KKMElwaltRh01FBH4xOMriqmhXp0S
         n/v5K2gv8DkzWqmgi3OPIu/uZeatsk/e4eUzGdC/tnfmx7B5olD03Ys6HOFk0rzfIFkk
         oA/DgVgpEyMOza2fUdSzLIot4e5OEk2/nTGtVCQ2ueoFhiMdtb2PXRsIn7WBf++sEABC
         Yi2PICeym++vGALaVMd2XCJIW5JRrrpqhh+wohmHf72c1gY2dgUH/Ba6AsPkvF3kqNnc
         T57wge3JXy4SGLqEQyZQTkK0m1+nxgiYoRdzni+bWhDOBzPPRY7SqyxSbC2ICet8Abbo
         9JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RoWuMVNmRfMP6twJoSi1+gPLSwhvWNnJuHSrIbb4GeQ=;
        b=UjEv79Z69+KyhFkyJP/iL41DUsAVcpqoHm8WdwRtPJsgVscCuufusCwHfzZjE9Wc3Q
         YZ//3s/EABNND9GhOV9Vtw0XIdK4/kJ2erx8slcumFXa9Qpw9ImxJUOCFcNw9zzHmHEy
         SRcEe3CaEfe451XSzKfawRK2FbPjD6gP5dplNVAUC91d3gTT28uUJCrbwsZ6NNIOscr0
         5qvyWtwfmGn/1pU08w13WbzXNr7TljWnG2Qvi781mqSt+d3AMt4fT+TeJKnFVa6A+FW6
         zqijnZojRRrjreKh0QlaEQ8UpEVU2eGfjd8XVbUVKzlimDKJIc0bnQuHhNXtZKqwPbRV
         iTyQ==
X-Gm-Message-State: APjAAAU5xpsX350+ERIedozgvRUS7kQnHIhv8tDqDX2all5reJGKbSD+
        czgO7g0wkvVACNjPIV2Zlo1N5INl28ULWHPfN0uK4Jnsljo=
X-Google-Smtp-Source: APXvYqyvTTzfZlxz9lgLLA6e7+UPFvYSd1PebuD8n5S/aCiPLUwVFCoM3CmHUJckUsWy/8R2gqFgH/Uhfolr9hDtZBQ=
X-Received: by 2002:a63:c442:: with SMTP id m2mr8020736pgg.286.1565186041896;
 Wed, 07 Aug 2019 06:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000088af91058f0fe377@google.com> <Pine.LNX.4.44L0.1908061509040.1571-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908061509040.1571-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Aug 2019 15:53:50 +0200
Message-ID: <CAAeHK+zLrYaE+Kt6AULPjKhBNknxPBWncfkTDmm3eFoLSpsffw@mail.gmail.com>
Subject: Re: possible deadlock in open_rio
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Cesar Miquel <miquel@df.uba.ar>,
        rio500-users@lists.sourceforge.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 9:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, 1 Aug 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=136b6aec600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7bbcbe9c9ff0cd49592a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.3.0-rc2+ #23 Not tainted
> > ------------------------------------------------------
>
> Andrey:
>
> This should be completely reproducible, since it's a simple ABBA
> locking violation.  Maybe just introducing a time delay (to avoid races
> and give the open() call time to run) between the gadget creation and
> gadget removal would be enough to do it.

I've tried some simple approaches to reproducing this, but failed.
Should this require two rio500 devices to trigger?

>
> Is there any way you can test this?

Not yet.

>
> Alan Stern
>
