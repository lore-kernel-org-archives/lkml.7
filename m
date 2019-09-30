Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6537EC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E0821855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e876S8J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfI3Jgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:36:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730033AbfI3Jgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569836198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0K7l5E0jT2kU7E4OL4KnInZb6DPLchuZ7JsMiIQYJgc=;
        b=e876S8J/DyakPLdMGrGqy6zCtIvqNcyxUiIfWY8xubZ8ebaKzR4asVVaX2C+pUbSUKkHwD
        RlqlZ5zy5PwyqH2UX75Nlp0RvIiMBVELaf+jZ5raL8dqvNewbpk6IC4xGV9mNtB+PNesJa
        G8nIxZaExpmD6nLgBfzD0uRFSKiozHs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-6fVc47QMNGm_x3N9qsa9uQ-1; Mon, 30 Sep 2019 05:36:36 -0400
Received: by mail-qk1-f198.google.com with SMTP id b143so10367050qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 02:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FLSITt2UCArtOmIOQcEejRtEdLk44vdWkXXB2cpNlQ=;
        b=c3tzBji9MNtH7MiDdiGY2EGbjeMOpz9EWh7tgCriHT7m8wqYNt2M4VEXXVNRiStykE
         +GRaXZv7goi0g828ruDjl4Iw63uhCPZ5aBw/HotYvYEhZ3TZasy1E1M4gddYnCwBZhAa
         jHbocXlxrcQAI7loos77xxyQhuIbAHVsgQLpQDsbBQ6Q9yyj+eTOwZR33JIzclmX9wby
         py0hZ+znGtgnePZtlia1vBRsPawEoDnX8XFIkCqyvH1fzO1T81fs1LXZgT0toGLR4UHa
         hgp7OT9MTjBOZQQMEokW/8f2U7y+j3oD0j3B8u6y8/t0YnrFlAtRzRVgZ0RlQ+Bwxu/C
         y2TQ==
X-Gm-Message-State: APjAAAUxjZMFLiWVJTNfnHEGHpmpBGNnRRj8tCeScWOaQo1BGtNB2Vj9
        Cxm7wQniOU5SM16OSZkvl+xbv5Hhr1GVLsziutADC34kEtokWEzDhOoz3AT7krou8AhHpMH6F4T
        3qjflee1DOmLNO9JW64rsQcxBBBIPhNZ+9ECD7me6
X-Received: by 2002:ac8:3059:: with SMTP id g25mr23587245qte.154.1569836195934;
        Mon, 30 Sep 2019 02:36:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbIXYQ5nToZ03gcL/MhsfLatCHv/lPXCzN/JBTkBDUnPnmdIqAmNgXNah7mRqwloYNXE3LbQulDbjDhXBiSzc=
X-Received: by 2002:ac8:3059:: with SMTP id g25mr23587233qte.154.1569836195675;
 Mon, 30 Sep 2019 02:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <1569830949-10771-1-git-send-email-candlesea@gmail.com>
In-Reply-To: <1569830949-10771-1-git-send-email-candlesea@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 30 Sep 2019 11:36:23 +0200
Message-ID: <CAO-hwJLrQTp7qeMpQvF7429a0qisAe-=zLFRtY79ajhLtusdRg@mail.gmail.com>
Subject: Re: [PATCH] HID: core: add usage_page_preceding flag for hid_concatenate_usage_page()
To:     Candle Sun <candlesea@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, chunyan.zhang@unisoc.com,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
X-MC-Unique: 6fVc47QMNGm_x3N9qsa9uQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[also addingg Nicolas, the author of 58e75155009c]

On Mon, Sep 30, 2019 at 10:10 AM Candle Sun <candlesea@gmail.com> wrote:
>
> From: Candle Sun <candle.sun@unisoc.com>
>
> Upstream commit 58e75155009c ("HID: core: move Usage Page concatenation
> to Main item") adds support for Usage Page item following Usage items
> (such as keyboards manufactured by Primax).
>
> Usage Page concatenation in Main item works well for following report
> descriptor patterns:
>
>     USAGE_PAGE (Keyboard)                   05 07
>     USAGE_MINIMUM (Keyboard LeftControl)    19 E0
>     USAGE_MAXIMUM (Keyboard Right GUI)      29 E7
>     LOGICAL_MINIMUM (0)                     15 00
>     LOGICAL_MAXIMUM (1)                     25 01
>     REPORT_SIZE (1)                         75 01
>     REPORT_COUNT (8)                        95 08
>     INPUT (Data,Var,Abs)                    81 02
>
> -------------
>
>     USAGE_MINIMUM (Keyboard LeftControl)    19 E0
>     USAGE_MAXIMUM (Keyboard Right GUI)      29 E7
>     LOGICAL_MINIMUM (0)                     15 00
>     LOGICAL_MAXIMUM (1)                     25 01
>     REPORT_SIZE (1)                         75 01
>     REPORT_COUNT (8)                        95 08
>     USAGE_PAGE (Keyboard)                   05 07
>     INPUT (Data,Var,Abs)                    81 02
>
> But it makes the parser act wrong for the following report
> descriptor pattern(such as some Gamepads):
>
>     USAGE_PAGE (Button)                     05 09
>     USAGE (Button 1)                        09 01
>     USAGE (Button 2)                        09 02
>     USAGE (Button 4)                        09 04
>     USAGE (Button 5)                        09 05
>     USAGE (Button 7)                        09 07
>     USAGE (Button 8)                        09 08
>     USAGE (Button 14)                       09 0E
>     USAGE (Button 15)                       09 0F
>     USAGE (Button 13)                       09 0D
>     USAGE_PAGE (Consumer Devices)           05 0C
>     USAGE (Back)                            0a 24 02
>     USAGE (HomePage)                        0a 23 02
>     LOGICAL_MINIMUM (0)                     15 00
>     LOGICAL_MAXIMUM (1)                     25 01
>     REPORT_SIZE (1)                         75 01
>     REPORT_COUNT (11)                       95 0B
>     INPUT (Data,Var,Abs)                    81 02
>
> With Usage Page concatenation in Main item, parser recognizes all the
> 11 Usages as consumer keys, it is not the HID device's real intention.
>
> This patch adds usage_page_preceding flag to detect the third pattern.
> Usage Page concatenation is done in both Local and Main parsing.
> If usage_page_preceding equals 3(the third pattern encountered),
> hid_concatenate_usage_page() is jumped.

For anything core related (and especially the parsing), I am trying to
enforce having regression tests.
See https://gitlab.freedesktop.org/libevdev/hid-tools/merge_requests/37
for the one related to 58e75155009c.

So I would like to have a similar-ish MR adding the matching tests so
I know we won't break this in the future.

Few other comments in the code:

>
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> ---
>  drivers/hid/hid-core.c | 21 +++++++++++++++++++--
>  include/linux/hid.h    |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 3eaee2c..043a232 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -221,7 +221,15 @@ static int hid_add_usage(struct hid_parser *parser, =
unsigned usage, u8 size)
>                 hid_err(parser->device, "usage index exceeded\n");
>                 return -1;
>         }
> -       parser->local.usage[parser->local.usage_index] =3D usage;
> +       if (!parser->local.usage_index && parser->global.usage_page)

parser->global.usage_page is never reset, so unless I am misreading,
it will always be set to a value except for the very first elements.
I am just raising this in case you rely on global.usage_page being
null in your algorithm.

> +               parser->local.usage_page_preceding =3D 1;
> +       if (parser->local.usage_page_preceding =3D=3D 2)
> +               parser->local.usage_page_preceding =3D 3;

Can't we use an enum at least for those 1, 2, 3 values?
Unless you are counting the previous items, in which we should rename
the field .usage_page_preceding with something more explicit IMO.


> +       if (size <=3D 2 && parser->global.usage_page)
> +               parser->local.usage[parser->local.usage_index] =3D
> +                       (usage & 0xffff) + (parser->global.usage_page << =
16);

we could use a function as this assignment is also reused in
hid_concatenate_usage_page()

> +       else
> +               parser->local.usage[parser->local.usage_index] =3D usage;
>         parser->local.usage_size[parser->local.usage_index] =3D size;
>         parser->local.collection_index[parser->local.usage_index] =3D
>                 parser->collection_stack_ptr ?
> @@ -366,6 +374,8 @@ static int hid_parser_global(struct hid_parser *parse=
r, struct hid_item *item)
>
>         case HID_GLOBAL_ITEM_TAG_USAGE_PAGE:
>                 parser->global.usage_page =3D item_udata(item);
> +               if (parser->local.usage_page_preceding =3D=3D 1)
> +                       parser->local.usage_page_preceding =3D 2;
>                 return 0;
>
>         case HID_GLOBAL_ITEM_TAG_LOGICAL_MINIMUM:
> @@ -547,9 +557,16 @@ static void hid_concatenate_usage_page(struct hid_pa=
rser *parser)
>  {
>         int i;
>
> +       if (parser->local.usage_page_preceding =3D=3D 3) {
> +               dbg_hid("Using preceding usage page for final usage\n");
> +               return;
> +       }
> +
>         for (i =3D 0; i < parser->local.usage_index; i++)
>                 if (parser->local.usage_size[i] <=3D 2)
> -                       parser->local.usage[i] +=3D parser->global.usage_=
page << 16;
> +                       parser->local.usage[i] =3D
> +                               (parser->global.usage_page << 16)
> +                               + (parser->local.usage[i] & 0xffff);

I find the whole logic really hard to follow. I'm not saying you are
wrong, but if it's hard to get the concepts behind the various states
and this will make it really prone to future errors.

I wonder if we should not:
- store the current usage page in the current local item as they come in
- then in hid_concatenate_usage_page() iterate over the usages in
reverse order. We should be able to detect if the last usage page was
given for the whole previous range (i.e. not assigned to any local
usage) or if it has already been given to a local usage, meaning we
should just keep things as it is.

Cheers,
Benjamin

>  }
>
>  /*
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index cd41f20..7fb6cf3 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -412,6 +412,7 @@ struct hid_local {
>         unsigned usage_minimum;
>         unsigned delimiter_depth;
>         unsigned delimiter_branch;
> +       unsigned int usage_page_preceding;
>  };
>
>  /*
> --
> 2.7.4
>

