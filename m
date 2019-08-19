Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA44DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98D520651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="TjRfrMeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfHSPJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:09:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44841 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:09:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so9080063wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cexPhrCLObLWuEp73k9kJmodhWBwZ7DxuWqGj7qCEDA=;
        b=TjRfrMeuPlMjyuBy47+ksxr6FmfZjGkDNkXRu5/hwIyw1NlgdUHHn6o94/O+Wxoy0P
         OqwTYfWZU/kaEZ3NBy27JlqV6AOJzjmTIHTMx3qvNywoNOSAR7soXBUJa5uWbx++pmp1
         3urb9mti67/zJHeHCkgNfCPslQ33U0Yxz9huifekewmAjgfpkr3F82NhvOL4ZhMGnEup
         Uo+SMvSwQfu3EbtKP+U2QsI+msI4BgSDPcNE4WSRq6hHfBpaaLjzEiodzpm0sJCxTh9v
         N8FWjUPivsUUEZh7nB4NhK/aK25uEEhTFjPDjhYukNG2PjXrO3UyR795lTmkZxJe6/gU
         SqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cexPhrCLObLWuEp73k9kJmodhWBwZ7DxuWqGj7qCEDA=;
        b=m37figKbyFApTFvN6392RmJEdb03j1YyXQ/BYmhAdVl/ME2TSfMl7ULJELalZylvLw
         DWw1zxN2jCzenKq1EW4EOKeUqwPx6DWjWhZ8aC7w+EAuQRa1/qyS4Vc7y7rdDZ1FODL1
         RQ7GA35gC0mDv0sqdl11OcsKPDMJmmJpdmhU1tLhLSWTPWCpZIQ4fACsXBAvreXOkwlm
         J5BplPyOndYqxAYF4q/IM21jkPCXW01KDXduq2NfTeoeOa/0ABaPTIFeGILvcWr/MIx8
         RqL8VZX8d8DKqUL8LpZpj1XwsgakHpjHhf+0/Qx9gBRvIp9zU4SY8VU7arP0p9E9yuy8
         0bFw==
X-Gm-Message-State: APjAAAX/+fHobu1VUlV7LJg6Myagwn+hPSdgtnQfYii7k3f67akJ52CU
        Ok8VMQCBlzPw2v/iMxltLO/eOHUM4hJ4/QPkil/zPQ==
X-Google-Smtp-Source: APXvYqxV/0uOhnuxnc2R0h3qP1aT0Liq9FhY/9Gz4IWrfKiJ3gPJFTzL/OOJpQPukmL9s4TFqlCHy2g9K4TSCe3fKcE=
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr25030881wrx.328.1566227354761;
 Mon, 19 Aug 2019 08:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190810014309.20838-1-atish.patra@wdc.com> <20190812145631.GC26897@infradead.org>
 <f58814e156b918531f058acfac944abef34f5fb1.camel@wdc.com> <20190813143027.GA31668@infradead.org>
 <3f55d5878044129a3cbb72b13b712e9a1c218dc7.camel@wdc.com> <20190819144627.GA27061@infradead.org>
In-Reply-To: <20190819144627.GA27061@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 19 Aug 2019 20:39:02 +0530
Message-ID: <CAAhSdy3KLCW540mLVk4F6nAqYP2dYuiGqO4FuwTD1Hra_gHcGg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
To:     "hch@infradead.org" <hch@infradead.org>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:16 PM hch@infradead.org <hch@infradead.org> wrote:
>
> On Thu, Aug 15, 2019 at 08:37:04PM +0000, Atish Patra wrote:
> > We get ton of them. Here is the stack dump.
>
> Looks like we might not need to flush anything at all here as the
> mm_struct was never scheduled to run on any cpu?

If we were using ASID then yes we don't need to flush anything
but currently we don't use ASID due to lack of HW support and
HW can certainly do speculatively page table walks so flushing
local TLB when MM mask is empty might help.

This just my theory and we need to stress test more.

Regards,
Anup
