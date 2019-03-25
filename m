Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1A220863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfCYKj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:39:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36970 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfCYKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:39:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so9618151qtn.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PjRdDLknxfMaB5QaAXk6qBv900t7usa1MmMsYkHwcs=;
        b=XPOgx1ynjt3BYcbA6N0smxnLpTNlmvJt4luwxQjKLPl/FBa7/qPjbrpJz8boJno0Wn
         tvdVBr0wfYNGYB7Z3FaFrP/hi5+kb87pMmx29Ck7t9DYXBiIXU2MsCzc78NpA395E4pJ
         jH67P+09tOgDiNVpTcq50hASLFPkGs50DWdfDAzqrFzRq5UJ3LE/Ae6IyUfxHr9YJU++
         SW9Mv21S5ViCQsy4rbST3mGvmZ1I1o0/TfkfKfez+7qR55U+u9/mCKzsUypGWqaNa805
         aQFKrq+ofvX+6ovklXGdbvmpB6sVqWMdD9JUuJLuFdxXW7G9TZJ7TLm5HpFtk5ODpkBb
         TdwA==
X-Gm-Message-State: APjAAAUl8GeddMojPib21fqjkwc9h8z7e4oZ4CqGPbjVv/XCtkuXJV1D
        jJ729reYFjACHvSB3lAnubEE3eRz1QodWbp7EwmQTeMU
X-Google-Smtp-Source: APXvYqwPuqGazEuUlHkxbuHVmhJmVEXl/ruGAVtRKoFQbQLeHM+wWzkW4YMGQDo/C3zw1S0gd5vTck7aUgvHxKp3NlI=
X-Received: by 2002:ac8:247c:: with SMTP id d57mr19774851qtd.308.1553510397961;
 Mon, 25 Mar 2019 03:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190312093652.12829-1-nsaenzjulienne@suse.de>
In-Reply-To: <20190312093652.12829-1-nsaenzjulienne@suse.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 25 Mar 2019 11:39:46 +0100
Message-ID: <CAO-hwJKo84vMDubVZM8Tye9wyGYkLC9sOVNUw=hUbzH1ktGv1A@mail.gmail.com>
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

Hi Nicolas,

On Tue, Mar 12, 2019 at 10:37 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> As seen on some USB wireless keyboards manufactured by Primax, the HID
> parser was using some assumptions that are not always true. In this case
> it's s the fact that, inside the scope of a main item, an Usage Page
> will always precede an Usage.
>
> The spec is not pretty clear as 6.2.2.7 states "Any usage that follows
> is interpreted as a Usage ID and concatenated with the Usage Page".
> While 6.2.2.8 states "When the parser encounters a main item it
> concatenates the last declared Usage Page with a Usage to form a
> complete usage value." Being somewhat contradictory it was decided to
> match Window's implementation, which follows 6.2.2.8.
>
> In summary, the patch moves the Usage Page concatenation from the local
> item parsing function to the main item parsing function.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Patch looks good to me.

Terry, did you have time to review it?

Cheers,
Benjamin

>
> Note: A PR in hid-tools shoud show up anytime soon
>
>  drivers/hid/hid-core.c | 30 ++++++++++++++++++------------
>  include/linux/hid.h    |  1 +
>  2 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9993b692598f..158468ef23a6 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
>   * Add a usage to the temporary parser table.
>   */
>
> -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> +static int hid_add_usage(struct hid_parser *parser, unsigned usage, __u8 size)
>  {
>         if (parser->local.usage_index >= HID_MAX_USAGES) {
>                 hid_err(parser->device, "usage index exceeded\n");
>                 return -1;
>         }
>         parser->local.usage[parser->local.usage_index] = usage;
> +       parser->local.usage_size[parser->local.usage_index] = size;
>         parser->local.collection_index[parser->local.usage_index] =
>                 parser->collection_stack_ptr ?
>                 parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
> @@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                         return 0;
>                 }
>
> -               if (item->size <= 2)
> -                       data = (parser->global.usage_page << 16) + data;
> -
> -               return hid_add_usage(parser, data);
> +               return hid_add_usage(parser, data, item->size);
>
>         case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
>
> @@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                         return 0;
>                 }
>
> -               if (item->size <= 2)
> -                       data = (parser->global.usage_page << 16) + data;
> -
>                 parser->local.usage_minimum = data;
>                 return 0;
>
> @@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                         return 0;
>                 }
>
> -               if (item->size <= 2)
> -                       data = (parser->global.usage_page << 16) + data;
> -
>                 count = data - parser->local.usage_minimum;
>                 if (count + parser->local.usage_index >= HID_MAX_USAGES) {
>                         /*
> @@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>                 }
>
>                 for (n = parser->local.usage_minimum; n <= data; n++)
> -                       if (hid_add_usage(parser, n)) {
> +                       if (hid_add_usage(parser, n, item->size)) {
>                                 dbg_hid("hid_add_usage failed\n");
>                                 return -1;
>                         }
> @@ -553,8 +545,22 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>
>  static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
>  {
> +       unsigned int usages;
>         __u32 data;
>         int ret;
> +       int i;
> +
> +       usages = max_t(unsigned, parser->local.usage_index,
> +                                parser->global.report_count);
> +
> +       /*
> +        * As per specification, 6.2.2.8:
> +        * "When the parser encounters a main item it concatenates the last
> +        * declared Usage Page with a Usage to form a complete usage value."
> +        */
> +       for (i = 0; i < usages; i++)
> +               if (parser->local.usage_size[i] <= 2)
> +                       parser->local.usage[i] += parser->global.usage_page << 16;
>
>         data = item_udata(item);
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index f9707d1dcb58..d1fb4b678873 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -417,6 +417,7 @@ struct hid_global {
>
>  struct hid_local {
>         unsigned usage[HID_MAX_USAGES]; /* usage array */
> +       __u8 usage_size[HID_MAX_USAGES]; /* usage size array */
>         unsigned collection_index[HID_MAX_USAGES]; /* collection index array */
>         unsigned usage_index;
>         unsigned usage_minimum;
> --
> 2.21.0
>
