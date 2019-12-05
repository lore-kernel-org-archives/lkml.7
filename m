Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9800FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D5E22525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="vlWRoepl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfLEXXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:23:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33152 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEXXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:23:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id y23so8467597wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoew3w+WjCDvHa4nERX4szfxNTztaiIuTi5nYNUkYZY=;
        b=vlWRoepl00jLfiXESI0GCgAl5wxXlnr5e1i4KUimKoDa2Ab+iu2yxSM5HkhaHOGQUX
         kVP3wz3yMrBLYChAlm+JrIo7cr40RALBw2NKPcjcMt55KAxku8dJqbykXlnk9kEfdlfm
         yJTgkc3QNQMMebhIRne6lp+lfa+/q+AInAGOon2bzXPLp1YMqkeWy01PoPy78222hAmd
         hR1tx9sfHzojLy7Slwep84Z71mbYoRT3ZAOVNAdRfEDVL4r3LCExAN5Rs4SsfsRRP1xL
         tpDxx0eB3V3mPuv/FR6fJllox5q6mmh89fj35K9fYxcVUcHCjlkVHTh4fOrEEIMQXOZU
         iIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoew3w+WjCDvHa4nERX4szfxNTztaiIuTi5nYNUkYZY=;
        b=ZbVRVY5/X3VuLBgFEMoZepnuz40Wn7XeklRmdPW9TyP9lIlwFoF/qY8JwYm4kZ75/m
         eqbWYq8gOBzAntlXLjTb67Lm2Cd945TEvsHi8ICRMntfgeN84m0IOlg6JzJ4C7luR5WD
         VRfDIhO6X96j7iq8h/Vo85NH4eZGqGvOsAiGIUXrE2Ji8Mbz3ChI0aCRWaVAhZaqR4sz
         PxXdRxDJnWRv791IHJrTOru6/uaJfpFPddIH4JyNKLnSCW8vF7BPRxwkLgsnHkLzfR+R
         P15Iz2JkTBsbuy3541P7wYhtzeLl7QQ8xLb5m3a1MLRVzprPSUPwEgrXUXvYcrQfstoG
         j/9Q==
X-Gm-Message-State: APjAAAVj8rth9zz16MM1hFUkpb5oeT0vxPAGbAo0Vk1Vdz2PxAAQQ7+b
        vIJ9U6YHhyYuk+AxK0asEKN9b4dlMQ2V7KpyJCVfgYi7frU=
X-Google-Smtp-Source: APXvYqz3qNfyynvmdufghI95by6GfxVqSiTFOJeqqtWbL44qExje+YkBX4Yuyji8d4GJFqWKeKcnLjW/D97Q6dCbDSE=
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr7287277wme.124.1575588227572;
 Thu, 05 Dec 2019 15:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20191205005601.1559-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1912041859070.215427@viisi.sifive.com>
 <CAAhSdy1RQw3MVcVT5y1EHr72LDNADKRL5nO2E8OrzBi+tpuvtA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1912050900030.218941@viisi.sifive.com>
 <CAAhSdy2ySO_TGL9EYsHnk2p=tceRGaVfogyhthqJEJf-AoOCYw@mail.gmail.com> <alpine.DEB.2.21.9999.1912051512590.239155@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1912051512590.239155@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 6 Dec 2019 04:53:36 +0530
Message-ID: <CAAhSdy0VXuhqXnEHTMwYKfDKQt2c5fU=ejXuz54c6LvwLRew_A@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add debug defconfigs
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 4:44 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Thu, 5 Dec 2019, Anup Patel wrote:
>
> > On Thu, Dec 5, 2019 at 10:31 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> >
> > > What leads you to conclude that this was done for SiFive internal use?
> >
> > Why else you need it ?
>
> Suppose you were to assume that I had reasons for doing it that aren't
> related to SiFive.  What might they be?

It does not matter what your reasons were. Having DEBUG options in
defconfigs is not the right way to do it.

I have posted v2 of this patch. Please have a look. It's much cleaner
now and does not have performance impact for people using defconfigs.

Regards,
Anup
