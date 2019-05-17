Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC76C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596E121734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfEQSd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:33:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42124 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfEQSdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:33:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id j53so9109342qta.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpbDUS34YEE3/go9H9nTqXvmrFu74UgQef2p9ork8w8=;
        b=BjgchH44jChZgUAzEnTi25aWaRrc1Nj2s0ULP0ktrzle/uq4W7KiDvwwYFPhR2IoWf
         D3HA+iJRjkn1RD2kIC7Xn7EbDRNtdoq7/jsfNpcU08M7f3wE/gCzBiPOxWDaWlMrVaz7
         9p9n0RXuSKeV4uctGGbfGIXCRCGlDEcrK+9yZF+4GMxGwQZ+nK+nMa0uqybOQ2DOupo/
         2agzpCXyLyqlOJF/WTb/KQQckALiEcUS4nZ0zYyu0O4bYHrfFrOHzg9uiv8mP41fFjeh
         sHON86dTrYEiydRvB3hMkPDC1fQ5HEByrgNA/FR0FMWbyBkZJm5GrjJtClqkse43OL1x
         K/9g==
X-Gm-Message-State: APjAAAW/pBm0jjwmFw+SFlm14JJbzFpSobjIVDyQS+dZpZLgZQNR7DwD
        oFintRVu07/7KN7tZrVHY6DDVTAHLQzVIr7Ie5l3eh/c
X-Google-Smtp-Source: APXvYqy6PpspnDkZDXkEJVr14bKmNUUcRj9TIej7s2amqxIB6mesiPZXz8ozFWeV37S3wVKxNpPJXrHq7NdGqaowcqM=
X-Received: by 2002:ac8:2433:: with SMTP id c48mr36064873qtc.18.1558118033332;
 Fri, 17 May 2019 11:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com> <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org>
In-Reply-To: <14a040b6-8187-3fbc-754d-2e267d587858@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 May 2019 20:33:37 +0200
Message-ID: <CAK8P3a37bPRZTHZcrg8KrYRLAhCr9pk8v4yuo_wSyUONs2OysQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 8:08 PM Alex Elder <elder@linaro.org> wrote:
>
> On 5/15/19 2:34 AM, Arnd Bergmann wrote:
> >> +static void gsi_trans_tre_fill(struct gsi_tre *dest_tre, dma_addr_t addr,
> >> +                              u32 len, bool last_tre, bool bei,
> >> +                              enum ipa_cmd_opcode opcode)
> >> +{
> >> +       struct gsi_tre tre;
> >> +
> >> +       tre.addr = cpu_to_le64(addr);
> >> +       tre.len_opcode = gsi_tre_len_opcode(opcode, len);
> >> +       tre.reserved = 0;
> >> +       tre.flags = gsi_tre_flags(last_tre, bei, opcode);
> >> +
> >> +       *dest_tre = tre;        /* Write TRE as a single (16-byte) unit */
> >> +}
> > Have you checked that the atomic write is actually what happens here,
> > but looking at the compiler output? You might need to add a 'volatile'
> > qualifier to the dest_tre argument so the temporary structure doesn't
> > get optimized away here.
>
> Currently, the assignment *does* become a "stp" instruction.
> But I don't know that we can *force* the compiler to write it
> as a pair of registers, so I'll soften the comment with
> "Attempt to write" or something similar.
>
> To my knowledge, adding a volatile qualifier only prevents the
> compiler from performing funny optimizations, but that has no
> effect on whether the 128-bit assignment is made as a single
> unit.  Do you know otherwise?

I don't think it you can force the 128-bit assignment to be
atomic, but marking 'dest_tre' should serve to prevent a
specific optimization that replaces the function with

    dest_tre->addr = ...
    dest_tre->len_opcode = ...
    dest_tre->reserved = ...
    dest_tre->flags = ...

which it might find more efficient than the stp and is equivalent
when the pointer is not marked volatile. We also have the WRITE_ONCE()
macro that can help prevent this, but it does not work reliably beyond
64 bit assignments.

      Arnd
