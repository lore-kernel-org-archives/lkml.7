Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3E320878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWKF02Yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfDXFn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:43:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39172 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfDXFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:43:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so13292560oih.6;
        Tue, 23 Apr 2019 22:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gt37jn4OJnCg96FT7hHMvjzr83xeO454dQxbQ9mWocQ=;
        b=gWKF02Yo40vyai70q58rAreGr/AHF/v6gMqA2d/nLLugqcpzR2ONXFtgl93+brg1cZ
         RMz33Se+FsEh4HJ9jwXrDBeKeBoHMk6aXIb0/MvF9LLqc6OeSUFJqfwE3TLdgrPBcbO+
         GDzfCY/ZS6Y5L/Q95casbzxgmLnLpsPQoZoMHy2EXCxJnuB7MjopmU92OtTPMhwwu5Q3
         DDFA0GcVjYsdmLCI4X6g400JIkJakG7XpZohfJ4+XO5rZlfq3K/SdHpvE58z87o8U1It
         wDB4yYcnJ4WFZLHSg+RAijqILkUf5XnlUkcYZ9vQLKUQ2BU/lRbluB+5iNiMMqLpe06j
         VuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gt37jn4OJnCg96FT7hHMvjzr83xeO454dQxbQ9mWocQ=;
        b=OpIPkVCNIqo8ihUnoHoR99BhIjS+bIf6FqglOaY8dDRITRfc0Q9ZOqiO+iHvFvIS9E
         cvvGi4ElUk3Kh1ibWzULDq53VRmouK3N5BbziyGhYilbmrAQDVvLM07mqIzHmClAQbrC
         XarIsg3v2TgfEKFXIPQ7+Xm2rCLGMnC3OcLWUpammOL7bfr4bbAvSLdsB1GVAeZSAsI6
         FA2JjAP+DZMUyOtV17qLtmwr97AfLqutI1nmvt7J0GGlgXeSmOeveab53tkE+Y7J8Sft
         2jsEB3EFdCUgDniANjeNVAuFgBbGjBnsOjU2t6qTpMeotS82T4G3KjIck5jo7M80N2L5
         uI5A==
X-Gm-Message-State: APjAAAVBA/e2A9MT3SYr4ohAyAucv0ngozA3U017Jufn1fn09RBLwVDE
        USvu3uQClQzxvqlVdaG+wdXwSMZ9GdcEuWq71H4=
X-Google-Smtp-Source: APXvYqwrAIpF6iT+8uK4hMyEB+95ROZ0EJE7BPasQwHZONN68s0XlGNLtI8bJPg69fQi3QXbu+fqCKiv4+x7beX1aB4=
X-Received: by 2002:aca:4282:: with SMTP id p124mr4224925oia.175.1556084606975;
 Tue, 23 Apr 2019 22:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190423072236.24999-1-jprvita@endlessm.com> <D4B5C1C6-0A7A-4666-A1D2-D7A42BD5EABA@holtmann.org>
In-Reply-To: <D4B5C1C6-0A7A-4666-A1D2-D7A42BD5EABA@holtmann.org>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Wed, 24 Apr 2019 13:42:50 +0800
Message-ID: <CA+A7VXWMgx44=747MES=EvkLdrtQgyF3e+h5v7vQaAsHxbcedw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Quirk to enable QCA9377 to discover BLE devices
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        ytkim@qca.qualcomm.com, "David S. Miller" <davem@davemloft.net>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
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

Hello Marcel, thanks for the quick response.

On Wed, Apr 24, 2019 at 12:17 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Joao Paulo,
>
> > As reported previously on [1], it is currently not possible to discover
> > BLE devices with QCA9377 controllers. When trying to start an active
> > scanning procedure with this controller, three commands are queued,
> > LE_SET_RANDOM_ADDR, LE_SET_SCAN_PARAM and LE_SET_SCAN_ENABLE. After the
> > first command is sent to the controller, a command complete event for i=
t
> > is received, and the second command is sent, an extra command complete
> > for the first command is received. At this point the kernel sends the
> > next command and fails to process the command complete event for the
> > LE_SET_SCAN_PARAM command, because when it arrives it does not match th=
e
> > last command that was sent. This makes hdev->le_scan_type never be
> > updated and the kernel behaves as if a passive scanning procedure was
> > being performed, thus no device found events are sent to userspace.
> >
> > [1] https://www.spinics.net/lists/linux-bluetooth/msg79102.html
> >
> > I have received no replies on the previous report and on further
> > attempts to contact the QCA addresses that have submitted Bluetooth
> > firmware blobs to linux-firmware upstream. This series avoids the
> > problem described above, but I believe ideally the controller should no=
t
> > be sending this extra command complete event.
> >
> > I'm not 100% sure if the approach taken here is the best way to work
> > around this problem in the kernel, as I am not super familiar with the
> > HCI layer. I'll be happy to hear suggestions of better approaches.
> >
> > Full logs from btmon can be found bellow this message, and the extra
> > command complete event can be seen at timestamp 27.420131.
>
> so can we get a fixed firmware from Qualcomm? Or at least some ROM patche=
s for it?
>

That was my initial expectation as well -- maybe you can show the
problem to some Qualcomm contacts?

> > Best regards,
> >
> > Jo=C3=A3o Paulo Rechi Vita (2):
> >  Bluetooth: Create new HCI_QUIRK_WAIT_FOR_MATCHING_CC
> >  Bluetooth: Set HCI_QUIRK_WAIT_FOR_MATCHING_CC for QCA9377
> >
> > drivers/bluetooth/btusb.c        | 9 +++++++++
> > include/net/bluetooth/hci.h      | 4 ++++
> > include/net/bluetooth/hci_core.h | 1 +
> > net/bluetooth/hci_core.c         | 3 +++
> > net/bluetooth/hci_event.c        | 4 ++++
> > 5 files changed, 21 insertions(+)
> >
> > --
> > 2.20.1
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
>
> so we really need to ignore this command complete and not start ahead wit=
h the next command. Especially since we really only support one command at =
a time right now.
>

Agreed.

> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2      #5 [hci0] 2=
7.420259
> >        Scanning: Enabled (0x01)
> >        Filter duplicates: Enabled (0x01)
> >> HCI Event: Command Complete (0x0e) plen 4                 #6 [hci0] 27=
.420969
> >      LE Set Scan Parameters (0x08|0x000b) ncmd 1
> >        Status: Success (0x00)
>
> We need for this command complete to arrive and only then continue with L=
E Set Scan Enable. We don=E2=80=99t need a quirk for it. Just add support f=
or dealing with unexpected command complete opcodes. And print a big error =
if that happens.
>

Makes sense, I'm sending an updated version ignoring unexpected CC
events on all hardware. Looking at the code it seems the only
exception is a CC event for HCI_OP_RESET on some CSR controllers,
which is handled in hci_req_cmd_complete, so I'm letting that flow
through.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
