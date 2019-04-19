Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD6DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215AB208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H9HwqyWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfDSVNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:13:37 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40928 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfDSVNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:13:36 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so10060383itb.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PDbWxb27fzlzzWLDxv2f+CVVkrb2FlVAONWimUJDpDE=;
        b=H9HwqyWyJ66jfkcOgCjeTmJ/A/Z3Lqv9zJQUjiVfODxEYXxFaLd6bFt5k/9Cj27RpD
         k5ghRtuoHeQ3xo+KGz67aaUO4CUFzJ2ViKX83lwXJ28Mln1M+y0oxhUq8ijdcruaShko
         LuGNKLr7ydsacRgR5/NtiYQokOEJrdG2YiWz+dkHWGiBnfq+rRCjQk14ceqPnX5DsHOu
         UAo7GEUYbO+XCuUwavtfuDaXqN7CqzKt0BGeM4S9nO+EQlDMvR1DP6KfxRM9YUHWgztT
         zMJh4DpAc8/THc0h5iTqNpmvgvyatbyLKfCgfkH0hZXc46gqMVL0ouyF9744Xgt8iBYt
         Ouuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PDbWxb27fzlzzWLDxv2f+CVVkrb2FlVAONWimUJDpDE=;
        b=jop2/p+U0DOWOdmmf1ig4UaPI29oj1LgxWhRjZondwRs9AYReXJriOPBeXokd1Q1LC
         RfDypK/ryU940vc9LCgDV8ufklnB/gIivE0GuMx9wpdMTyawYYbCRiV70OdG+qfU12Fn
         e61KBCHlp90cHURTBTLUvnIIdSb1hq+f/COe2wz2tNPe7q7StlJ2KYIWczOFAyJJ2ukb
         wzhb73jHvNWbY4kw60LJNHqgLmkitCpPhdduqwzDajiVTmbUHN1ZL686ypt7K9a3yGBZ
         HqHzhR6DmqIlxoqxTod4zUuDq5NPTVXBZXlf0xxv4JV20iIStD4DkEInKOeizEgUpy95
         yZ/w==
X-Gm-Message-State: APjAAAW+TEWjHNH2+Gvpfcz5Dsi3mb6vGDRoHTrd5h+4FNCpMkrBvKop
        21wky/R/7pTSzgitwexBuGeQdw==
X-Google-Smtp-Source: APXvYqxefgCQSLJJmbb1fnAb05JCxgT0qx3hF+pjPtWqkbr8h20/Alu3bYVrwshxLXn/4Aqof7iv3Q==
X-Received: by 2002:a24:549:: with SMTP id 70mr4632419itl.108.1555708416119;
        Fri, 19 Apr 2019 14:13:36 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id 65sm2987763itw.1.2019.04.19.14.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 14:13:35 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:13:34 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Kevin Hilman <khilman@baylibre.com>
cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/2] tty: serial: add DT bindings and serial driver
 for the SiFive FU540 UART
In-Reply-To: <7htvetbupi.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1904191407310.5118@viisi.sifive.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <7hmukmew5j.fsf@baylibre.com> <883f3d5f-9b04-1435-30d3-2b48ab7eb76d@wdc.com> <7h5zr9dcsi.fsf@baylibre.com> <f2bb876c-2b44-663b-ea06-d849f721fb6c@wdc.com> <7htvetbupi.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Apr 2019, Kevin Hilman wrote:

> Looks like Paul has so far only tested this with BBL + FSBL, so I think
> I'll wait to hear from him how that setup might be different from using
> OpenSBI + u-boot.

I'd recommend testing the DT patches with BBL and the open-source FSBL.  
That's the traditional way of booting RISC-V Linux systems.

The goal is to transition to U-Boot over time.  However, right now the 
U-boot port is still new.  It wouldn't surprise me if we need to modify 
the kernel, U-boot, or the SBI layers as part of that process.  In the 
short term, we need to get some sort of baseline DT data in place before 
more chips and boards start showing up.

I'll post a separate message with details on how to reproduce the test 
setup that I'm using.


- Paul
