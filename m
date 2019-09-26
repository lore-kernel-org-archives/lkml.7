Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C0C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E6C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bVUqyu6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfIZWoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:44:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37377 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfIZWoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:44:11 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so10934264iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2RBa1Aq2wGyPCj/7NlPZ9URqEf7+Teb++mDJA7G0Fo=;
        b=bVUqyu6ChxtpXtfiAdnqCFhnpn95dZG9LsB8SnMa2HrY0EnNnfcizsMzc4RMtHmS0I
         UIFIBwHZslqumlqW2bq6oplOBKDgAdjfce6m/uVb6cT54vZYeYhm8gsRXo4edasSPOKx
         jnAssqn6Lvaq7GGV6547JB9H7OqFIQY6bKxJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2RBa1Aq2wGyPCj/7NlPZ9URqEf7+Teb++mDJA7G0Fo=;
        b=YlhL4/p97x4jkSNkIVeMUbHW6GpZatbSVeSFGu8KZcyuH+Zq+vgven7sIbIEOLGIFJ
         Sx0vWJAXctFAmIckuJbst2x7SyeoY54DkbasPCf9mWn3yUigK0T6APaNbBCA7qlWh4Tm
         6j9VwXCh3FdoKSKhN6EjwF8IyB2eyu4mUJA+Aiwgeow4PNOs+PslwWXJB6sSPg9vP2px
         Cpnukg/xvlptBnCGLf4HfDt3U4kkTVHo2Y/uFhgStbUqtOZbgMdsSBrX5ttXyGSbJKFu
         rkLtTGRECR10zuHWbCQHKn4Rf89rRY47veqhMYrHfFe6Bhkcuhz9JCQXo+XfgLthyuZA
         t/Fg==
X-Gm-Message-State: APjAAAV4EkSOscx9IXJbdyklRKx4LEORd0vt5AB1gNjo2ZoSgIEWQl9X
        HoCjLM97IORw4XAWaDEgClmkECmBd2KIzOPVsZkZjXSshMEQQA==
X-Google-Smtp-Source: APXvYqw8FTmRK4wP2wIFDoFi+w++dkhFz+C9SJs7D69ow+DQYhh4fIa+FB0mXfMV2n7rI+lrzuwKIV0YTLJfU30T/Ok=
X-Received: by 2002:a5e:8704:: with SMTP id y4mr1779026ioj.103.1569537848894;
 Thu, 26 Sep 2019 15:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190621135907.112232-1-yuehaibing@huawei.com> <CAHX4x86qUKPTkRFWvWMgTMh1VY8ogJfr55khsSJTakS0emiyFA@mail.gmail.com>
In-Reply-To: <CAHX4x86qUKPTkRFWvWMgTMh1VY8ogJfr55khsSJTakS0emiyFA@mail.gmail.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Thu, 26 Sep 2019 15:43:56 -0700
Message-ID: <CANLzEkvw-UGKh-OE91PiHUvOnjjdbTngnUNwFC4f54h8e3v+9A@mail.gmail.com>
Subject: Re: [PATCH -next] platform/chrome: wilco_ec: Use kmemdup in enqueue_events()
To:     Nick Crews <ncrews@chromium.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nick,
On Fri, Jun 21, 2019 at 7:51 AM Nick Crews <ncrews@chromium.org> wrote:
>
> Thanks Yue, looks good to me.
>
> Nick
>
> On Fri, Jun 21, 2019 at 7:59 AM YueHaibing <yuehaibing@huawei.com> wrote:
> >
> > Use kmemdup rather than duplicating its implementation
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/platform/chrome/wilco_ec/event.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> > index c975b76e6255..70156e75047e 100644
> > --- a/drivers/platform/chrome/wilco_ec/event.c
> > +++ b/drivers/platform/chrome/wilco_ec/event.c
> > @@ -248,10 +248,9 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
> >                 offset += event_size;
> >
> >                 /* Copy event into the queue */
> > -               queue_event = kzalloc(event_size, GFP_KERNEL);
> > +               queue_event = kmemdup(event, event_size, GFP_KERNEL);
> >                 if (!queue_event)
> >                         return -ENOMEM;
> > -               memcpy(queue_event, event, event_size);
> >                 event_queue_push(dev_data->events, queue_event);
> >         }
> >
> >
> >

Looks like this was already incorporated into your commit,
platform/chrome: wilco_ec: Use kmemdup in enqueue_events().

Thanks!
Benson

-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
