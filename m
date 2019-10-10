Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034CC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5422086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5DYis7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfJJA0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:26:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36609 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfJJA0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:26:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so3999685qkc.3;
        Wed, 09 Oct 2019 17:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJVRzApWUSHgdNBRH3SUZ0/qd5E2CCfr2UoORKNjRa8=;
        b=N5DYis7uPKipl0cDXvFbCowOIVqJOHtHkPbbgeuPBKtiej1Ij51lQaKh+Gy7hRp2ra
         EIu8aTLliFZcetEYjur8WYm1n75nqJ+Hy0/aSL4snbMcyzqEHLslTZ1taRJpxDOwmkdh
         mka1E6M9BOtuGsHqgOWKYdcDpMXT80IiOMMgWxIYOug1zlnw9yW5u0k8Vrfz4TJ3sNab
         oKPjjN2sdBqYWw343JKpsqRR6YyU/3ZfYMwUcA4RPkQHbj0SBF1iMh0lheHJDnslaoS3
         bqWRJozkJtU4I5P/Iw1sf4VOSXmJDL5v9G7oF2TFPU14AxdJN85h3fC8fJ3uRil6Md4m
         ZbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJVRzApWUSHgdNBRH3SUZ0/qd5E2CCfr2UoORKNjRa8=;
        b=XiHDSMs/+PN+fnWYOnhnHO4skVy86hFrdKUUc5PJ7LudhcmuJFRq9tJUPUEHyfWN1D
         D+yalBfFTa7HMPzDuo/vMfnZh7xe7dW7botD4ovvx9HLJukrgRnjXKNRt/9Sd40BUhl1
         P+bHPILgWscu8LOzGNTF3TmZ3VJpaWhfar7lzq70mw1kSe3DFh33BFDWhWxm9VcXDbvh
         fB70PX6CPD9Jyal3jU++0KMnN4/dtz1OSb2aqzlspZhaMenYoWeIbcrtbyN8WZRDOjs3
         8l7snMwuPkC/RLj8/UnzDdJM7BLrWvKNOxrbexAhAvsU0dwno975ypUXM7WofjrWNpQr
         KKyw==
X-Gm-Message-State: APjAAAV6rkDNwRRkYxxs2QnB/BagKLrSOt+yVspQ3jPG6BgRi1cfnw2X
        90jUl0Tw3TFezuzv0sk/mPPx3KCwf7jDp5eAFU0=
X-Google-Smtp-Source: APXvYqxUSe0DseUwlExqerpeDVzqzpbZSaxkzseSPt9wfk83oiom+qzJWnHqrY7tZz8n93L9Dc5K57DvbXGqR3ZFumg=
X-Received: by 2002:a37:4c13:: with SMTP id z19mr6820886qka.449.1570667207415;
 Wed, 09 Oct 2019 17:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org> <20191009204134.26960-12-ivan.khoronzhuk@linaro.org>
In-Reply-To: <20191009204134.26960-12-ivan.khoronzhuk@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Oct 2019 17:26:36 -0700
Message-ID: <CAEf4BzZ=-DYoP0yPttx9WWwqZe10q+=nxAer7V_S0WRY47tp9Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 11/15] libbpf: don't use cxx to test_libpf target
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org,
        sergei.shtylyov@cogentembedded.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 1:43 PM Ivan Khoronzhuk
<ivan.khoronzhuk@linaro.org> wrote:
>
> No need to use C++ for test_libbpf target when libbpf is on C and it
> can be tested with C, after this change the CXXFLAGS in makefiles can
> be avoided, at least in bpf samples, when sysroot is used, passing
> same C/LDFLAGS as for lib.
>
> Add "return 0" in test_libbpf to void warn, but also remove spaces at
> start of the lines to keep same style and avoid warns while apply.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

Thanks for the clean up!

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
