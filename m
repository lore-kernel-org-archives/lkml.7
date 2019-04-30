Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB35FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7665B20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HucAEhzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfD3B5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:57:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40417 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3B5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:57:20 -0400
Received: by mail-io1-f66.google.com with SMTP id m9so4420169iok.7;
        Mon, 29 Apr 2019 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4eDQEWWW3C1zHEw+XhHMcdX5N8JmPC7I6tUL4buhW3Q=;
        b=HucAEhzRRcPrs4HGlAiJWZVNWZ9dP7Fizb+b5xI/BKueiljvrIsi0fGHmTXV28YvDJ
         J/6LPjfZu7rcx2IJp3SwF3Mj7HPF/2EmdrwUFshiwYp2X6e3TXZGKztw9jgmnPXNuUm3
         6BDTd8j2GDUhn5VeUD0LdeNr+prfPKZHVuPtxJqwMgCd4jRk1nc+kuJPBVm2xW/Xmrmo
         nDaWZJE31ZTHv8ha5pby+m8/FNGNYz4oewXs0XrRuAn+eQO042B7PoRs0EPi90kZGd16
         lt59QtBqXkiJeYhdgw9qOBwDoqe7G5g4AlvZqTWM8NOcoW3plzeBw4rsGkQJevP4PKGS
         450A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4eDQEWWW3C1zHEw+XhHMcdX5N8JmPC7I6tUL4buhW3Q=;
        b=mSudIrO4GXhJNUc1aw/7vdD56XgDUi78VkcDZAJ7mlswsKLfuwdOoArdcC0nV52l3q
         aNJINm01ToFX5harPa1Elxgtoy2FzbuszgUN9oqqcubsBuhvHeIdPO8o5FCz+ywO5uxd
         +VBKT6mHhzTlmkih7TI9k3tRTvw6HgqwmZZPGeq+ocfhc1ciepqTo5F2iiChcWQIFs5z
         PEzQg0U+k17Ii+JgwDpxaNLvIz3TyTh620Xiz2ORzrgeKaLH65FxcZy6iXs1K3gZXiKG
         Y5O8PbbOWf9IA3ALLehsht+S68EZN2Hi39Ga33103ZThVsqFFkUUpHmBVYCLst0wTuoX
         fxcQ==
X-Gm-Message-State: APjAAAXFsky3Wcfb0xaFcwzUoamUNnyLw1eltqin0IYTpTTE/oLrFze0
        kGIAztjEE0hrIOfbfmxTGYrzFGyY9rNOPptP/qI=
X-Google-Smtp-Source: APXvYqzTYLmncM9hFrR7+JKfYHkyJnb1pDKKIgIA/5OJs/6SE3fXAtIMGuxODLRA7mWnL38flgbmT9FGaqxqGNvoLro=
X-Received: by 2002:a6b:410e:: with SMTP id n14mr38489961ioa.141.1556589438730;
 Mon, 29 Apr 2019 18:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190208025828.30901-1-andrew.smirnov@gmail.com> <D53F2ED9-E0E6-4290-9E3E-864D2AF43572@holtmann.org>
In-Reply-To: <D53F2ED9-E0E6-4290-9E3E-864D2AF43572@holtmann.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 29 Apr 2019 18:57:06 -0700
Message-ID: <CAHQ1cqH=fRWBxd_SyeNmnnj-RqzU-M-PjvyE1P+HD-RtoUEzxA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 1:08 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Andrey,
>
> > Due to:
> >
> > - current implementation of l2cap_config_rsp() dropping BT
> >   connection if sender of configuration response replied with unknown
> >   option failure (Result=3D0x0003/L2CAP_CONF_UNKNOWN)
> >
> > - current implementation of l2cap_build_conf_req() adding
> >   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
> >   the Linux host.
> >
> > devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
> > controllers, will get stuck in endless connect -> configure ->
> > disconnect loop, never connect and be generaly unusable.
> >
> > To avoid this problem add code to do the following:
> >
> > 1. Store a mask of supported conf option types per connection
> >
> > 2. Parse the body of response L2CAP_CONF_UNKNOWN and adjust
> >    connection's supported conf option types mask
> >
> > 3. Retry configuration step the same way it's done for
> >    L2CAP_CONF_UNACCEPT
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> > Cc: Florian Dollinger <dollinger.florian@gmx.de>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: linux-bluetooth@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >
> > Everyone:
> >
> > I marked this as an RFC, since I don't have a lot of experience with
> > Bluetooth subsystem and don't have hight degree of confidence about
> > choices made in this patch. I do, however, thins is is good enough to
> > start a discussion about the problem.
> >
> > Thanks,
> > Andrey Smirnov
>
> so it seems that the remote side claims to support Streaming Mode and tha=
t is why we are trying to set it up.
>
> > ACL Data RX: Handle 12 flags 0x02 dlen 16
>       L2CAP: Information Response (0x0b) ident 1 len 8
>         Type: Extended features supported (0x0002)
>         Result: Success (0x0000)
>         Features: 0x00000010
>           Streaming Mode
>
> And that is why we do this.
>
> < ACL Data TX: Handle 12 flags 0x00 dlen 23
>       L2CAP: Configure Request (0x04) ident 2 len 15
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
>
> > ACL Data RX: Handle 12 flags 0x02 dlen 15
>       L2CAP: Configure Response (0x05) ident 2 len 7
>         Source CID: 64
>         Flags: 0x0000
>         Result: Failure - unknown options (0x0003)
>         04
>
> So btmon needs a patch to decide the failed option octet here. We really =
want do provide a human description of the failed option.
>

I'll see if that's an easy thing to add. Can't promise anything though.

> >
> > include/net/bluetooth/l2cap.h |  1 +
> > net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++++-----
> > 2 files changed, 51 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index 093aedebdf0c..6898bba5d9a8 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -632,6 +632,7 @@ struct l2cap_conn {
> >       unsigned int            mtu;
> >
> >       __u32                   feat_mask;
> > +     __u32                   known_options;
> >       __u8                    remote_fixed_chan;
> >       __u8                    local_fixed_chan;
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index f17e393b43b4..49be98b6de72 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3243,8 +3243,10 @@ static int l2cap_build_conf_req(struct l2cap_cha=
n *chan, void *data, size_t data
> >               rfc.monitor_timeout =3D 0;
> >               rfc.max_pdu_size    =3D 0;
> >
> > -             l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> > -                                (unsigned long) &rfc, endptr - ptr);
> > +             if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
> > +                     l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(r=
fc),
> > +                                        (unsigned long)&rfc, endptr - =
ptr);
> > +             }
> >               break;
> >
> >       case L2CAP_MODE_ERTM:
> > @@ -3263,8 +3265,10 @@ static int l2cap_build_conf_req(struct l2cap_cha=
n *chan, void *data, size_t data
> >               rfc.txwin_size =3D min_t(u16, chan->tx_win,
> >                                      L2CAP_DEFAULT_TX_WINDOW);
> >
> > -             l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> > -                                (unsigned long) &rfc, endptr - ptr);
> > +             if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
> > +                     l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(r=
fc),
> > +                                        (unsigned long)&rfc, endptr - =
ptr);
> > +             }
> >
> >               if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
> >                       l2cap_add_opt_efs(&ptr, chan, endptr - ptr);
> > @@ -3295,8 +3299,10 @@ static int l2cap_build_conf_req(struct l2cap_cha=
n *chan, void *data, size_t data
> >                            L2CAP_FCS_SIZE);
> >               rfc.max_pdu_size =3D cpu_to_le16(size);
> >
> > -             l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> > -                                (unsigned long) &rfc, endptr - ptr);
> > +             if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
> > +                     l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(r=
fc),
> > +                                        (unsigned long)&rfc, endptr - =
ptr);
> > +             }
> >
> >               if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
> >                       l2cap_add_opt_efs(&ptr, chan, endptr - ptr);
> > @@ -3550,11 +3556,47 @@ static int l2cap_parse_conf_rsp(struct l2cap_ch=
an *chan, void *rsp, int len,
> >       void *endptr =3D data + size;
> >       int type, olen;
> >       unsigned long val;
> > +     const bool unknown_options =3D *result =3D=3D L2CAP_CONF_UNKNOWN;
> >       struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_BASIC };
> >       struct l2cap_conf_efs efs;
> >
> >       BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
> >
> > +     /* throw out any old stored conf requests */
> > +     *result =3D L2CAP_CONF_SUCCESS;
> > +
> > +     if (unknown_options) {
> > +             const u8 *option_type =3D rsp;
> > +
> > +             if (!len) {
> > +                     /* If no list of unknown option types is
> > +                      * provided there's nothing for us to do
> > +                      */
> > +                     return -ECONNREFUSED;
> > +             }
> > +
> > +             while (len--) {
> > +                     BT_DBG("chan %p, unknown option type: %u", chan,
> > +                            *option_type);
> > +                     /* "...Hints shall not be included in the
> > +                      * Response and shall not be the sole cause
> > +                      * for rejecting the Request.."
> > +                      */
> > +                     if (*option_type & L2CAP_CONF_HINT)
> > +                             return -ECONNREFUSED;
> > +                     /* Make sure option type is one of the types
> > +                      * supported/used in configure requests
> > +                      */
> > +                     if (*option_type < L2CAP_CONF_MTU ||
> > +                         *option_type > L2CAP_CONF_EWS)
> > +                             return -ECONNREFUSED;
> > +
> > +                     chan->conn->known_options &=3D ~BIT(*option_type+=
+);
> > +             }
> > +
> > +             return l2cap_build_conf_req(chan, data, size);
> > +     }
> > +
> >       while (len >=3D L2CAP_CONF_OPT_SIZE) {
> >               len -=3D l2cap_get_conf_opt(&rsp, &type, &olen, &val);
> >               if (len < 0)
> > @@ -4240,6 +4282,7 @@ static inline int l2cap_config_rsp(struct l2cap_c=
onn *conn,
> >               }
> >               goto done;
> >
> > +     case L2CAP_CONF_UNKNOWN:
> >       case L2CAP_CONF_UNACCEPT:
> >               if (chan->num_conf_rsp <=3D L2CAP_CONF_MAX_CONF_RSP) {
> >                       char req[64];
> > @@ -4249,8 +4292,6 @@ static inline int l2cap_config_rsp(struct l2cap_c=
onn *conn,
> >                               goto done;
> >                       }
> >
> > -                     /* throw out any old stored conf requests */
> > -                     result =3D L2CAP_CONF_SUCCESS;
> >                       len =3D l2cap_parse_conf_rsp(chan, rsp->data, len=
,
> >                                                  req, sizeof(req), &res=
ult);
> >                       if (len < 0) {
>
> So I really wonder if we want to combine CONF_UNKNOWN and CONF_UNACCEPT a=
ctually here. It might be better to do them as separate handlers.

I just wanted to minimize all of the surrounding boilerplate code
duplication. Will change v2 to have a separate handler.

>
> Frankly it might be enough if the option code 0x04 is marked as not suppo=
rted, then just clear
>
>         conn->feat_mask &=3D ~(L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING);
>
> There is really no point for us known about all unsupported / unknown opt=
ions. Unless we understand them, then don=E2=80=99t bother. Just keep it si=
mple.
>

OK, sure, I think that should work. I'll give it a try and report back in v=
2.

Thanks,
Andrey Smirnov
