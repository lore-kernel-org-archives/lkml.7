Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE68C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD681205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7WJlt4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfEPQtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:49:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46088 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfEPQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:49:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id z19so4640072qtz.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V54eRnKwdjS+PEKbXuK6UCgdmon3FdybUlySjzqEJGo=;
        b=Y7WJlt4bLjAJ4WhWIbMzJ/8PhricDREUZCU7Q1/HTZvvFSjXhMw6Fj3NYJLMxnF5H3
         xFmNwRnXYTntWpRu3Lpdbvwa5tqci5Xe358XawRq25kd+KE+5NovF5rGFK6+pyVUKFjE
         t5pWcHvFVNZlhWAdiIbzyX+khalrXvVMxRhdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V54eRnKwdjS+PEKbXuK6UCgdmon3FdybUlySjzqEJGo=;
        b=qzZh9SxsiAiAUuE/FPLywk7z6GCOX+oyB421rAAR09Rcf5xx0jT9MhrRozlb7kLyx4
         by8LTTi0WLwduA1XjD/Elu5+AcGhVb08HZ+mq1k0Inetb4xw9NUeWOUoTRcAuwINQJFC
         avlwwIUow8l2BmJsF1RhKot0fBjC5FN6xDzzJFas9dCRUmDlK7m23E0ng6TXcU4QXc2V
         /e4uBstkpI0sKVcox02GFhsae527Qji9qfBJJ6HiQGbvUdBrRYwdVcJcTz8QdtO08IC6
         xvW2ZYt0tovWhh3d1Wt4W5Z0Wyu5jR7jvX1qv+rlmWhO6uCFR68DK8AWTX5pyKws5ELo
         gnvw==
X-Gm-Message-State: APjAAAUloXaD7OVSbitjzQnL66HGYcw0aMaZB0EnfhKV+Ixd7OquikZB
        GYi33nIpxJY+XojyiPI8WtYkNdAFvdmfKp2NCZznaQ==
X-Google-Smtp-Source: APXvYqy+/6RfTqO4HVKK22HJ4SUb9lK/prYvmIxZ0Cl7qxFHUR3oqhJi1qikDD7OHXt/c+stN5QSeCyFVHsMZ9dZnA4=
X-Received: by 2002:a0c:8aad:: with SMTP id 42mr40983967qvv.200.1558025353386;
 Thu, 16 May 2019 09:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102817.188519-1-hsinyi@chromium.org> <20190516102817.188519-2-hsinyi@chromium.org>
 <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
 <CAJMQK-jrJQri3gM=X6JRD6Rk+B5S4939HJTptrQMY64xEWr1qA@mail.gmail.com> <CAL_Jsq+dVg9E_EzpoC4Bz1ytUckDGXUcEJyU5pV2HS6rZuKmHA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+dVg9E_EzpoC4Bz1ytUckDGXUcEJyU5pV2HS6rZuKmHA@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 17 May 2019 00:48:47 +0800
Message-ID: <CAJMQK-hzjSBf2-QFMn52Sa8fwvm5-gaddzBOudfEc1neR2rwnA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Thu, May 16, 2019 at 11:32 PM Rob Herring <robh+dt@kernel.org> wrote:

> Doesn't kexec operate on a copy because it already does modifications.
>
Hi Rob,

This patch is to assist "[PATCH v3 3/3] fdt: add support for rng-seed"
(https://lkml.org/lkml/2019/5/16/257). I thought that by default
second kernel would use original fdt, so I write new seed back to
original fdt. Might be wrong.

** "[PATCH v3 3/3] fdt: add support for rng-seed" is supposed to
handle for adding new seed in kexec case, discussed in v2
(https://lkml.org/lkml/2019/5/13/425)

By default (not considering user defines their own fdt), if second
kernel uses copied fdt, when is it copied and can we modify that?

Thanks!
