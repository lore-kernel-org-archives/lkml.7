Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7E9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3202083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJUMwLs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDLD7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:59:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35550 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDLD7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:59:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so9210341wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 20:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDjbew8/XnEWPCx2JhORMgpWfv6ak7qB7VTQ5Y2QSSQ=;
        b=yJUMwLs/VuheROMdvbgcxf4aIlTmHjgP0u0OBcJVi/d+ATgieKvDC5dQ9akuiy+0as
         1SWiHpYd3ln7U9/XZXOiWPacUxeA4m7ZwIagBdles+ZrvSDlTmzTaUl6dM3ji725o9D/
         xw9PYnbcHoRwWBqHHluLC/I/k+y6vUD2mycjfMOGhH+4e3bOc9yS5uSGQAFodOgnwxAK
         sNY4u+dATu/fRLitXCIs915unk3mx+at3s+kf8cb4RqsC/ZaE6bv9nbYTxIiPkVx1vDV
         uzGqJUDVQHxvmLcvsBksSoZ+/X3fb7yHxdoLKCGeividloux9ewo97rgVOUYs1uKvAE2
         Uuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDjbew8/XnEWPCx2JhORMgpWfv6ak7qB7VTQ5Y2QSSQ=;
        b=I3M2WGwjUi6cSqRSJDUAWYFRHXc8x559WryuDbSyC5nUHDjTIM78LnSHSgbNbTgU38
         MwiLAKN7GHa6dNm9Zb4+i4h9mUZYBCGHgW1PdZjMAQrk0IOGgMh2NZ1XLdiOEPW7iIkW
         2Jyv60bE6o5bpv5slwSpmyoOgnnwUZNvKqfT3HXZFPz5qocqZKUbOqB8WtcFmss307tv
         mvHq2j1/b21TxkFQ9HFaRAQsu1Q+afmxnaD14S54mi2tKXylDtbrsHKUQKlc+XvcL9om
         wdJDEiiNaPVKxpUyy4wqBOtusEffrmFLbW03kI1gpla1v8N2dPzbZhAJm9VPE0goagfQ
         VbjA==
X-Gm-Message-State: APjAAAVZCMkhc1mS7tLHmFwOuvNgPr+qWj6aqgtXc07zgHEWZ7OXftFm
        9VuRTJhU4eavxbx95lbF0QMbps5qm2ED6e5G91d8zA==
X-Google-Smtp-Source: APXvYqwmNvRI2C5zFcXXGEjgvhsdkSLF3QjkF0eksska2gjzZB75WwT6NhB+7nv2p7FzRVpgPijHAosZyFC7RKRtFr8=
X-Received: by 2002:a1c:a103:: with SMTP id k3mr9179534wme.8.1555041570364;
 Thu, 11 Apr 2019 20:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190329041409.70138-1-chenyu56@huawei.com> <20190329041409.70138-10-chenyu56@huawei.com>
 <CALAqxLUQW03waz0LETcnYpc7qhm=RG6RfwbGVZ7MQz00jTZSWQ@mail.gmail.com>
In-Reply-To: <CALAqxLUQW03waz0LETcnYpc7qhm=RG6RfwbGVZ7MQz00jTZSWQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 11 Apr 2019 20:59:17 -0700
Message-ID: <CALAqxLWf0_73spYd68-bnYZp5evLNjcFwBqevVdHCoziG9paBA@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] usb: roles: Add usb role switch notifier.
To:     Yu Chen <chenyu56@huawei.com>
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        "Liuyu (R)" <liuyu712@hisilicon.com>, wanghu17@hisilicon.com,
        butao <butao@hisilicon.com>, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com,
        Li Pengcheng <lipengcheng8@huawei.com>,
        songxiaowei@hisilicon.com, YiPing Xu <xuyiping@hisilicon.com>,
        xuyoujun4@huawei.com, Yudongbin <yudongbin@hisilicon.com>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 6:12 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Mar 28, 2019 at 9:14 PM Yu Chen <chenyu56@huawei.com> wrote:
> >
> > This patch adds notifier for drivers want to be informed of the usb role
> > switch.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Yu Chen <chenyu56@huawei.com>
>
> Hey Yu Chen!
>    Thanks again for sending this patch out! As mentioned in my
> comments with the other patches, I've got one proposal I wanted to
> share to try to avoid  state initialization races that I've seen with
> this patchset.
>
> > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> > index f45d8df5cfb8..e2caaa665d6e 100644
> > --- a/drivers/usb/roles/class.c
> > +++ b/drivers/usb/roles/class.c
> > @@ -58,6 +61,20 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
> >
> > +int usb_role_switch_register_notifier(struct usb_role_switch *sw,
> > +                                     struct notifier_block *nb)
> > +{
> > +       return blocking_notifier_chain_register(&sw->nh, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(usb_role_switch_register_notifier);
>
> As noted earlier, one issue I've seen is that the hisi_hikey_usb
> driver's notifier may not get called early enough to receive
> notification of the initial usb state.
>
> It seems like on registration here, we should take the lock, read the
> role state and immediately call the notifier to properly initialize
> it? I suspect that should close the window for any state races around
> driver probe timings and
>
> Does that make sense? I have roughly prototyped this but need to do
> additional testing.

So these seem to be working ok.
First, the notifier call on register change:
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=1d312db9763c2449c3cf5b3383b1f33390f8ce7b

Second, the current_dr_role change for dwc3:
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=b80b536de76eb80f7df0846aa54ac22e2b4ffe4e

Feel free to fold/rework those changes into your patch set.

thanks
-john
