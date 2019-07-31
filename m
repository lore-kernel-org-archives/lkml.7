Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78325C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D9A2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1wIjjla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfGaEND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 00:13:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33071 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaENC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 00:13:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so48273457qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 21:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFVesl0ZnOpQBqtMqV5lpfo1vwR6WRneLNekq2w+A+0=;
        b=r1wIjjlaOUYXC9i0CtRzf8gVkGR6i7HDy0I7VVJKls8IoU+bJTFRBj1qe/DGeZNwS3
         mgGjvWiGMKJ5bP8brcspcZO4X4V9eenYomQN3tD6rEkVc0vAb+6ZpUSxr5z+Ixu7M5LS
         C+dQ4sCispoR+WPJbpeV4A3KmqkmKV8aNcP8bUq37kWCpCN8HmKmrmVc8vrmnmmS5a1z
         pllvWFZjj4465RcciKSuD8r9iNFT9t0DU+fajvZmzT+qVTZnQCeDyTZZLsYvTPcta7Vy
         4NaCttjGVF1oboy6iznh59NugAeylu++kg+f7wcyJVdYPc0G39Hhm3wTwrIOxZ+x8oOL
         cRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFVesl0ZnOpQBqtMqV5lpfo1vwR6WRneLNekq2w+A+0=;
        b=DCnTqnMdb8WX/NLn5qvdUkxc1RpiAUsVpMA/1C13IudOQnSlGgC9wXole3ZnzqUdl6
         3jlD7/IwofugdPmzoc9dSOeVqnH5HGJUqp1H8mxfWBzT/4WknsLLgXzZA7AgkZsH6fAj
         iIOjVI/DZWs0RO5kKUefvnCCSpQvKb2AnoWx1T4J1ykbHJ1+bwlb2k+zrle8zFwFlx7x
         UmAzmJBpdw143ElLDo2AZlqLJ7SH1Gx6QrGRF1X2ssq7p64iX1hBJqT0NluLnutVsuZw
         pTFKSeEti2JPXmaRUJDaMCt+RstVnRLv+mo6yVhqek4fXunsNYFQveguo3Q76wIrPHKE
         pnHg==
X-Gm-Message-State: APjAAAUMyXKVhT7la54ZK4CHDmbDsmV2i0jkCQbFe88y3OtnNIqZW6yr
        UDiQ3jnI4KpUvN3/vADLhpMPbbZLmanqfy7XgyfToUN9
X-Google-Smtp-Source: APXvYqy2sz2eWCGTJfeBDvYeHklxGvXDMSeWgw1gHMMJZXav5IjX+rI/W8oAUPJin0pn2pg2QXOlbRH7FD1Tuk2ix2k=
X-Received: by 2002:a37:5942:: with SMTP id n63mr5572295qkb.69.1564546381707;
 Tue, 30 Jul 2019 21:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190730044326.1805-1-luaraneda@gmail.com> <20190730104746.GA1330@shell.armlinux.org.uk>
In-Reply-To: <20190730104746.GA1330@shell.armlinux.org.uk>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Wed, 31 Jul 2019 00:12:11 -0400
Message-ID: <CAHbBuxoMBiq23Rkt7-jm42O4ePY=23ZsgNEVf3UJKQ2Dg+3fbg@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: zynq: Use memcpy_toio instead of memcpy on smp bring-up
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Thanks for reviewing.

On Tue, Jul 30, 2019 at 6:47 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jul 30, 2019 at 12:43:26AM -0400, Luis Araneda wrote:
> > This fixes a kernel panic (read overflow) on memcpy when
> > FORTIFY_SOURCE is enabled.
[...]
>
> I'm not convinced that this is correct.  It looks like
> zynq_secondary_trampoline could be either ARM or Thumb code - there is
> no .arm directive before it.  If it's ARM code, then this is fine.  If
> Thumb code, then zynq_secondary_trampoline will be offset by one, and
> we will miss copying the first byte of code.

You're right, I tested what happens if the zynq_secondary_trampoline
is ARM or Thumb by editing the file where it's defined, headsmp.S

When the .arm directive is used, the CPU is brought-up correctly,
but if I use .thumb, I get the following message (no panic):
> CPU1: failed to come online

This seems unrelated to solving the panic, as the message
even appears with memcpy and FORTIFY_SOURCE disabled.

I could add the .arm directive to headsmp.S
Is that your expected solution?
Should that change be on a separate commit?

I'd like to know Michal's opinion, as he wrote the code.
