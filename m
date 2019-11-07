Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E31FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5764C21D7F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzyNDpSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbfKGIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:48:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41374 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727408AbfKGIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573116506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GkaaySWUIuikkrk8Qp2LFGG/L7X0kNfIu5fvLKbIgk=;
        b=NzyNDpSKr7sNZciskMSmKQw5zFGKJALA7piHiImrI5gL0rUF56EjkfzZWC1YFpV/EY5mpM
        v8iKdZqhrJHIfuj7SDsxufc4mvxOzBB7tWmP3mHOKKe0E4ZaKxc6fw0IUySgUzRiFU15kq
        1cA7gZXS8BjbGg4O7a6DKjZfc9fSv6s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-aF4NKaqTOa2FBXqgmi5b2Q-1; Thu, 07 Nov 2019 03:48:25 -0500
Received: by mail-qt1-f197.google.com with SMTP id b26so1687004qtr.23
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5GkaaySWUIuikkrk8Qp2LFGG/L7X0kNfIu5fvLKbIgk=;
        b=QYTyEBKAKoYJdHwOp2mQHCdlI+df3eK/TnUyvglZG6+ISkhM23wPe87uv0UunkIQ6g
         Qvjq+DnJnT/kB4+OObzTRGxuM1/Bzr0N32EMrec/XGPVwYbDwjPS0vIj8XFAKyuzHwJO
         Fi77b12rWwIBxz5dW4xZ+UybsM7dMaFsp95emgtGIc9a2+pRh9v7nAZoP3W/1V6b0lN/
         mv6Sb46WMZtaRhydOpUg4LXSpVE0JBc6ZUNt6wE9PvMp13Eh6ub7C9nlpFzmhvJ0F8hR
         pMc7wajxHA5f9HrmJFdYf2QBM/+CXb7GvuN5jUpNzsXlLbbpOAcBk7sC1ctCtXKqVG6u
         FCCQ==
X-Gm-Message-State: APjAAAUs+DustxpLcxNhx/OetMuL/rjXIr5yHRAuZOGQFrYN5XzroftM
        33X2iXjuqaIxozdCuW+OhWd8Ll2I5uBGsD7Y+25ZcFmGUkwTRemyYLlb6yhKyvEzf6kjWP+sl1h
        ePAD+G+QuQt61k85Q3r48jB4tGWhr7HNtrfrwYopl
X-Received: by 2002:a37:4b97:: with SMTP id y145mr1636940qka.133.1573116503887;
        Thu, 07 Nov 2019 00:48:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtse75twJz4aKiv1RqxK/wmk+xVaMgjdKKBd8QMtQCzC/6EdhjtKwtV/rfIIFjcOSfTsg+b9SKEFmXuweXrIc=
X-Received: by 2002:a37:98c6:: with SMTP id a189mr1714662qke.230.1573116500554;
 Thu, 07 Nov 2019 00:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20191106110246.70937-1-blaz@mxxn.io>
In-Reply-To: <20191106110246.70937-1-blaz@mxxn.io>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 7 Nov 2019 09:48:09 +0100
Message-ID: <CAO-hwJKJvkW2_Dif4+P7ebBXwb-tLk+PHqks7yqevVZ-CHyTCQ@mail.gmail.com>
Subject: Re: [PATCH] HID: Improve Windows Precision Touchpad detection.
To:     =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-MC-Unique: aF4NKaqTOa2FBXqgmi5b2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bla=C5=BE,

On Wed, Nov 6, 2019 at 12:03 PM Bla=C5=BE Hrastnik <blaz@mxxn.io> wrote:
>
> Per Microsoft spec, usage 0xC5 (page 0xFF) returns a blob containing
> data used to verify the touchpad as a Windows Precision Touchpad.
>
>    0x85, REPORTID_PTPHQA,    //    REPORT_ID (PTPHQA)
>     0x09, 0xC5,              //    USAGE (Vendor Usage 0xC5)
>     0x15, 0x00,              //    LOGICAL_MINIMUM (0)
>     0x26, 0xff, 0x00,        //    LOGICAL_MAXIMUM (0xff)
>     0x75, 0x08,              //    REPORT_SIZE (8)
>     0x96, 0x00, 0x01,        //    REPORT_COUNT (0x100 (256))
>     0xb1, 0x02,              //    FEATURE (Data,Var,Abs)
>
> However, some devices, namely Microsoft's Surface line of products
> instead implement a "segmented device certification report" (usage 0xC6)
> which returns the same report, but in smaller chunks.
>
>     0x06, 0x00, 0xff,        //     USAGE_PAGE (Vendor Defined)
>     0x85, REPORTID_PTPHQA,   //     REPORT_ID (PTPHQA)
>     0x09, 0xC6,              //     USAGE (Vendor usage for segment #)
>     0x25, 0x08,              //     LOGICAL_MAXIMUM (8)
>     0x75, 0x08,              //     REPORT_SIZE (8)
>     0x95, 0x01,              //     REPORT_COUNT (1)
>     0xb1, 0x02,              //     FEATURE (Data,Var,Abs)
>     0x09, 0xC7,              //     USAGE (Vendor Usage)
>     0x26, 0xff, 0x00,        //     LOGICAL_MAXIMUM (0xff)
>     0x95, 0x20,              //     REPORT_COUNT (32)
>     0xb1, 0x02,              //     FEATURE (Data,Var,Abs)
>
> By expanding Win8 touchpad detection to also look for the segmented
> report, all Surface touchpads are now properly recognized by
> hid-multitouch.
>
> Signed-off-by: Bla=C5=BE Hrastnik <blaz@mxxn.io>
> ---

This looks good to me.
We *could* shorten the ifs and make only one conditional, but I find
it this way more readable and future proof.

There is just one last step required before we merge this: add a
regression test so we ensure we do not break it in the future.

It should be merely a matter of sending a MR to
https://gitlab.freedesktop.org/libevdev/hid-tools.
It should consist in adding the report descriptor in the same way we
have https://gitlab.freedesktop.org/libevdev/hid-tools/blob/master/tests/te=
st_multitouch.py#L1656-1658.
Then, make sure an unpatched kernel breaks the multitouch test (sudo
pytest-3 -k 'multitouch and TestPTP') and that a patched kernel is
fixed.

Cheers,
Benjamin

>  drivers/hid/hid-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 63fdbf09b044..2af597cd5d65 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -742,6 +742,10 @@ static void hid_scan_feature_usage(struct hid_parser=
 *parser, u32 usage)
>         if (usage =3D=3D 0xff0000c5 && parser->global.report_count =3D=3D=
 256 &&
>             parser->global.report_size =3D=3D 8)
>                 parser->scan_flags |=3D HID_SCAN_FLAG_MT_WIN_8;
> +
> +       if (usage =3D=3D 0xff0000c6 && parser->global.report_count =3D=3D=
 1 &&
> +           parser->global.report_size =3D=3D 8)
> +               parser->scan_flags |=3D HID_SCAN_FLAG_MT_WIN_8;
>  }
>
>  static void hid_scan_collection(struct hid_parser *parser, unsigned type=
)
> --
> 2.23.0
>

