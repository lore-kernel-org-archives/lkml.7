Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467D3C4647D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C5321871
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJUf2C50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGBOX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:23:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35210 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGBOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:23:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id c27so10371244wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fYd2nLSJd2JtuXW4PvhhIc8hhI47lGgNieCsOyTTMr0=;
        b=hJUf2C50kZgFGsrA5T0byl86DfevCCPZn4MqhTrIVgX4gvlXGnmRKs3FMRNHqyFSp+
         6IVWVp6dgqLwZA3AvbRCC7/YxNhuYyWMeLXftCsawO8Siq2PzyZPNbIzyMnfUZAbhEcd
         fv5C2x53P72r17ITIeLXXNxlJye7wUFmiLrGNdCtfAiM8EId0E35kVIXCgEBf6I8nuzQ
         QJP2TWdcXNytr0zwQYmWklWkr+EbsMYlfQOLUzSIbjbooMiUphiMViB1X46QuWD4n28i
         oAOJGR8grQLUjxu3lQ9QSxIyBUyV3kUcJpNnMyO2PoAvCf00+z+1zKOGqsB8TdbJJRfN
         4CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fYd2nLSJd2JtuXW4PvhhIc8hhI47lGgNieCsOyTTMr0=;
        b=m/BP2xSgyVK5WGElVusgwRErnj2DB8zC8EklXObMI5q6zkC6QNHRjRyrbMVwri/IdD
         tHfa+XkjqYMEStatNTSRNvKONUzwVUqtHDsMMuZ4vNTPqiDXH+fsu/KkzxBgx/z8Cv2Q
         PGcEy2GXMs2cRrfz3va5OqsRN9bkBckNQRZmd8FeWcVQfbjT88MHt2XVdL0OvOEMmxoK
         2rt8aHnts0NBxtOKUP9918GaO/ukggOdqL80VYwyFKVbl+/EsKCF3pJhhXQtYK1Jlpkn
         mDKTWS5bNXVPREwUJG7ozBl4C6QPWl0S0ZT/T1hdryat9sUluk8d7ossRf5dm2n363l1
         sA6Q==
X-Gm-Message-State: APjAAAWba4dRQfWWGx7v9C+bXsRHvlqvGaVb/VMMGTVJOWjrsRBSMqy/
        +JQSj6jpYul57dJuxbTxt+2QlEdiswOcwMud2KUnEk7DB2E=
X-Google-Smtp-Source: APXvYqwLMvAHfv1sTx1VayA6+S8cQcR7JuRg+X1Ptd3HNI8mYyOl8QVHTULib9r0UUHpDw87A4OVj6OpjaUTXjpkh2A=
X-Received: by 2002:a5d:518f:: with SMTP id k15mr23509522wrv.321.1562077403779;
 Tue, 02 Jul 2019 07:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000089d7f058683115e@google.com> <20190702140211.28399-1-tranmanphong@gmail.com>
In-Reply-To: <20190702140211.28399-1-tranmanphong@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 2 Jul 2019 16:23:11 +0200
Message-ID: <CAG_fn=VHpZW69TfK35aqL7o6CvgsPazL5raeW1QmWpu9ReYkhw@mail.gmail.com>
Subject: Re: [PATCH] media: usb: technisat-usb2: fix buffer overflow
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com,
        Andrey Konovalov <andreyknvl@google.com>,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 4:02 PM Phong Tran <tranmanphong@gmail.com> wrote:
>
> The buffer will be overflow in case of the while loop can not break.
> Add the checking buffer condition in while loop for avoiding
> overlooping index.
>
> This issue was reported by syzbot
>
> Reported-by: syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com
>
> Tested by:
> https://groups.google.com/d/msg/syzkaller-bugs/CySBCKuUOOs/0hKq1CdjCwAJ
>
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---
>  drivers/media/usb/dvb-usb/technisat-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/u=
sb/dvb-usb/technisat-usb2.c
> index c659e18b358b..4e0b6185666a 100644
> --- a/drivers/media/usb/dvb-usb/technisat-usb2.c
> +++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
> @@ -655,7 +655,7 @@ static int technisat_usb2_get_ir(struct dvb_usb_devic=
e *d)
>  #endif
>
>         ev.pulse =3D 0;
> -       while (1) {
> +       while (b !=3D (buf + 63)) {
I think it won't hurt to either use ARRAY_SIZE here, or define some
magic constant for the buffer size in struct technisat_usb2_state.

>                 ev.pulse =3D !ev.pulse;
>                 ev.duration =3D (*b * FIRMWARE_CLOCK_DIVISOR * FIRMWARE_C=
LOCK_TICK) / 1000;
>                 ir_raw_event_store(d->rc_dev, &ev);
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20190702140211.28399-1-tranmanphong%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
