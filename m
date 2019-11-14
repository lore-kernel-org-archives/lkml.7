Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B92C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98832206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbRXLqwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKNA6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:58:35 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41881 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKNA6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:58:35 -0500
Received: by mail-il1-f195.google.com with SMTP id q15so3691118ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OdeD7OqNa7shyV2JJY+k9JSRGsgFQ0975oOdNMOtpU=;
        b=JbRXLqwgOvARobcyQJURdfaqMqOYVB+64hepTiKiHXlGe9eh6JV2F23sfKDEWkv5LZ
         aeEhnSS2sjrbkDgqLkj1rPInZglrhN5X3QJYZ5Q3b8CjAy0CPSNXKMMutyasrF+Wbs3q
         IwC60JrEyeY4lmWhbXws9ik15rFATeB4mRe4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OdeD7OqNa7shyV2JJY+k9JSRGsgFQ0975oOdNMOtpU=;
        b=GQIxeNfZczxlRsgVD3dEyZdcE29sgFCzTK4KN45le72Zv4F8TOTmtdJZ910LdeiiES
         Wm59LTEkkHhZ9zZoNsysKYbARzF5VRjfAZcbqG1KgI1j1qg82taV4pXZyruceKINOA++
         7REhewpbh2C9YKfqoKw/aJWMza8GndE/lv0orG7BTh5jPcSZ+IdQIdtqfEQEd9JRSgqZ
         uhbxYnWOQd0C1qsD1H+mJ3n4JyyzE/DHQfsE06b9XdBLpuPl1TSyupHdHG0jc7CeBPg+
         YgQFt41u8WtZZQSMmQjBQSHmHyvGuK4REgujtwnGxSUeal0UBKBYMwCeHmb7scfC6+Sm
         7Ifg==
X-Gm-Message-State: APjAAAW85IphMk6VWK7qTZcLmAkUeE3ltg8F4JHu8PhFlq4pNCycMEiC
        o0Zqztayg4alnYChYixBqVuH0Al9iKAK2ni2XbiUbg==
X-Google-Smtp-Source: APXvYqyeDpFAzTHdW208zMg0vRkfsMHSbWDwOpBPuwYJVhznggV8XOPmeqTDxy6NKsjOyh+ra4bBfh+YAdUprAPDgl0=
X-Received: by 2002:a92:dd8f:: with SMTP id g15mr7047684iln.145.1573693114210;
 Wed, 13 Nov 2019 16:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20191105222652.70226-1-gwendal@chromium.org> <20191105222652.70226-6-gwendal@chromium.org>
 <20191110121750.78f0824f@archlinux> <acc58053-bd09-e4f4-e598-aabe1d151f85@collabora.com>
In-Reply-To: <acc58053-bd09-e4f4-e598-aabe1d151f85@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 13 Nov 2019 16:58:23 -0800
Message-ID: <CAPUE2usar2RyxXc_PvOE1W63_nUAUR7zJ8-rs=53=9RAr2+BKQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] platform: chrome: cros_ec: Do not attempt to
 register a non-positive IRQ number
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 1:29 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
>
>
> On 10/11/19 13:17, Jonathan Cameron wrote:
> > On Tue,  5 Nov 2019 14:26:40 -0800
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> >> Add a layer of sanity checking to cros_ec_register against attempting to
> >> register IRQ values that are not strictly greater than 0.
> >>
> >> Signed-off-by: Enrico Granata <egranata@chromium.org>
> >> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >
> > This strikes me as something that could be a potential fix to backport?
> > Any known cases of a negative irq getting to here or is this a by
> > inspection thing?
inspection only.

> >
> > Otherwise seems obviously correct.
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
>
> Looks good to me:
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Thanks,
>  Enric
>
> > Jonathan
> >
> >> ---
> >> No changes in v4, v3.
> >> Changes in v2:
> >>   Remove dual Enrico's signature.
> >>
> >>  drivers/platform/chrome/cros_ec.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> >> index 925f84dbf621..d3dfa27171e6 100644
> >> --- a/drivers/platform/chrome/cros_ec.c
> >> +++ b/drivers/platform/chrome/cros_ec.c
> >> @@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >>              return err;
> >>      }
> >>
> >> -    if (ec_dev->irq) {
> >> +    if (ec_dev->irq > 0) {
> >>              err = devm_request_threaded_irq(dev, ec_dev->irq,
> >>                                              ec_irq_handler,
> >>                                              ec_irq_thread,
> >
