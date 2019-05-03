Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2287EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9F2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 03:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQuKYFlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfECDiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 23:38:20 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:46875 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECDiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 23:38:20 -0400
Received: by mail-pf1-f171.google.com with SMTP id j11so2163694pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 20:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vYq3LLgVuFl+Q4Cfesc/hNih9b2VH/+j6MEqw1Odz0c=;
        b=ZQuKYFlB5bt+x6kvfiPga6EKU9dz2+5hc5tVns/3D7hxiCaQaNmsH7UqDEaU2Sj39C
         t/oHNX3E10jYVn0GMG/2xNbqCspNHbQGQKemn9nq6X24fP6AU3NoqZl575bRK322lMKz
         RUSEOR9jKyziJTKWY1HaUK0j2498zn6YPwFVuBu4Jyh5DEsi3hM8NL6MLLjjDfIC6lX6
         GZPo8mozNR3pHbuAYFq0TLXoMJ9OPABvHQXfo1EkszAfJZVmCJk44j//HJI2qLwQ+uI8
         77mLFG+JGItOvhSwZbt2JzJc6STCqS7FHxZamY0e5MvI1NLFNmyhOoFNfIFB4ThrzkAp
         s+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vYq3LLgVuFl+Q4Cfesc/hNih9b2VH/+j6MEqw1Odz0c=;
        b=DULxhIJudHfdzCju9/dYJ9Fp5Hn/qb3XNgculsNZd+P8VQBXQ5A6cXy7w0t7L6U8s9
         fI9M2qdzvO+VHFU/YDEBuQkciT7a/qF7P1nJYT9PM0MVgEplvikmaFnF+CgBfskIyH01
         +d6AdEJrCwj6/fcW/fGcJiUi1pIfPaTd8GsQNDYYzXtxCidm6Ikt25zkDqwJf1Kpk08f
         90GEwjyH3nQGrPWAgYvMqVsXzY8/yjmDDIFIiFKxcay0xM5sWsPn2XlxusY7j5r2gM7R
         kKV9wsylNSO/6nxluJIQZxJ89DK57JhUr94B7HZJsqlLPkRTnZaRszlAmJjduivo296i
         5TcA==
X-Gm-Message-State: APjAAAVhWNFT6n3ssP8xsY+SW2tdgyM0yqGrwUYxrRPOWFJ/KM82QhWE
        Cr1n3NObrZ8IBSGE8UVGoPn7ynLgCR12q+ALQpQ=
X-Google-Smtp-Source: APXvYqzKuTFTwoC86bQ2qw6iOJ8RsxTkS0HUuiYFSODFmG4a+zwmdQpfNpDDK9/uJA/fSWJIbqg2wn/tqVvfW2sNtA0=
X-Received: by 2002:a62:5542:: with SMTP id j63mr7923162pfb.34.1556854699491;
 Thu, 02 May 2019 20:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com> <20190502125722.GA28470@localhost.localdomain>
In-Reply-To: <20190502125722.GA28470@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 3 May 2019 12:38:08 +0900
Message-ID: <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
Subject: Re: [PATCH 0/4] nvme-pci: support device coredump
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 22:03 Keith Busch <keith.busch=
@intel.com>:
>
> On Thu, May 02, 2019 at 05:59:17PM +0900, Akinobu Mita wrote:
> > This enables to capture snapshot of controller information via device
> > coredump machanism, and it helps diagnose and debug issues.
> >
> > The nvme device coredump is triggered before resetting the controller
> > caused by I/O timeout, and creates the following coredump files.
> >
> > - regs: NVMe controller registers, including each I/O queue doorbell
> >         registers, in nvme-show-regs style text format.
>
> You're supposed to treat queue doorbells as write-only. Spec says:
>
>   The host should not read the doorbell registers. If a doorbell register
>   is read, the value returned is vendor specific.

OK.  I'll exclude the doorbell registers from register dump.  It will work
out without the information if we have snapshot of the queues.
