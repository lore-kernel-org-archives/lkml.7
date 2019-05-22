Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D52C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795F920881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4uVaRKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfEVV1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:27:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44938 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfEVV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:27:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so3868464wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPM/jVZtGO2/RgT9Pi90b9WxpAcXAmjN4dUeTd5rlc0=;
        b=l4uVaRKKyhOj6q8UAKaPAPsHBuT94pMVw7A9dKSHMy5YOm42zxlYYfjLIYzck9FmTv
         fzTQOPjh2PkrGZikx2x296/rTWPPbh5GdpImItlwd8d8xkJVIkSc5JhMDe6HrLbw09JS
         4449DXkARWg8JSqIZ1Fpl2wqzyES7uNfiuw2sJSoN9fTdGkPXQQXro/H6NC+C6hfA14R
         OTw+sEBZJugdPZN3U2nQRSZRQCaThk+ZSwC2oLi6P+xt+u8pSfwrs5GbPoPkUe+YZbd/
         GfL8QZDRP+sqalPutnO63lgpRrwiFFM5nRk8+6Veu30Olh8zHQU0IOF04BK7Y1jo/Q1R
         HNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPM/jVZtGO2/RgT9Pi90b9WxpAcXAmjN4dUeTd5rlc0=;
        b=dpAwotq0l8OLn2ewgTbhNhDZEV+NFf7O24vf+HvABeoWtvdwaZ1tnmN8JTId3FTSL5
         FEDdzciTaRpAuAPMf4NKkX+f68WfI4IWsaH03bfKF/IHVJYlwo1p3vogkaMkJYVm68pR
         QP8S55/xoMM9RVl5HyVgNR7PIaXJEi/7RHbJgYvebAQEYP0infFmmHQ6k1gAUK5ymMQM
         tQw7s6CndKA80z+zzUqapJca1WsYh7o9Wduze/tRNDCrrghtkFJkXV8cGsRDiOk2h/SP
         tLx7MHNN+W4qe7Y7y+HLpf5Okhpsv4EBnyAnXjy7UjgBCq9VgF50Ca5kCry8O1Gm4s5X
         QJnQ==
X-Gm-Message-State: APjAAAV9PawT+TOzY9HqS/+JxsDSuFWzAyqGd2PPhoSfNjBw4liLobC5
        cUYqE/mUowUgl1v3eLjGQSgL8L7yeK1efMxOePVUJXWk5b4=
X-Google-Smtp-Source: APXvYqy1HLPgU0D13o/8TkRWOMOKejvjfwnw+2WACNEYNIbz5sOD1C5mnszzqR+Xj8MfEhBGYWzqiRFtNIavxuQn9EY=
X-Received: by 2002:adf:db81:: with SMTP id u1mr27305113wri.296.1558560420784;
 Wed, 22 May 2019 14:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
 <20190522000753.13300-2-chris.packham@alliedtelesis.co.nz>
 <CAFLxGvy2c9KV1CyoFaD76jvThfPiotqfoeNchqjGcDp+uHie7Q@mail.gmail.com> <0c59bcd6c866429cb9727f787b7f61ce@svr-chch-ex1.atlnz.lc>
In-Reply-To: <0c59bcd6c866429cb9727f787b7f61ce@svr-chch-ex1.atlnz.lc>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 22 May 2019 23:26:48 +0200
Message-ID: <CAFLxGvwRnBtscaJDQ4qYGpQt87+amKYb4vBJvtt-3BmsOorL_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: concat: implement _is_locked mtd operation
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:06 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> On 23/05/19 8:44 AM, Richard Weinberger wrote:
> > On Wed, May 22, 2019 at 2:08 AM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> >>
> >> Add an implementation of the _is_locked operation for concatenated mtd
> >> devices. As with concat_lock/concat_unlock this can simply use the
> >> common helper and pass mtd_is_locked as the operation.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> ---
> >>   drivers/mtd/mtdconcat.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> >> index 9514cd2db63c..0e919f3423af 100644
> >> --- a/drivers/mtd/mtdconcat.c
> >> +++ b/drivers/mtd/mtdconcat.c
> >> @@ -496,6 +496,11 @@ static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> >>          return __concat_xxlock(mtd, ofs, len, mtd_unlock);
> >>   }
> >>
> >> +static int concat_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> >> +{
> >> +       return __concat_xxlock(mtd, ofs, len, mtd_is_locked);
> >> +}
> >
> > Hmm, here you start abusing your own new API. :(
>
> Abusing because xxlock is a poor choice of name? I initially had a third
> copy of the logic from lock/unlock which is what lead me to do the
> cleanup first. mtd_lock(), mtd_unlock() and mtd_is_locked() all work the
> same way namely given an offset and a length either lock, unlock or
> return the status of the len/erasesz blocks at ofs.

Well, for unlock/lock it is just a loop which applies an operation to
a given range on all submtds.
But as soon an operation returns non-zero, the loop stops and returns
that error.
This makes sense for unlock/lock.

Now you abuse this as "apply a random mtd operation to a given range".
So, giving it a proper name is the first step. Step two is figuring
for what kind
of mtd operations it makes sense and is correct.

> >
> > Did you verify that the unlock/lock-functions deal correctly with all
> > semantics from mtd_is_locked?
> > i.e. mtd_is_locked() with len = 0 returns 1 for spi-nor.
> >
>
> I believe so. I've only got access to a parallel NOR flash system that
> uses concatenation and that seems sane  (is mtdconcat able to work with
> spi memories?). The concat_is_locked() should just reflect what the
> underlying mtd device driver returns.

mtdconcat *should* work with any mtd. But I never used it much, I see
it more as legacy
code.

What happens if one submtd is locked and another not?
Does concat_is_locked() return something sane then?
I'd expect it to return true if at least one submtd is locked and 0
of no submtd is locked.

If the loop and return code handling in __concat_xxlock() can take care of that,
awesome. Then all you need is giving it a better name. :-)

-- 
Thanks,
//richard
