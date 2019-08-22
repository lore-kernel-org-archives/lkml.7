Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBF823401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbfHVPtr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfHVPtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:49:47 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 958A0C08EC04
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:49:46 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id m198so6202288qke.22
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pskUH55ezZZYsmq8KUNRt7ni5u96u5d8lg/XOqXA4+M=;
        b=K/9c8rb9zGEKNaACXyFuv1whcBnLqqlYKT4A6TqPtqQ+uIvvBhZOApse1OTx88EYJQ
         Sml0L887YA12ilVdsTd9V5ppul9zdTJSwFaQ02aNdqJzzbKjoo1EFyNuGn17I4b7C712
         dN9blmGVDIWQ4C9Nn8YpaBp87bJFFDrZCLSWiTCsOwY3jXGQmRrn7Xyqknam7wG6uGGi
         19eqcpTNB8vvEzpVBFb2HjkvlpwDqE18/dKOzNqWWJiIVqHzsleNIEW8KsBpP3r2kHK5
         EUygpmsq8O67QZJ6yUcrL0cwOdj55kGX1OmgSkl66au4EqhH23Z0aAQcPqCDJjQKKVzj
         Pj3Q==
X-Gm-Message-State: APjAAAXMNGP0M/5i2pDu+gpeHHgPHIIMTxZkztaDw9MUupi3BlW9S9RW
        XYHh2v1h5EHb7dEf1o5nxxuGlWpGBvTnzd9NUF7+2dZt+nDglg15fb8CyPwmO1TBJBx1/GTGgTs
        l9hsshB1cc7qEc4ieFxQvRZl+x3gSYNoCYF6kPk7r
X-Received: by 2002:ac8:4910:: with SMTP id e16mr266355qtq.260.1566488985935;
        Thu, 22 Aug 2019 08:49:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDNL9hS7kz+2UHvZzCqEyaX9aCTR8za8u3UmrYTh3Cn122EQGqfKTcIr5o5tLp6aHPhmOEO5LlwvF9Y89t/9k=
X-Received: by 2002:ac8:4910:: with SMTP id e16mr266332qtq.260.1566488985726;
 Thu, 22 Aug 2019 08:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190812162740.15898-1-benjamin.tissoires@redhat.com>
 <20190812162740.15898-3-benjamin.tissoires@redhat.com> <CANRwn3QQcGVGx2KjoU0sG70gSjzwjDKUuL_8q-oYFHRYrn4qGQ@mail.gmail.com>
In-Reply-To: <CANRwn3QQcGVGx2KjoU0sG70gSjzwjDKUuL_8q-oYFHRYrn4qGQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 22 Aug 2019 17:49:34 +0200
Message-ID: <CAO-hwJLyHYmBKiEvcWebr5tyic9tnm1tydgqt8CimxsEaPWrYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: wacom: do not call hid_set_drvdata(hdev, NULL)
To:     Jason Gerecke <killertofu@gmail.com>
Cc:     =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ping Cheng <pinglinux@gmail.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 12:04 AM Jason Gerecke <killertofu@gmail.com> wrote:
>
> On Mon, Aug 12, 2019 at 9:29 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > This is a common pattern in the HID drivers to reset the drvdata.
> > However, this is actually already handled by driver core, so there
> > is no need to do it manually.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Thanks

Applied to for-5.4/wacom

Cheers,
Benjamin

>
> Jason
> ---
> Now instead of four in the eights place /
> you’ve got three, ‘Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can’t take seven from three,    /
> So you look at the sixty-fours....
>
>
> > ---
> >  drivers/hid/wacom_sys.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 53bddb50aeba..69ccfdd51a6f 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -2718,14 +2718,12 @@ static int wacom_probe(struct hid_device *hdev,
> >         wacom_wac->features = *((struct wacom_features *)id->driver_data);
> >         features = &wacom_wac->features;
> >
> > -       if (features->check_for_hid_type && features->hid_type != hdev->type) {
> > -               error = -ENODEV;
> > -               goto fail;
> > -       }
> > +       if (features->check_for_hid_type && features->hid_type != hdev->type)
> > +               return -ENODEV;
> >
> >         error = kfifo_alloc(&wacom_wac->pen_fifo, WACOM_PKGLEN_MAX, GFP_KERNEL);
> >         if (error)
> > -               goto fail;
> > +               return error;
> >
> >         wacom_wac->hid_data.inputmode = -1;
> >         wacom_wac->mode_report = -1;
> > @@ -2743,12 +2741,12 @@ static int wacom_probe(struct hid_device *hdev,
> >         error = hid_parse(hdev);
> >         if (error) {
> >                 hid_err(hdev, "parse failed\n");
> > -               goto fail;
> > +               return error;
> >         }
> >
> >         error = wacom_parse_and_register(wacom, false);
> >         if (error)
> > -               goto fail;
> > +               return error;
> >
> >         if (hdev->bus == BUS_BLUETOOTH) {
> >                 error = device_create_file(&hdev->dev, &dev_attr_speed);
> > @@ -2759,10 +2757,6 @@ static int wacom_probe(struct hid_device *hdev,
> >         }
> >
> >         return 0;
> > -
> > -fail:
> > -       hid_set_drvdata(hdev, NULL);
> > -       return error;
> >  }
> >
> >  static void wacom_remove(struct hid_device *hdev)
> > @@ -2791,8 +2785,6 @@ static void wacom_remove(struct hid_device *hdev)
> >                 wacom_release_resources(wacom);
> >
> >         kfifo_free(&wacom_wac->pen_fifo);
> > -
> > -       hid_set_drvdata(hdev, NULL);
> >  }
> >
> >  #ifdef CONFIG_PM
> > --
> > 2.19.2
> >
