Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14064CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED7520820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfw7CJKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504041AbfJRF4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:56:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41359 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392030AbfJRF4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:56:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so4781092wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RX/eZVxJTs9fdKiBk/fJa6nhTLf1toXcxAcB3Pwujk=;
        b=sfw7CJKy5k8boS6JMeROudXdBBBjjIVKJrZYxCI6saAh0WDUnKZ5Gv4p2lUzQTLblg
         Pam9xKNx4ksKyqH8JysNrdhaGzWFxvLlxY23dPDalnzM6FAtgYVAUvv0V0yGWF37Ow1p
         dv5gGTgZomYK8VbHoXBLpDztiZFM/xIK+yGpq+q+l9icE0vv+DiNxPI5NBSB9ffDhKNY
         erAby/3GNgQBsoOlV6n9h8RDimV1kJhSW1oQ/FMQ5cuyd5rVG+l4ZslbC6rpw93MnIT6
         lyt/IPVcp73hXjs/W4fSd+SegGPzBmHOgJS7TtMa/S5fgEaxTqGGdp/r27xPuOVUc77J
         JsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RX/eZVxJTs9fdKiBk/fJa6nhTLf1toXcxAcB3Pwujk=;
        b=glI9np9hziftjDBlOxP+r3AsLIwUmP20qYvaKglZtbsLuDHeQKtXwBuLekty0/cVf/
         Iedosyw6/4v3DWlN33CUd3e+/qU2hZR5w+HGpR0PfJPt+uJ4bzWsObGLSACuj5fi1Zl/
         gHLl2zo8CwAyban2jSlW5xq2mYN4XGbe7dF7MUYmAxbQPN0q8WaeeTZLQEW45lhOdFj0
         /GUP8PzuQozwgO26Buz94/cdhjfSi3HvKrcZEq3aKdLH7BJXU/UYBISk2XUNl2thny/+
         lPfITfcUKIM2rjdVKwXhyDQpiF1GiIsDO3XphsGSgoO0fKYRC9H8secrqfcrRo9tRL3q
         7vBA==
X-Gm-Message-State: APjAAAUHhGmalzfH58zrSO5L0z4zYlIhEfy5k/wDayp/Hm5loAKVxhNQ
        sxj0iGg9htwQfIffJApVxE9rcV7t+2EJNRFzYazD0Q==
X-Google-Smtp-Source: APXvYqyVa2tdZUqgwmas2Off/KMa7do38JBAZiNLti1ibsNaD8x0PeLlp8nm8+4re5slTCw/ZLGPlAqydiSGFc9te/0=
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr5917799wrt.36.1571378156662;
 Thu, 17 Oct 2019 22:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com> <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com> <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
 <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com>
In-Reply-To: <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 17 Oct 2019 22:55:45 -0700
Message-ID: <CALAqxLWh0=GRod5ORpi+ENpWCkmY39mUw_=NV67sKY8qH_otZw@mail.gmail.com>
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

On Wed, Oct 16, 2019 at 12:27 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 10/15/19 7:39 AM, John Stultz wrote:
> > On Thu, Oct 3, 2019 at 1:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 03-10-2019 22:37, John Stultz wrote:
> >>> Fair point. I'm sort of taking a larger patchset and trying to break
> >>> it up into more easily reviewable chunks, but I guess here I mis-cut.
> >>>
> >>> The user is the hikey960 gpio hub driver here:
> >>>     https://git.linaro.org/people/john.stultz/android-dev.git/commit/?id=b06158a2d3eb00c914f12c76c93695e92d9af00f
> >>
> >> Hmm, that seems to tie the TypeC data-role to the power-role, which
> >> is not going to work with role swapping.
> >
> > Thanks again for the feedback here. Sorry for the slow response. Been
> > reworking some of the easier changes but am starting to look at how to
> > address your feedback here.
> >
> >> What is controlling the usb-role-switch, and thus ultimately
> >> causing the notifier you are suggesting to get called ?
> >
> > The tcpm_mux_set() call via tcpm_state_machine_work()
> >
> >> Things like TYPEC_VBUS_POWER_OFF and TYPEC_VBUS_POWER_ON
> >> really beg to be modeled as a regulator and then the
> >> Type-C controller (using e.g. the drivers/usb/typec/tcpm/tcpm.c
> >> framework) can use that regulator to control things.
> >> in case of the tcpm.c framework it can then use that
> >> regulator to implement the set_vbus callback.
> >
> > So I'm looking at the bindings and I'm not sure exactly how to tie a
> > regulator style driver into the tcpm for this?
> > Looking at the driver I just see this commented out bit:
> >     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/tcpm/tcpm.c#n3075
> >
> > Do you happen to have a pointer to something closer to what you are describing?
>
> Look at the tcpm_set_vbus implementation in drivers/usb/typec/tcpm/fusb302.c
> you need to do something similar in your Type-C controller driver and
> export the GPIO as as a gpio-controlled regulator and tie the regulator to
> the connector.

Thanks for the suggestion, I really appreciate it! One more question
though, since I'm using the tcpci_rt1711h driver, which re-uses the
somewhat sparse tcpci.c implementation, would you recommend trying to
add generic regulator support to the tcpci code or trying to extend
the implementation somehow allow the tcpci_rt1711h driver replace just
the set_vbus function?

thanks
-john
