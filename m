Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AD4CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3FE21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCkIh9nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfKDPCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:02:05 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35931 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfKDPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:02:05 -0500
Received: by mail-yw1-f65.google.com with SMTP id y64so4187253ywe.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+Iy7ChZaVTYIBEpx4qfobr917iForOix/y0Q8dZCPs=;
        b=eCkIh9nvYNasuS98f92lbZBrT9P/ERTzX7Eq6v6/OjOtJ19UPRCofXW5BwXRtIuob1
         gH7Wj1lYMLMpTpj1T3SqjMiHKSgFb+vNfozPsx1bk32aKoFXDXzfbPADYLm+spQfSfdZ
         1jpoRjl8Rc1fb6kI4bNyw+jadi+cXVQK4S1w/Tq4i/iBNXg3u5r7tg0QL99DEb/Cdb21
         iMW+2yNiqvfbG9NLq8rMf7L7PPQrApckgKxujIIe7Bq7G5Ldp4QdyzSHcXgFOyJlcnmR
         i1czsmamS3bARr/hfAW6LLfuHU4Ko9r+rpAafuYZ2OnDxKTngiKMf4ChRv/Rn0elm9tX
         myeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+Iy7ChZaVTYIBEpx4qfobr917iForOix/y0Q8dZCPs=;
        b=cOLB6bkz+HZnITcujG1XqRJi85i+0rDyraiotqb9JyiEBlDXNf8YFY2A1LIebqFgg1
         QQr+eKyGoIQcAmCROUMPqoFjn2KUphOfU3mlbkyr2T88wi/K/zJWvKxTWVM03TQ2CCWQ
         ow0C+5TGt31eE674KBgTjEFih6jRZei/YjZBo5Ad82bBjXD3wuzfNjIA6KI7RhLtwQ2X
         LGSqYUyhTTiyRghVr+TeiB8lW0VLrZZYkhM+CU8SUkHm1L6yW0Ztb0YtG8gPcqQSxi1o
         4OqAGZwh8yUS9J/2I5KGUjLq11UZtetiHbj1QFqzGQt3MswyrAmEbfHHDsvq4G9cwIji
         wLkw==
X-Gm-Message-State: APjAAAXckAPlVvLOlqt8vifoK49WjCoVQLWiYE02qbMTwQiHQlG77BGS
        swEMEy1Md9WkJbFV9dOpq56jhG7fql3pZuntiyA=
X-Google-Smtp-Source: APXvYqzfkPQ2lOX33XS5YjF+WOofdN2erZkB5sf7/kcHuf9q7ma020bq1NDJRXqhJ0a5/zmNYkiHwcbwmQvxfBDFbao=
X-Received: by 2002:a81:98c6:: with SMTP id p189mr2906416ywg.443.1572879724375;
 Mon, 04 Nov 2019 07:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de>
 <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
 <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com> <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
In-Reply-To: <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
From:   Charles Machalow <csm10495@gmail.com>
Date:   Mon, 4 Nov 2019 07:01:52 -0800
Message-ID: <CANSCoS_MX97_JyLkKrZ7YjTS9L+JsZcPsHpoZ-keA8t3W394Dg@mail.gmail.com>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64's result field.
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        kbusch <kbusch@kernel.org>, axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes. The idea is just to change the 64 IOCTL structure so it lines up
with the old ones so that the same struct can be used from userspace.
Right now the first 32 of 64's result doesn't line up with the old
result field.

- Charlie Scott Machalow

On Mon, Nov 4, 2019 at 6:56 AM Marta Rybczynska <mrybczyn@kalray.eu> wrote:
>
>
>
> ----- On 4 Nov, 2019, at 15:51, Charles Machalow csm10495@gmail.com wrote:
>
> > For this one yes, UAPI size changes. Though I believe this IOCTL
> > hasn't been in a released Kernel yet (just RC). Technically it may be
> > changeable as a fix until the next Kernel is released. I do think its
> > a useful enough
> > change to warrant a late fix.
>
> The old one is in UAPI for years. The new one is not yet, right. I'm OK
> to change the new structure. To have compatibility you would have to use
> the new structure (at least its size) in the user space code. This is
> what you'd liek to do?
>
> Marta
