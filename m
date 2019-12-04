Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259EC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E0820833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="qDRuLg+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfLDP4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:56:12 -0500
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:45257
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727828AbfLDP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:56:11 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7AFAC1A209E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 15:56:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a93.g.dreamhost.com (100-96-14-7.trex.outbound.svc.cluster.local [100.96.14.7])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B6ABB1A1F01
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 15:56:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a93.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Wed, 04 Dec 2019 15:56:10 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Snatch: 3b33244459eec7ad_1575474970196_2248684031
X-MC-Loop-Signature: 1575474970196:3262206106
X-MC-Ingress-Time: 1575474970196
Received: from pdx1-sub0-mail-a93.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a93.g.dreamhost.com (Postfix) with ESMTP id 318FA818B3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 07:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=qrpff.net;
         bh=/Kn4LfddrJDyvMKQRu8wpyUc8WA=; b=qDRuLg+sjOGlLjUfxZbrjUHoHfpw
        zT3IIn+0asZeMUTtjYxIH4oIGFYGjC3dPLc4dztZnWcuZThpUsUIudtQgxOKZd6s
        wl7wdFMgPQ2RtS+7v65LjZhCSENAx/6wj8np565Fpi4vpZNxU0Pa5DXZ1wbmFFaQ
        eZk1AwwSHouRGOk=
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a93.g.dreamhost.com (Postfix) with ESMTPSA id 7B1AB8155F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 07:55:55 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id z17so8653962ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:55:55 -0800 (PST)
X-Gm-Message-State: APjAAAU6pIsy9+RUIksohi883m3h9fo0q+CJNDHTAgo2TaU0c6xgOyoY
        BnikxLcHJcpR1nJKbdD4Ge4YMZ3C23XLoikhaqY=
X-Google-Smtp-Source: APXvYqxQkYTuc245sv1m5iD+qbiatoI2NghXpwEq2lr0SndWytpOUMy/6bKZ79GTRYts4BsJ8Y8W7Di0GXEOM/65RqM=
X-Received: by 2002:a2e:88d6:: with SMTP id a22mr2341326ljk.163.1575474953331;
 Wed, 04 Dec 2019 07:55:53 -0800 (PST)
MIME-Version: 1.0
X-DH-BACKEND: pdx1-sub0-mail-a93
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Wed, 4 Dec 2019 10:55:42 -0500
X-Gmail-Original-Message-ID: <CAD_xR9dfgVeBkm9PZ5gk1fB37vEj+__5O6HUoK6SW3zoOwhDiw@mail.gmail.com>
Message-ID: <CAD_xR9dfgVeBkm9PZ5gk1fB37vEj+__5O6HUoK6SW3zoOwhDiw@mail.gmail.com>
Subject: Re: [RFC] chromeos_laptop: Make touchscreen work on C720
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 2:36 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Stephen,
>
> Does the new kernel work with the original firmware (it should as that's
> what it's been tested with)?

It took some finagling -- MrChromebox is UEFI, but the stock firmware
boots with SeaBIOS -- but I was able to confirm that yes, the
touchscreen works in 4.19 when booting from stock firmware.

> Acer C720 did not use ACPI to describe its devices, it relied on static
> board support to instantiate touchscreen and trackpad and other devices.

> I see that MrChromebox BIOS declares the peripherals on Peppy via ACPI.
> I'd recommend reaching out and ask to update the binding (maybe switch
> from ATML0001 to PRP0001 and full OF-style binding to avoid confusion).

(This is my first-ever foray into anything involving Linux and I2C,
ACPI, _or_ multi-module cooperation, and lucky me, I get all three!
Good thing it's easy to verify that a touchscreen is working.  I also
have no idea what "OF-style binding" is.)

Approaching from the perspective of "I'm designing a brand new kind of
machine that runs Linux, uses ACPI tables, and has one or more Atmel
MXT chips", several things become apparent:

* The driver expects a strange "compatible" property that communicates
no useful information.  The property's value is not read, only its
existence, which is one bit of information. '1' is interpreted as
'this is a supported device', while '0' is interpreted as 'this is not
a supported device'.  But if it's not a supported device, why was the
driver loaded in the first place?

* If it's a touchpad, the driver needs to know what buttons the
various GPIOs are mapped to.
  (Conceivably, it doesn't need to be a touchpad; in my hypothetical
machine, it could also be a touchscreen that also has some input
buttons wired up through the MXT chip, because that saved a nickel per
unit. To support that, however, we would also need an indicator
specifying whether it's a touchscreen or a touchpad, as the driver
interprets 'has buttons' as 'is touchpad'.)

This leads to my first question: With this in mind, couldn't simply
removing the "compatible" check work?
On any existing machine where this driver is loaded and working, the
chromeos_laptop driver has already run and set up the appropriate
device properties first.

--
Stephen
