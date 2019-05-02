Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95358C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656C220645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TI91P15e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfEBS5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:57:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41048 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEBS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:57:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so1466212pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lM2c+tlo6jGaS6GcPDKA87rxkv7bKTgFNvNaS30BO0w=;
        b=TI91P15erL2OywYjQHKmIyJKBc6sPfbma4Qr9Fh0sTkr/TzyaepILFifwYW4g3wWaw
         JuJPUAw4UCajVjqYmP0wxQ4QClyaC1XNagHXWS8h3ToDYO6hg5yh/bnRCdy2zSZpUXIF
         +ZrwD3wVO9CmImJ6Cr65rI0qa09e2fyN1HhuaRJcY8jarKy4cgoU5rDr7ewq9l9WpxVM
         UnfLfaw/exsvG2xp7cpGC3033uhM41JUT8rpyrK/C29Hn+61Jm4tlyynwE0NkdVriH1A
         Pvav5x2WyCk2Er31bwKzupa2n2HetnuU0Cf+9naP7mL/8eBllYDQq7WXm98G685XPEDf
         cTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lM2c+tlo6jGaS6GcPDKA87rxkv7bKTgFNvNaS30BO0w=;
        b=DOnIhHDoSOhjjAD3xnrPwkvgw+RfX9tMCQ8KAXKtjHxWXsrkLzn1EqgJDq6xnmuWYY
         Ims40Ds1quh9oG6ujx6+3/j0dENeiBan1kja4pZ3xh2VANtU+7ABKd3EwRVQ5Yibxj5K
         1EAxvSCCveHBQSqIop+3atgosE94MCAoZ7QjnReGUDl+Aq/r3NFJv+dZlbrPL9WMISsK
         /EgF6m7cAak1+dR1YcXu2GgCbXBW1WWLb1ymzrwFywdmLg3HWxC5Im12bgJGg71oeZGm
         iVWtE2C9XUPXaT7t3EPTe6XRzDUHxoiyMGOqQS1iryyFVSLK06O6euW4gWGeb32cSELE
         RGXA==
X-Gm-Message-State: APjAAAX7eRmh2dnlfLcgNAKV25ouf2+ZwwSS9GQkO+mP9wlm8UfsaPnN
        jvqvPS8ARkHbywyOK+ISl6PrQA==
X-Google-Smtp-Source: APXvYqymPePW8yUoH5ZJ85MmB2vDe8cjepG/rf5Xz4mWP/mQIgzpZMZjapJeyzFwZOJiaQm+QroUbA==
X-Received: by 2002:a65:608a:: with SMTP id t10mr5631142pgu.125.1556823440489;
        Thu, 02 May 2019 11:57:20 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e50d:c7fa:92aa:c53d])
        by smtp.googlemail.com with ESMTPSA id j22sm30688288pfi.139.2019.05.02.11.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 11:57:19 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial\@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
In-Reply-To: <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com> <7htvetbupi.fsf@baylibre.com> <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
Date:   Thu, 02 May 2019 11:57:18 -0700
Message-ID: <7hsgtwlm5t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> writes:

> On Fri, 19 Apr 2019, Kevin Hilman wrote:
>
>> Looks like Paul has so far only tested this with BBL + FSBL, so I think
>> I'll wait to hear from him how that setup might be different from using
>> OpenSBI + u-boot.
>
> I'd recommend testing the DT patches with BBL and the open-source FSBL.  
> That's the traditional way of booting RISC-V Linux systems.

OK, but as you know, not the tradiaional way of booting most other linux
systems.  ;)

I'm working on getting RISC-V supported in kernelCI in a fully-automated
way, and I don't currently have the time to add add support for BBL+FSBL
to kernelCI automation tooling, so having u-boot support is the best way
to get support in kernelCI, IMO.

Kevin
