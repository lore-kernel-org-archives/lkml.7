Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84245206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1QyemLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDHOcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:32:02 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53588 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfDHOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:32:01 -0400
Received: by mail-it1-f193.google.com with SMTP id y204so20994707itf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sO9l/xiQgqykeBG4qzIQPRWpUK4S5v2eLlxjDK8yMGw=;
        b=q1QyemLOUU0NdREG8RPzDTN+BgQNgPcoUM5lTJuBKXyJ/EH4Yl1M+2yQ1cy8gM7NK4
         ju0S5WZbvANEEn/C57zJIE9MwZZOY/hFOw/oOnZj3wFBQQVHXJ4yVf6plFvCP5EouO/B
         dHg+zBMjbkyfrN12OvgBEemXV9/tfuY5Ce0s5O6tlqRsu2mfq4g8a/WTXOTPaDMo/XiJ
         BAEayGWochMZ/175mz8JY+9gN185EGVCTGaEBr58Czrw0rQvB7/YTkQKyNDp6HP0Jk33
         ioPaX1lwrOPfTulPz6eNCXZSwY/5KHK9Oep8AKUCyfoV3db9Y+TpHeSy7CY9LLckGYal
         RaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sO9l/xiQgqykeBG4qzIQPRWpUK4S5v2eLlxjDK8yMGw=;
        b=EuTvVyqPhlc1v0HnFuz+D9oilHs7lXn9wnsdTLE7TBRu4NYHZC6Qtk7pcqPx6wA4mH
         x39BcqcS4mYRxnzNjruPSxWmC71R3+UEbgfn1i2OJNYIqsFFacC7Z0lnaCLq1qDiZYi9
         lzrpTRQfL4Jx2oZJoZk/yYJvsbqPYJgzICeD1eTz+zR0XWWkwT1BS8AbKZ1Tq/cj4zfR
         bldNeAFdC/hFoP/u5KVxvmra5IBOFukg2cnQkXtOy7N5jqB/JDHLqz80yUkv1J/DAqi8
         egDbrKeP4CBVvI0uXh1wf24YFIhsVg/+JKGsjdE4lMUoLGwBINrobMJjaWuhpJGFbZZT
         lN0g==
X-Gm-Message-State: APjAAAW9XyQab+eLc1QV2N01CpdwT4aZZrucSxP66sDs6Juu+crqfrR6
        1MJYpZmLQRjRFli331f3QX3jRFRp35Wk0udsMis=
X-Google-Smtp-Source: APXvYqwjSDdZZF08mKcl+FTc2fF39txa6Ry1LLvHMipA+1gHdafpLd52WvsWN25gXw+Owfd8NCUYQ7RngqetFp523yc=
X-Received: by 2002:a02:924d:: with SMTP id y13mr18844725jag.24.1554733920606;
 Mon, 08 Apr 2019 07:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
 <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com>
 <054b9d43-cf4e-057d-132d-7c1758956595@baylibre.com> <CAKGbVbtok8RUzDqw=WShAHoiLqWLaKA8coKhcW5EPrsHCO89pA@mail.gmail.com>
 <CAKGbVbtpNKxUDRM9nE05gBuS5jwO68wHh0Uq2NsdYX6pdFtxYw@mail.gmail.com>
 <CAKGbVbuT84tS=H9BeOC7OQ8usopqcYjBy5hoMDTzJbCy7KJStw@mail.gmail.com> <763785ea-ab9d-8135-be8d-a9fb8c92884b@baylibre.com>
In-Reply-To: <763785ea-ab9d-8135-be8d-a9fb8c92884b@baylibre.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 8 Apr 2019 22:31:49 +0800
Message-ID: <CAKGbVbuuhb36mrTuNroQxBtdUswATzLWTAg+1roVbEhPdoAc_g@mail.gmail.com>
Subject: Re: [Lima] [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lima@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 9:45 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 08/04/2019 15:19, Qiang Yu wrote:
> > Oh, I'm really sorry if I did something wrong to use:
> > dim push-branch drm-misc-next
> > (Should the committer just use "git push" not the "dim push-branch
> > drm-misc-next"?)
>
> I can see your commit just fine on drm-misc-next :
>
> commit 6f61a82507c95f146c4e529d28ef7e5ac93242c9 (HEAD -> drm-misc-next, narmstrong/for-linux-next, narmstrong/drm-misc-next)
> Author: Randy Dunlap <rdunlap@infradead.org>
> Date:   Sun Apr 7 12:12:10 2019 -0700
>
>     MAINTAINERS: mark lima mailing list as moderated
>
>     Note that the lima mailing list is moderated.
>
>     Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>     Cc: Qiang Yu <yuq825@gmail.com>
>     Cc: dri-devel@lists.freedesktop.org
>     Cc: lima@lists.freedesktop.org
>     Signed-off-by: Qiang Yu <yuq825@gmail.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org
>     Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> >
> > Because I found the drm-tip repo has been updated also with
> > a few commits that I can't find similar ones in the history.
> >
> > Could any maintainer help with this?
>
> I also usually use "dim push-branch drm-misc-next", it would not accept
> the push if HEAD changed upstream anyway.

How about the drm-tip repo in your case? Will it be updated also after the
command?
https://cgit.freedesktop.org/drm-tip/

I see there're a couple of merge commits by me at the top of drm-tip which
push in many code from other branches and add a new file integration-manifest.
I can't find similar commits in the history, so worry I've done something wrong.

Regards,
Qiang

>
> Neil
>
> >
> > Thanks,
> > Qiang
> >
> > On Mon, Apr 8, 2019 at 8:40 PM Qiang Yu <yuq825@gmail.com> wrote:
> >>
> >> Here's a question first time I use command:
> >> dim push-branch drm-misc-next
> >>
> >> I see it updates both drm-misc-next and for-linux-next branch, is this
> >> expected? What's the difference between drm-misc-next/drm-misc-next-fixes
> >> and for-linux-next/for-linux-next-fixes?
> >>
> >> Thanks,
> >> Qiang
> >>
> >> On Mon, Apr 8, 2019 at 8:26 PM Qiang Yu <yuq825@gmail.com> wrote:
> >>>
> >>> On Mon, Apr 8, 2019 at 8:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>
> >>>> On 08/04/2019 03:37, Qiang Yu wrote:
> >>>>> Looks good for me, patch is:
> >>>>> Reviewed-by: Qiang Yu <yuq825@gmail.com>
> >>>>
> >>>> Also:
> >>>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>>
> >>>>>
> >>>>> Should I apply this patch to drm-misc in this case? Or this patch will be
> >>>>> submitted in other kernel tree and back merged to drm-misc?
> >>>>
> >>>> You can push it yourself on the drm-misc-next branch now.
> >>>>
> >>>> (Then you can reply to the original patch when you applied it)
> >>>
> >>> Thanks for the guidance. I'll push it soon.
> >>>
> >>> Regards,
> >>> Qiang
> >>>
> >>>>
> >>>> Neil
> >>>>
> >>>>>
> >>>>> Regards,
> >>>>> Qiang
> >>>>>
> >>>>> On Mon, Apr 8, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>>>>
> >>>>>> From: Randy Dunlap <rdunlap@infradead.org>
> >>>>>>
> >>>>>> Note that the lima mailing list is moderated.
> >>>>>>
> >>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>>> Cc: Qiang Yu <yuq825@gmail.com>
> >>>>>> Cc: dri-devel@lists.freedesktop.org
> >>>>>> Cc: lima@lists.freedesktop.org
> >>>>>> ---
> >>>>>>  MAINTAINERS |    2 +-
> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> --- mmotm-2019-0405-1828.orig/MAINTAINERS
> >>>>>> +++ mmotm-2019-0405-1828/MAINTAINERS
> >>>>>> @@ -5226,7 +5226,7 @@ F:        Documentation/devicetree/bindings/dis
> >>>>>>  DRM DRIVERS FOR LIMA
> >>>>>>  M:     Qiang Yu <yuq825@gmail.com>
> >>>>>>  L:     dri-devel@lists.freedesktop.org
> >>>>>> -L:     lima@lists.freedesktop.org
> >>>>>> +L:     lima@lists.freedesktop.org (moderated for non-subscribers)
> >>>>>>  S:     Maintained
> >>>>>>  F:     drivers/gpu/drm/lima/
> >>>>>>  F:     include/uapi/drm/lima_drm.h
> >>>>>>
> >>>>>>
> >>>>> _______________________________________________
> >>>>> lima mailing list
> >>>>> lima@lists.freedesktop.org
> >>>>> https://lists.freedesktop.org/mailman/listinfo/lima
> >>>>>
> >>>>
>
