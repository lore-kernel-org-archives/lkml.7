Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212BC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0CB20989
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/i/NqMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfELVQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 17:16:10 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:33736 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 17:16:10 -0400
Received: by mail-yw1-f50.google.com with SMTP id q11so9409542ywb.0;
        Sun, 12 May 2019 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvr0F0kwYHeCbEE7X7nfXJQszg2ULC/PKICf98qkw4g=;
        b=c/i/NqMVt1JZIJ1y1LfSuoubeXL8EWr451se0bvwshMCfYbs3nwoNle1F6YTUt+bTL
         RYSIuAkUw1lsbTo9I/zmr+VRloHP4nqr6gPiFrz4+LZABrzaxWkUHsDdYVwCV2TdxbzG
         cRi1urqkpQI81ooMhN9sFEHPJXdPze8em5fHydCX6cgm4gV2zYAWobPHDLLuiERVYTvr
         bXCgrcny/k9xMTCneOXtyFP5gDvGOhIimqW/NGkySnxqITDAos3W/H7tmNG9qJkYyPuk
         sBhXcNZfdOGvnMO1ofV022dNK6+yr2Ddp0VkyoAj3OoghYSIClsTnHur2zq1f1lO61BP
         1rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvr0F0kwYHeCbEE7X7nfXJQszg2ULC/PKICf98qkw4g=;
        b=N7aF7YLNCaIMOOVEnLBil7vDNgHGI22pa0apbIxNe+wxJDK4E+aFIOS/4F9Ahy7SyS
         LWEsEObHx1U0wR+En5uspCB7No/m6bg5F84Maasdee4iyYTxMNbGAR8IMTLjpUqSnfX9
         8siuFt46aRmbQwrowkQVP2qNHZPojblpluVIaEjJxaDH35ruwi/1BWaUuCbsWe9LMyrM
         ZUuQ4DjL3OBBYm7Y2ueJMxaxML1BQxgC1c3Q9V9ggciXxjTZYcLrzKPaY77pg/fMff2E
         kQ7otyffBGtfbg2IghDAq5lna9wogbWklKkWBR5AfCRYpQX4agYpP5M0VKqstie8Jmfr
         yr5g==
X-Gm-Message-State: APjAAAVsnQn79KQ+TpJW3Nn8NUXi+50/jF/SN1I921IcY4oP7UEb8Eu3
        bIHcuRAdth+pCDTQfmcV1KJs7dYt9froGJTRoCo=
X-Google-Smtp-Source: APXvYqxMd+2U5eNGv45W53rbwmDGaCHOze+e4tOGsODAkZixx0nm0NKGCpzuDX7KgKjXeA5oxU3wdSiu455MhQxtmz4=
X-Received: by 2002:a81:9284:: with SMTP id j126mr10812146ywg.445.1557695769565;
 Sun, 12 May 2019 14:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190502074519.61272b42@canb.auug.org.au> <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
 <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com> <f52cf203-c48a-fd04-5827-19903c3a192f@bell.net>
In-Reply-To: <f52cf203-c48a-fd04-5827-19903c3a192f@bell.net>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Sun, 12 May 2019 23:15:40 +0200
Message-ID: <CA+QBN9AZHQHTGFVc21UfROHObKxAZz+bwCPeMf-Tpjn2UHmDNg@mail.gmail.com>
Subject: Re: C3600, sata controller
To:     John David Anglin <dave.anglin@bell.net>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The c3600 doesn't have any PCI-X slots (only PCI) as far as I can tell from user manuals.

PCI-32/33 device I/O bus
PCI-64/33 high-performance device I/O bus <----------------- this is
PCI-X, 64bit 5V
PCI-64/66 high-performance graphics I/O bus <----------------- this is
PCI-X, 64bit 3.3V

https://www.openpa.net/systems/hp-visualize_b1000_c3000_c3600.html
