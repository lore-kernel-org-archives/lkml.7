Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59327C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239B824658
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fF7LHLt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLEXPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:15:02 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43271 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfLEXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:15:01 -0500
Received: by mail-il1-f195.google.com with SMTP id u16so4549928ilg.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=StZhfAUYQQoX4hSeN7hmhB8YxNwfE6easEwqsPBfh9o=;
        b=fF7LHLt5NfogWQmdGHQc1p/sFHLwFSySpSt8RlN6ociIGyw6Qrui71XT6rSxFOrlGj
         u+mz5XhPYWipDeJMktJSJ0399DtB7JygbnK98hSZLw+ewDoPIY9NxJkW2jeDgXgr2MyQ
         4h7bYy9AfTg0wuk+auK6Tt78//6AIpCBjas1/3E0OAhT+VBhf8qR5axwBS5KTJ1+RCdU
         y1GedK2ClGrCdjAe9BammfNeqk0dpewSESqeiE0hGh8e8qRi2ErrIvoIkTZf4SBglCEO
         VJFMgbqp4a3Bc6QZggD+Lx1UhbBnOfNoI8DivihSsgAc8GapXu/n2byIJUlCJvtPC8Bs
         ftiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=StZhfAUYQQoX4hSeN7hmhB8YxNwfE6easEwqsPBfh9o=;
        b=rXIdoTuk3ObOt1s662Q2mLcXbVyzMDuo7uLqK882pQ1nQ/qL4pwIFNRoQ7LJ53yXF/
         BgQOGDkWQ4ALSqKx5FYp8ehpm9NrlpmD/yHsTHj1BC2yjRJXT26a+4AbhEPsOnoGoJqQ
         xmf6vfeHqViewacrTvMZeOhx439N5sLtz97DgdcldLuC6LLsvioILCmCB6hD8ewt617z
         blOtS6M0IZswYK6l9qcYnDr5PWWRBqa5Y9PMZUYypdl6/uez3Znm3iksDx0QJOw3X1hv
         sXfsgVKkogCyKrgBfhHfkRlssp9A9bCXfu+8kq7KCpE/eH959mifH4qrTYtOnWUkBAsH
         VHPQ==
X-Gm-Message-State: APjAAAUFISH2kxDzrTrmrUMzIwseGuMaE0ITbzzQvrly9Y0cRm1N7K+6
        yDcA5ADHB0P9GGZ2zEF158H+KTIgqPQ=
X-Google-Smtp-Source: APXvYqydf7mBx0+Uo1plA0d7tO+7ImshuSiBG4WEJNBPDdtWKuLvED1KnHVqzaPR8FxH2svgWvllyA==
X-Received: by 2002:a92:8458:: with SMTP id l85mr11587638ild.296.1575587699432;
        Thu, 05 Dec 2019 15:14:59 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id l26sm1721358ioj.73.2019.12.05.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:14:58 -0800 (PST)
Date:   Thu, 5 Dec 2019 15:14:55 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
In-Reply-To: <CAAhSdy2ySO_TGL9EYsHnk2p=tceRGaVfogyhthqJEJf-AoOCYw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1912051512590.239155@viisi.sifive.com>
References: <20191205005601.1559-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com> <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com> <alpine.DEB.2.21.9999.1912050900030.218941@viisi.sifive.com>
 <CAAhSdy2ySO_TGL9EYsHnk2p=tceRGaVfogyhthqJEJf-AoOCYw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019, Anup Patel wrote:

> On Thu, Dec 5, 2019 at 10:31 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> > What leads you to conclude that this was done for SiFive internal use?
> 
> Why else you need it ?

Suppose you were to assume that I had reasons for doing it that aren't 
related to SiFive.  What might they be?


- Paul
