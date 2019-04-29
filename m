Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF483C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF112075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="UujbU0fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfD2HtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:49:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43189 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfD2HtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:49:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id g4so10842863qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qeY97UX3qPR9mVn0ASslox/fHOez69lznk44IZQyJw=;
        b=UujbU0faikIxS++cH5j5UD1NhEIoggeoWj8ogOT52YaPJGsXef74ROHkAS6lFTVKul
         /CEwbKNYgZQIGON7B3EkfWKkF/i9yfWGNwYOKPG0Rtmy9DX3ol87CFrpTIoOfMexKfOZ
         JZ5iQdbtbOe66KvS8wQGKrJ1Hzz7G/Pl6OdNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qeY97UX3qPR9mVn0ASslox/fHOez69lznk44IZQyJw=;
        b=d0/ZmD5TMz7JFNKlp+3Hj8pP9UCj6xjYrNj87WrAPgI89lGE6hvy8MqvWCkoa4bFYq
         kQZ51GmdpvYys0ArY8JENW9ljHDNJovgwd2jVwEcQxybdYARt28UthaWB4yohg6krEVN
         jgMyEQWGNBEteAUAIVjugYnnkMgQrDmEGNPYfz3QxLMCt5VjC5U5Xcyaw8+9cxNQ3jCf
         7DHz6t+GDfzsqHy4mUooKt2efsBjG6E11q3W44PV0zL4QQ71EgEEo8LlBlVb59ssF5Sq
         e2HmCUWGaBwY+uBfD0igDtNw8MdPtLyfF2JiSs4kPTbowpumoly1YYrRHVIqj8Zv0GHK
         9cIA==
X-Gm-Message-State: APjAAAX1w2wjJRNERFWxyP9HdAjgh7LJ/9Pw92rUZaCaatDPiCFuxSYO
        dSDKb2L/MAcEnGIGscoddkgqZ27TVHz7xoqvSCI=
X-Google-Smtp-Source: APXvYqzsVaFHI1mpvrMv9BhEk+TvbyuiHJPC8oNa5muwf3tjYXiBtUjwDtoUocY+KZOatuMT5qEd4Xcwx7ENT9rnVds=
X-Received: by 2002:a0c:948e:: with SMTP id j14mr17683473qvj.245.1556524143870;
 Mon, 29 Apr 2019 00:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com> <20190425172549.GA12376@kroah.com>
In-Reply-To: <20190425172549.GA12376@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 29 Apr 2019 07:48:52 +0000
Message-ID: <CACPK8XemgKvM38wDSUJsXXeK51dwmeUoKWn+e3ZNHd9v5VBZHA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Patrick Venture <venture@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 17:25, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > >
> > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > currently present into this folder.  These drivers are not generic part
> > > > drivers, but rather only apply to the ASPEED SoCs.
> > > >
> > > > Signed-off-by: Patrick Venture <venture@google.com>
> > >
> > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > didn't see it on v1 before re-sending v2 to the larger audience.
> >
> > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > Ack this version of the patchset since it changes when the soc/aspeed
> > Makefile is followed.
>
> I have no objection for moving stuff out of drivers/misc/ so the SOC
> maintainers are free to take this.

I was on the fence about this. The downside of moving drivers out of
drivers/misc is it allows SoCs to hide little drivers away from
scrutiny, when in fact they could be sharing a common userspace API
with other BMCs.  (Keep an eye out for the coming Nuvoton "bios post
code" driver which is very similar to
drivers/misc/aspeed-lpc-snoop.c).

However, in the effort to move away from BMC that are full of shell
scripts that bash on /dev/mem, we are going to see a collection of
small, very SoC specific, drivers and it doesn't make sense to clutter
up drivers/misc.

Acked-by: Joel Stanley <joel@jms.id.au>

The p2a driver has been merged by Greg. We should move that one over
too. Arnd, can you advise Patrick on how to proceed? We could have him
spin a v3 that includes the p2a driver, but it would depend on Greg's
char-misc-next branch.

Cheers,

Joel
