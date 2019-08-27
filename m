Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083CAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2DA2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8vyk3/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfH0VwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:52:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40906 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfH0VwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:52:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so254804pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+irtzyVRDDrZdpMz7JihRashs6tjpw1hAnPhyXixHfQ=;
        b=H8vyk3/hGsv4WW7to+VBsIoy/ie5y44IptvuovFBoFlS81qgLeHyMG6YQgBw/5NiNJ
         4OJbnrcOAqOdQIj7AyUVcV0NQCjrAJdZ1axoB+yMJ3BYN38u4jmdQCGEOEwkSrTpRMhe
         qO8BNNHqBeQ7OjCM6FRGwKKxkAUT6DfiP5VlwZGowJ17eLxv8jhB0or8+sYF37ERbtzM
         otWRjXgj2ld2gyoMIrYgsQi4iPLd6zR64a9P8MdgkI8YnzYQZULtWc0Q3QrHJOgA8B26
         PXEj/PSKdDzY6isF4T/zCx0ihKcSOl8bNbmAbPU0xCELf7iMVWfiH9fVuxD+OjxvTWlc
         pleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+irtzyVRDDrZdpMz7JihRashs6tjpw1hAnPhyXixHfQ=;
        b=th6Qise1/8oUGiUeHmZiOXBfx1UuVWtfvWU7/EJ4tzCrTYEWeoB4hXotQb3OhdfO3y
         rCcPIiyfSCc1+HJQI2H8uKrs9yJjVZK4iZsqYe4rdS4CpB3LyJL5oDxVpvwv8Y8snxY8
         MiOU8J6pOw/GF4bAUMgEkAI9RBqZv3OAxGo7V3xg080yTB3SJyoFPNeM6yngyLJQ3a5Z
         4U41+ljQdOPrkD+9Fa3ksA4DVz4q8T1PRSAPEtg9tmjJouuyA+Tf+Sd9yNrfkp3PBihx
         3iDuCjArZMnbU/9qL4JEGf30EekeR0B/f6rupOhIO13YS0aiZ7BzJgCrbRsQHpT/QkMm
         eVbQ==
X-Gm-Message-State: APjAAAUsDTedOtpkoDUdrWGSKGXJiMNf70hLMYCgW/Fk9IaPulNsmLp3
        nITqgcIIUIQ0nDCXT/MXtnwalctfQ5YJxaNQpTDL/g==
X-Google-Smtp-Source: APXvYqxrNp5MqJ49VvEtHBx+6SXiy4HCQDDbPjQbTxaNkfrxJpIxNaW7wj73njCyaAs203y7ieJUT/8pgVpCFwemiTA=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr527994pgk.384.1566942728992;
 Tue, 27 Aug 2019 14:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190827174932.44177-1-brendanhiggins@google.com> <20190827214613.9B896206E0@mail.kernel.org>
In-Reply-To: <20190827214613.9B896206E0@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 14:51:53 -0700
Message-ID: <CAFd5g45NudtV4Q-ooXStGnEUDYCBbTx2JvkYQn1_mLZNYqnPjA@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     shuah <shuah@kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 2:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-27 10:49:32)
> > Previously KUnit assumed that printk would always be present, which is
> > not a valid assumption to make. Fix that by ifdefing out functions which
> > directly depend on printk core functions similar to what dev_printk
> > does.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> Does kunit itself have any meaning if printk doesn't work? Why not just
> depend on CONFIG_PRINTK for now?

I was thinking about that, but I figured it is probably easier in the
long run to make sure it always works without printk.

It also just seemed like the right thing to do, but I suppose that's
not a very good reason.

I am fine with any of the three options: depend on CONFIG_PRINTK - as
suggested by Stephen, just use printk - as suggested by Shuah, or
continue to use vprintk_emit as I have been doing. However, my
preference is the vprintk_emit option.

Anyone have any strong opinions on the matter?
