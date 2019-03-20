Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9762146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlnsAh4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfCTQzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:55:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35622 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCTQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:55:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so2821035wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTDjI+RbBB/APbmiNr6t1AVweAu5f4OB7m4SUCNMIm8=;
        b=LlnsAh4FOgQPAo5yzjVr2zzx+xuQcnJN5/2dLYrSyoWEfRty6NBCEEfpvsERueQzY4
         FzXz+z0zK3JF/f4d0S7zyYx8eX2oh2Q9WVUrIHsvYHIfyJwzv7EAlYEOy3YtK+aWHA6U
         4sKOq6FGMYtG/eWdxhsgVSd9eSGTPFUN5pSkeM6WftbYltTzj2nHskDw5yH8CKlaPK9z
         a1cnslJ9sGj00zGZQlm++Vyyz1WhiEJnBhhV1YbkJFUQwqwlB4jK3VxSoaCbHXBfogsy
         LUiWmpGGxrySMusNCSA5kyYDTB4jLVFFVP9YJfl9TsSPl1wn2zZR/p4uLVgbOXS8O++u
         rTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTDjI+RbBB/APbmiNr6t1AVweAu5f4OB7m4SUCNMIm8=;
        b=GrSeHS8sY9u95Hl+4sXcoTqbR9oYCqs4xqBR5CFQ6d8y+NiQv6gHUTuPQ2HSGcd0Ke
         M9KgXUc6TCDSeO6O4Aq9RvFHpPg2zSLMkNbBE0rcIn2qSk3Df8y2X3WYfLPWBWhz0OmM
         drqjTVAfP4cu+RLFi5zPfvmU0634WhkDuMvWkHp66KtOGqhXBU3iKOAaMH9leEvYoM5g
         fHH2G0XRBvjbw8X636q76E7qJFTV1aIJQ2iDOkQdHHXDCrEZx4geDxs5ozZgCBk5J2tB
         IlPI4GwuOATVd33HBuxV0ZWvUiFW9Rhu/71L039m3JSfjWqAGX1RveRSwwBJR/jPl7Ie
         qyzw==
X-Gm-Message-State: APjAAAWlZqiTSXEIu9RzE8LbmK11ese+hlsOO992iSHYTLGFvsm/OkAZ
        1EtDWFsgGffWoP12lHhjo2kqeWNOf1I+n7emNi4+DQ==
X-Google-Smtp-Source: APXvYqwl95GZVNfzZIAfGvo0ZGyoI/9ScqC0aUjpeYJ2kFMHEYms/Rlp9ec9jooj977mP45PYTXVNUpt5p7PkpxN2Ds=
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr9466859wmh.9.1553100934116;
 Wed, 20 Mar 2019 09:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1903201247570.1538-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1903201247570.1538-100000@iolanthe.rowland.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 20 Mar 2019 09:55:22 -0700
Message-ID: <CALAqxLUdNe5PUnqM8MBdQaGkMU0QGuDjpWL0VeSCH_fx2jWGWg@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     fei.yang@intel.com, Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, andrzej.p@collabora.com,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Shen Jing <jingx.shen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:52 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 20 Mar 2019, John Stultz wrote:
>
> > Hey Fei,
> >   So while this patch does resolve the issues I was seeing with
> > mainline kernels and recent changes to adbd, Josh pointed out that it
> > wouldn't resolve the issues I was seeing with older kernels which is
> > slightly different (but still related to aio usage).
> >
> > On the older kernels I'm hitting scheduling while atomic on reboot,
> > which seems to be due to ffs_aio_cancel() taking a spinlock then
> > calling usb_ep_dequeue() which might sleep.
> >
> > It seems a fix for this was tried earlier with d52e4d0c0c428 ("usb:
> > gadget: ffs: Fix BUG when userland exits with submitted AIO
> > transfers") which was then reverted by a9c859033f6e.
> >
> > Elsewhere it seems the ffs driver takes effort to drop any locks
> > before calling usb_ep_dequeue(), so this seems like that should be
> > addressed, but it also seems like recent change to the dwc3 driver has
> > been made to avoid sleeping in that path (see fec9095bdef4 ("usb:
> > dwc3: gadget: remove wait_end_transfer")), which may be why I'm not
> > seeing the problem with mainline (and your patch here, of coarse).
> > But that also doesn't clarify if its still a potential issue w/
> > non-dwc3 platforms.
> >
> > So for older kernels, do you have a suggestion of which approach is
> > advised?  Does usb_ep_dequeue need to avoid sleeping or do we need to
> > rework the ffs_aio_cancel logic?
>
> usb_ep_dequeue can be called in interrupt context, meaning it is never
> allowed to sleep.  This is mentioned in the kerneldoc:

Thanks for the clarification! Sorry I didn't see the kernel doc!
-john
