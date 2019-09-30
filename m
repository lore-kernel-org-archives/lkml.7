Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06179C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 00:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF8F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 00:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SMiW6Imf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfI3AWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 20:22:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34778 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfI3AWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 20:22:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so6332009qke.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 17:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGwdw6USM6fmVtOR4py7H/FTk388TMG/pxH4fNnR7YQ=;
        b=SMiW6Imf160HoDD7OIZxz/j458zUAz2dFCa0mZIo1gAP5XTsQDQxGtpiND94fDI04i
         q7K3c7Od4+9vl7y5Zr6hd7umOAAsr/vRsODisq1i7+sdLtSoXdgZG9GJOT5kF++ogH5Q
         SF4F9+RdVpYJDy3psGxNKEjz+bJMVJg6mxFCxA7fQ4L9JfGu1brjRfr425SUDcB6t+7/
         oMxxPZET7P2bPMeadtM3wVu9kc+Og4kNrHMPEFqVxDjtM+r5d48i2p39s4G+tGXMKxqY
         MBEYEusD/cnIk8g8RrwoouEGjH1bdVGVydg5m0p1WF4fD4GZPLBJO6iCGBKTf5xNm5nV
         br0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGwdw6USM6fmVtOR4py7H/FTk388TMG/pxH4fNnR7YQ=;
        b=oX02qS0dzMBKGwZjOJcgir9CpwhwcfXRHJjei14+7qA7vNJrm1HFPx9dTFqbyAEi+h
         SLZOosMiD7xcmeyZ2FX66GhYjUqW5A0bOq0PNRJ+b9KTa9PSog2V+y4ESgLdw88kU2f+
         AG4DCzEhaXGwZDULVjRl1K4kQeDYQYM7/VRxpM10Lyb8u7TxPzENxIcmMRuuu7+llqb5
         tR97YntP9UmOYViKJZKIW4F7Q1QVboAXuob0Jq96KhOmJNzzcS3vORCvRQvQxg5RfZ1h
         +WaSS075N7BqbcKLTTi1hoIwwnCwC9eoRd7hCLozptbRRlugpHNA7KUP42+Xqk9eitgh
         TAHw==
X-Gm-Message-State: APjAAAUGicn1h3qFX3uEn/B4LWzZIIJwtM/o0QKeitGJdUUtkdJsvD+5
        pSatymF5T3uiFz4CXCMFuYpeJGn/Xb8kcrNEsx+pzA==
X-Google-Smtp-Source: APXvYqy3j8uNg+CUEJI8czs3s9DRTMDcdCN0bb3XNnLIQb0jeIVng5zqybz5yWzFCcY8NlU7y0u9BfZCOPRSu9kY7l0=
X-Received: by 2002:a37:a68e:: with SMTP id p136mr15969911qke.49.1569802962803;
 Sun, 29 Sep 2019 17:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-3-git-send-email-vincent.chen@sifive.com> <20190927225620.GA26970@infradead.org>
In-Reply-To: <20190927225620.GA26970@infradead.org>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Mon, 30 Sep 2019 08:22:31 +0800
Message-ID: <CABvJ_xgqtY4YydhAtM3ap_Ods1DUHtRE4p3OZpD8_a7iRj+gzQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] rsicv: avoid sending a SIGTRAP to a user thread
 trapped in WARN()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 6:56 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Oh and s/rsicv/riscv/ in the subject, please.

Oh! Thank you for finding this typo.
I will correct it.
