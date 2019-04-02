Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85657C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5598220857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfDBOeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:34:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38227 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfDBOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:34:46 -0400
Received: by mail-qk1-f195.google.com with SMTP id g1so8028318qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 07:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4MCmPBHqF0QX2tQe3LYGcwav8besCv7EdyrlajFni8=;
        b=r643TsmsE+1PSJlxfWzV3KEnD6RjPmwZWQlYu9RB9aKDbhOvqTRs21+7UaXYQMDYVI
         +4D3L4excYVRSV7ee1gQ6rFjcJUa10a3XDsNEiX5VVdgOA0uKw70BrFqyEAGhQYPExtj
         8ZKL5mP3v0XhMfrN7LPxKnX6H8ypYYjfjPnj91ZwV0SZAMHyf1tqSN2Ma2DnqjMvU3Ry
         8WZnx4nQKE7xgrnqrs4q2Xk/BlXPON8nMgdT+FNnV2GdrFyizWbclEWIAtBblghatYs8
         YN3wD3g2w/+H0weGyHE/ITHDjg37G3CvwSY9NwyxQstsiqO4mmERasOeOEWLTYEi2rsI
         gadA==
X-Gm-Message-State: APjAAAWGoLUHnGufK84+Tm5TdM11ytXYkcExZ9fITOjmFL4DvTqNV1vG
        tWkrr1S20nc+I61FsDsDoTCgziTneIMJBZ6ECPcmtg==
X-Google-Smtp-Source: APXvYqzrLbDx3XrXHYGrnlOq8QQGeGNiA1FlUL+e3eQh1WwgdqolWQyPY461XWbycGoJ3jod1vdzrD6tgSLuyz+SE7o=
X-Received: by 2002:ae9:e909:: with SMTP id x9mr49874162qkf.130.1554215685107;
 Tue, 02 Apr 2019 07:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190327101848.25477-1-nsaenzjulienne@suse.de>
In-Reply-To: <20190327101848.25477-1-nsaenzjulienne@suse.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 2 Apr 2019 16:34:33 +0200
Message-ID: <CAO-hwJJEkuxdgZ2vRO-HV1Z6yNxjvVRf82ncPRBVJ=5ujyRsRg@mail.gmail.com>
Subject: Re: [PATCH v4] HID: core: move Usage Page concatenation to Main item
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

On Wed, Mar 27, 2019 at 11:19 AM Nicolas Saenz Julienne
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

Applied to for-5.2/core with Terry's reviewed-by.

Thanks everybody.

Cheers,
Benjamin

>
> v3->v4: - Use u8 instead of __u8
>         - Remove overly complex usage size calculation
>
> v2->v3: - Update patch title
>
> v1->v2: - Add usage concatenation to hid_scan_main()
>         - Rework tests in hid-tools, making sure no-one is failing
>
>  drivers/hid/hid-core.c | 36 ++++++++++++++++++++++++------------
>  include/linux/hid.h    |  1 +
>  2 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 9993b692598f..852bbd303d9a 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
>   * Add a usage to the temporary parser table.
>   */
>
> -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> +static int hid_add_usage(struct hid_parser *parser, unsigned usage, u8 size)
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
> @@ -547,6 +539,22 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
>         return 0;
>  }
>
> +/*
> + * Concatenate Usage Pages into Usages where relevant:
> + * As per specification, 6.2.2.8: "When the parser encounters a main item it
> + * concatenates the last declared Usage Page with a Usage to form a complete
> + * usage value."
> + */
> +
> +static void hid_concatenate_usage_page(struct hid_parser *parser)
> +{
> +       int i;
> +
> +       for (i = 0; i < parser->local.usage_index; i++)
> +               if (parser->local.usage_size[i] <= 2)
> +                       parser->local.usage[i] += parser->global.usage_page << 16;
> +}
> +
>  /*
>   * Process a main item.
>   */
> @@ -556,6 +564,8 @@ static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
>         __u32 data;
>         int ret;
>
> +       hid_concatenate_usage_page(parser);
> +
>         data = item_udata(item);
>
>         switch (item->tag) {
> @@ -765,6 +775,8 @@ static int hid_scan_main(struct hid_parser *parser, struct hid_item *item)
>         __u32 data;
>         int i;
>
> +       hid_concatenate_usage_page(parser);
> +
>         data = item_udata(item);
>
>         switch (item->tag) {
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index f9707d1dcb58..ac0c70b4ce10 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -417,6 +417,7 @@ struct hid_global {
>
>  struct hid_local {
>         unsigned usage[HID_MAX_USAGES]; /* usage array */
> +       u8 usage_size[HID_MAX_USAGES]; /* usage size array */
>         unsigned collection_index[HID_MAX_USAGES]; /* collection index array */
>         unsigned usage_index;
>         unsigned usage_minimum;
> --
> 2.21.0
>
