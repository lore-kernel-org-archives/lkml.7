Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA57C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696FA218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfDXNai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:30:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46338 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfDXNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:30:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id w26so13426285qto.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 06:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ4M9Io+vxUkyqK34cCWUDRN+7XRjk6lhLR+A0NuYVU=;
        b=WKf5F3egt4XB+4xW/BWg5aaxFPSHG2Pf355Cm3TfZl4UXicstpXsqJYTLyEV3sgdwd
         RwvCBv++PAv3nJVWTMZEkIBJjYfzRKH/6LRLoNTIZKW1YKfq75GRqj2Kmbv0rbJ1NGyr
         iPNXkZspWKdNrPrxle7dFvzUwOuPG0RqBnfiKlDGopEWbHoHG5F+oEkrrLiY0ORIXPDX
         qGr1+Jp6icuZgbkrKnRSUZA79AzW1YAuUKKeq9gAXqV9EoAsmIbgebS+bnR9JXi6CRWz
         rY9fFylOT7N+d6nzsTh5notTGqKqeFEaPUlyWzRNTjNh2lPGs5MrvFQNDQHdBlR/Ndgj
         hJEQ==
X-Gm-Message-State: APjAAAWkAybu83ygHdfFBNhDDQ0j5Virj4kt5NHGIKYbhmn9925MxNgX
        TQPH01c0c2ORsWhgf0Z/V7u7uaGRX1Huw51edJdA/PN6
X-Google-Smtp-Source: APXvYqzYFH9BBtykJYKoreMaWTEcePJBi39zZGLV6EXF4eWlCO41W8sQvg5UHUogeMVsAee5XajVj7uE8CWKR6QZ7nI=
X-Received: by 2002:a0c:aed4:: with SMTP id n20mr25701121qvd.136.1556112636589;
 Wed, 24 Apr 2019 06:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 24 Apr 2019 15:30:25 +0200
Message-ID: <CAO-hwJLCL95pAzO9kco2jo2_uCV2=3f5OEf=P=AoB9EpEjFTAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: input: make sure the wheel high resolution
 multiplier is set
To:     Jiri Kosina <jikos@kernel.org>, James Feeney <james@nurealm.net>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 5:46 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Some old mice have a tendency to not accept the high resolution multiplier.
> They reply with a -EPIPE which was previously ignored.
>
> Force the call to resolution multiplier to be synchronous and actually
> check for the answer. If this fails, consider the mouse like a normal one.
>
> Fixes: 2dc702c991e377 ("HID: input: use the Resolution Multiplier for
>        high-resolution scrolling")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1700071
> Reported-and-tested-by: James Feeney <james@nurealm.net>
> Cc: stable@vger.kernel.org  # v5.0+
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Given that this basically breaks a basic functionality of many
Microsoft mice, I went ahead and applied this series to
for-5.1/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/hid-core.c  |  7 +++-
>  drivers/hid/hid-input.c | 81 +++++++++++++++++++++++++----------------
>  include/linux/hid.h     |  2 +-
>  3 files changed, 56 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 76464aabd20c..92387fc0bf18 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1637,7 +1637,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
>   * Implement a generic .request() callback, using .raw_request()
>   * DO NOT USE in hid drivers directly, but through hid_hw_request instead.
>   */
> -void __hid_request(struct hid_device *hid, struct hid_report *report,
> +int __hid_request(struct hid_device *hid, struct hid_report *report,
>                 int reqtype)
>  {
>         char *buf;
> @@ -1646,7 +1646,7 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
>
>         buf = hid_alloc_report_buf(report, GFP_KERNEL);
>         if (!buf)
> -               return;
> +               return -ENOMEM;
>
>         len = hid_report_len(report);
>
> @@ -1663,8 +1663,11 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
>         if (reqtype == HID_REQ_GET_REPORT)
>                 hid_input_report(hid, report->type, buf, ret, 0);
>
> +       ret = 0;
> +
>  out:
>         kfree(buf);
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(__hid_request);
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 1fce0076e7dc..fadf76f0a386 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1542,52 +1542,71 @@ static void hidinput_close(struct input_dev *dev)
>         hid_hw_close(hid);
>  }
>
> -static void hidinput_change_resolution_multipliers(struct hid_device *hid)
> +static bool __hidinput_change_resolution_multipliers(struct hid_device *hid,
> +               struct hid_report *report, bool use_logical_max)
>  {
> -       struct hid_report_enum *rep_enum;
> -       struct hid_report *rep;
>         struct hid_usage *usage;
> +       bool update_needed = false;
>         int i, j;
>
> -       rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
> -       list_for_each_entry(rep, &rep_enum->report_list, list) {
> -               bool update_needed = false;
> +       if (report->maxfield == 0)
> +               return false;
>
> -               if (rep->maxfield == 0)
> -                       continue;
> +       /*
> +        * If we have more than one feature within this report we
> +        * need to fill in the bits from the others before we can
> +        * overwrite the ones for the Resolution Multiplier.
> +        */
> +       if (report->maxfield > 1) {
> +               hid_hw_request(hid, report, HID_REQ_GET_REPORT);
> +               hid_hw_wait(hid);
> +       }
>
> -               /*
> -                * If we have more than one feature within this report we
> -                * need to fill in the bits from the others before we can
> -                * overwrite the ones for the Resolution Multiplier.
> +       for (i = 0; i < report->maxfield; i++) {
> +               __s32 value = use_logical_max ?
> +                             report->field[i]->logical_maximum :
> +                             report->field[i]->logical_minimum;
> +
> +               /* There is no good reason for a Resolution
> +                * Multiplier to have a count other than 1.
> +                * Ignore that case.
>                  */
> -               if (rep->maxfield > 1) {
> -                       hid_hw_request(hid, rep, HID_REQ_GET_REPORT);
> -                       hid_hw_wait(hid);
> -               }
> +               if (report->field[i]->report_count != 1)
> +                       continue;
>
> -               for (i = 0; i < rep->maxfield; i++) {
> -                       __s32 logical_max = rep->field[i]->logical_maximum;
> +               for (j = 0; j < report->field[i]->maxusage; j++) {
> +                       usage = &report->field[i]->usage[j];
>
> -                       /* There is no good reason for a Resolution
> -                        * Multiplier to have a count other than 1.
> -                        * Ignore that case.
> -                        */
> -                       if (rep->field[i]->report_count != 1)
> +                       if (usage->hid != HID_GD_RESOLUTION_MULTIPLIER)
>                                 continue;
>
> -                       for (j = 0; j < rep->field[i]->maxusage; j++) {
> -                               usage = &rep->field[i]->usage[j];
> +                       *report->field[i]->value = value;
> +                       update_needed = true;
> +               }
> +       }
> +
> +       return update_needed;
> +}
>
> -                               if (usage->hid != HID_GD_RESOLUTION_MULTIPLIER)
> -                                       continue;
> +static void hidinput_change_resolution_multipliers(struct hid_device *hid)
> +{
> +       struct hid_report_enum *rep_enum;
> +       struct hid_report *rep;
> +       int ret;
>
> -                               *rep->field[i]->value = logical_max;
> -                               update_needed = true;
> +       rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
> +       list_for_each_entry(rep, &rep_enum->report_list, list) {
> +               bool update_needed = __hidinput_change_resolution_multipliers(hid,
> +                                                                    rep, true);
> +
> +               if (update_needed) {
> +                       ret = __hid_request(hid, rep, HID_REQ_SET_REPORT);
> +                       if (ret) {
> +                               __hidinput_change_resolution_multipliers(hid,
> +                                                                   rep, false);
> +                               return;
>                         }
>                 }
> -               if (update_needed)
> -                       hid_hw_request(hid, rep, HID_REQ_SET_REPORT);
>         }
>
>         /* refresh our structs */
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ac0c70b4ce10..5a24ebfb5b47 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -894,7 +894,7 @@ struct hid_field *hidinput_get_led_field(struct hid_device *hid);
>  unsigned int hidinput_count_leds(struct hid_device *hid);
>  __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
>  void hid_output_report(struct hid_report *report, __u8 *data);
> -void __hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype);
> +int __hid_request(struct hid_device *hid, struct hid_report *rep, int reqtype);
>  u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
>  struct hid_device *hid_allocate_device(void);
>  struct hid_report *hid_register_report(struct hid_device *device,
> --
> 2.19.2
>
