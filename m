Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A4C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B6D216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIqviWeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFPLYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 07:24:35 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42406 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfFPLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 07:24:35 -0400
Received: by mail-ua1-f66.google.com with SMTP id a97so2451169uaa.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YFtP5iq4BuWWAYRxXcVS3zg7MUScG/wOavOEpLgmd4=;
        b=MIqviWeHh0MAPFZ+O748eD1CPUP+ze9taXOmIk320qFtd0z0ZwWdRMT/3aVaU0L1od
         /papDVqO6pJktv5ACUwSLfl8tMgvRaTBtOmfX+EsFL+IdBrJ/6fYb9HI6lONV8WoTOi/
         9BTXQQ1ghWGfhgDK7sb7eC7AoWVy7IQP7WeRggCunxTmuC3iNxuOL65a++ql6ClyZd4B
         KeaJXXJ7iyl4NO1w2UaMGngDyhSbNHpCzJrwBWvoWvQwH0EwaTULYGczXhzOcugcbOxC
         zLMbChGl23+XaSiG3si+cV3WlHzfkFK1AehSnt9Xw17DIFdds21kzXmCARlHxbd3q1lX
         BAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YFtP5iq4BuWWAYRxXcVS3zg7MUScG/wOavOEpLgmd4=;
        b=ZWOneBzGcigh64ffnk4EojRCWCysZpyPXJ6T+mZ+4lMiNhn6CmNn+peJD1NXA/EMCh
         K8vDKeOgdAULcnCHLhedIWDkD0QkVIazyjdTXwAysg3ywYXMtRX4gBvbTVzMywDS9G9G
         mOWSZcX4q7oh46bgf/u+Go/uUqDONgRqFp67hvPcInTXL5RhYCKTEFGVxyo8OnnTRTGq
         cMnNwQbDyTypdK0LlJ3tfeltC5RhpqxQ10adxz7znOtJscVL5gde9P9dNxlNwFNAuKnK
         YRYnBy4CLZFzs+0tBVySPD6gMBdu7txs/oqQQirrI3OXsAlyqxf+K55MlskeU4cyzw/D
         JedA==
X-Gm-Message-State: APjAAAX6mYuSOMt/bEfE9/yTppwBq2gHBb62rGmStyXPg9X+MvfdDf3E
        CwO2eluzrF7Q+s3TzYPso2raxi+EDxptpfMb93Pxrhkd
X-Google-Smtp-Source: APXvYqwFnjkL/sGG6t/J2J4p55Sgoswg5CgNeymio3riVhqmFIfVhmwbO0lvkgKGo3NOAWyf60liJs64r5OK8KHwUQE=
X-Received: by 2002:ab0:698f:: with SMTP id t15mr27953515uaq.34.1560684274198;
 Sun, 16 Jun 2019 04:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com> <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf11DKi+pfvvGR2zN4jvwTQZ9-Lm=OXBs+ZU=E-eFfJOi7A@mail.gmail.com> <20190616095554.GA5156@infradead.org>
In-Reply-To: <20190616095554.GA5156@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 16 Jun 2019 14:24:08 +0300
Message-ID: <CAFCwf11XU1JydbS-wswXBzm4t-fxLjGyXuHCqrNxTsWzLraSZQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 12:55 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Jun 15, 2019 at 03:12:36PM +0300, Oded Gabbay wrote:
> > So after the dust has settled a bit, do you think it is reasonable to
> > add this patch upstream ?
>
> I'm not Greg, but the answer is a very clear no.  drivers have abslutely
> no business adding these hacks.

So the alternative is that my device won't work on POWER9. Does that make sense?
What is the reason for this logic?
I'm not adding code that will be used by other drivers/users.
I'm just doing a special configuration to my device's H/W and I
condition it upon the PCI device ID of my parent PCI device.
What is the harm in that?

Thanks,
Oded
