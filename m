Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E277CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF582086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wobk7zeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfJOFkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:40:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39466 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOFkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:40:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so22145438wrj.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 22:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgXIwZUEBFUFxozlcJa8pF4R5hS6O4lvi7YgXVTtNrg=;
        b=wobk7zeU2Qq4Iw4VYGauePPRVllk+oX4BOTXW4dqIuZOU65i669vY0sI98tfrYcOZ5
         SshO5hlj9xhcyL22b4GpHbRJWWe/55C0R23E2Q4WjVy/Td59knbs3xvJ4MPctCSIG7Jw
         f2yddxGid5Qylc/tlOo6/r7RWlnkAq64dhtH9MlpO1G1QqQNndYMQLGyhR9QBN6Qi90W
         JeURaeQ+4gEghE38gdiQujzUV1xWBCPxHAWgFJJpCzDWm2Dcm1rIU0OWeVsPemcPcJrL
         TU5gIu9NjSC9kgfQ0mht0q61rqiJQtnsqYYzrKuJVWnvcXb8qz2NhTj1DOCbX5ewie5Y
         QpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgXIwZUEBFUFxozlcJa8pF4R5hS6O4lvi7YgXVTtNrg=;
        b=Tf0E8JC7YfOBoH3RgUOOxULI9AbXMyLIYHv7wZ02u7YIxAkyL4L4nIvthbonidbK0o
         mN2b43WRHT1zEivFqEYIlH90+6Ga9jhX268lP78RzU9wKp+r/niKXIoniMGxFs6tUxeX
         m7paRoEzebQ2dKwfL6R81gCb2ndcb54Rz7azWb4IZLGT7MbVVwtBX36Jx1PNl6n44SEk
         UvX5EMsAkFFsfwPVkKPTTroCv/ZEuHxSJ68SzcFwoflrdF1+r/ltE1FIB0bk28oMJ9rh
         OtWgd+tOrgXtdUXdsEireg9ZHR4UBXwqdVBwuuFapRr/Fj05J4Uuy2zD1bMQR2MQGUws
         1LQg==
X-Gm-Message-State: APjAAAUkb0jDTNzxUtxuHT3/9M/Ms9yiM3l6bkMd4EQ3rsyJwW/iPV4Z
        W9ouIMVD3UQi2dSDd59LejC+Ea2x/UWjGIVuPEpB0g==
X-Google-Smtp-Source: APXvYqw22c6HVZZ+Kpi/RqnTBbP1ROHewS5lJFHx9CR+JR4q2hJYAD5M98Q9ue9e4uA7Wv2AfuCyqpA1kNE9d99rEbk=
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr27636293wrt.36.1571118003994;
 Mon, 14 Oct 2019 22:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com> <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
In-Reply-To: <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 14 Oct 2019 22:39:51 -0700
Message-ID: <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 1:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 03-10-2019 22:37, John Stultz wrote:
> > Fair point. I'm sort of taking a larger patchset and trying to break
> > it up into more easily reviewable chunks, but I guess here I mis-cut.
> >
> > The user is the hikey960 gpio hub driver here:
> >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?id=b06158a2d3eb00c914f12c76c93695e92d9af00f
>
> Hmm, that seems to tie the TypeC data-role to the power-role, which
> is not going to work with role swapping.

Thanks again for the feedback here. Sorry for the slow response. Been
reworking some of the easier changes but am starting to look at how to
address your feedback here.

> What is controlling the usb-role-switch, and thus ultimately
> causing the notifier you are suggesting to get called ?

The tcpm_mux_set() call via tcpm_state_machine_work()

> Things like TYPEC_VBUS_POWER_OFF and TYPEC_VBUS_POWER_ON
> really beg to be modeled as a regulator and then the
> Type-C controller (using e.g. the drivers/usb/typec/tcpm/tcpm.c
> framework) can use that regulator to control things.
> in case of the tcpm.c framework it can then use that
> regulator to implement the set_vbus callback.

So I'm looking at the bindings and I'm not sure exactly how to tie a
regulator style driver into the tcpm for this?
Looking at the driver I just see this commented out bit:
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/tcpm/tcpm.c#n3075

Do you happen to have a pointer to something closer to what you are describing?

thanks
-john
