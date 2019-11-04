Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F8FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1E20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIWwAK2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfKDPUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:20:55 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46997 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfKDPUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:20:55 -0500
Received: by mail-yw1-f66.google.com with SMTP id i2so7051625ywg.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Luti0tQiJhItUnQbPoidnL8DId53OBM9Rj2bS+xXQGQ=;
        b=SIWwAK2mezGoY9UG7SR1eHZmjkDzG+LtE9EPBS4fE0EpIf3cqQaT//OrBo+EtWNKoA
         AuN0fA1lwsO1D678F23Qr6r59UdlTDfgiob2fFHrvvegK9zt+yVMOBg8Z7R2g2Y9liDU
         8+wXMmy5LRtVlm7bp5ZDcdfZ4+H5GD2LTSmdYWd4jlWQbIDWUjATVAsDE4Ir5+sJJX9s
         MzPnmk9XQ/pPWNSRRM5FHjU4Q2q3VG0gh3XhrHoJiXMLBHucBAdMMAVJHGmnAtx0NKjA
         vjDb4Z2IdZdUV7I7Hr2CkHNm+y2ZzggFcaa7jnPq8ULG3j9ZUG94ZMyJy1NEWamJo5S0
         9SeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Luti0tQiJhItUnQbPoidnL8DId53OBM9Rj2bS+xXQGQ=;
        b=U5pkQzLVr2s8UFo2fuSDuP9vQnnPiQF7QBvtYi17Bf6KKEUYoIYlhI6VUD3sN097De
         0vu5NhkCeARaqlIWKGaI7r2QHEbExLPMrjQM/wX8rnIIS/2UNX0lCZyGZNlN4YxoZbH/
         B3lK7OEHRYNmXlGWzU/EcJeyxb/crBdfOt6tHQjPOt5QR2gfi7SKvfcLqC+OW0q2zr3V
         Pqcem14mKneie4rAjWbZiQ8eBKT777KDfU4CTX3MQRUCMO5SiNFNUBArJNqXagp/6G/o
         mQIkinWaCP9fnc8MfuUn7/QjNIIJpDuxyNM0Cav633KGDZFu9gxzwMxySB3J9LaD5RSf
         MYsg==
X-Gm-Message-State: APjAAAVtvVv7lrGia/6copoDll6KYhuRI56RbATZcxEZFY2QDrPftnyc
        4vfAFXl1cDMpCAapzDgnFDluDS8KQ0jGfzjAmhc=
X-Google-Smtp-Source: APXvYqwZo2tsf7nvbTk8g69GUTtQFbGtIsUzz/1gNs+Z08yppSHxlSkUAhx6vt2vS3a8AGFJXmiC7DDrDDu77VtgBRM=
X-Received: by 2002:a81:27cd:: with SMTP id n196mr21457626ywn.148.1572880852863;
 Mon, 04 Nov 2019 07:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20191031050338.12700-1-csm10495@gmail.com> <20191031133921.GA4763@lst.de>
 <1977598237.90293761.1572878080625.JavaMail.zimbra@kalray.eu>
 <CANSCoS-2k08Si3a4b+h-4QTR86EfZHZx_oaGAHWorsYkdp35Bg@mail.gmail.com>
 <871357470.90297451.1572879417091.JavaMail.zimbra@kalray.eu>
 <CANSCoS_MX97_JyLkKrZ7YjTS9L+JsZcPsHpoZ-keA8t3W394Dg@mail.gmail.com> <266047531.90300507.1572880575232.JavaMail.zimbra@kalray.eu>
In-Reply-To: <266047531.90300507.1572880575232.JavaMail.zimbra@kalray.eu>
From:   Charles Machalow <csm10495@gmail.com>
Date:   Mon, 4 Nov 2019 07:20:43 -0800
Message-ID: <CANSCoS9A1XY4DzdBwGU4+oT-uKvpohxhyWxdJ1ySJ6QKv6moKw@mail.gmail.com>
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

The thing with that structure is if you use it with the old IOCTL, the
result will go into rsvd2 instead of the first 32 bits of result.

- Charlie Scott Machalow

On Mon, Nov 4, 2019 at 7:16 AM Marta Rybczynska <mrybczyn@kalray.eu> wrote:
>
>
>
> ----- On 4 Nov, 2019, at 16:01, Charles Machalow csm10495@gmail.com wrote:
>
> > Yes. The idea is just to change the 64 IOCTL structure so it lines up
> > with the old ones so that the same struct can be used from userspace.
> > Right now the first 32 of 64's result doesn't line up with the old
> > result field.
> >
> > - Charlie Scott Machalow
>
> OK, then this will work on all architectures I know:
>
> struct nvme_passthru_cmd64 {
>         __u8    opcode;
>         __u8    flags;
>         __u16   rsvd1;
>         __u32   nsid;
>         __u32   cdw2;
>         __u32   cdw3;
>         __u64   metadata;
>         __u64   addr;
>         __u32   metadata_len;
>         __u32   data_len;
>         __u32   cdw10;
>         __u32   cdw11;
>         __u32   cdw12;
>         __u32   cdw13;
>         __u32   cdw14;
>         __u32   cdw15;
>         __u32   timeout_ms;
>         __u32   rsvd2;
>         __u64   result;
> };
>
> Marta
