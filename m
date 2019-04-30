Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAC2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4D32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZV5D5lv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfD3GU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:20:29 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55028 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfD3GU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:20:28 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so2874019ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 23:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=AV9ZTDDQcqZfQOAe4qT7E6y4JoSwEYhZS+A0aSnML+s=;
        b=ZV5D5lv7eg1gyd5O6CJUMoMHBVvq2u/J+sCgxVwj6ybz2prZuez6tDOWXyJvseqqkr
         rk8o/IZDvwanTWSyqZJzkmRHFdO3SxjxNOYlC03qHde8Dytq4GaJWkoTiBd3mNxxLjVC
         fbhU25q+UCIxArF7Ul6wjlFrFJLHoiXWpSO6WLmP3JY3I+L7HVx4Vf++usyiXWWqKSdX
         kzSQUxn1Mln3B+Hh4t9Dtxzk35DOM/lJzAKzkAtqgdJTrgfuVv6CvbiJQYlGv/kTKYCz
         cSedb2oBBkwXyqS1e3uop4Kx0YnI0HnjikQUbMXUB92QCMiOG6ugiB3w88DjZZ7nvcOZ
         UuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=AV9ZTDDQcqZfQOAe4qT7E6y4JoSwEYhZS+A0aSnML+s=;
        b=p6sKo+/P/R8iZrtce2E2UUdd/ba9kudj5eoAwkLfqbZHioyiwHzYxNLi4+bmTuXxVT
         5o41cmfOwt7yijSZZpcwM0EeOa2+TcohlKi2qTpq3GewjmWCciaAsg48wiGUUz4c9iSm
         rNy/HzGi5WvAriWrPz0jxCcQ3k63Eb9SIwA/YFYoeYJVac7Gxg/kBIdsyOfEC/Yf2VJR
         vw1rjXVBvM+oCkDV1ziwie1lJc/H4kQmguDEuoO6wgXS170r6Tiko39pU8j5NIE7YeT6
         0fpCrbMgFfgc23sJffRp95TDImdgc+qrFhBy89KLvbA2H5QTQiqb1RM4mtd1TYwxjvSA
         giGQ==
X-Gm-Message-State: APjAAAW6fWdT5+n/4LzCVt/opyARyAMMTXxHSVq0oHFd7bYVC4Fd4rJP
        nsyIXevNqw6wz6ryBztyAl3arw==
X-Google-Smtp-Source: APXvYqzH1CSf//UWvt+BdmDERbKBSmcenZ2fnx2isCJPie+haSmfsZdhwXMx57NQC5bbn4rBB4DslQ==
X-Received: by 2002:a24:d003:: with SMTP id m3mr2198104itg.132.1556605227707;
        Mon, 29 Apr 2019 23:20:27 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e4sm7828414iof.62.2019.04.29.23.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 23:20:26 -0700 (PDT)
Date:   Mon, 29 Apr 2019 23:20:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stephen Boyd <sboyd@kernel.org>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
Subject: Re: [PATCH v3 3/3] clk: sifive: add a driver for the SiFive FU540
 PRCI IP block
In-Reply-To: <256b9312-4740-e7b1-84ac-c0cc1ff4bc77@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1904292258000.7063@viisi.sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <20190411082733.3736-4-paul.walmsley@sifive.com> <256b9312-4740-e7b1-84ac-c0cc1ff4bc77@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Sat, 27 Apr 2019, Atish Patra wrote:

> On 4/11/19 1:28 AM, Paul Walmsley wrote:
> > Add driver code for the SiFive FU540 PRCI IP block.  This IP block
> > handles reset and clock control for the SiFive FU540 device and
> > implements SoC-level clock tree controls and dividers.

[...]

> > +static const struct of_device_id sifive_fu540_prci_of_match[] = {
> > +	{ .compatible = "sifive,fu540-c000-prci", },
> 
> All the existing unleashed devices have prci clock compatible string as
> "sifive,aloeprci0" or "sifive,ux00prci0". Should it be added to maintain
> backward compatibility?

As you note, just adding the old (unreviewed) compatible string isn't 
enough.

> Even after adding the compatible string (just for my testing purpose), I get
> this while booting.
> 
> [    0.104571] sifive-fu540-prci 10000000.prci: expected only two parent
> clocks, found 1
> [    0.112460] sifive-fu540-prci 10000000.prci: could not register clocks: -22
> [    0.119499] sifive-fu540-prci: probe of 10000000.prci failed with error -22
> 
> Looking at the DT entries, your DT patch has
> 
> +		prci: clock-controller@10000000 {
> +			compatible = "sifive,fu540-c000-prci";
> +			reg = <0x0 0x10000000 0x0 0x1000>;
> +			clocks = <&hfclk>, <&rtcclk>;
> +			#clock-cells = <1>;
> +		};
> 
> 
> while current DT from FSBL
> (https://github.com/sifive/freedom-u540-c000-bootloader/blob/master/fsbl/ux00_fsbl.dts)
> 
> prci: prci@10000000 {
> 			compatible = "sifive,aloeprci0", "sifive,ux00prci0";
> 			reg = <0x0 0x10000000 0x0 0x1000>;
> 			reg-names = "control";
> 			clocks = <&refclk>;
> 			#clock-cells = <1>;
> 		};
> 
> This seems to be the cause of error. It looks like this patch needs a complete
> different DT (your DT patch) than FSBL provides.

That's right.  That old data was completely out of tree and unreviewed.  
It's part of the reason why we're going through the process of posting DT 
data to the kernel and devicetree lists and getting that data reviewed:

https://lore.kernel.org/linux-riscv/20190411084242.4999-1-paul.walmsley@sifive.com/

> This means everybody must upgrade the FSBL to use your DT patch in their
> boards once this driver is merged. Is this okay?

People can continue to use the out-of-tree DT data if they want.  They'll 
just have to continue to patch their kernels to add out-of-tree drivers, 
as they do now.

Otherwise, if people want to use the upstream PRCI driver in the upstream 
kernel, then it's necessary to use DT data that aligns with what's in the 
upstream binding documentation.


- Paul
