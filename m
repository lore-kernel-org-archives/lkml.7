Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E15C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A963A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM0Gq4yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCLPLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:11:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33314 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:11:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id z7so2682862lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAsmMb/KS/4LTNxcX+BEFLVFT469PItXv1tXVOcQ5zo=;
        b=mM0Gq4ydM5nvRE5QPnlN8exLU+qqSGfASxIkgaROI0T/C0l1FkgKD/k4oBQmoDYZRB
         tHybO0CDdJn1+Eif+nkFUnV31zyF2n7V0qm9ogd5xREFWnbz4zhk80TKetQeV3QwFLZR
         62JkZsWo7s/plZPE6bF9wYqbmzo+KvHW9zj+foffpMqynhaA5mn2phjwKPAaz4OHZlNG
         WHC2adsevjThrAoh0HbaLq1cdEaTBqHOSQBI2oH5gqoC3wgm3Cka7oreCAHAgJ2LhMZJ
         h/T5aXmzaw8X0ctOJ7pdWbOYZc4w0386QVQ1foKBdwbqIH07zy9Wkv20obvKGD8nWkqJ
         G2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAsmMb/KS/4LTNxcX+BEFLVFT469PItXv1tXVOcQ5zo=;
        b=l2OIpHrTobNH7WBxdKC51Eq5RlS83OWLCoBTZcb+hENhjtKDoHPnyJNGEQUEa1xy+N
         mkkc+TF8jgtp6h3iP9zyzm62oMawWk6APHUcB19p6JlSgV+/bAkuesh3eWUH5r9Q+Y85
         saNtSLKWWqLPQh5/X3+0b17jQ3zOaHe5mB/YXW/qN+kT5ksORO1ifbGXOzPgDZAX/wOY
         pCfaOGqCEiK6wCllCBNxUjmbqpWrqkeIIFoFH5RUMEo0ob4tPX9PFsE56uOV58WYgs2Q
         CF0Lhixqd1V0MZjRfMW2c39Hbge51erV82n8o+OmVuAIulhlZqE1VvZufKJXWb1yQHmy
         smAA==
X-Gm-Message-State: APjAAAUanqlmlFvSk3IvR58Or8I9JSKayGdv55JSwfO0lmV2y7O/9SIU
        4gicaoJnnV305rkhhsh2ep8LrHjyUpto1Pq2iv18Pg==
X-Google-Smtp-Source: APXvYqxVYWHcs7SQHFjOmoBkNvNci39YQEI9dFTN/SmcfWmiU4e6ERzEolquz923sqa2Hv5cG0sqswbdjzwP+uXXitY=
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr20059411ljb.182.1552403507340;
 Tue, 12 Mar 2019 08:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 12 Mar 2019 16:11:36 +0100
Message-ID: <CANiq72mmeCv+mVGjE39OMxaJH9CDmDSDuDkdXo7aG+edxo3ekg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] auxdisplay: Introduce charlcd_free()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I have found a memory leak in hd44780 and it becomes that we have no
> counterpart to charlcd_alloc() that developers can easily miss.

Side-note now that I see these patches: I forgot to CC you in a series
for charlcd that we got from Mans a week or two ago -- please take a
chance to review them if you want! Also pinging Geert & Willy again in
case they want to take a look.

Cheers,
Miguel
