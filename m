Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46676208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g6X2ExKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfFGJtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:49:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfFGJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:49:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so1472077wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Qj24v20If9zgLt13neBHdsQHg4q/cs2v9iuEfMb+jR8=;
        b=g6X2ExKqaEWGP16yZeToDxgi/hFe4wnLeV/g34TOGsJNHgdfDNK2QUkTqq13LwRWBx
         sSmyEdrjhZcumVGP62IpizYxeuQl6Q7aw/E4CstzGn/CzN0YIDSdpJlD36itYzTfu6Sj
         szvtkdN9e3bLkxGizqDY5jVsM0VJm18LSI4f3KF7FvZJnY/wZlXbcajq6p+Wk6w/Gk9n
         Tu1if2GQlSzDTJXE5WNZAKZ1cjHlMpuu3X+C37VQvqM/Pbo4bQjiyFfj8oNiGbzdnMJa
         xVPmidT/6pZi86OrAGGLwELTDe3J1CwlfvPAKcfjYh0o2tRtGa89RRAw6YZKv4HOGELw
         ulEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Qj24v20If9zgLt13neBHdsQHg4q/cs2v9iuEfMb+jR8=;
        b=ReBfJHrtMC0oSYhCG9MZmFx3255+rnMwbGGpa4OnC8rTVkPZUTN6IE29uU2s1QJtvk
         h7iCkLBIk/31aeT9ymkWg/nXg8eUvSYtouX6+fevFqEv6cOMEaKwCpgpZBxPYBpSQgyl
         OyMH+tmeoaQuKtjHyoLy6ZmcW0SbVDrQf5ZF+elGlM9PQj0vXByYtYzhHXadClqi7O1P
         td5g8ZTUtYTQHXYTfA/OQhj7dMnDaP0X/zPUN1wdbmOmt4kAh+rbC8gqaf3oJmzxwzUA
         l78lYbWbJE4PjMpYik1GhSMzrzdXTKDrvL1oJQDMYs1DbMq1zOvNJiTer2ZpdDcaYybY
         +xLQ==
X-Gm-Message-State: APjAAAXKcV1EWE95D6ruwQbEEoQxzlZk93lmA8x0Op/5Gr3iSK9gaqRG
        U/+5ZxT6zGW44dQCEfo1Mk8ueNf5fQzl/g==
X-Google-Smtp-Source: APXvYqwWGlXNT1rix2H5Zql0Hm0SBRVNRNthbupEGwYwbeXvTUfJiWy7Ye5ZMiyjXXaCEt/uPmp9Dw==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr6576125wrt.197.1559900952280;
        Fri, 07 Jun 2019 02:49:12 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:56e0])
        by smtp.gmail.com with ESMTPSA id z65sm1338145wme.37.2019.06.07.02.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 02:49:11 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/5] arch: riscv: add support for building DTB files from DT source data
In-Reply-To: <alpine.DEB.2.21.9999.1906062208280.28147@viisi.sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-2-paul.walmsley@sifive.com> <86v9xlh0x8.fsf@baylibre.com> <alpine.DEB.2.21.9999.1906062208280.28147@viisi.sifive.com>
Date:   Fri, 07 Jun 2019 11:49:10 +0200
Message-ID: <86y32dwwrt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Jun 2019 at 22:12, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> On Tue, 4 Jun 2019, Loys Ollivier wrote:
>
>> Always build it ?
>> Any particular reason to drop ARCH_SIFIVE ?
>
> Palmer had some reservations about it, so I dropped it for now.  But then 
> as I was thinking about it, I remembered that I also had some reservations 
> about it, years ago: that everyone should use CONFIG_SOC_* for this, 
> rather than CONFIG_ARCH.  CONFIG_ARCH_* seems better reserved for 
> CPU architectures.

Agree on the CONFIG_SOC.

>
> If you agree, would you like to send a followup series, based on the DT 
> patches, to make the SiFive DT file builds depend on CONFIG_SOC_* instead?

Sure, I'd be glad to follow up on that. I'll send a followup series to
start a discussion.

--
Loys
