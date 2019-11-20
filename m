Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA8C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93343206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3znqmQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfKTHWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:22:54 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45932 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfKTHWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:22:54 -0500
Received: by mail-vk1-f196.google.com with SMTP id s4so3630748vkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 23:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exLwy8I4wv0OS303Fp+Xi/Ap9Cd+ko2/xIdZfSeo7/c=;
        b=J3znqmQK3Q0Ao+w13eeRO/EfbxBzc7qrTpXdEzyqQLwlKx6HNzsGA1qqAOQ9FUMjYt
         J7Nr5sDFCX6reUKxvIfJ2zb14bCRL3dAwXmTa7lu/U7OdjJ5+lbMJWzL59fyM8WMQyjL
         bwkea5cLAK3F3rMUyLqE5bx9ummbaAnxY/NW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exLwy8I4wv0OS303Fp+Xi/Ap9Cd+ko2/xIdZfSeo7/c=;
        b=NMe0WUgoT+VlEk+n4oJgGyZnNESN/khy+Z8wbgz22mbMeH6zvWOj7QoKUb//mSLWHX
         dVQhfyX2HTDcJ9iyacM/bmK0fqbJ+Sw+vkPsKPdSCLC7Av0G7yRDDxRB5qLjKbfELEVH
         m28FsRKGpNmehEb2Yg3FdJ+jRaO4EWDHP6cNFbraHNFDhaGDz7FzwLFaCFAIRmH7CNy8
         ZqE+FHkG1WWb2M0YCjdZtBnZ4A9FNw4nHJNueoFUEZRc0zJwMa8WdFnzuuYM5iDEAQjn
         QdjGeWFXL1cTVJmmWN2BocNt5xNACYgdw7Ucy4J+g8keeBjjt8u6CHDSfrbcu+cKA3pO
         NbJg==
X-Gm-Message-State: APjAAAVne6wVQd7SB1YUGGZLZ6XEnc/CP18j7Ses8nnRRUL3E1ZUZFhy
        9d9GmAzv1+cObro8pFQqsLEdTkUFOIm1ULm76JxLTQ==
X-Google-Smtp-Source: APXvYqx46DxSppP9z4fLUawkft0B9je26ldEZNXrcJ8GaH2xHBvgFhf+YzbiZ2SQHEHJX7owu7YLf02XNktLBDSEhAE=
X-Received: by 2002:a1f:250b:: with SMTP id l11mr611772vkl.10.1574234573246;
 Tue, 19 Nov 2019 23:22:53 -0800 (PST)
MIME-Version: 1.0
References: <CAATdQgBPrk=obCOiMAe1zAoP1As21MuzGzn-ixU56EmSkdQr1w@mail.gmail.com>
 <Pine.LNX.4.44L0.1911191008440.1506-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911191008440.1506-100000@iolanthe.rowland.org>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 20 Nov 2019 15:22:42 +0800
Message-ID: <CAATdQgB9_qd+u1mr7ExNbeg0NP6AWO150WfXUabvL9AvKZC0dA@mail.gmail.com>
Subject: Re: [PATCH 0/2] usb: override hub device bInterval with device node
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        Nicolas Boitchat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 11:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 19 Nov 2019, Ikjoon Jang wrote:
>
> > On Sun, Nov 17, 2019 at 11:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Sun, 17 Nov 2019, Ikjoon Jang wrote:
> > >
> > > > This patchset enables hard wired hub device to use different bInterval
> > > > from its descriptor when the hub has a combined device node.
> > > >
> > > > When we know the specific hard wired hub supports changing its polling
> > > > interval, we can adjust hub's interval to reduce the time of waking up
> > > > from autosuspend or connect detection of HIDs.
> > >
> > > In fact, _all_ hubs support changing the polling interval.  The value
> > > given in the USB spec is just an upper limit; any smaller value is
> > > equally acceptable.
> > >
> > > So why are you doing this only for hard-wired hubs?  Why not for all
> > > hubs?
> >
> > Because we only want to apply it to a specific device instance under
> > our control.
>
> Why?  What's so special about that device instance?
>
> For example, why not instead have a poll_interval sysfs attribute for
> all hubs that can be written from userspace?  Then people could reduce
> the autoresume latency for any device they want.

Changing its INT interval during runtime seems not so easy, there's no device
drivers doing this to my knowledge. At least xhci needs to restart
endpoint to change
the interval. So I think patching ep descriptor at enumeration stage
is more convincing.

>
> > We apply autosuspend to built-in touchpad device for power savings,
> >
> > Users can attach external hub devices with same VID:PID that we don't want to
> > change the behavior.
>
> Why don't you want to change the behavior?  Or allow the user to change
> the behavior?
>

Yes, that's a difficult question here too, when the hub is external device,
it can't be fully controlled by here. Even though it's the same
VID:PID hub chip,
that's not the 100% same device. We don't know how much this will
impact to the other
external hub devices regarding power consumption and compatibility.

> >  Maybe disabling autosuspend for external HIDs
> > can be more reasonable for that case?
>
> If it makes sense to to save power for your built-in touchpad device,
> why doesn't it also make sense to save power for other external HIDs?
>
> > > And is 250 ms really too long to wait for remote wakeup or connect
> > > detection?  What's the real motivation behind this change?
> >
> > When a user starts to move the cursor while touchpad is in autosuspend state,
> > It takes more than >250ms (worst case can be >500ms) to wake up and response.
> > That makes the cursor stuck for a while and warp to another location suddenly.
>
> All right, that's a good reason.  But doesn't it apply just as well to
> other devices, not only your built-in touchpad?

Actually the hub is the one to be applied, I don't care much about the
rare case that
a user connects an additional external hub with same PID and connect
external HID
under that hub.

We could reduce autosuspend delay for built-in touchpad when we know
that's better
for power savings only if response time of wake up is good enough. but
we don't know
the optimal values for external HIDs. So we could use the default long
delay for external
devices, or just disable autosuspend for all external HIDs,
so user might experience much less cursor lags even with that rare case.

>
> Alan Stern
>
