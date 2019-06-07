Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8AAC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD45D20825
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 05:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KzOVJS3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFGFOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:14:41 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43263 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:14:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id t2so239015ywe.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3Xju7gDMx5B9qHaj8jfngLaT2SOH6/zYkG9Df0Mcl7k=;
        b=KzOVJS3w8Hhs9rF7BQM3HuP+5QYVcJa+tptO+Mfetj+yo79LIL0EQ53UDXHCQucfMN
         nqrC7YbiJhTy5A+Nwa2PZNbCScrF7D3p8s5szl104PIvwELvD1BLO46dJtbtBji0lurn
         tytv/uYYJD02f22byeiCCB4SQAJAAgBtuQO+HZXNKhhXGz6mcwRDHDXtnPiUG+wCG4WU
         +I7blFPOzKut/E6lYvlURG+pRA4TRjnpTOc5ICrN9w4H9vtbb+eD1mYdOE/SPuu+Zf2m
         K+Gse+UhmqBfr2SL4aaFYV/xMatUnwv/fmaA9/ygeDWezbLXafyOnxnyuJFV2+64wjVn
         hY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3Xju7gDMx5B9qHaj8jfngLaT2SOH6/zYkG9Df0Mcl7k=;
        b=SFc9WTuQmJTIb1YhMZiHWLu96Q3vljQ34778mStAjXeIKgurzt/ckJbsVH+e8N0Eod
         FCI3zYDL+DIQtJDXZV34WfXjIfYDi4axz0HMK3o6fb2NrwZ6CIt7OGj0x6f1rnz3CT70
         r8iXk1jZ0QUXl8Cj48Jpp2yDVmfs4IFU9B3EqRK55RBGYHQkgS2el/zuuyi+qUOBsMsA
         pxSACwdBIToV8FFN8gcY8KHa4plXCwA1ah3oxO1LjfrYb9CcIlui0nh8IXEjBXnmGA5b
         YwOg9AtgJq2O5I+fUJ407u/NGncNIvC7LFwfIiNOlBk+ehNiR9jjLul/7DaEvsFy4zHk
         tN1Q==
X-Gm-Message-State: APjAAAVK9quEux6fGJsWedPZflN26Hwh6EBJ6+4FRgQ2qNK8hw61hv1u
        ZzA4MPMNxGLcXCbeW6yYGlrnDw==
X-Google-Smtp-Source: APXvYqymtR0IKUoS+1Xfs5Lrap+5HcqM6C2mqqK5beiLYtakPNM8vO4d1FONXXn79jn905ffOBLsfA==
X-Received: by 2002:a81:15d4:: with SMTP id 203mr24760997ywv.133.1559884480901;
        Thu, 06 Jun 2019 22:14:40 -0700 (PDT)
Received: from localhost ([14.141.105.52])
        by smtp.gmail.com with ESMTPSA id i1sm287854ywa.19.2019.06.06.22.14.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 22:14:40 -0700 (PDT)
Date:   Thu, 6 Jun 2019 22:14:36 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Loys Ollivier <lollivier@baylibre.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/5] arch: riscv: add board and SoC DT file support
In-Reply-To: <86y32hh16j.fsf@baylibre.com>
Message-ID: <alpine.DEB.2.21.9999.1906062213590.28147@viisi.sifive.com>
References: <86y32hh16j.fsf@baylibre.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019, Loys Ollivier wrote:

> On Sun 02 Jun 2019 at 01:04, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> > Add support for building flattened DT files from DT source files under
> > arch/riscv/boot/dts.  Follow existing kernel precedent from other SoC
> > architectures.  Start our board support by adding initial support for
> > the SiFive FU540 SoC and the first development board that uses it, the
> > SiFive HiFive Unleashed A00.
> >
> > This third version of the patch set adds I2C data for the chip,
> > incorporates all remaining changes that riscv-pk was making
> > automatically, and addresses a comment from Rob Herring
> > <robh@kernel.org>.
> >
> > Boot-tested on v5.2-rc1 on a HiFive Unleashed A00 board, using the
> > BBL and open-source FSBL, with modifications to pass in the DTB
> > file generated by these patches.
> >
> > This patch series can be found, along with the PRCI patch set
> > and the DT macro prerequisite patch, at:
> >
> > https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1
> 
> Tested patch 1, 4 and 5 using FSBL + OpenSBI + U-Boot on HiFive Unleashed.
> Tested-by: Loys Ollivier <lollivier@baylibre.com>

Thanks very much for your testing!


- Paul
