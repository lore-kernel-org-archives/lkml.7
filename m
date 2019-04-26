Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8815EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAEF20684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUfXYz33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfDZIz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:55:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38779 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZIz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:55:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id t20so2014417otl.5;
        Fri, 26 Apr 2019 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mTf4/8wYtcMpQlfQaPH5hWdzk/rVCCnm5CRMs2JLrcI=;
        b=BUfXYz33IzwdUfcWffmJAv+LGY/gGtrBpks5nf9AuxAfFV016OP90lMQ+2UziVv2sC
         gqRg8MU2rCh0qa4VZFlnEvXphg5AH6tRqCVjjBuYcxPnQdejnNT2c4GDp5D5Swke2Ndd
         g79bcQpNgbYYR6oVVZPmHd7tLUQf7Oqk04iSl7iJMe5y+dPO6qXx9Lj+aG2kbWMXxvdI
         sMTn88H7W6bJOqmBCNaBRfq7f5Djdzu7chtKaT5iClD488eMROunmsbL90P1aaqqyESQ
         aNteESZW6kCenHNhVOBheOEgCHKb57PUjmS2ZL72r3VHiHCPOrKWptpSh7oOPrzk0Sxe
         JEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mTf4/8wYtcMpQlfQaPH5hWdzk/rVCCnm5CRMs2JLrcI=;
        b=sElZ02uabCIIHjyI3ieZq2LsHMrz6uFXf0OO0KrM9q3uwOOFNFpbBivCXqTOI+T1hO
         ywT69CFKGVY/0gBlqP9jC34WRdSzpXAJfBaPqBQ5A5IAmwaDIiTcHrY8p8Oz88lyjpJt
         gHpEYV+eLLUjIHw51Ihxc2Rvk4rQ61sQoUj+m1hZhL1C7naFYgD4TcssX9ZVyy2nvB39
         urklM3DfYQmPtZmFZKueWFGWnR51iViG2mRcTe63GjAfl/jM6KKcaUa81aj6qUSrmpDZ
         gUmZR8/SvbH6S9eU9MsoGIwZAzwjqr+AmzbefgLs4y4QIUBYiAEuYANOO130yDc86w5r
         zL4g==
X-Gm-Message-State: APjAAAU32Wk/2DfDDa74nuGupCLb2yA6KKZ5qCRwZh3okBeuaj1qjmhf
        3LenbvrA5y8S22vX7tO+SQIGK456ur+PMifoTPEtlVq8oPBZOQ==
X-Google-Smtp-Source: APXvYqxzfJZcf1s/eSHaW5hsPzeNIX1ehgl6e4nxtlJu6hxy1QwHDSPgaRN1CO2VF/hcqEWMX0a21rKZX5/XfaAhjCc=
X-Received: by 2002:a9d:3b49:: with SMTP id z67mr26879360otb.57.1556268956828;
 Fri, 26 Apr 2019 01:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+A7VXVa9pFizfQ8C8QUS=3=YDjojmScOKPS=Yhcx-w8G=wsVw@mail.gmail.com>
 <20190425063812.14509-1-jprvita@endlessm.com> <C4118FC8-1589-44D5-97C4-E18892448985@holtmann.org>
In-Reply-To: <C4118FC8-1589-44D5-97C4-E18892448985@holtmann.org>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Fri, 26 Apr 2019 16:55:19 +0800
Message-ID: <CA+A7VXWss=RAXMYb9FfWi=xPCF4Fg+A5tAbYX594HPX2b151fQ@mail.gmail.com>
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

On Thu, Apr 25, 2019 at 7:08 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Joao,
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
> > include/net/bluetooth/hci_core.h | 1 +
> > net/bluetooth/hci_core.c         | 5 +++++
> > net/bluetooth/hci_event.c        | 3 +++
> > 3 files changed, 9 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 094e61e07030..85bed4e916d3 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -364,6 +364,7 @@ struct hci_dev {
> >       struct sk_buff_head     cmd_q;
> >
> >       struct sk_buff          *sent_cmd;
> > +     __u8                    sent_cmd_pending_cc;
>
> is there anything wrong with a bool type? And frankly using a flag seems =
more safe than just a boolean.
>

Ok, I'll change it into a flag.

> >
> >       struct mutex            req_lock;
> >       wait_queue_head_t       req_wait_q;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index d6b2540ba7f8..37893b0c6077 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -4380,9 +4380,13 @@ void hci_req_cmd_complete(struct hci_dev *hdev, =
u16 opcode, u8 status,
> >               if (test_bit(HCI_INIT, &hdev->flags) && opcode =3D=3D HCI=
_OP_RESET)
> >                       hci_resend_last(hdev);
> >
> > +             bt_dev_err(hdev,
> > +                        "unexpected CC event for opcode 0x%4.4x", opco=
de);
>
> Have you tested this? This will cause many error from tools like hciconfi=
g or hcitool.
>

I have tested this, but not with hciconfig or hcitool custom commands.
Do you have an example that I could use to verify this?

> >               return;
> >       }
> >
> > +     hdev->sent_cmd_pending_cc =3D 0;
> > +
> >       /* If the command succeeded and there's still more commands in
> >        * this request the request is not yet complete.
> >        */
> > @@ -4493,6 +4497,7 @@ static void hci_cmd_work(struct work_struct *work=
)
> >
> >               hdev->sent_cmd =3D skb_clone(skb, GFP_KERNEL);
> >               if (hdev->sent_cmd) {
> > +                     hdev->sent_cmd_pending_cc =3D 1;
> >                       atomic_dec(&hdev->cmd_cnt);
> >                       hci_send_frame(hdev, skb);
> >                       if (test_bit(HCI_RESET, &hdev->flags))
>
> Fun part is actually that even commands injected via hcitool etc. will be=
 added to the sent_cmd queue unless they are vendor specific commands. Howe=
ver some manufactures choose to use command complete for their vendor comma=
nds as well (others don=E2=80=99t).
>

So injected commands and vendor-specific commands are not part of an
hci_request, but end up in this same hdev->cmd_q somehow. Is that
correct?

> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 609fd6871c5a..7541a4bc9444 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3404,6 +3404,9 @@ static void hci_cmd_complete_evt(struct hci_dev *=
hdev, struct sk_buff *skb,
> >       hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
> >                            req_complete_skb);
> >
> > +     if (hdev->sent_cmd_pending_cc)
> > +             return;
> > +
> >       if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q)=
)
> >               queue_work(hdev->workqueue, &hdev->cmd_work);
>
> I rather see this done super cleanly. We have a pending cmd request from =
the kernel, make sure it gets answered with the corresponding command compl=
ete or command status and not just some other event. If there is a command =
complete or command status for a command that we don=E2=80=99t have pending=
, then ignore.
>

So, just to make this clear: are you saying we should only try to
match commands with events if the command is part of a hci_request?
IIUC the way to verify if a command is part of a request is to check
if hdev->req_status =3D=3D HCI_REQ_PEND.

> Frankly, you are just hacking around here.
>

Well, I tried to make this point on my first submission -- I am not
familiar with the HCI layer, but having identified the bug and have
the affected hardware at hand, I thought I might as well try to fix it
so users with this controller can use BLE devices. I am happy to keep
working on it some guidance, but I would not mind testing patches
either if you think that would be easier.

> Regards
>
> Marcel
>

Thanks for the reviews so far. I'm sending a new revision
incorporating my understanding of the feedback above,

Best regards,

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
