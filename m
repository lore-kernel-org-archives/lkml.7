Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FDFCA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8526721479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlqZHIbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfJ2BlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:41:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36102 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ2BlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:41:05 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so12990663ioc.3;
        Mon, 28 Oct 2019 18:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5r5chbimG3vwg9Bu9cDKc/At1mSPZYJV+dL3qJFfUlQ=;
        b=IlqZHIbb5E1+fb9hAdZlz24flN1nu2VHyw8qPHSqTnxvDQvgRiAqesjSFZxyGAHZRt
         YzgrB2pAijVLzPPZgMTepDJk5Fkt1QHXDenbSAX+Pw6ikzIZ+dNqjq04KDeBpoF23sTm
         7no6JMgLE4EQIWOZ6nvMhczvxG4zlGqmKKOQSJCIqtqvXIS1PI+o+pprAnHsE1AzuYir
         zw9TgcwEBlmwjyHolQ1pVZ4x4gg4z+I2V6gY3ilnEJXe+oZjgsoqqtN0cEJjoeugyrcD
         2vgjw8D3fppE3NOQRgEQFJ34lQkSxPAMgKqw3LUhf4rvnjg95vz4XIfHhxoYgOW8rOiA
         bllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5r5chbimG3vwg9Bu9cDKc/At1mSPZYJV+dL3qJFfUlQ=;
        b=PV1AlfloctWn5Ya3uaCnf3FDQ5F7HeIJpLmaI8orLp4NBugzP6qvQnsfy47V2m0IL7
         usiHilgglPIJCbLUyaxaQ63cV1VnuUK0xzXa/30Xr0tBDb8zATVJpB5/CRIXtb1GNO1V
         2xmIBFJu5+vl83RPSWoC+J7L3r2MJ0Tg/r+VpK9Wi0URBtiAHRrnk3i2pa/IkcUsQTpe
         y5N+ikeSIJoS91WgeNUl6cLidq0sJFkWjV1Ucl1wCRsj1npBpNBX98CgmBnwShbPxFEU
         QNqfoYvhEQqBjqkr+sTl/HSxJ/IaD29uK8D9TVjDpi6YWNdPVkgJ/r/Kq6qjVbBIWW1Z
         afpQ==
X-Gm-Message-State: APjAAAXDUXew0yq6JAQHg8vhQIqmatrfyuCG6mY1v1L3uJHw6N/mhL5/
        CsQGDCOzOMuGmf3E4onoJ587s6GKj/ZVCQEgwBA=
X-Google-Smtp-Source: APXvYqyxa2L/V4/auI/Wib9HzJhbCDF/WGb3P6p8HQPLBcoLM8/M4Q3beS3GcMjMT8AUCn27qBkPQC4LOolYvGX1B5E=
X-Received: by 2002:a5e:d707:: with SMTP id v7mr1101440iom.226.1572313262624;
 Mon, 28 Oct 2019 18:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191028155639.30330-1-e5ten.arch@gmail.com> <CAK7LNAS41TxKMLBj3_N=WE57CT7ttHes+7GdLWNW-mAgPkvW7w@mail.gmail.com>
In-Reply-To: <CAK7LNAS41TxKMLBj3_N=WE57CT7ttHes+7GdLWNW-mAgPkvW7w@mail.gmail.com>
From:   Ethan Sommer <e5ten.arch@gmail.com>
Date:   Mon, 28 Oct 2019 21:40:51 -0400
Message-ID: <CAMEGPiq+Z7kbjJSNA0m=1TAymamQExud_7v5yzakSPdciPbq1Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: support byacc as alternative YACC to bison
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I applied this patch, and tried the latest byacc,
> but I still cannot build kconfig probably because
> %destructor is not supported.
> byacc does not seem to work anyway.

Hi Masahiro, because I hadn't built it in a while I completely forgot
that to support %destructor byacc needs to be built with
--enable-btyacc, should I update the commit message to include that
detail?
