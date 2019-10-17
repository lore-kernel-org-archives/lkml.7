Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679EFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE88C21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGOC2fW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503360AbfJQTHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:07:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37693 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503341AbfJQTHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:07:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so1890110pgi.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8xAHlfkcXXy3tAV1rfOh1RH08qh99XamRpJlnNkuCs=;
        b=WGOC2fW3eL810UxK2OyOTVUqrRlRaY0iNjVmxNOAEmof0riKtYccrkunE9/apbWrH1
         EtkKYxJrIK7f/7C/KQKAIuRYZAAsWiRXHm6wagzHd/QlCWtjaa373xFQemLS1HE/cC6c
         OGM1kH96dHWLpow6T/2IUPIUcXtP3LZ5uJ3UaUE521IegSRcqW2J7hH3x6kmiECXc1k9
         0u7fVQ3wPFOFFYSx47ZxAFkm6uxEqLK4zqpdgf/TxcjvX6HQo7dI/F41UU5BDTx+mI0z
         ejod0hKhi8zPWU5OOHD+NTSzc5dN77WKZtiR0gMvEOzhByD842QYtsBN3n8v88YF4ugn
         BDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8xAHlfkcXXy3tAV1rfOh1RH08qh99XamRpJlnNkuCs=;
        b=bQSifyFTG2+alr6sP2IN4BV7rkFQwPTnAxoSTaqsr8rBZz5irBSVi+Je95rag5YeMU
         nNYgx8xxMg8LEtJlJAwWSKPm752lCbiQ+rEWyquiefnPHuN2f4IsfQhjTyzgr3sT8brl
         8CQBADRh79pB/8k2gPG54gayZXwKUAnmc+FGya3t+XPQ1ouT9EDu4eetIdmEjBrM05OL
         aANYc7m2JdoFpfHfXuXauWr2DzyElqcEeYtT8qUxtZBlUjySj+7xDc8ZBoHoOt5abZZK
         /TiZLoNueWFLQKDhRWAz7f1CTCtn34mTQHIoxjg/T0sqx/Zxjamny1kdVaEI0myDEov5
         PsTw==
X-Gm-Message-State: APjAAAV2U8stARUt+Nr+tW8TRPMrmp/Rwh9b2uI2etDQnbdcb9yN9+pU
        vJxxdm9gA0ZlvFVPuNQRlhT7egWUCwbTBgeyJgbT/Q==
X-Google-Smtp-Source: APXvYqx48LhISGcOzRtwaIhszXsRUYe5Kli1JNiMo5SrzNfO5jHqIrJS0QlR3iXZlDy9TTxurGoX3WwkbHUfLynZEK0=
X-Received: by 2002:a63:541e:: with SMTP id i30mr5796978pgb.130.1571339227516;
 Thu, 17 Oct 2019 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571333592.git.andreyknvl@google.com> <1b30d1c9e7f86c25425c5ee53d7facede289608e.1571333592.git.andreyknvl@google.com>
 <20191017181943.GC1094415@kroah.com>
In-Reply-To: <20191017181943.GC1094415@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 17 Oct 2019 21:06:56 +0200
Message-ID: <CAAeHK+zEoEbtk62raCU_10V_K97VAeebfJfuCRaf5DskT5yVhw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] usb, kcov: collect coverage from hub_event
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 8:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 17, 2019 at 07:44:14PM +0200, Andrey Konovalov wrote:
> > This patch adds kcov_remote_start/kcov_remote_stop annotations to the
> > hub_event function, which is responsible for processing events on USB
> > buses, in particular events that happen during USB device enumeration.
> > Each USB bus gets a unique id, which can be used to attach a kcov device
> > to a particular USB bus for coverage collection.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  drivers/usb/core/hub.c    | 4 ++++
> >  include/linux/kcov.h      | 1 +
> >  include/uapi/linux/kcov.h | 7 +++++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 236313f41f4a..03a40e41b099 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -5374,6 +5374,8 @@ static void hub_event(struct work_struct *work)
> >       hub_dev = hub->intfdev;
> >       intf = to_usb_interface(hub_dev);
> >
> > +     kcov_remote_start(kcov_remote_handle_usb(hdev->bus->busnum));
> > +
> >       dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
> >                       hdev->state, hdev->maxchild,
> >                       /* NOTE: expects max 15 ports... */
> > @@ -5480,6 +5482,8 @@ static void hub_event(struct work_struct *work)
> >       /* Balance the stuff in kick_hub_wq() and allow autosuspend */
> >       usb_autopm_put_interface(intf);
> >       kref_put(&hub->kref, hub_release);
> > +
> > +     kcov_remote_stop();
> >  }
> >
> >  static const struct usb_device_id hub_id_table[] = {
> > diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> > index 702672d98d35..38a47e0b67c2 100644
> > --- a/include/linux/kcov.h
> > +++ b/include/linux/kcov.h
> > @@ -30,6 +30,7 @@ void kcov_task_exit(struct task_struct *t);
> >  /*
> >   * Reserved handle ranges:
> >   * 0000000000000000 - 0000ffffffffffff : common handles
> > + * 0001000000000000 - 0001ffffffffffff : USB subsystem handles
>
> So how many bits are you going to have for any in-kernel tasks?  Aren't
> you going to run out quickly?

With these patches we only collect coverage from hub_event threads,
and we need one ID per USB bus, the number of which is quite limited.
But then we might want to collect coverage from other parts of the USB
subsystem, so we might need more IDs. I don't expect the number of
different subsystem from which we want to collect coverage to be
large, so the idea here is to use 2 bytes of an ID to denote the
subsystem, and the other 6 to denote different coverage collection
sections within it.

But overall, which encoding scheme to use here is a good question.
Ideas are welcome.

> >   */
> >  void kcov_remote_start(u64 handle);
> >  void kcov_remote_stop(void);
> > diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> > index 46f78f716ca9..45c9ae59cebc 100644
> > --- a/include/uapi/linux/kcov.h
> > +++ b/include/uapi/linux/kcov.h
> > @@ -43,4 +43,11 @@ enum {
> >  #define KCOV_CMP_SIZE(n)        ((n) << 1)
> >  #define KCOV_CMP_MASK           KCOV_CMP_SIZE(3)
> >
> > +#define KCOV_REMOTE_HANDLE_USB  0x0001000000000000ull
> > +
> > +static inline __u64 kcov_remote_handle_usb(unsigned int bus)
> > +{
> > +     return KCOV_REMOTE_HANDLE_USB + (__u64)bus;
> > +}
>
> Why is this function in a uapi .h file?  What userspace code would call
> this?

A userspace process that wants to collect coverage from USB bus # N
needs to pass kcov_remote_handle_usb(N) into KCOV_REMOTE_ENABLE ioctl.
