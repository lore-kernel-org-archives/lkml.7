Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72EC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A7206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEDJig convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 05:38:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36369 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEDJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:38:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so6275458oia.3;
        Sat, 04 May 2019 02:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=HFseoIWdZ0CgvYQXA3eAJnk39OPJTIq5Z9waS1ZE/Jc=;
        b=MLaA2HE++m5V4WSryK46H1oRcZYNNYjQ2OJNoCy1cZLuDhVOFP8hUXqIXwWv9vVb6t
         HUkEEAGwMbRUPzKAQW5J5smYBnJ80A1voiHLSeKHwbCvl03GwT+6IuLkHOUx1JI5TFQP
         JYRMIOUCa3IgBso2QXyYPVEf9aeEcf955H0LH9eCwAFF3DwFW5HO1v1ZRpcNvggpkFr9
         LQ4do+TXESwwflNu7Me3T6u4yvbaF8Kdg1xxS92CjhuR4xC8al0khaXmxwnx9htdTmj/
         tvxIQv5odfm3fIqCQVAaqaTOc3hYUtyYa9xzJpMLJj5uE0DW+/ea7IkT6HhIPx4j5kTO
         kcaA==
X-Gm-Message-State: APjAAAU4AxqfOu2G4q+soLKHSb7sbtKrk42Cj2HiyrBaibBESPYy5kDJ
        EpxSWm7omIK8T3itSvJjAo5E9RghijkpM8JCP2s=
X-Google-Smtp-Source: APXvYqzSnqDL5V1V0nXKvVXGhTqE7hzRVYiJdoDEV0gao7+HsCWuCIR5ouFQqReU4n19/y4ehX0kTkLO0aUKFmOKP0g=
X-Received: by 2002:aca:eb11:: with SMTP id j17mr2029311oih.67.1556962714541;
 Sat, 04 May 2019 02:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190403185310.8437-1-matwey@sai.msu.ru> <20190403185310.8437-7-matwey@sai.msu.ru>
 <20190430153118.GI20993@uda0271908>
In-Reply-To: <20190430153118.GI20993@uda0271908>
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Date:   Sat, 4 May 2019 12:38:22 +0300
Message-ID: <CAJs94EZLDotLHQmfhvzyRZWDAEL6hnUTmkXKMoVrO_JBJcHX4A@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: musb: Decrease URB starting latency in musb_advance_schedule()
To:     Bin Liu <b-liu@ti.com>, "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?0JzQsNGC0LLQtdC5INCa0L7RgNC90LjQu9C+0LI=?= 
        <matwey.kornilov@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

вт, 30 апр. 2019 г. в 18:31, Bin Liu <b-liu@ti.com>:
>
> Hi Greg and all devs,
>
> On Wed, Apr 03, 2019 at 09:53:10PM +0300, Matwey V. Kornilov wrote:
> > Previously, the algorithm was the following:
> >
> >  1. giveback current URB
> >  2. if current qh is not empty
> >     then start next URB
> >  3. if current qh is empty
> >     then dispose the qh, find next qh if any, and start URB.
> >
> > It may take a while to run urb->callback inside URB giveback which is
> > run synchronously in musb. In order to improve the latency we rearrange
> > the function behaviour for the case when qh is not empty: next URB is
> > started before URB giveback. When qh is empty then the behaviour is
> > intentionally kept in order not to break existing inter qh scheduling:
> > URB giveback could potentionally enqueue other URB to the empty qh
> > preventing it from being disposed.
>
> This patch changes the sequence of urb giveback in musb.
>
>         before                          after
>         ------                          -----
> 1. giveback current urb                 1. start next urb if qh != empty
> 2. start next urb if qh != empty        2. giveback current urb
>
> I see there is a potential that the urb giveback could be out of order,
> for example, if urb giveback in BH and the next urb finishes before BH
> runs.

Could you please give more details? Frankly speaking, I am not sure
that I understand the reordering issue origin correctly.
I see in the existing implementation that the function call order is
the following:

1. glue interrupt handler (for instance dsps_interrupt() in my am335x
case) holds musb->lock;
2. musb_interrupt()
3. musb_host_rx() (or *_tx())
4. musb_advance_schedule()
5. musb_giveback() releases and reacquires musb->lock around:
6. usb_hcd_giveback_urb()

So, when musb_giveback() is called inside musb_advance_schedule() then
the second instance of musb_advance_schedule() can be started
simultaneously when the following interrupt is being handled at other
CPU core. And we can see two usb_hcd_giveback_urb() running
concurrently.
Is it correct?

>
> If this potential is possible, is it a problem for any class driver?
>
> Thanks,
> -Bin.
>
> >
> > Before this patch, time spent in urb->callback led to the following
> > glitches between the host and a hub during isoc transfer (line 4):
> >
> >     11.624492 d=  0.000124 [130.6 +  1.050] [  4] SPLIT
> >     11.624492 d=  0.000000 [130.6 +  1.467] [  3] IN   : 3.5
> >     11.624493 d=  0.000000 [130.6 +  1.967] [ 37] DATA0: aa 08 [skipped...]
> >     11.625617 d=  0.001124 [131.7 +  1.050] [  4] SPLIT
> >     11.625617 d=  0.000000 [131.7 +  1.467] [  3] IN   : 3.5
> >     11.625867 d=  0.000250 [132.1 +  1.050] [  4] SPLIT
> >     11.625867 d=  0.000000 [132.1 +  1.467] [  3] IN   : 3.5
> >     11.625868 d=  0.000001 [132.1 +  1.983] [  3] DATA0: 00 00
> >     11.626617 d=  0.000749 [132.7 +  1.050] [  4] SPLIT
> >     11.626617 d=  0.000000 [132.7 +  1.467] [  3] IN   : 3.5
> >     11.626867 d=  0.000250 [133.1 +  1.050] [  4] SPLIT
> >     11.626867 d=  0.000000 [133.1 +  1.467] [  3] IN   : 3.5
> >     11.626868 d=  0.000000 [133.1 +  1.967] [  3] DATA0: 00 00
> >
> > After the hub, they look as the following and may lead to broken
> > perepherial transfer (as in case of PWC based webcam):
> >
> >     11.332004 d=  0.000997 [ 30.0 +  3.417] [  3] IN   : 5.5
> >     11.332007 d=  0.000003 [ 30.0 +  6.833] [800] DATA0: 8a 1c [skipped...]
> >     11.334004 d=  0.001997 [ 32.0 +  3.417] [  3] IN   : 5.5
> >     11.334007 d=  0.000003 [ 32.0 +  6.750] [  3] DATA0: 00 00
> >     11.335004 d=  0.000997 [ 33   +  3.417] [  3] IN   : 5.5
> >     11.335007 d=  0.000003 [ 33   +  6.750] [  3] DATA0: 00 00
> >
> > Removing this glitches makes us able to successfully run 10fps
> > video stream from the webcam attached via USB hub. That was
> > previously impossible.
> >
> > Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> > ---
> >  drivers/usb/musb/musb_host.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > index ed99ecd4e63a..75be92873b5b 100644
> > --- a/drivers/usb/musb/musb_host.c
> > +++ b/drivers/usb/musb/musb_host.c
> > @@ -85,6 +85,11 @@ static bool musb_qh_empty(struct musb_qh *qh)
> >       return list_empty(&qh->hep->urb_list);
> >  }
> >
> > +static bool musb_qh_singular(struct musb_qh *qh)
> > +{
> > +     return list_is_singular(&qh->hep->urb_list);
> > +}
> > +
> >  static void musb_qh_unlink_hep(struct musb_qh *qh)
> >  {
> >       if (!qh->hep)
> > @@ -362,6 +367,19 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
> >               break;
> >       }
> >
> > +     if (ready && !musb_qh_singular(qh)) {
> > +             struct urb *next_urb = list_next_entry(urb, urb_list);
> > +
> > +             musb_dbg(musb, "... next ep%d %cX urb %p", hw_ep->epnum, is_in ? 'R' : 'T', next_urb);
> > +             musb_start_urb(musb, is_in, qh, next_urb);
> > +
> > +             qh->is_ready = 0;
> > +             musb_giveback(musb, urb, status);
> > +             qh->is_ready = ready;
> > +
> > +             return;
> > +     }
> > +
> >       qh->is_ready = 0;
> >       musb_giveback(musb, urb, status);
> >       qh->is_ready = ready;
> > --
> > 2.16.4
> >



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119234, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
