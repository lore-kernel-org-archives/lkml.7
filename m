Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13761C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FE3218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/+3+Sio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCTXnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:43:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53178 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCTXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:43:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so950756wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yq9DaKQ00cZ1pNB/118bquMfFjN67tRouuMKGnaosxo=;
        b=g/+3+SiohpvgLWqF76bydKQh5mu3EafovnZgDZ7H6/rShY7jkXb92VfHqPorpwnnyp
         E5bqm7lBlCiuMSNGgqtLTnYv8+ZkQ3eroyokx08VONoxlJnTd0fqAhhUkMs/BrEYTfki
         HdiBuMQdrCbPO0jsvDzOqAPk93XqIrdqH+yl2Ii0Yz1BBNBilfyZAivga7sR5AS2YnvJ
         0remWZ0gAnTstQl4/jSZCTl2WQef3gSBoiTqztTMb4sVFhTpejS9OoJyoLSNWNEY0aEP
         EiP/j76a9E7HxcTigiDBoLEzp6TZUEHsElILgMJQho+boyzAYP63Lrawb7C+ccvAFng7
         ZrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yq9DaKQ00cZ1pNB/118bquMfFjN67tRouuMKGnaosxo=;
        b=fmHSy56B5v8MZScFqAc3WwGmTvRkY7ou8d3vyVDZ769LmK6GL+DkFw5OAALsmqOama
         T2tH4BuONIj6zzu4jNHHkduW2vzMtXDAVtZXwy5Pqvzj6mEdnaDbWPneikhYzSy1PGUc
         wQGdtio235T0C8xftznBVupFw9RQug2EMRLuT8NtWH/YcZR1Bxx64cgxhcMqeRj1HuZr
         dCYkvGJW++vJWiIO9MG717pShxk1f69So4/DQl/NteC04ReFDmsP1PLHsX2ErXGBq3yf
         5CXf86S6Qe+ivuMiBKqMllMkt0ZbupSLwwVjQpp7uym0U+Zl0ErFQ0fqZoXs2ERT4Ww0
         d6Cg==
X-Gm-Message-State: APjAAAXIpi7yFweGEtsZavaXmd1PIzhgIvXKDrghVAQ4gigF5TLV30CR
        a7q3gwjfbHWhQ2QDsesaUbt2tgp5tI5EUC13bEfqCQ==
X-Google-Smtp-Source: APXvYqwNG337fMRQuhO2GxyuPqxFSpQGhhmTb79a1MxvqX9C1ZpTUKXaFwquUwh6UdvyP/bq+oYGIqzY2ivcuINprAU=
X-Received: by 2002:a1c:9691:: with SMTP id y139mr467757wmd.64.1553125381390;
 Wed, 20 Mar 2019 16:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
 <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com> <02E7334B1630744CBDC55DA8586225837F7FB935@ORSMSX102.amr.corp.intel.com>
In-Reply-To: <02E7334B1630744CBDC55DA8586225837F7FB935@ORSMSX102.amr.corp.intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 20 Mar 2019 16:42:48 -0700
Message-ID: <CALAqxLXqPSt2X=vo1qsyz4mwPkKj9s2g2VSqQbrWUkG2KYSjaQ@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     "Yang, Fei" <fei.yang@intel.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "andrzej.p@collabora.com" <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "Shen, JingX" <jingx.shen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 4:28 PM Yang, Fei <fei.yang@intel.com> wrote:
>
> > Hey Fei,
> >  So while this patch does resolve the issues I was seeing with mainline=
 kernels and recent changes to adbd,
> > Josh pointed out that it wouldn't resolve the issues I was seeing with =
older kernels which is slightly different (but still related to aio usage).
> >
> > On the older kernels I'm hitting scheduling while atomic on reboot, whi=
ch seems to be due to ffs_aio_cancel() taking a spinlock then calling usb_e=
p_dequeue() which might sleep.
> >
> > It seems a fix for this was tried earlier with d52e4d0c0c428 ("usb:
> > gadget: ffs: Fix BUG when userland exits with submitted AIO
> > transfers") which was then reverted by a9c859033f6e.
> >
> > Elsewhere it seems the ffs driver takes effort to drop any locks before=
 calling usb_ep_dequeue(), so this seems like
> > that should be addressed, but it also seems like recent change to the d=
wc3 driver has been made to avoid sleeping
> > in that path (see fec9095bdef4 ("usb: dwc3: gadget: remove wait_end_tra=
nsfer")), which may be why I'm not seeing
> > the problem with mainline (and your patch here, of coarse). But that al=
so doesn't clarify if its still a potential issue
> > w/ non-dwc3 platforms.
> >
> > So for older kernels, do you have a suggestion of which approach is adv=
ised?  Does usb_ep_dequeue need to avoid
> > sleeping or do we need to rework the ffs_aio_cancel logic?
>
> Are you seeing this issue with Android? When running adb reboot?
> I have tried 4.19 and 4.9 kernel with Android P-dessert on one of the Int=
el platforms, but no luck on reproducing the issue.

You probably need to be running AOSP/master to trigger this. The
changes which uncovered this landed just last week.

> I will get back to you if I could reproduce the issue. I'm afraid I won=
=E2=80=99t be able to do much by just looking at the code.

So as discussed in further mails, the main issue seems to be the dwc3
code was sleeping in its ep_dequeue logic, which isn't safe as
ffs_aio_cancel calls it while holding a spinlock. Upstream the dw3c
driver has been fixed, but -stable kernels still have the issue.

thanks
-john
