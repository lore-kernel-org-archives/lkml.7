Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E32C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425CF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h9jZDqw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfCSAtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:49:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36153 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfCSAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:49:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id y36so10487160qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=asrXCS/6vWeWFF7aW3/oea2sdTVH2vDaZZYBDhZyzCk=;
        b=h9jZDqw39onoRVGAKgdRyNfvVUbW6tPxBrTNpweHbiLUOt3AV1Ian32a1eBggv1B8P
         FlzxQB6PrF2KFKP/Jeycu8ROs0nqRddL+5AKE+WgeKfsksvm4QRUDCmFYZASC5a0JtJP
         +LecE1BJj2Ohp4tMbvdFbNDhk4A3INd7l0am8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=asrXCS/6vWeWFF7aW3/oea2sdTVH2vDaZZYBDhZyzCk=;
        b=IFDng1eKYjcowSjOK5StaFPi1atujSaAb3StPxFYoD1RlgTgVU4aRzMOQ19eUQXyCr
         RObeb9SSAcqd1CJA9EcP6IshKLY9N3m5DHMDWxzLJmY9mN4b9Zexepq19bAv08M6UAe8
         Zd93fGs9yMTtfq+vLOUDFUeqjuWvdk/A3wjYezqNLj+tv/p4hGns/JckSY/e7tD81yMq
         PBAuWGGWWJ6S6F/qvpWFmR5Skdp9KLkvqcEtVnFbuPsD/pF+wSMYNCuyIpqxHkL5DkZy
         2TsyU93JJDcGA0g26IvJNH4r4RAVZKStzqaiaAcY36ijrly1xt8Q2wI4om+b/yF7srVz
         T7sw==
X-Gm-Message-State: APjAAAWoOwPJBZx1JXMpiVnoJ0lXZgpz1sEXIbw7BUqJmN2mZSaaudRE
        rI/ap2pYdL9dpXIBewNODDqzwBSpSXo5k+/rb5ndMA==
X-Google-Smtp-Source: APXvYqyrZKawXwTd7SynWZzNSMUKyFOK4pkT+9dqHa/h/ryTaJslvISzZkjcwsJTCKj38h0TjNim9tIMSkDhhTmiBao=
X-Received: by 2002:a0c:9319:: with SMTP id d25mr2436197qvd.99.1552956592546;
 Mon, 18 Mar 2019 17:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190306162113.8585-1-bgodavar@codeaurora.org>
 <155191158734.20095.15990837191526416248@swboyd.mtv.corp.google.com>
 <a22894cea091ee9945af9c22d6e42051@codeaurora.org> <82fdfbd3dc4dbc1b6258dd470afff589@codeaurora.org>
In-Reply-To: <82fdfbd3dc4dbc1b6258dd470afff589@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 19 Mar 2019 08:49:41 +0800
Message-ID: <CANMq1KDrGYTrYi1UxyfM2ZMw_GmFpFrrTC6acZkKRHtizAT8OA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Give enough time to ROME
 controller to bootup.
To:     rjliao@codeaurora.org
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, johan.hedberg@gmail.com,
        marcel@holtmann.org, Matthias Kaehlcke <mka@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 5:45 PM <rjliao@codeaurora.org> wrote:
>
> =E5=9C=A8 2019-03-07 14:49=EF=BC=8CBalakrishna Godavarthi =E5=86=99=E9=81=
=93=EF=BC=9A
> > Hi Stepen,
> >
> > On 2019-03-07 04:03, Stephen Boyd wrote:
> >> Quoting Balakrishna Godavarthi (2019-03-06 08:21:13)
> >>> This patch enables enough time to ROME controller to bootup
> >>> after we bring the enable ping out of reset.
> >>>
> >>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> >>> ---
> >>
> >> Any Fixes tag? And maybe some more explanation or background on where
> >> 150 ms sleep comes from would be useful. Was it determined
> >> experimentally or did it come from a datasheet somewhere? Does the
> >> time
> >> differ between boards?
> >>
> > [Bala]: this was observed in our stress testing and even the CHIP
> > firmware team
> >         confirmed that BT chip required at least 150 ms to boot up.
> >
> > @Rocky to confirm my statement.
> >
> >>>  drivers/bluetooth/hci_qca.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/bluetooth/hci_qca.c
> >>> b/drivers/bluetooth/hci_qca.c
> >>> index 237aea34b69f..1953b13511e7 100644
> >>> --- a/drivers/bluetooth/hci_qca.c
> >>> +++ b/drivers/bluetooth/hci_qca.c
> >>> @@ -508,6 +508,8 @@ static int qca_open(struct hci_uart *hu)
> >>>                 qcadev =3D serdev_device_get_drvdata(hu->serdev);
> >>>                 if (qcadev->btsoc_type !=3D QCA_WCN3990) {
> >>>                         gpiod_set_value_cansleep(qcadev->bt_en, 1);
> >>> +                       /* Controller needs time to bootup. */
> >>> +                       msleep(150);
> >>>                 } else {
> >>>                         hu->init_speed =3D qcadev->init_speed;
> >>>                         hu->oper_speed =3D qcadev->oper_speed;
>
> Hello,
>
> Any concern to merge this change? Without this change the Rome cannot up
> while running the serdev way, we should mainline this change ASAP.

Stephen was also asking about a Fixes tag, maybe we should add this?
Fixes: 05ba533c5c11 ("Bluetooth: hci_qca: Add serdev support")
