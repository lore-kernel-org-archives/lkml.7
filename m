Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02437ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FBA20663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFV9ZuDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439676AbfJQL0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:26:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35496 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405872AbfJQL0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:26:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so1475428pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp43P0cGhhiOHZS3+IYqiVvEgQX4eVeuGxkCs4X4mgc=;
        b=uFV9ZuDOfmZXXI/JLG8LBTtE9alrffdZkWGmRFlMwje001D8NG8cjeyMq08mO3C6jD
         pP45vSaMWKbxxEslfSDBUFLUSp1CwXCKVy+HxsKjLqiTdxJ4Cv25gzOwwLISVw5g3lvJ
         hgpbA6FTsmStiJx3VP14EybgfOvKpbjzbOS8OnHfzn4JgsfPIFa3jFA33nCQJSmWkG0r
         llj46cmWDRoPNOccQDiPkFvC0aZoUi9zG1bde6LieNGbKqHpRGIs+8ZbBbStZow8FFiR
         x7eIBWdl9rDIJ4Fm2h++/1tSKefjHvSDPEwchejwwy4VkudI8YD4+d+wpFkPvd7QCrXo
         b2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp43P0cGhhiOHZS3+IYqiVvEgQX4eVeuGxkCs4X4mgc=;
        b=teyuS+nHikpvBmaU86ka1VaFDdSqWfZtx8dL/AeJ7WmHXbBnjPMQvzKojDyW8q4SAU
         lZHznYx0xjQAZceLOAT0W4MBNgDIAdNrI2csAKxl5MJAWiMZMfzQvCoy4lbgO5g5AAU7
         J05WkCdyT02X017j9at+6mCNI4ujQ3lsnLGhHIOaZ7u8VWcvqj+Oaa9SctpHJY9vc2+0
         1lZFMSUcRsIHXXX+UWlRYuFFNz3dPNReJ7n98DPx13NKNgcZ0TqANo9C9vL+V2lgJ+TF
         1pykks4dAEsZLMHLTc5Z+LGe0Ys0m1NlRo64VkzB6AifqsKdTRWmqb0NXd98pl4G+H7r
         0GLg==
X-Gm-Message-State: APjAAAXVzH0ke93piD05Ssa43ytRNz0qdiwiwCAyRG+UUimwsthrfIkF
        etS1s65PBve9KnQb62VD+r/RzlcUlXb8nYH6wn0=
X-Google-Smtp-Source: APXvYqwpdq/8pB36vgDA1mSInLkk8y88iDTf32L8d01RYXiI67+z5afiS0eIzkFPLKzqIxao2ZiZB5y3esAb21HxJJc=
X-Received: by 2002:a62:e80b:: with SMTP id c11mr3160941pfi.241.1571311602344;
 Thu, 17 Oct 2019 04:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191016082430.5955-1-poeschel@lemonage.de> <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
 <20191017080741.GA17556@lem-wkst-02.lemonage>
In-Reply-To: <20191017080741.GA17556@lem-wkst-02.lemonage>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 17 Oct 2019 14:26:31 +0300
Message-ID: <CAHp75Vd2WqpSMHGR6LDvePyhdDDPOOWWsStD5RWDvpw7xyM6VQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:07 AM Lars Poeschel <poeschel@lemonage.de> wrote:
> On Wed, Oct 16, 2019 at 06:53:20PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 16, 2019 at 10:24 AM Lars Poeschel <poeschel@lemonage.de> wrote:

> > Thanks Lars, CC'ing Geert since he wrote a large portion of this, as
> > well as Andy.

I would be able to test next version if you Cc it to me (better to my
@linux.intel.com address).


> The idea with changing the return types: It seems a bit, that with this
> patch charlcd is becoming more of an universal interface and maybe more
> display backends get added - maybe with displays, that can report
> failure of operations. And I thought, it will be better to have this
> earlier and have the "interface" stable and more uniform. But you are
> the maintainer. If you don't like the changed return types I happily
> revert back to the original ones in the next version of the patch.

First rule of all, split as much as one logical change per patch. If
you wish to split, do simple split and nothing else. But I think you
also need to prepare something for the split. I would think of
introducing ops structure beforehand.

> Are you able to test the panel driver ?
I would be able to test on HD44780 connected via GPIO (4-bit mode).

-- 
With Best Regards,
Andy Shevchenko
