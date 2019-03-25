Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F3320828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="o/FaLzux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfCYDTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:19:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfCYDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:19:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so488802wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+KBawshO2ac9odd0aZdpxY21SVc/hnJhTxHZNDsCqc=;
        b=o/FaLzuxCRSMDHvwZjCd2TG7JRIPfsq9KAJlNaJFIAILPPO3XvEIWHv5iMaJm4l575
         I67VCbrEGCvRn8v9cBjY0DCkrYcvp5SfpxF6dwWr2zIeXn/sLjoJkjJ4aCZ7RbIz+FCg
         k0aa2i++UENBkDf5vM71io2Yn0i2a1KtQOz4Y4N+ygpcOgb7DKHKrFjzdKUoUlBSVMWs
         o21wxSpMfFkkINk4pyoPWWs7qpLN8wkxjgyx1xTpqGa3/tXCH6jxTe+3bUeNIma2ey2v
         e9iasmi3Y5LCP0JqRJtF8835HM1g9+fFyIifhDNkyyDjshYlbvG+Pnunrmyq0pXRTV8d
         UdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+KBawshO2ac9odd0aZdpxY21SVc/hnJhTxHZNDsCqc=;
        b=iai7xQwvEkioWwhi/XiePZL++WKkNy7c5sfJU+6f/1v4FGiPExf+1USVG7vtYCoCcf
         7HJXdI8QsKNrHKTlsMKDQeErOQoMElIzHvCquL3kxJUHo0/HbLhGFNpry3zOwl6hBe9+
         A54IrSSEQmDxJ0gjU1yM4jPUPiINRK/c9ylizM4+91vv5WiVbQzFNJSPa+QQ3CBsELBa
         CLCylE6fqXbiGaIrzxz4U2oAc91/7Z20FlwlveQ93NqazOSMXXc7hGuNmwxJgOQQ6Llv
         W1GB+eV2CalymhuRKBquoyGTf0ZDhlH/7GHnoSq/8oLAUYR4SHfyMTSb5e5oazUn8GuE
         wZ3g==
X-Gm-Message-State: APjAAAW3+kUF2Z4CBh84LU38YnQAxb8chKt5XJ7EWWUt1I7eyctiabEn
        kzlOAqdsqFrP13+Skbkdl7iC5phjPVnAwzpNv8qkgg==
X-Google-Smtp-Source: APXvYqwQ7z8znKmubuBIgR31+9p1eg7UMtNPW9S5EYCpJTKszx56IPpvbJ6XpTXteGOx38q7pSwx96CpB+nLFYXSbYE=
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr3917693wme.16.1553483970223;
 Sun, 24 Mar 2019 20:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190324110804.68555-1-anup.patel@wdc.com> <20190324145708.GA3355@lst.de>
 <20190324164316.GA2925@rapoport-lnx>
In-Reply-To: <20190324164316.GA2925@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 Mar 2019 08:49:19 +0530
Message-ID: <CAAhSdy1JcvFtzwcUpd5xHbeUiCBoTCy+AnEiW+nQAs2KHez44Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Always compile mm/init.c with cmodel=medany
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 10:13 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Sun, Mar 24, 2019 at 03:57:08PM +0100, Christoph Hellwig wrote:
> > On Sun, Mar 24, 2019 at 11:08:29AM +0000, Anup Patel wrote:
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Huh?  I don't think this is from Mike and me.
>
> Suggested-by: would me more appropriate indeed :)

Sure, I will use Suggested-by: here.

Regards,
Anup
