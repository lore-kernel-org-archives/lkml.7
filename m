Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC3C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB77206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb3s9Sv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHLVqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:46:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37982 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:46:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so14930486ota.5;
        Mon, 12 Aug 2019 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nkr+gIxBqJFzbWoJfHgW3m7rzqgw9KiVs/6RGjZDRIE=;
        b=gb3s9Sv3HPzBuaC3EiLO0FNuc/94OYMO3ZLktnyjaS+lDLsYD/udOgs1bduzDvAQIp
         wKA/z462vLytjz4AxyK4uufltfvTRd67Up6etwBvtOpZx6iX6Ev0eznFpRXZkUO3VRZ0
         9aYqTU6+3Dy7SPqRIwbhzzGnxsMCbFcKFjSF2SiaVjWM8Qt4ZT3gpCj9d9HAeWGTY6jQ
         9hyjTDQE6EStrFkTq/p0Uhqxa5vyLNHoCPaOqykjKt7dAEy3ueXRONeg+TkgVT9dZUWX
         CFwX9wT3ycD/ni656k2S6FCk/ZecJ0/Qov43udnJ2dmslJokvq7fnfEjbM8Z2DoTvQBH
         1dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nkr+gIxBqJFzbWoJfHgW3m7rzqgw9KiVs/6RGjZDRIE=;
        b=KXem9y0r5Ijr9CpewkBnm6TBEz5eJqM0nflZ1yQaT9TWK5V3H9e5zuEZu2/DsWmow2
         qSWAuTeL5UfnuenLBZNny1uh8GUxvuIrSlgBhhkiUeBLfo0BuIOdLshrHo613y/HJmhW
         giO0TdqKKA8fq041r32BqT6shtC9tKLXDnuOxcru9H39eQRINInxHyN57pchdp+xmUoR
         NMuzw0syf0ElQa1ADmo/B/nZF44/l6qRVo971x58yszlcssM4svcwBcI2VB9pEE6RFV4
         vOgb96DZiuw7V2Tfk3bOrY820wXOsHP7jkEiXYfAqueNUtsXzr9+2BXykihfSygZhtz8
         eICQ==
X-Gm-Message-State: APjAAAUSKwrXdut20kWi8hwBdcr+M2WNzVlcBhi1c6jYXXTSP04czPhI
        TN3qs8QwoZQ+L2FC2Cc9CVfvBdKjH+pKvD6GTB1cqw==
X-Google-Smtp-Source: APXvYqwAyNV0aoo1JgRTizUlMZhcmLZp+ePIOOGhBR9XXQDREIsPzaMnEKBBtRT9HS5LeBuYLTV5wdHKDqyUhCqP3iI=
X-Received: by 2002:a02:a1c7:: with SMTP id o7mr40873256jah.26.1565646402920;
 Mon, 12 Aug 2019 14:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190802120217.GA8712@toshiba> <A83A0A38-8AC8-4662-BBC1-3B48B707E97B@holtmann.org>
In-Reply-To: <A83A0A38-8AC8-4662-BBC1-3B48B707E97B@holtmann.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 12 Aug 2019 14:46:32 -0700
Message-ID: <CAKdAkRQP8DBbpdfA6yFZK6THw5eVUbdr+QnVQMkm-mLyEp5brg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix suspend issue for Realtek devices
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alex Lu <alex_lu@realsil.com.cn>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 9:36 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Alex,
>
> > From the perspective of controller, global suspend means there is no
> > SET_FEATURE (DEVICE_REMOTE_WAKEUP) and controller would drop the
> > firmware. It would consume less power. So we should not send this kind
> > of SET_FEATURE when host goes to suspend state.
> > Otherwise, when making device enter selective suspend, host should send
> > SET_FEATURE to make sure the firmware remains.
> >
> > Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> > ---
> > drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++++++++++----
> > 1 file changed, 30 insertions(+), 4 deletions(-)
>
> this one doesn=E2=80=99t apply cleanly to bluetooth-next. Can you please =
send a version that does.

Is this a chip issue or system issue? I.e. if in some system BT
controller is wired so that it loses power over system suspend, this
is quite different form chip itself losing firmware in certain
situations, and this smells like a system issue and thus needs to be
addressed on system level.

Thanks.

--=20
Dmitry
