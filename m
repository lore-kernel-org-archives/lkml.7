Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA75C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfH1SnT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:43:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52692 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfH1SnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:43:19 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dan.streetman@canonical.com>)
        id 1i32ub-0003Xm-DG
        for linux-kernel@vger.kernel.org; Wed, 28 Aug 2019 18:43:17 +0000
Received: by mail-io1-f70.google.com with SMTP id m7so765855ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xo4NJ4KDDgALFX7Tqoxor2uGZPbldp8kTAdetgMQVtA=;
        b=ta+nzH/6TW8JU+2qcsyfzz0CMyPHEx3viZYSqceFApB1eHhFmQcMZeKSt+MCBmwal0
         d+45PuNsJ619k9q0ew/dvL9Pb2lj19MOlfWmKFiBcNfQ2uDQiHDPngX/jga6j6nZo2y8
         QKAj0gauWx7L5bDDuTYxQ2vJhwk1x4jdMwiI1G4shB//MsXkYKw/fLDSmhtTO/KA1kCN
         6DoMJ89SAdYGR6LbpLMPbGrP5bFZLOIDQsadV5swm4RIp7K/UthewkR2XOWZcRJeFzbP
         g7SHF1HuXCj5inxDdEZXKAUZAeOkbvjDyLGSAImly4oYR9YjXlaXvTbZsBBH3y+Pi72P
         OLzg==
X-Gm-Message-State: APjAAAV2Ho6usR2/2D4269tPy2BT5k015cGzY8TjtA70NeT/2jGDUhbB
        /GbQcL2/JQiVCvElAvs9ad6MSHbeMhVGW7BmVzrU7JdJgS9rf7X7G4HPyaUL+3UkGAq17p1ZH6o
        lzOzt3N8DwBj7GbadXNI2+baqpgj3EErgWUxe7231U5r07HH67T9O8MgWyQ==
X-Received: by 2002:a5e:a80f:: with SMTP id c15mr2725648ioa.270.1567017796195;
        Wed, 28 Aug 2019 11:43:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMujKUJUD7JXYB1erKP8udJALPFmCxjApwznrkp0elZ7PfnmIZUeX3Sjz0w46mowoOarXhx9KFcf8h6NdqDac=
X-Received: by 2002:a5e:a80f:: with SMTP id c15mr2725605ioa.270.1567017795889;
 Wed, 28 Aug 2019 11:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZ2QJOZStRYa=5fyod_AEJcJQw90_yX40dPYY3Dhvfso1e=RA@mail.gmail.com>
 <20190828175051.GK7482@intel.com> <20190828175913.GL7482@intel.com>
In-Reply-To: <20190828175913.GL7482@intel.com>
From:   Dan Streetman <dan.streetman@canonical.com>
Date:   Wed, 28 Aug 2019 14:42:39 -0400
Message-ID: <CAOZ2QJP-P1jfpNXL4nsRB802a+j-Hxc-suQa1e-=ypvto_MtXw@mail.gmail.com>
Subject: Re: Follow up on hid2hci: Fix udev rules for linux-4.14+
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Brian Gix <brian.gix@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Steve Brown <sbrown@ewol.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 1:59 PM Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Aug 28, 2019 at 08:50:51PM +0300, Ville Syrjälä wrote:
> > On Wed, Aug 28, 2019 at 01:34:07PM -0400, Dan Streetman wrote:
> > > It looks like this patch got lost at some point:
> > > https://lore.kernel.org/patchwork/patch/902126/#1138115
> > >
> > > but it seems to still be a problem and I'd like to pull it into Ubuntu:
> > > https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1759836
> > >
> > > Ville, did you ever follow up with a v2 for that patch and/or do you
> > > know if it will be accepted soon?
> >
> > There's a more recent version of that somewhere on the mailing list.
> > The problem is getting someone to actually apply it. Seems much harder
> > than it should be...
>
> https://lore.kernel.org/patchwork/patch/1021109/

I added to this reply a few of the most recent commit authors to the
bluez tools/ subdir...can any of you review and/or apply Ville's
patch?

Marcel, you appear to have created the hid2hci.rules file back in
2012, can you comment on the patch?

>
> >
> > And IIRC I also posted a few other fixes for hid2hci tool which didn't
> > get any response from the crowd.
>
> https://www.spinics.net/lists/linux-bluetooth/msg79803.html
>
> --
> Ville Syrjälä
> Intel
