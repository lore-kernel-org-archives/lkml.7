Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE841C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F85217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=joaomoreno-com.20150623.gappssmtp.com header.i=@joaomoreno-com.20150623.gappssmtp.com header.b="mZqmbg8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfICSdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:33:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38542 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:33:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id l11so9726960wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joaomoreno-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pspeRXdO2j1HTYVZdDPL9GbMWHeSQdfOo4maF+TAMok=;
        b=mZqmbg8YdNqm34eF30MUz6zRJpRyWQwWiHvgFGGDoIc5o/DLmk4lWlBvIxB1TWT5PS
         SMt4UNMbxD+X9bDEnkCxLYHz4qaPKkrMwUm+PeqX4UVxc3VcYgI1SR68yWPae4NXD4bw
         l9RXbjfoGnpmRzR7t+WyAURZLrH/cIILLenAF24VwIaGUxU+I60L6pSbHqpHOIWeoPJ5
         DcFwJVx7j/RKZrHrAY0/4cW/mcvFR3TOQX8PDwkYZ9/f5P+GgDaI6FIn80XUnmSaT4hr
         j7F8Ruoiw/0oC2VkRg8jarJnoUHkXyHekZKB/B4gW4s1JiN+KVyGrvWEDhJsOSbnYjk4
         k9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pspeRXdO2j1HTYVZdDPL9GbMWHeSQdfOo4maF+TAMok=;
        b=QlM6nZVTdjVZFzGcbp0/MvmVWfq5lL8gISPbB470KE2VcpjtyIvZXIo99e1jBLA8Mo
         MaWdlTUcSC4HtXQf9wV6H5xCWjNOYvshKgs9ba6aI7ahxBACgZbnRUHZY+Js/OzbLSI+
         iDYHFQ2PBDjx31BmU7t0oJmj7RCZxepkm1TlFcFzUzCAIX25Mi9p38zjhhbXIarXB7ZX
         UXqtAPcpHMy9w60q0SKQeMlQrHTOTLSbXqJsqNrOBrsiSWmSfabuMvuS7l68WLa0ZFFf
         FzR+kYwlnBHQP/RuDPD624ke9757qHWTd8X0tSv0kOckE58uUhfnahX95ezCwX3qnrF6
         sRWw==
X-Gm-Message-State: APjAAAVCT93uZIYfbazdJjUvypVMuDlGKsPUcuUoiKgz0hGrtJofw0dZ
        3TDKVx49Nfu6N5JlJnpIwZ4qqK3UNt6kMD2af4dNew==
X-Google-Smtp-Source: APXvYqy/XvaP6187x664PfozZKvN1XpiK8C6lANO0NJPJjHlN8sofCs58c1EFb512gWlwYZ/ifV+D642d6Sk2TTlDno=
X-Received: by 2002:a5d:6211:: with SMTP id y17mr3220387wru.35.1567535625608;
 Tue, 03 Sep 2019 11:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190903144632.26299-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20190903144632.26299-1-benjamin.tissoires@redhat.com>
From:   =?UTF-8?B?Sm/Do28gTW9yZW5v?= <mail@joaomoreno.com>
Date:   Tue, 3 Sep 2019 20:33:34 +0200
Message-ID: <CAHxFc3SXM6hkbpTGZCsWOk70tByHE8af59ftOBwahY4fL0Sz=g@mail.gmail.com>
Subject: Re: [PATCH v2] HID: apple: Fix stuck function keys when using FN
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Tue, 3 Sep 2019 at 16:46, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> From: Joao Moreno <mail@joaomoreno.com>
>
> This fixes an issue in which key down events for function keys would be
> repeatedly emitted even after the user has raised the physical key. For
> example, the driver fails to emit the F5 key up event when going through
> the following steps:
> - fnmode=3D1: hold FN, hold F5, release FN, release F5
> - fnmode=3D2: hold F5, hold FN, release F5, release FN
>
> The repeated F5 key down events can be easily verified using xev.
>
> Signed-off-by: Joao Moreno <mail@joaomoreno.com>
> Co-developed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> Hi Joao,
>
> last chance to pull back :)
>
> If you are still happy, I'll push this version
>
> Cheers,
> Benjamin
>

Looks great. Thanks a bunch for your help!

Cheers,
Jo=C3=A3o

>  drivers/hid/hid-apple.c | 49 +++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 81df62f48c4c..6ac8becc2372 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -54,7 +54,6 @@ MODULE_PARM_DESC(swap_opt_cmd, "Swap the Option (\"Alt\=
") and Command (\"Flag\")
>  struct apple_sc {
>         unsigned long quirks;
>         unsigned int fn_on;
> -       DECLARE_BITMAP(pressed_fn, KEY_CNT);
>         DECLARE_BITMAP(pressed_numlock, KEY_CNT);
>  };
>
> @@ -181,6 +180,8 @@ static int hidinput_apple_event(struct hid_device *hi=
d, struct input_dev *input,
>  {
>         struct apple_sc *asc =3D hid_get_drvdata(hid);
>         const struct apple_key_translation *trans, *table;
> +       bool do_translate;
> +       u16 code =3D 0;
>
>         if (usage->code =3D=3D KEY_FN) {
>                 asc->fn_on =3D !!value;
> @@ -189,8 +190,6 @@ static int hidinput_apple_event(struct hid_device *hi=
d, struct input_dev *input,
>         }
>
>         if (fnmode) {
> -               int do_translate;
> -
>                 if (hid->product >=3D USB_DEVICE_ID_APPLE_WELLSPRING4_ANS=
I &&
>                                 hid->product <=3D USB_DEVICE_ID_APPLE_WEL=
LSPRING4A_JIS)
>                         table =3D macbookair_fn_keys;
> @@ -202,25 +201,33 @@ static int hidinput_apple_event(struct hid_device *=
hid, struct input_dev *input,
>                 trans =3D apple_find_translation (table, usage->code);
>
>                 if (trans) {
> -                       if (test_bit(usage->code, asc->pressed_fn))
> -                               do_translate =3D 1;
> -                       else if (trans->flags & APPLE_FLAG_FKEY)
> -                               do_translate =3D (fnmode =3D=3D 2 && asc-=
>fn_on) ||
> -                                       (fnmode =3D=3D 1 && !asc->fn_on);
> -                       else
> -                               do_translate =3D asc->fn_on;
> -
> -                       if (do_translate) {
> -                               if (value)
> -                                       set_bit(usage->code, asc->pressed=
_fn);
> -                               else
> -                                       clear_bit(usage->code, asc->press=
ed_fn);
> -
> -                               input_event(input, usage->type, trans->to=
,
> -                                               value);
> -
> -                               return 1;
> +                       if (test_bit(trans->from, input->key))
> +                               code =3D trans->from;
> +                       else if (test_bit(trans->to, input->key))
> +                               code =3D trans->to;
> +
> +                       if (!code) {
> +                               if (trans->flags & APPLE_FLAG_FKEY) {
> +                                       switch (fnmode) {
> +                                       case 1:
> +                                               do_translate =3D !asc->fn=
_on;
> +                                               break;
> +                                       case 2:
> +                                               do_translate =3D asc->fn_=
on;
> +                                               break;
> +                                       default:
> +                                               /* should never happen */
> +                                               do_translate =3D false;
> +                                       }
> +                               } else {
> +                                       do_translate =3D asc->fn_on;
> +                               }
> +
> +                               code =3D do_translate ? trans->to : trans=
->from;
>                         }
> +
> +                       input_event(input, usage->type, code, value);
> +                       return 1;
>                 }
>
>                 if (asc->quirks & APPLE_NUMLOCK_EMULATION &&
> --
> 2.19.2
>
