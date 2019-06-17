Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC01C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BAD2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Iay63UGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfFQOUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:20:35 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46388 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:20:35 -0400
Received: by mail-ed1-f45.google.com with SMTP id d4so16390793edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lPDqMdPEKR2PzqaGXWoGDd7T5h4jBpHExcweaLaSSK0=;
        b=Iay63UGcYlvzI9g3XDbohxpgexk9t4pKF6mBC7NJEA0o2i/h7b/F3pyRiN7Ztb5yhg
         IGbfDCuvvjULm7skN4POwuaHWx33fxSiMI7qeoYiZf+H4tqbmlcbZc1tb396Gn9C+r0j
         wLA9hWmoRSXQE1p8DWJnjWib2J/4Kaz2VWSVHI688WdK0no2cBvovBdcdntWCHAxQ946
         z2JoMRtEJvhNYoUFUu3ZKtlUkW3DiKCMs5jrJfXK1Cqn2Xs4IjIEY8K6M8szn+ozlS1c
         EZYkDBaWPauhcR4yqdZ4NLQpUqF7pdJSAhwbay0oiAGr8k3TfraHW12LWhIdIN34y+0A
         xU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lPDqMdPEKR2PzqaGXWoGDd7T5h4jBpHExcweaLaSSK0=;
        b=huhSyEgw9HHxhU9UJm7MFsH7XnxixpRs9bNNVa6XA6OY0ClBQD+Dj2dNG5ViLixr5T
         SoZ8/Ex9EwuZARfw/i4pynU8TCeWBzIBdpmbXWB+SBax4cf6k64mve4FIjQqEBQOF1pm
         cdPW+1lmZDjFf81A63E/KATmgvzebuIrH+ndEZXrWMkwWTmEjWz50l6LUIxmmYEa79gO
         l6NqBiufly7vwUfR37meyPHQxQ1dyOB18PG8CVPn7ZCMcVr7ORPjyhOCTtEqsZpZbu4x
         9U/Y1xBqtW1+03BC0rJC0tO4pUOrsSzEpuDr8PnbngPm8+n6auqdlZjh03YhYhbSTmf9
         pcPA==
X-Gm-Message-State: APjAAAUVx/gt1w0VK45OICc0I8Q9YDRyDZ2pnS26ABLdc+CGt2UuBw2D
        ZQc4dunTIvsSbfri+abi6/27IQ==
X-Google-Smtp-Source: APXvYqyNGHMS9Mr0hlgx8DUwk8VB/wUtnm/TqHyh3muEpDOB7qL1OTl8vAIIxlvfK0LsosNfRT+dCw==
X-Received: by 2002:a50:95ae:: with SMTP id w43mr90466777eda.115.1560781232849;
        Mon, 17 Jun 2019 07:20:32 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id w27sm2071922edw.63.2019.06.17.07.20.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:20:32 -0700 (PDT)
Date:   Mon, 17 Jun 2019 07:20:31 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Troy Benjegerdes <troy.benjegerdes@sifive.com>
cc:     Andreas Schwab <schwab@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        netdev@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.ferre@microchip.com,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org,
        ynezz@true.cz, linux-riscv@lists.infradead.org,
        davem@davemloft.net, Jim Jacobsen <jamez@wit.com>
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
In-Reply-To: <F48A4F7F-0B0D-4191-91AD-DC51686D1E78@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1906170715350.32654@viisi.sifive.com>
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com> <mvmtvco62k9.fsf@suse.de> <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com> <mvmpnnc5y49.fsf@suse.de> <alpine.DEB.2.21.9999.1906170305020.19994@viisi.sifive.com> <mvmh88o5xi5.fsf@suse.de>
 <alpine.DEB.2.21.9999.1906170419010.19994@viisi.sifive.com> <F48A4F7F-0B0D-4191-91AD-DC51686D1E78@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Troy Benjegerdes wrote:

> Have we documented this tx clock switch register in something with a
> direct URL link (rather than a PDF)?

The SiFive FU540 user manual PDF is the canonical public reference:

https://static.dev.sifive.com/FU540-C000-v1.0.pdf

This practice aligns with other SoC vendors, who also release PDFs.

The relevant Ethernet documentation, including register maps, is in 
Chapter 19.


- Paul
