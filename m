Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B51220659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGBIof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:44:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45931 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGBIof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:44:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so13271811qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRr1ICNLsP/bZydo2ESlOmbE20F/PgMFOAALZnGqKRI=;
        b=kzAWfNx2gn/1CkDIsg2QB94OxKgG4Rmw1DHMZgPWC0RMEWYBmY4Sx0F+mYxBeXyjBg
         h0CEck/ZjWiMujhoMsJvvrEwH6waE6KR8Z0FuUqp/o8Z/Hp+YGeyO32Vr2nUDonRtnYV
         A50SmiKjlASnPzgrjReBUUwExif3byDDRFKdkcbxS83h93YErCe4iJKRcLN1uMd9/neD
         SDfW56MdJe2KZmXsC5xRLm/VpWxfPvG4AiuctE9PfWaRH26sPec9b2ykUmuI6iwyt1ZO
         b+9mSOyXIf2JqSqvjzwsxpk1Pq1f3fINp9mItoe50H5BxpIC+h3UQerF1Nd4R//4rwRt
         RdNQ==
X-Gm-Message-State: APjAAAWHzgebnVtkYtVVHHTdXNX1GEbK5EEbebrquQCRnOv5jbaNFNul
        f1RA3RZuFZ3b93jo9v7fwPkKnl1veLr4N7vLZsjijg==
X-Google-Smtp-Source: APXvYqzykw2KRjSeIdUtulZYvxYMEJT9/dDg7bU5axVLq04LNZK9WnGtZKlJF8kANxWrC/BEFhGBQxU0Cj9mQXBqJyM=
X-Received: by 2002:a37:a86:: with SMTP id 128mr24911948qkk.169.1562057074451;
 Tue, 02 Jul 2019 01:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190701102010.6611-1-hadess@hadess.net> <CAO-hwJ+hHKqZeOfpnWkU57RwzD4m6U9afG7iMND=OGZodzS1GQ@mail.gmail.com>
 <9171d69f51a6a197e0d554326fcedc39bfb3fbbc.camel@hadess.net>
In-Reply-To: <9171d69f51a6a197e0d554326fcedc39bfb3fbbc.camel@hadess.net>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 2 Jul 2019 10:44:23 +0200
Message-ID: <CAO-hwJLmewFMcFpn4X1RhjgpuYCRnDJgL5Vu5kduy8a0LUgQjA@mail.gmail.com>
Subject: Re: [PATCH v5] HID: sb0540: add support for Creative SB0540 IR receivers
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <bnocera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 10:39 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2019-07-02 at 10:29 +0200, Benjamin Tissoires wrote:
> > drivers/hid/hid-creative-sb0540.c: In function
> > 'creative_sb0540_raw_event':
> > drivers/hid/hid-creative-sb0540.c:157:3: error: label 'out' used but
> > not defined
> >   157 |   goto out;
> >       |   ^~~~
> >
> > It would have been nice to at least try to compile it in a tree.
> > You don't need to compile the whole tree: just clone it, apply your
> > patch and then `make -j4 M=drivers/hid`
>
> v4 _did_ build. Don't be surprised if after 4 versions on top of the
> ones you did when the driver was out of tree, I get review fatigue, go
> for expediency and some mistakes slip through.

Right, sorry.

>
> Fixed in v6.
>

Thanks!

Cheers,
Benjamin
