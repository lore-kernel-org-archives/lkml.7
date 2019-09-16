Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D34C4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572D020890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMUCxiwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfIPIwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:52:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27669 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727387AbfIPIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:52:07 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 04:52:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568623925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6l+UhGzduqlSI45MW+s7UO58r4VXI09pVmwaGMkul5c=;
        b=YMUCxiwvkvD0IbPChoDIFp/iqiwGoFoeE91ZSfJzdHyCn1+DC0yvcQex8OV9qOOIZPu99/
        Klq7StEmD6T+3CAe5LpS+p4gm3DO5BsivofVOLwcTo9KDxLVd2VQW0/rM7bFIwUmVQYidS
        +LFfAMwSKeWsteFXv7JAVPr7ZVuhby8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-baBvaprBMOS2vKs5qqb2oQ-1; Mon, 16 Sep 2019 04:45:38 -0400
Received: by mail-wr1-f69.google.com with SMTP id h6so13232735wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+vsKaIlWHsMuXk6hiyOP9VPLO7i3D1QiUR8hPf7NlYw=;
        b=fWnhUCzuYFUnUJpqbew0ApSibu5Qa6VXzxCcHnWLdOs91yimjWvKTft2i5Xf0DVP05
         mHGOob52ijIxit0qzX7LJd8us+eTo7s6FLBllRHP2FFm8i93dMagK+vrN/NIqGGOKjUL
         LEJ6Q+mIWe4d+lIU3qfJR0H5DneEvqw0gJbH1thU8iYoRVjt4uTQVvX/fXaIz6NQbt43
         gGLKjrD9aZUM7aBt+w0OCvguOVrNnFn2ofbRgGbclCHfmrf2bKYBiOMhyiSKz+AIX1XX
         ZX/DORDV3Vu24qEyjvx4SrtpS262IHBxU66icJ2IdXHxF5zbnWxcauqIpyIcBuHzKrsK
         m2tA==
X-Gm-Message-State: APjAAAW9zJQYelnUskNc0LZg6LbXJ+YHtnat8HQeman6R+zWlMjMZmak
        gkiWLWK8APQBmZzHEUfHsV7kghcLWKEnh3d/NsJkbjvfWgHAVXfhnFt5sE+TD5EWByYIsoiDCFK
        595teDkLqw+T5+LlHvTE3Q08I
X-Received: by 2002:a1c:a851:: with SMTP id r78mr12712539wme.166.1568623537512;
        Mon, 16 Sep 2019 01:45:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7wRIpg9ABKlbAmxa1eHPTzojP71muAiQmJ4bCmRlDiA9ptL/No0WdClCYdM75jePWlF/TEg==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr12712519wme.166.1568623537245;
        Mon, 16 Sep 2019 01:45:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o19sm45814861wro.50.2019.09.16.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 01:45:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/3] hv_utils: Add the support of hibernation
In-Reply-To: <PU1P153MB0169C6B4A78787930CC9ED4FBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com> <1568245130-70712-2-git-send-email-decui@microsoft.com> <877e6dcvzj.fsf@vitty.brq.redhat.com> <PU1P153MB0169C6B4A78787930CC9ED4FBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Date:   Mon, 16 Sep 2019 10:45:35 +0200
Message-ID: <87pnk0bpe8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: baBvaprBMOS2vKs5qqb2oQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Thursday, September 12, 2019 9:37 AM
>
>> > +static int util_suspend(struct hv_device *dev)
>> > +{
>> > +=09struct hv_util_service *srv =3D hv_get_drvdata(dev);
>> > +
>> > +=09if (srv->util_cancel_work)
>> > +=09=09srv->util_cancel_work();
>> > +
>> > +=09vmbus_close(dev->channel);
>>=20
>> And what happens if you receive a real reply from userspace after you
>> close the channel? You've only cancelled timeout work so the driver
>> will not try to reply by itself but this doesn't mean we won't try to
>> write to the channel on legitimate replies from daemons.
>>=20
>> I think you need to block all userspace requests (hang in kernel until
>> util_resume()).
>>=20
>> While I'm not sure we can't get away without it but I'd suggest we add a
>> new HVUTIL_SUSPENDED state to the hvutil state machine.
>> Vitaly
>
> When we reach util_suspend(), all the userspace processes have been
> frozen: see kernel/power/hibernate.c: hibernate() -> freeze_processes(),
> so here we can not receive a reply from the userspace daemon.
>

Let's add a WARN() or something then as if this ever happens this is
going to be realy tricky to catch.

> However, it looks there is indeed some tricky corner cases we need to dea=
l
> with: in util_resume(), before we call vmbus_open(), all the userspace
> processes are still frozen, and the userspace daemon (e.g. hv_kvp_daemon)=
=20
> can be in any of these states:
>
> 1. the driver has not buffered any message for the daemon. This is good.
>
> 2. the driver has buffered a message for the daemon, and
> kvp_transaction.state is HVUTIL_USERSPACE_REQ. Later, the kvp daemon
> writes the response to the driver, and in kvp_on_msg()=20
> kvp_transaction.state is moved to HVUTIL_USERSPACE_RECV, but since
> cancel_delayed_work_sync(&kvp_timeout_work) is false (the work has
> been cancelled by util_suspend()), the driver reports nothing to the host=
,
> which is good as the VM has undergone a hibernation event and IMO the
> response may be stale and I believe the host is not expecting this=20
> response from the VM at all (the host side application that requested the
> KVP must have failed or timed out), but the bad thing is: the "state"
> remains in HVUTIL_USERSPACE_RECV, preventing
> hv_kvp_onchannelcallback() from reading from the channel ringbuffer.
>
> I suggest we work around this race condition by the below patch:
>
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -250,8 +250,8 @@ static int kvp_on_msg(void *msg, int len)
>          */
>         if (cancel_delayed_work_sync(&kvp_timeout_work)) {
>                 kvp_respond_to_host(message, error);
> -               hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wr=
apper);
>         }
> +       hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
>
>         return 0;
>  }
>
> How do you like this?
>

Is it safe to call hv_poll_channel() simultaneously on several CPUs? It
seems it is as we're doing=20

smp_call_function_single(channel->target_cpu, cb, channel, true);

(I'm asking because if it's not, than doing what you suggest will open
the following window: timeout function kvp_timeout_func() is already
running but the daemon is trying to reply at the same moment).

> I can imagine there is still a small chance that the state machine can ru=
n
> out of order, and the kvp daemon may exit due to the return values of
> read()/write() being -EINVAL, but the chance should be small enough in
> practice, and IMO the issue even exists in the current code when
> hibernation is not involved, e.g. kvp_timeout_func() and kvp_on_msg()=20
> can run concurrently; if kvp_on_msg() runs slowly due to some reason=20
> (e.g. the kvp daemon is stopped as I'm gdb'ing it), kvp_timeout_func()
> fires and moves the state to HVUTIL_READY; later kvp_on_msg() starts
> to run and returns -EINVAL, and the kvp daemon will exit().
>
> IMHO here it looks extremely difficult to make things flawless (if that's
> even possible), so it's necessary to ask the daemons to auto-restart once
> they exit() unexpectedly. This can be achieved by configuring systemd
> properly for the kvp/vss/fcopy services.=20

I think we can also teach daemons to ignore -EINVAL or switch to
something like -EAGAIN in non-fatal cases.
=20
>
> I'm not sure introducing a HVUTIL_SUSPENDED state would solve all
> of the corner cases, but I'm sure that would further complicate the
> current code, at least to me. :-)
>

Maybe, if we don't need it than we don't. Basically, I see the only
advantage in having such state: it makes our tricks to support
hibernation more visible in the code.

--=20
Vitaly

