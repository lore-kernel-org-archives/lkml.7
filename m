Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE7EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD5123711
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfIDHZw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDHZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:25:52 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78D3BC04D293
        for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2019 07:25:51 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id x11so21748451qtm.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 00:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qGt7/Asvjla5NLjhNtTVWV76tKsaxhQMsyUh6I8J27A=;
        b=ZLNOvsnVjlqzydQtbqOEVGPEuYk99mgR0IqKLZlIIyUaL5E0mOGWNADjvgVLLMpUpm
         eBXvvGQkIdtZD3epMQRy6YOf6UoEV8+fw/Puaaj8JQc8UdA2UHM7I9YVnQbAeUqopIf7
         3nCABoMSts3GVwVpOq6G4Dzjkk88Ftq/rLv5Ss3aYzR2lQghAKw/Hh8ZSDs8lyRNux5g
         /GxZJl+3osm9AFmCZOfnoRPipxQ/mV/VCZch4Bt0hgeZK4L1hZZ3ST5H6UriLc2wMX6Q
         6f9br/Qz+05YyCMqJtrxOZZ4YXUegKx35m2sddP1pqOTd7MflhBw3nkqXWvBfOkGsbdL
         SmgQ==
X-Gm-Message-State: APjAAAXWNpKzedQ1wYPKMXwjBY8aI7AKLVY/vYM7/BzrP4Nf3+tcEAkh
        SBLpiU5CoaIQttxnMMLXwyDaL8mO0SuhrdktSvADFsxQu12cS3A48kquajrS4YtMXqION8lPO8N
        z20mdr5bODaJvUiqcRr6zBvbWHyqrPm7PoKfz4P6K
X-Received: by 2002:a0c:afe6:: with SMTP id t35mr7541973qvc.29.1567581950732;
        Wed, 04 Sep 2019 00:25:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0M8yUCb0WYixzLgIMORz7xhZ11Kr5p8HFZwGTG6xWd+7Qxtmg+iNn2bUV+vuS1zR+c+tR1J0zYys01uH0UmQ=
X-Received: by 2002:a0c:afe6:: with SMTP id t35mr7541962qvc.29.1567581950479;
 Wed, 04 Sep 2019 00:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190903144632.26299-1-benjamin.tissoires@redhat.com> <CAHxFc3SXM6hkbpTGZCsWOk70tByHE8af59ftOBwahY4fL0Sz=g@mail.gmail.com>
In-Reply-To: <CAHxFc3SXM6hkbpTGZCsWOk70tByHE8af59ftOBwahY4fL0Sz=g@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 4 Sep 2019 09:25:39 +0200
Message-ID: <CAO-hwJLunZZr0f2u8TMV8REbq-nCGyJtMmWzTo6F2yTMcUbnEQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: apple: Fix stuck function keys when using FN
To:     =?UTF-8?B?Sm/Do28gTW9yZW5v?= <mail@joaomoreno.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 8:33 PM João Moreno <mail@joaomoreno.com> wrote:
>
> Hi Benjamin,
>
> On Tue, 3 Sep 2019 at 16:46, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > From: Joao Moreno <mail@joaomoreno.com>
> >
> > This fixes an issue in which key down events for function keys would be
> > repeatedly emitted even after the user has raised the physical key. For
> > example, the driver fails to emit the F5 key up event when going through
> > the following steps:
> > - fnmode=1: hold FN, hold F5, release FN, release F5
> > - fnmode=2: hold F5, hold FN, release F5, release FN
> >
> > The repeated F5 key down events can be easily verified using xev.
> >
> > Signed-off-by: Joao Moreno <mail@joaomoreno.com>
> > Co-developed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >
> > Hi Joao,
> >
> > last chance to pull back :)
> >
> > If you are still happy, I'll push this version
> >
> > Cheers,
> > Benjamin
> >
>
> Looks great. Thanks a bunch for your help!
>

Thanks.

Applied to for-5.4/apple

Cheers,
Benjamin

> Cheers,
> João
>
> >  drivers/hid/hid-apple.c | 49 +++++++++++++++++++++++------------------
> >  1 file changed, 28 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 81df62f48c4c..6ac8becc2372 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -54,7 +54,6 @@ MODULE_PARM_DESC(swap_opt_cmd, "Swap the Option (\"Alt\") and Command (\"Flag\")
> >  struct apple_sc {
> >         unsigned long quirks;
> >         unsigned int fn_on;
> > -       DECLARE_BITMAP(pressed_fn, KEY_CNT);
> >         DECLARE_BITMAP(pressed_numlock, KEY_CNT);
> >  };
> >
> > @@ -181,6 +180,8 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
> >  {
> >         struct apple_sc *asc = hid_get_drvdata(hid);
> >         const struct apple_key_translation *trans, *table;
> > +       bool do_translate;
> > +       u16 code = 0;
> >
> >         if (usage->code == KEY_FN) {
> >                 asc->fn_on = !!value;
> > @@ -189,8 +190,6 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
> >         }
> >
> >         if (fnmode) {
> > -               int do_translate;
> > -
> >                 if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
> >                                 hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
> >                         table = macbookair_fn_keys;
> > @@ -202,25 +201,33 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
> >                 trans = apple_find_translation (table, usage->code);
> >
> >                 if (trans) {
> > -                       if (test_bit(usage->code, asc->pressed_fn))
> > -                               do_translate = 1;
> > -                       else if (trans->flags & APPLE_FLAG_FKEY)
> > -                               do_translate = (fnmode == 2 && asc->fn_on) ||
> > -                                       (fnmode == 1 && !asc->fn_on);
> > -                       else
> > -                               do_translate = asc->fn_on;
> > -
> > -                       if (do_translate) {
> > -                               if (value)
> > -                                       set_bit(usage->code, asc->pressed_fn);
> > -                               else
> > -                                       clear_bit(usage->code, asc->pressed_fn);
> > -
> > -                               input_event(input, usage->type, trans->to,
> > -                                               value);
> > -
> > -                               return 1;
> > +                       if (test_bit(trans->from, input->key))
> > +                               code = trans->from;
> > +                       else if (test_bit(trans->to, input->key))
> > +                               code = trans->to;
> > +
> > +                       if (!code) {
> > +                               if (trans->flags & APPLE_FLAG_FKEY) {
> > +                                       switch (fnmode) {
> > +                                       case 1:
> > +                                               do_translate = !asc->fn_on;
> > +                                               break;
> > +                                       case 2:
> > +                                               do_translate = asc->fn_on;
> > +                                               break;
> > +                                       default:
> > +                                               /* should never happen */
> > +                                               do_translate = false;
> > +                                       }
> > +                               } else {
> > +                                       do_translate = asc->fn_on;
> > +                               }
> > +
> > +                               code = do_translate ? trans->to : trans->from;
> >                         }
> > +
> > +                       input_event(input, usage->type, code, value);
> > +                       return 1;
> >                 }
> >
> >                 if (asc->quirks & APPLE_NUMLOCK_EMULATION &&
> > --
> > 2.19.2
> >
