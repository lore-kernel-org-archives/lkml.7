Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE314C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A18F2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvAAsEp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfHEQfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:35:07 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:34109 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfHEQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:35:07 -0400
Received: by mail-qk1-f171.google.com with SMTP id t8so60563870qkt.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiRlEkepGMSBghGordYKrd53LhTX7Zo4aO4skFP+FPQ=;
        b=KvAAsEp7EBlmFnFm4A3RAJMlB16Gu/ClvhmFXF3/nwkvC5G3iN4z6D5ZAIMQe6rNqy
         C9y9oS1wkZ6b0qlJqiG5dKcARxLYs606StbTrx5pU50S/+YvdJKieH9ziJKmkBTXHyxr
         vd8kTNJR5d72pYVhLyhomafAyREIb+BcHb5B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiRlEkepGMSBghGordYKrd53LhTX7Zo4aO4skFP+FPQ=;
        b=rHLV/lhKwrAj0kB7ayYbFCuUZQ19rGrjtwzxTctGz3UvEO/9Ig7uIBK/n3hAUYNk5X
         mvadbZumf5b0ZgK+XPo/TghiB9vG0Hy93EMelm9sEAPFO9Fr1L5jvPtmGgACglfpLP8l
         9s2k/Djm5uwFdySraU4uWTHIrtqR0PT+JRPCfMwtQe28WM8gkMH4AWl9cfZzHONav5Mk
         XIN7Ismn1PKDo0pEPj3JO5ZJEUWwV+un7cIBIc0a17zC9JdKSo19RulHKARwZ8KqLe4O
         ibHGGWslplTPMjy4I+SefJxtUlysOR3V1G++P44Ebo7vRrVZalBkinQwK8zQqFYgJzf/
         iRCA==
X-Gm-Message-State: APjAAAW548lJPOs2pLcDQPLj1Lyzlk/GIcMhY7gVKlbj2qRz7rwX89Qr
        d0t2/0Yo8zYSKyUJbho9uOKD5+omNWqLMdokM3tdtw==
X-Google-Smtp-Source: APXvYqwpHxcg06Mbli+NdzWaalL0e2240Scm0EbQOE4XY2ybkQPkjSSR20aWvi9JTpQhhWlZ4idPL5YNwkECJiwlU5I=
X-Received: by 2002:a37:660b:: with SMTP id a11mr99152263qkc.342.1565022905887;
 Mon, 05 Aug 2019 09:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190703040135.169843-1-hsinyi@chromium.org>
In-Reply-To: <20190703040135.169843-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 5 Aug 2019 09:34:40 -0700
Message-ID: <CAJMQK-jaLi9QaZ4n0TguL7GD_rdn6VVNnf-3=j2XwGbUHwrgBw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] add support for rng-seed
To:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping on the thread.
Should the series be proceeded?

Thanks
