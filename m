Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8E620868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHb3mWn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfDPXTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:19:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47012 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDPXTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:19:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so11044367pgv.13;
        Tue, 16 Apr 2019 16:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiBSfQQASh97WUaoc1T5iQOiPq5hQrvtst1A1NK2kCQ=;
        b=ZHb3mWn6DSd4+dpQioivQHXyjyTceOEqJ3I7trAdZjPhF23LgJd5rQ/QnlRgfFWGIZ
         8ymxiKssr8MZDLrzm2mCIyGuAJnqrGZ2shHEycgJ7aSrC0imwD8EAjU2mfTOG5nuXiAt
         vqsTtr3skN5RzTCaqvhoSWMmfsHAnu2hR4YCuPCdK79lQHViOPsQYetldFtjJSUTmmxk
         5/rMrZGA2GTGnHYsc2YGj0gRyC5Ebbh4XcD5Yq2Bvuu24SxTY+jtL+muaXsx5VFT7uN6
         A/bSScpjzoxfmjuTK97uGkGPSxaMERvuUtEOojyiurGnmRCPjpsF7nWQDz1MdfepCgSX
         FO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiBSfQQASh97WUaoc1T5iQOiPq5hQrvtst1A1NK2kCQ=;
        b=VAaa3KV3a2O68qVJS90bpOJrTQDhMmOR1tZQHdZ2RDJ5kmCY4HRQGVSoWdQ4nUVV+p
         e4nYSbOB3UaDVPw21VvdnPLAR0MCcvqQTDcQLTt4pxtfx5ny9txPqHW+fx88fipR9WTn
         xRrQsP8ctU00P8ZzVjSnlBq+DLA/Pb91UFJL0WtVBb1YHl5ETMlxaBD9EKaAY7lz7jvl
         CvtrgXHQOHK9ddnoFgzd68h3m5YkmtNT7krT3bG5vdGgBQ0J116epQINXRofi7dT+viZ
         if5bhgKIda+esyvKmdjIZSW8LXIffNp8DxWd1YxjiDHvg9TxF1dDXIo3551yqTSBkEGc
         hw9w==
X-Gm-Message-State: APjAAAXdvmX19aj19d2rWCn9dcCu5q+Qhw/CoqMeuXOri5V1E6endKwr
        ZI3aQPiso/nGp7G7iP1hbovhNCdCcEvx711jKAI=
X-Google-Smtp-Source: APXvYqzfM65PF6ek8Ie0OJPhaCbKbfzStKNvKImtRzWjnvFuLZ9tkG9V7WwesiVu75TRGvaZ3BdTCG5/SwxTGG9suyc=
X-Received: by 2002:a65:5342:: with SMTP id w2mr57344231pgr.220.1555456749024;
 Tue, 16 Apr 2019 16:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416090726.GD27892@zn.tnic> <20190416221852.GA10781@agluck-desk>
In-Reply-To: <20190416221852.GA10781@agluck-desk>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 16:18:57 -0700
Message-ID: <CAM_iQpWit6gHTEFPB5cN3XuHQjeR4mBSb03wRc1F44WEQfNH_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 3:18 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Tue, Apr 16, 2019 at 11:07:26AM +0200, Borislav Petkov wrote:
> > On Mon, Apr 15, 2019 at 06:20:00PM -0700, Cong Wang wrote:
> > > ce_arr.array[] is always within the range [0, ce_arr.n-1].
> > > However, the binary search code in __find_elem() uses ce_arr.n
> > > as the maximum index, which could lead to an off-by-one
> > > out-of-bound access when the element after the last is exactly
> > > the one just got deleted, that is, 'min' returned to caller as
> > > 'ce_arr.n'.
> >
> > Sorry, I don't follow.
> >
> > There's a debugfs interface in /sys/kernel/debug/ras/cec/ with which you
> > can input random PFNs and test the thing.
> >
> > Show me pls how this can happen with an example.
>
> The array of previously seen pfn values is one page.
>
> The problem case occurs when we've seen enough distinct
> errors that we have filled every entry, then we try to
> look up a pfn that is larger that any seen before.
>
> The loop:
>
>         while (min < max) {
>                 ...
>         }
>
> will terminate with "min" set to MAX_ELEMS. Then we
> execute:
>
>         this_pfn = PFN(ca->array[min]);
>
> which references beyond the end of the space allocated
> for ca->array.

Exactly.


>
> Probably won't crash, but we will read a garbage value
> from whatever memory is allocated next.


It will eventually crash, this can be proved. :)


>
> Chances are high that the test:
>
>         if (this_pfn == pfn)
>
> won't find that the garbage value matches the pfn that
> we were looking for ... so we will likley be lucky and
> not do anything too dumb. But we shouldn't just cross
> our fingers and hope.
>
> Fix looks mostly OK, but we should probably move the
>
>         if (to)
>                 *to = min;
>
> inside the new
>
>         if (min < ca->n) {
>                 ...
>         }
>
> clause.

No, we can't, in case of -ENOKEY, we still have to save the index
for caller to insert it at the end of the array, therefore *to must be
always saved.

Thanks.
