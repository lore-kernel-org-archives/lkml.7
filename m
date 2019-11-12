Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319C4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A65214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583963;
	bh=7jI3zxoAk5wueaZfUenBjnVXpiZ4XEKIs1A3JC1BJw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EUJWwMKQX92idpygcjsCepIvgZBbwL2y0N/Q4xcQOi1qITqFODWTZsLBz96o805Op
	 WXeh7A3wScArleQ83bPSIGWRUG4Fez0kbQD7whqfkN6DEg/qPTGIikupDMN9ubosze
	 Ma0h2idSaHEY//3PZk1raT0uVGXl6rAZeutjYWtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfKLSjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:39:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41929 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfKLSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:39:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id j14so13688944lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3/5+bE6a1aacx1NneO4G1AEtvlCm22h7I0IfvLwDdM=;
        b=h3mM4K7MdjNYkyyzw74cY6LaurZbZ0BediutdB4c6fnjSAaQMB7XKmFEa5BbJrTmYb
         W6T4IjafBbff7661PiiuiCIe9bisVOI9/hAmlYrc0kKmZj7XcOeYLAvCMUsoi5361Lk9
         Z01vkoYEoBTtnFMw6CbLvLjcmlO6+fvnSkTpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3/5+bE6a1aacx1NneO4G1AEtvlCm22h7I0IfvLwDdM=;
        b=NbQYIj9ni7Iy++fU7dK1XD0lueD4SOZL+YqwE8kR5sKAq7+rIgiHa4gmFR+VjCpSgc
         NlAB2LWEl+gdpUPhck0WsIGSVjD56ROrf7aXk93nLHB0YQG1bBRuX4uxrqDrXxNJxoLX
         vpvjtZYm0npT/KeAMp3HDRE7H2kbe3nkE7m4XLE1SwUTCpXlu0VWQvqQBUvGI52rumaE
         +JqN22Ie4i5BrcvrJHZfLBkNhmLEGsEV7PGaC+kCl9xAd2O2veLUC0BZ40ujTV/B1yI6
         hfWSwE/KIaCv4dzj97hBRWS5y8rDD1wiZm1LqdFOV8muuyOfvqdcGWxsOK7lm7VeSSSX
         rptA==
X-Gm-Message-State: APjAAAWRm/1lt6LFGPELve6RlPOX9T/cmhM8ifQvYetLTmMBAq2IpjSK
        kWFrHv78XZ/k61nM8bPYy73l7Qaw95U=
X-Google-Smtp-Source: APXvYqzuH95GDXEpXH/Z/+f6yR798WqsOTG0/eS0nnanXtl/nrvdPOFkkd/F3iMIpG5lTNHm8Tv/3w==
X-Received: by 2002:ac2:5b47:: with SMTP id i7mr20390937lfp.82.1573583958877;
        Tue, 12 Nov 2019 10:39:18 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id x19sm6349144ljh.14.2019.11.12.10.39.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 10:39:18 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id g3so18940442ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:39:17 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr21258377lji.97.1573583957672;
 Tue, 12 Nov 2019 10:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20191112130244.16630-1-vincent.whitchurch@axis.com>
 <20191112160855.GA22025@arrakis.emea.arm.com> <20191112180034.GB19889@willie-the-truck>
 <20191112182249.GB22025@arrakis.emea.arm.com>
In-Reply-To: <20191112182249.GB22025@arrakis.emea.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 10:39:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
Message-ID: <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read hazard
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincent Whitchurch <rabinv@axis.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:22 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> OK, so this includes changing test_bit() to perform a READ_ONCE.

That's not going to happen.

              Linus
