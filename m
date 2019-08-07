Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC98C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E98B21E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs2BZRdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfHGM3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:29:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36818 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbfHGM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:29:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so86050940edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMGcLcpBFvBpeJnTu8pKFKchF/J4VwKD/tTDs+NsQXU=;
        b=Hs2BZRdpKwuVf04EmL/zxWrnNhMxtMy7h0wGB3ikJvc3l/oxOzFWnumHtlGGzHAEX1
         zySBfRKQCOt8Fs1uW+NRNdqCLcU6I1CKBWWPz3V9PUuHR/Qq/eG6O11acF4zG5BpD36m
         2ZLfT9yo6+bHOkew7NGT5pU4xa/i+jOGcoXw+sKYn0jBTp9YB504PVh6Ehicjsns5mUp
         3TAsX7d+r/kbrvYcHl9IW9NaYgYGWncAM3Z0wpJ2niOieZ1SviuTY+xedO0IjXBR+4NO
         QwTPlWBimBKD0BfkFRwF3fFfNZiLCDA7fSQDn4OjAYuqA1KrmbgK9qCD0VTrqYif08HT
         gZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMGcLcpBFvBpeJnTu8pKFKchF/J4VwKD/tTDs+NsQXU=;
        b=JpWtBl1Xv3uR5GDSQw889Eqiu8F+GeWP91jBc0V3XLUWGAsnilGuIBIm2Y7c8NjfRW
         /bt/EWINtCifzScgXHBatkQMB7B+0u+i/uiUN0bDDN9qL4AddBC8FiR4BtUrZlJsmtQJ
         wN4pzTmZOe1DlApxeUw/dZl4Eqk/fA1UQQSEet/Ow3Li8X6HSj6XNN/staKB97HWS7Fn
         MYp3WZOMzJSzArMOTCmByjff51UmExtmO0GLS1MmG+iN+InhfgYkVOu8tr9UGiHm9jXo
         61aqcOct94v3enmOAaHHBrvQAdcVe5nhh3Mrrv5nLHQEn1rg50FFrm9AEB7DuAv96Qcw
         vdAw==
X-Gm-Message-State: APjAAAVbzLweiOzBfdMOxk/jNsQ4/35c0/0ROMs+vvu3dsW3tkv0pUGt
        M2imIXQExz9+dAFYRSWkF1vbZ24zhqjvFGL/f7pkK94e
X-Google-Smtp-Source: APXvYqzCdGyICX2LUoiY5hqgxJ7SHzCXH7ef6H+PwGXHY9Jlh73ZnjzNMytBeuwief9bV3euiMPvWui+bAoe41vQnDE=
X-Received: by 2002:a17:906:fcb8:: with SMTP id qw24mr8113765ejb.239.1565180947146;
 Wed, 07 Aug 2019 05:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 7 Aug 2019 20:28:54 +0800
Message-ID: <CAEUhbmVTM2OUnX-gnBZw5oqU+1MwdYkErrOnA3NGJKh5gxULng@mail.gmail.com>
Subject: Re: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 10:30 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> The baseline ISA support requirement for the RISC-V Linux kernel
> mandates compressed instructions, so it doesn't make sense for
> compressed instruction support to be configurable.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Atish Patra <atish.patra@wdc.com>
>
> ---
>  arch/riscv/Kconfig  | 10 ----------
>  arch/riscv/Makefile |  2 +-
>  2 files changed, 1 insertion(+), 11 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
