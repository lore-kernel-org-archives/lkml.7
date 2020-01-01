Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7AEC2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D1C206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 21:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577914777;
	bh=wD12BHaJhMgBAePC6cSGJBDf6v/Nbp0L/uTUtBhwHdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Il8ONVyCU9Vfv8S+96BS2ZD8wVDAeubiGKQ4Wn1LSqfmkaFhtretwyEfDuH0AEdsp
	 Fph9Ok0D1fkyYB/jfEn3aFfSIfGY7BHzoW178u/eUz1sV/dCrrVTXUuHmAl6GSzuQW
	 Mp77Rg3Y6sxy/Lrs/O1oxGn1t/Rtsb4VRT9fdfic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgAAVjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 16:39:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35343 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAAVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 16:39:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so28802641lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 13:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHPJhXYkezST1Eae4XgEkOOylkj1TqP4v+xkR6EhUQo=;
        b=UqilqWGwrY43jYSFs+AEUHzfz+SAWFEN1YG/VzXyLpLDfpNuDj6PpNPx2w7OFyyQ/I
         5/WtkbMq5MccAyUW2aa9c7TeDE7hEsH94zawg7I+II41dAchmZQjcTfyVt2zkXrcQW9I
         potvW0sBLPVmxr7ahcvSUAHZ/YKSyu+wXDwwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHPJhXYkezST1Eae4XgEkOOylkj1TqP4v+xkR6EhUQo=;
        b=Qj4TCFPRVwjujMQBwVG1YcUoGD6wws3m7b+jSsIelOLQ057kmHqS+PRMe+xt8a6G/G
         6tFOeJ0C6b3pml2o4EY1ELG9zrL1SkKI0MCdeE8V3mfHdEs0rxx65qXpnIgkW/Ong1Xq
         nDuO3jxm+7HpMcXMnvZnZ5zBxAIShaWIBlnVgeqhCEIbOvS313EDTMMNL5OjgbU8y9BD
         sJhTHr4+29ezfv3ytMbs432Dih3MOYffeVOF7gTRdnHyd0TraN+PlPsUjOmtAshib8pw
         IPjAGSiGCJY25unLSdKIRXrfQ4UFw65IUUZtWD5ripoVKl/QmSwSl/LlnIjFbaYVvcBd
         cMPg==
X-Gm-Message-State: APjAAAUKTtU7aI5zqAoTdpMODYHqTtpLXKLNuUfp4kiNGbGNz9ApqdTY
        WL1HkXaMrycgkO/Qmql08paiMSfWQzY=
X-Google-Smtp-Source: APXvYqyTaI8E2IO55GigVQW95Pen7AgqvgWHKX46LfncQA1budY9+40yYw0g8WxWsTLPbYTAcmMPEg==
X-Received: by 2002:a19:5007:: with SMTP id e7mr45747475lfb.153.1577914758463;
        Wed, 01 Jan 2020 13:39:18 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s1sm15560249ljc.3.2020.01.01.13.39.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 13:39:17 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id w1so17067291ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 13:39:16 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr47217329ljn.48.1577914756672;
 Wed, 01 Jan 2020 13:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan> <20200101183243.GB183871@rani.riverdale.lan>
In-Reply-To: <20200101183243.GB183871@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jan 2020 13:39:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
Message-ID: <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        youling 257 <youling257@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008ed5e7059b1ae88f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008ed5e7059b1ae88f
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 1, 2020 at 10:32 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Also, this shouldn't impact the current issue I think, but won't doing
> filp_open followed by 3 f_dupfd's cause the file->f_count to become 4
> but with only 3 open fd's? Don't we have to do an fd_install for the
> first one and only 2 f_dupfd's?

I think *this* is the real reason for the odd regression.

Because we're leaking a file count, the original /dev/console stays
open, and we end up never calling file->f_op->release().

So we don't call tty_release() on that original /dev/console open, and
one effect of that is that we never then call session_clear_tty(),
which should make sure that all the processes in that session ID have
their controlling tty (signal->tty pointer) cleared.

And if that original controlling tty wasn't cleared, then subsequent
calls to set the controlling tty won't do anything, and who knows what
odd session leader confusion we might have.

youling, can you check if - instead of the revert - this simple 'add
an fput' fixes your warning.

I'm not saying that the revert is wrong at this point, but honestly,
I'd like to avoid the "we revert because we didn't understand what
went wrong". It would be good to go "Aaaahhhh, _that_ was the
problem".

                 Linus

--0000000000008ed5e7059b1ae88f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k4vtp0lu0>
X-Attachment-Id: f_k4vtp0lu0

IGluaXQvbWFpbi5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2luaXQvbWFpbi5jIGIvaW5pdC9tYWluLmMKaW5kZXggMWVjZmQ0M2VkNDY0Li43
YjNhY2NiZDIyMTEgMTAwNjQ0Ci0tLSBhL2luaXQvbWFpbi5jCisrKyBiL2luaXQvbWFpbi5jCkBA
IC0xMTcxLDYgKzExNzEsOCBAQCB2b2lkIGNvbnNvbGVfb25fcm9vdGZzKHZvaWQpCiAJCWlmIChm
X2R1cGZkKGksIGZpbGUsIDApICE9IGkpCiAJCQlnb3RvIGVycl9vdXQ7CiAJfQorCS8qIHB1dCB0
aGUgb3JpZ2luYWwgcmVmIGZyb20gZmlscF9vcGVuLCBmX2R1cGZkKCkgaGFzIGluc3RhbGxlZCBu
ZXcgb25lcyAqLworCWZwdXQoZmlsZSk7CiAKIAlyZXR1cm47CiAK
--0000000000008ed5e7059b1ae88f--
