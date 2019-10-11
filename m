Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30630ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EFB2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfC5aK6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfJKO4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:56:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55755 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbfJKO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570805768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiDA3QBts5KfCGtUBop3Hw/Oo24dQFtETwEmLErKTH4=;
        b=YfC5aK6CiBxTYyITNFO4dL5sxQtW3PhXrLjMjARigFj/vH6RI/XmuunmeI14ZzSpygxMqa
        oT+A/60RPJtaAC7CCCkcpsXIMh0ZQNjOQ6hltpRxgKws7G5U40HaH+SKk9qeTBcYgKseAT
        +gAenYXisfqK8xjojvjV4Gj8XAIvIZo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-zODSv_bAPUaIlkvihGjNsw-1; Fri, 11 Oct 2019 10:56:03 -0400
Received: by mail-qt1-f199.google.com with SMTP id r19so9654132qtk.15
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JATZHH1NgtP8u5fFJewNDLUv2TCv4ss7bPRKEHICbr0=;
        b=hz6/C/D//XWVqc0UXzu/Gl5eyhQRwPFntuaR9ks7eEMlGqLWS8hlDGiZMSjx8YmfDx
         hIZy3HuOAqZbx8JiMl4XBp/zYbxcsNPA5FMfBwS1wWItW1Sa7RAtGDakVn+HXJVIzhq3
         nAiBoHwIC2LKdt4XmEUxTPKca49afHD4DeIhXHJw4qDrE2o2j7juVQ2OGLXtD/qUfk0k
         BrVlTP7zpwCcCfnKrteE7NolZSwkdRwSWAvTcVcmmEJthgYz+6qremjSQjng7OujAIf3
         +94SKsu57patGCSf8gi4q80ElU7Kx6k9kdnu1vyk0/OZiJg0ts1aegspbMKBJ5kEGOl4
         iXMw==
X-Gm-Message-State: APjAAAXr0li4NcoF5kTxJ9DeGd++D6/YqK9TS0jk8zGLHxfIWaf95S4r
        /DA37R1tS1ZVCxwKQIN8LCTJ++mg+w/iWN1YzUDXCvnlP8KX04cH7F+KpHOn8PRRzZPsHPy1+KW
        OdwAd8HldToWUqCmK56ZViCvwWGOCmYN6NtUkpqYE
X-Received: by 2002:ae9:f306:: with SMTP id p6mr16089656qkg.169.1570805763042;
        Fri, 11 Oct 2019 07:56:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhRxyO1bcuIfWi9+9ILjcQeYiWIMiW4HueiZFd7MJiAIFazyIv6uqj4C9dxgo9WNAj6xf5SxYEm9R5x2IqA4c=
X-Received: by 2002:ae9:f306:: with SMTP id p6mr16089632qkg.169.1570805762825;
 Fri, 11 Oct 2019 07:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191007051240.4410-1-andrew.smirnov@gmail.com> <20191007051240.4410-4-andrew.smirnov@gmail.com>
In-Reply-To: <20191007051240.4410-4-andrew.smirnov@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 11 Oct 2019 16:55:51 +0200
Message-ID: <CAO-hwJJ8tp4Rqte-umv9e=S5evR5oJTErsNR0Wk-z8wcbtR0wg@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: logitech-hidpp: add G920 device validation quirk
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Sam Bazely <sambazley@fastmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Austin Palmer <austinp@valvesoftware.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
X-MC-Unique: zODSv_bAPUaIlkvihGjNsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 7:13 AM Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>
> G920 device only advertises REPORT_ID_HIDPP_LONG and
> REPORT_ID_HIDPP_VERY_LONG in its HID report descriptor, so querying
> for REPORT_ID_HIDPP_SHORT with optional=3Dfalse will always fail and
> prevent G920 to be recognized as a valid HID++ device.
>
> Modify hidpp_validate_device() to check only REPORT_ID_HIDPP_LONG with
> optional=3Dfalse on G920 to fix this.
>
> Fixes: fe3ee1ec007b ("HID: logitech-hidpp: allow non HID++ devices to be =
handled by this module")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204191
> Reported-by: Sam Bazely <sambazley@fastmail.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Henrik Rydberg <rydberg@bitmath.org>
> Cc: Sam Bazely <sambazley@fastmail.com>
> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Cc: Austin Palmer <austinp@valvesoftware.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  drivers/hid/hid-logitech-hidpp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index cadf36d6c6f3..f415bf398e17 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3511,6 +3511,12 @@ static bool hidpp_validate_report(struct hid_devic=
e *hdev, int id,
>
>  static bool hidpp_validate_device(struct hid_device *hdev)
>  {
> +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> +
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
> +               return hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> +                                            HIDPP_REPORT_SHORT_LENGTH, f=
alse);
> +

with https://patchwork.kernel.org/patch/11184749/ we also have a need
for such a trick for BLE mice.

I wonder if we should not have a more common way of validating the devices

This can probably be handled later, as your patch fixes the current devices=
.

Cheers,
Benjamin

>         return hidpp_validate_report(hdev, REPORT_ID_HIDPP_SHORT,
>                                      HIDPP_REPORT_SHORT_LENGTH, false) &&
>                hidpp_validate_report(hdev, REPORT_ID_HIDPP_LONG,
> --
> 2.21.0
>

