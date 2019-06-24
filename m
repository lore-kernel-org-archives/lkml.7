Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990C720673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI729Alw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfFXT6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:58:30 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:44186 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:58:30 -0400
Received: by mail-lf1-f41.google.com with SMTP id r15so10916860lfm.11;
        Mon, 24 Jun 2019 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMA8++vd98/rlAwnVJntUv97lzDmhQiW1l9rW7+CeaE=;
        b=mI729AlwP9R+qtDCGGEiExjDVIvwap0quVVCd9H1QOIWRGj2a6WmiQ7mpu9JynWiTl
         MBiBgrlrd82Pib6+dBUqVzoYXHlnMsFn+0c97S+RiGADQ/yvqrXEbyWciynRJJ97H8lL
         8os5EwwPZ6cGimvRB4Pma0lW9NVDHHNFC+WxfPoUZin2DrzmmFwfPVrdA2bwE7QHssub
         Lac2zk2mktgSxkhAlDYnMi7tFkwVDhy2wScuhkYj+E2OZMYLN4WRSH7vvf7lIzbu8nDO
         qhzuPX54QkJIunmLSN5yBHiHdPULEPX02Q8T0AZ1QIiUffaDMCfV7cdLPYvsEeRXFbxD
         TZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMA8++vd98/rlAwnVJntUv97lzDmhQiW1l9rW7+CeaE=;
        b=dkvdBhTmTtAfIm/bXQKg+bCi1CggOY312oKYxNf1z3AdJjiXHNBmo3Ur7J7BgcbhWo
         Dnq5emliy4YaO0EEkb9ACMh5vkVMkocpVLENx0VVx1zaYdp5E5VqnEhoFOOUlLBMPHI7
         vAiYkHHkqJBuDsimC8LNqvpNLTa740oBh68zgq6aCgpQE5XxEfml9EDwqPtcmn9Y1Fgw
         icFY8ufDbqPXmYdFlWFugHoWgzNlVwLTg26Te3qVQzAZAY2qdOVAaS7wc13YsoWnQJfY
         +OB6VFc4bpZr588TJpqyBKluVuUahi52KMN4bIffFYCnTi1iSgDU+PzzLmmVEQ+2iJPY
         iAJg==
X-Gm-Message-State: APjAAAWFSd/yvj/bOnaWChaY8Tk1bQXxKBivUXZgH6mG0BUu0c3pS6iT
        vcQ8XCVMcOV97M9VQ/EcM3qPa2IZjhMyHtUDrs0=
X-Google-Smtp-Source: APXvYqxeWm1dY/BeGvUJ11kjU06uOztLuwFtzDS9B/aD8vqFftuGui5xb00hQr4+67JZuKerfwd3QqtMbTcAppnyMIY=
X-Received: by 2002:a19:e05c:: with SMTP id g28mr63608637lfj.167.1561406307546;
 Mon, 24 Jun 2019 12:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsMcdHmKY66CNhsrizO-gErkOQCkTcBSyOHLpOs+8g5=g@mail.gmail.com>
 <CAEf4BzbTD8G_zKkj-S3MOeG5Hq3_2zz3bGoXhQtpt0beG8nWJA@mail.gmail.com>
 <20190621161752.d7d7n4m5q67uivys@xps.therub.org> <CAEf4BzaSoKA5H5rN=w+OAtUz4bD30-VOjjjY+Qv9tTAnhMweiA@mail.gmail.com>
 <20190624195336.nubi7n2np5vfjutr@xps.therub.org>
In-Reply-To: <20190624195336.nubi7n2np5vfjutr@xps.therub.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Jun 2019 12:58:15 -0700
Message-ID: <CAADnVQKZycXgSw6C0qa7g0y=W3xRhM_4Rqcj7ZzL=rGh_n4mgA@mail.gmail.com>
Subject: Re: selftests: bpf: test_libbpf.sh failed at file test_l4lb.o
To:     Dan Rue <dan.rue@linaro.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Xdp <xdp-newbies@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:53 PM Dan Rue <dan.rue@linaro.org> wrote:
>
> I would say if it's not possible to check at runtime, and it requires
> clang 9.0, that this test should not be enabled by default.

The latest clang is the requirement.
If environment has old clang or no clang at all these tests will be failing.
