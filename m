Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419DC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DB8218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5F5YNcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGDSqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:46:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40608 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGDSqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:46:24 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so6287184iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EL1KLCRFQKW2ACCFaTqozaezf7EHz4hHVM/un1EcE4=;
        b=t5F5YNcug6hMseo0CGrmu4jtrScYyR5ptz8hoGQXZ2nAYmqEbnWUkptDsisVRn+DlR
         CwihM32a+oNgurJg0qF/nDO/Z7Use2bWSvL/B+Rs/djchh2zDLEkloovdGI54dEmg7Z7
         0ZcLtk9dxbf4JWb2t6EWq1MMcGyaVhvNZG3gucduuo5SYzlm2Ej4EDjeXGg2fUYsONWY
         wVSxZ+NiAJAy8IT861ZE5CZnGHPrrz8tDjXqwYFHsv145C6cr2YShpRTl8W7KSNlzkUK
         tR5Qy2gVPZtMNqRb6vSFgLcjAmVZ/dcSvndnrTJdKezTc/nvPEShNL2J6I+hSa2Pwbck
         a/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EL1KLCRFQKW2ACCFaTqozaezf7EHz4hHVM/un1EcE4=;
        b=IRRjzU67w2NGGTmHT2GuE0rHpfPfGumkOxCos3V6Ln9vKHLUZC1LqMVgvs/elvdmPb
         Nsn1j2HVqUEfEA6FUbmjOf5f4xUy+QvLv/jMeWBKXn4Xs86ux6NqUsD6bxaSD42R9Zey
         /kXjfIkU1XutCSEaHN910ww6QozgSxQzSnWxd6PxaCJAAQx3lnIvwfprWKPKUm+ztcX/
         iNRKgm8FSutekzmgd/RH5Om0CO6Q/ZPf9zrFHWvdGcPusJ3zTzgakbGunK/gASF33ZZ/
         1OapQ+lmZsmr67yHmPQ4ATVb/3tyNgL+c94hX782vJQV2ulOyiBqZpe3yBCl9C/zoWBj
         5iNQ==
X-Gm-Message-State: APjAAAWmMQSO8QeW2VSC/YwzKotQIiORbE4e+q/spc8SG5sqDT+ss7uv
        NgSr/0gSbbrKZ64QJDjZIPKqWgLQisz6mPfXQ9I=
X-Google-Smtp-Source: APXvYqw068LIiSNZG8tw6hH1iAgU3f8oV5wzSRuRWNvDNz3EezgtI9aQEHP/lGGiQvDKG3BtZpOWd1VgboUZlM9JGhc=
X-Received: by 2002:a05:6602:104:: with SMTP id s4mr39068278iot.200.1562265983623;
 Thu, 04 Jul 2019 11:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-9-kraxel@redhat.com>
 <CAPaKu7QP=A2kV_kqcT20Pmc831HviaBJN1RpOFoa=V1g6SmE_g@mail.gmail.com> <20190704112534.v7icsuverf7wrbjq@sirius.home.kraxel.org>
In-Reply-To: <20190704112534.v7icsuverf7wrbjq@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 4 Jul 2019 11:46:12 -0700
Message-ID: <CAPaKu7SQS5USJf0Y+K41tuRA=4qZJf5CnTu9EqAPZvz+GJCP2w@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 4:25 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > >         if (fence)
> > >                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> > > +       if (vbuf->objs) {
> > > +               virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> > > +               virtio_gpu_array_unlock_resv(vbuf->objs);
> > > +       }
> > This is with the spinlock held.  Maybe we should move the
> > virtio_gpu_array_unlock_resv call out of the critical section.
>
> That would bring back the race ...
Right...
>
> > I am actually more concerned about virtio_gpu_array_add_fence, but it
> > is also harder to move.  Should we add a kref to the object array?
>
> Yep, refcounting would be the other way to fix the race.
>
> > This bothers me because I recently ran into a CPU-bound game with very
> > bad lock contention here.
>
> Hmm.  Any clue where this comes from?  Multiple threads competing for
> virtio buffers I guess?  Maybe we should have larger virtqueues?
The game was single-threaded.  I guess it was the game and Xorg
competing for virtio buffers.  That was also on an older kernel
without explicit fences.  The userspace had to create dummy resources
frequently to do VIRTIO_IOCTL_RESOURCE_WAIT.

I think this is fine for now as far as I am concerned.  I can look
into this more closely after this series lands.


>
> cheers,
>   Gerd
>
