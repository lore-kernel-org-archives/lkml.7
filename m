Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E01C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFBB218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc4dhvgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfDYGiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:38:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46475 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfDYGiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:38:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id s24so18433372otk.13;
        Wed, 24 Apr 2019 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FOOwACaSdo72Lm1dIW+4DugYe9BUm0ON8kINn+IRshc=;
        b=oc4dhvgFP8PfJVRyOdnWVwUntIKfOmdblDWEdbNOjj8hVeup7ujmptQo817T1Nd0FR
         GpvPRW4HpDrQydbSYztlLJB6rj3udFjzxS9CPIKVx8/Ocj/8bvaU4o7doWPpt+I4aALV
         MhTXLmkUsbQepIcZxVNrfZ7De/iDfngyJsL/umKAhS6+gZhWyR8ZBIJpKeAPEwmCydIL
         O8csUcH2uQfWeNzNKibvHTvHkf4xSelqWm4pGYM5JB0B1B1T4dJ0CvzGaDB4ME5uspQG
         2wR8/LUrBmn3cAhg/l+bT2vYA5FrO8JyhwZg0ol/Ay9xpcloDMah9lQvx20BnwF1OlyP
         gAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FOOwACaSdo72Lm1dIW+4DugYe9BUm0ON8kINn+IRshc=;
        b=WqOJkFLuiDQDhS25qIqxnYwU1KfUeT6+0g++alcOgpp90GTnV2wafS3qHI6Maf98oE
         OQyTPeiG1MFqD4HMD7ICT6fTXBuu00hE3qufIx8QAnNQupKCqyOn3Wh3m3uae5omohw1
         GPW0eBt1iWPneBledt/MxE3Fbt1Lq2Ktw8P3KqXU3S8T0EycPxlcB0X7jHGKZS75pqPa
         /x2ebQArUjCjo3rYJycRVmgWjz9kbhbyGu182VuUV2KxdebJWtuqiW4Az+QneQZXArBu
         PjVVx7P+8k30RDDq+lJSlOAYadDrM+8XgR/cvh6YEoBKsyKWtrTs/591es659ayV6b5c
         OFHg==
X-Gm-Message-State: APjAAAV3lR73GBcKDDO/pXxxSXm950gwOd8HOsoCGWCnGPNvqNv8c2VJ
        O9Iw3tv45KWjjxjJf1JnevQy51Adjmll5/yNir4=
X-Google-Smtp-Source: APXvYqwIKQKaEKkery6SnQLuIhkINpVqw6GSive5fEfbJpYMyV26qYjnxOKC1eG+db4gzGy71z1QaCs78xiUyhdigEo=
X-Received: by 2002:a9d:6f90:: with SMTP id h16mr10254174otq.152.1556174282814;
 Wed, 24 Apr 2019 23:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190424054335.30044-1-jprvita@endlessm.com> <20190424060704.22721-1-jprvita@endlessm.com>
 <547E8A62-51BF-4545-931E-40734134B27E@holtmann.org>
In-Reply-To: <547E8A62-51BF-4545-931E-40734134B27E@holtmann.org>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Thu, 25 Apr 2019 14:37:25 +0800
Message-ID: <CA+A7VXVa9pFizfQ8C8QUS=3=YDjojmScOKPS=Yhcx-w8G=wsVw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Ignore CC events not matching the last HCI command
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        ytkim@qca.qualcomm.com, "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:45 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Joao Paulo,
>
> > This commit makes the kernel not send the next queued HCI command until
> > a command complete arrives for the last HCI command sent to the
> > controller. This change avoids a problem with some buggy controllers
> > (seen on two SKUs of QCA9377) that send an extra command complete event
> > for the previous command after the kernel had already sent a new HCI
> > command to the controller.
> >
> > The problem was reproduced when starting an active scanning procedure,
> > where an extra command complete event arrives for the LE_SET_RANDOM_ADD=
R
> > command. When this happends the kernel ends up not processing the
> > command complete for the following commmand, LE_SET_SCAN_PARAM, and
> > ultimately behaving as if a passive scanning procedure was being
> > performed, when in fact controller is performing an active scanning
> > procedure. This makes it impossible to discover BLE devices as no devic=
e
> > found events are sent to userspace.
> >
> > This problem is reproducible on 100% of the attempts on the affected
> > controllers. The extra command complete event can be seen at timestamp
> > 27.420131 on the btmon logs bellow.
> >
> > Bluetooth monitor ver 5.50
> > =3D Note: Linux version 5.0.0+ (x86_64)                                =
  0.352340
> > =3D Note: Bluetooth subsystem version 2.22                             =
  0.352343
> > =3D New Index: 80:C5:F2:8F:87:84 (Primary,USB,hci0)               [hci0=
] 0.352344
> > =3D Open Index: 80:C5:F2:8F:87:84                                 [hci0=
] 0.352345
> > =3D Index Info: 80:C5:F2:8F:87:84 (Qualcomm)                      [hci0=
] 0.352346
> > @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} =
0.352347
> > @ MGMT Open: btmon (privileged) version 1.14                  {0x0002} =
0.352366
> > @ MGMT Open: btmgmt (privileged) version 1.14                {0x0003} 2=
7.302164
> > @ MGMT Command: Start Discovery (0x0023) plen 1       {0x0003} [hci0] 2=
7.302310
> >        Address type: 0x06
> >          LE Public
> >          LE Random
> > < HCI Command: LE Set Random Address (0x08|0x0005) plen 6   #1 [hci0] 2=
7.302496
> >        Address: 15:60:F2:91:B2:24 (Non-Resolvable)
> >> HCI Event: Command Complete (0x0e) plen 4                 #2 [hci0] 27=
.419117
> >      LE Set Random Address (0x08|0x0005) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7  #3 [hci0] 2=
7.419244
> >        Type: Active (0x01)
> >        Interval: 11.250 msec (0x0012)
> >        Window: 11.250 msec (0x0012)
> >        Own address type: Random (0x01)
> >        Filter policy: Accept all advertisement (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4                 #4 [hci0] 27=
.420131
> >      LE Set Random Address (0x08|0x0005) ncmd 1
> >        Status: Success (0x00)
> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2      #5 [hci0] 2=
7.420259
> >        Scanning: Enabled (0x01)
> >        Filter duplicates: Enabled (0x01)
> >> HCI Event: Command Complete (0x0e) plen 4                 #6 [hci0] 27=
.420969
> >      LE Set Scan Parameters (0x08|0x000b) ncmd 1
> >        Status: Success (0x00)
> >> HCI Event: Command Complete (0x0e) plen 4                 #7 [hci0] 27=
.421983
> >      LE Set Scan Enable (0x08|0x000c) ncmd 1
> >        Status: Success (0x00)
> > @ MGMT Event: Command Complete (0x0001) plen 4        {0x0003} [hci0] 2=
7.422059
> >      Start Discovery (0x0023) plen 1
> >        Status: Success (0x00)
> >        Address type: 0x06
> >          LE Public
> >          LE Random
> > @ MGMT Event: Discovering (0x0013) plen 2             {0x0003} [hci0] 2=
7.422067
> >        Address type: 0x06
> >          LE Public
> >          LE Random
> >        Discovery: Enabled (0x01)
> > @ MGMT Event: Discovering (0x0013) plen 2             {0x0002} [hci0] 2=
7.422067
> >        Address type: 0x06
> >          LE Public
> >          LE Random
> >        Discovery: Enabled (0x01)
> > @ MGMT Event: Discovering (0x0013) plen 2             {0x0001} [hci0] 2=
7.422067
> >        Address type: 0x06
> >          LE Public
> >          LE Random
> >        Discovery: Enabled (0x01)
> >
> > Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
> > ---
> > net/bluetooth/hci_event.c | 13 +++++++++++++
> > 1 file changed, 13 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 609fd6871c5a..b349fc2b4123 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3071,6 +3071,19 @@ static void hci_cmd_complete_evt(struct hci_dev =
*hdev, struct sk_buff *skb,
> >       *opcode =3D __le16_to_cpu(ev->opcode);
> >       *status =3D skb->data[sizeof(*ev)];
> >
> > +     if (*opcode !=3D HCI_OP_RESET && !hci_sent_cmd_data(hdev, *opcode=
)) {
> > +             /* Some buggy controllers generate an extra command compl=
ete
> > +              * event for the previous command after a new commend was
> > +              * already sent, so if the opcode does not match the last=
 sent
> > +              * command we should ignore this event.
> > +              *
> > +              * HCI_OP_RESET is a special case handled in
> > +              * hci_req_cmd_complete.
> > +              */
> > +             bt_dev_err(hdev, "unexpected CC event opcode 0x%4.4x", *o=
pcode);
> > +             return;
> > +     }
> > +
>
> the return; here is not going to fly. You need to go through the switch s=
tatement since it actually does bookkeeping for a lot of features even if t=
he command is not executed by hci_req and instead comes from user space or =
someone else.
>

Ok, so you want the same approach I had before but not bound to a
quirk. Sorry, when you previously said "ignore this command complete
and not start ahead with the next command" I thought you meant to also
avoid going through that switch statement.

> What is the problem with handling this in hci_req_cmd_complete. We have h=
ci_sent_cmd_data check there already. Lets extend this to ensure that comma=
nd complete for random commands don=E2=80=99t trigger us to continue with t=
he request.
>

I'll send an updated revision soon.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
