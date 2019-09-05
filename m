Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27DAC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD6922CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM+jXFXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbfIEMB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38984 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388954AbfIEMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id u6so2422990edq.6;
        Thu, 05 Sep 2019 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+ahss9R0/cW0DeOcwapy1IK/U2OHcaNx/JZYNK4ddU=;
        b=kM+jXFXj6ryQBoFGB9uVMpD5N01LdySrsqKY7SCEXwho8V/Xq9LeBCbfdV9TxRvtCU
         c2GiT2vCFKL5re78cdhlwCOWLaFSHAkOiK7zSk0nB2OLrjjxFhYZl+YFf4o62EN/wavF
         ZwNw7kmVnNcocDME5w5k9IcAPI3QRm9WuXcI3PXZc8jg+dx8gKVCXrZpMM04xxhT/bjd
         60G35GNVdQMm6idbnyVWrbNRvkNZQUJLHRTlHdDGKwLJsdZSQ0iKl9oc6cyLzffU8y04
         RPQ/WRXzqgJw/nQmey7H0IJGOk+oRjXBm56HuVmU2UE/Fw0JiWtUwD+kFPvQ73M4a6sX
         dHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+ahss9R0/cW0DeOcwapy1IK/U2OHcaNx/JZYNK4ddU=;
        b=PELZFYQPG4UpdOTsAaKC+6LgQOkHwMUmFQ0oN746QUSoUUwdfzG3kPSTgBAOFXctWf
         gZqNQ2nBfUZigaR2vUHnHyUDafvG7dFPvl/MS7GFOsfyoJ7ny9hfqc61rQ4t7IlilQHM
         zisS7BXcFvjCBPLEHYiYXXApDEfLcxrbRsMsxV2yqdJY+7eyWedrRl7sYjYWhMBGHGPD
         RD1tB67pm6xtdhxhztEz8PSWqOtTZZTBAdmu2G+/gW8O7S633Mt4srT/Gzczo7COPZWY
         PcvdxxWpQNwOuSwYJVl+1RbozMn2shkvs+GJ9k2YKcM1mrGcgZMV1eDbvFwHrjCAPzq9
         RREQ==
X-Gm-Message-State: APjAAAW3VO4yCnDG8K0cN0ITSNnLigYX2gvgJwNtF+xxI3IrcPGXKTmB
        kAytTwoOgs0gTZCcAi+yZY+XRI5oOcMoM8A+2O+Zrw==
X-Google-Smtp-Source: APXvYqzs87vMu6hxGQg8ipzGgvddanc1Tbgk+uTCjFPT15fz9a4XMXJqpRaXlXqPeQJoHQbhz2qbq5T9mUeY/Q0ur8s=
X-Received: by 2002:a17:906:81d9:: with SMTP id e25mr2422583ejx.37.1567684911805;
 Thu, 05 Sep 2019 05:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <1565158960-12240-1-git-send-email-bmeng.cn@gmail.com> <alpine.DEB.2.21.9999.1908130758550.27195@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908130758550.27195@viisi.sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 5 Sep 2019 20:01:41 +0800
Message-ID: <CAEUhbmV8v2rjhAZfOMauJC15eZpxYUZ=9YS-YN2dhNRv4H8bEg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: sifive: Add missing "clock-frequency" to
 cpu0/cpu1 nodes
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:00 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Tue, 6 Aug 2019, Bin Meng wrote:
>
> > Add the missing "clock-frequency" property to the cpu0/cpu1 nodes
> > for consistency with other cpu nodes.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> Is this being driven by a schema validator warning?  If not, and this
> property isn't required, it seems better just to drop it.  It seems
> useless?
>

Yes, I think we can drop it. I will send v2.

Regards,
Bin
