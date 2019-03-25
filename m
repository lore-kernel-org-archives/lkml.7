Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1512082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfCYPJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:09:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44159 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCYPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:09:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id w5so10608845qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 08:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0CbBSAdR00hPNq0KX5pNvYsZ16sEyj0WiDvHgddMss=;
        b=EC1Kyr6r/5EpBvDV3K39bGpPpEyRRy8YZEsgEHVWk1ia8XQayxgpHV2iOmMbKn3aC7
         1VP82fmsnfpqLtRI6eaNDoObyyOVEfV5BTofdXuWHWkuCHCL6HM6dRA21Xsd7ocPQ+YS
         ef/hrurqWF1k4HwyIG3PR0ds+TyoAibO8MycyoUGE+OwSmrpGbTWr7+tagnYfmUO4Gfp
         mp/wJzNEmepBep1vqhs5Mmozf11CLxirQk3cbf4INwBA7EH6YINchtoG5IRikP7oXPiP
         lT8znQ8xlshimSXUA+oa5z5mcTDCVTOZmbaIlVWznoy8BncB7bOkNCkiIIOjF1hQuD31
         t9Hg==
X-Gm-Message-State: APjAAAX7Qntj4pATFeKWBmv8KgzHvNSgnpsLOfFW5s9lx3NFzFhUTdLK
        DLZfTcmW0F741JuNpgpPAiS5aYq79OEonI12+d+tAcaZJjY=
X-Google-Smtp-Source: APXvYqyv/feGls2BEctY6+DJR9VK6Pez0zPxDlnc6nytx0TnVlS/EtpS5lC40oj65MVmH/y6gLT6jI0yLuVvCIwdJYs=
X-Received: by 2002:ac8:fd7:: with SMTP id f23mr20711193qtk.167.1553526546851;
 Mon, 25 Mar 2019 08:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190312093652.12829-1-nsaenzjulienne@suse.de> <CAO-hwJKo84vMDubVZM8Tye9wyGYkLC9sOVNUw=hUbzH1ktGv1A@mail.gmail.com>
In-Reply-To: <CAO-hwJKo84vMDubVZM8Tye9wyGYkLC9sOVNUw=hUbzH1ktGv1A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 25 Mar 2019 16:08:55 +0100
Message-ID: <CAO-hwJ+_CBJ1tkUpcedMM8dgbzyHk2GPdhnFxFN+bAckwQytmA@mail.gmail.com>
Subject: Re: [PATCH] HID: core: move Usage Page concatenation to hid_parser_main()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Jiri Kosina <jikos@kernel.org>, oneukum@suse.de,
        "Junge, Terry" <Terry.Junge@plantronics.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:39 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Nicolas,
>
> On Tue, Mar 12, 2019 at 10:37 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >
> > As seen on some USB wireless keyboards manufactured by Primax, the HID
> > parser was using some assumptions that are not always true. In this case
> > it's s the fact that, inside the scope of a main item, an Usage Page
> > will always precede an Usage.
> >
> > The spec is not pretty clear as 6.2.2.7 states "Any usage that follows
> > is interpreted as a Usage ID and concatenated with the Usage Page".
> > While 6.2.2.8 states "When the parser encounters a main item it
> > concatenates the last declared Usage Page with a Usage to form a
> > complete usage value." Being somewhat contradictory it was decided to
> > match Window's implementation, which follows 6.2.2.8.
> >
> > In summary, the patch moves the Usage Page concatenation from the local
> > item parsing function to the main item parsing function.
> >
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
>
> Patch looks good to me.
>
> Terry, did you have time to review it?
>
> Cheers,
> Benjamin
>
> >
> > Note: A PR in hid-tools shoud show up anytime soon
> >
> >  drivers/hid/hid-core.c | 30 ++++++++++++++++++------------
> >  include/linux/hid.h    |  1 +
> >  2 files changed, 19 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 9993b692598f..158468ef23a6 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
> >   * Add a usage to the temporary parser table.
> >   */
> >
> > -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> > +static int hid_add_usage(struct hid_parser *parser, unsigned usage, __u8 size)
> >  {
> >         if (parser->local.usage_index >= HID_MAX_USAGES) {
> >                 hid_err(parser->device, "usage index exceeded\n");
> >                 return -1;
> >         }
> >         parser->local.usage[parser->local.usage_index] = usage;
> > +       parser->local.usage_size[parser->local.usage_index] = size;
> >         parser->local.collection_index[parser->local.usage_index] =
> >                 parser->collection_stack_ptr ?
> >                 parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
> > @@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
> >                         return 0;
> >                 }
> >
> > -               if (item->size <= 2)
> > -                       data = (parser->global.usage_page << 16) + data;
> > -
> > -               return hid_add_usage(parser, data);
> > +               return hid_add_usage(parser, data, item->size);
> >
> >         case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
> >
> > @@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
> >                         return 0;
> >                 }
> >
> > -               if (item->size <= 2)
> > -                       data = (parser->global.usage_page << 16) + data;
> > -
> >                 parser->local.usage_minimum = data;
> >                 return 0;
> >
> > @@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
> >                         return 0;
> >                 }
> >
> > -               if (item->size <= 2)
> > -                       data = (parser->global.usage_page << 16) + data;
> > -
> >                 count = data - parser->local.usage_minimum;
> >                 if (count + parser->local.usage_index >= HID_MAX_USAGES) {
> >                         /*
> > @@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
> >                 }
> >
> >                 for (n = parser->local.usage_minimum; n <= data; n++)
> > -                       if (hid_add_usage(parser, n)) {
> > +                       if (hid_add_usage(parser, n, item->size)) {
> >                                 dbg_hid("hid_add_usage failed\n");
> >                                 return -1;
> >                         }
> > @@ -553,8 +545,22 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
> >
> >  static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
> >  {
> > +       unsigned int usages;
> >         __u32 data;
> >         int ret;
> > +       int i;
> > +
> > +       usages = max_t(unsigned, parser->local.usage_index,
> > +                                parser->global.report_count);
> > +
> > +       /*
> > +        * As per specification, 6.2.2.8:
> > +        * "When the parser encounters a main item it concatenates the last
> > +        * declared Usage Page with a Usage to form a complete usage value."
> > +        */
> > +       for (i = 0; i < usages; i++)
> > +               if (parser->local.usage_size[i] <= 2)
> > +                       parser->local.usage[i] += parser->global.usage_page << 16;

Actually, the good thing of having a test suite, is that it raises bugs :)

You are also missing the computation of the usage in hid_scan_main().
This makes the autoloading of hid-multitouch fail, and thus the test
suite failing.

Cheers,
Benjamin

> >
> >         data = item_udata(item);
> >
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index f9707d1dcb58..d1fb4b678873 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -417,6 +417,7 @@ struct hid_global {
> >
> >  struct hid_local {
> >         unsigned usage[HID_MAX_USAGES]; /* usage array */
> > +       __u8 usage_size[HID_MAX_USAGES]; /* usage size array */
> >         unsigned collection_index[HID_MAX_USAGES]; /* collection index array */
> >         unsigned usage_index;
> >         unsigned usage_minimum;
> > --
> > 2.21.0
> >
