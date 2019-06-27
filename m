Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F776C004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CE02075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkX3/j7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF0Uha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:37:30 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39061 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0Uh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:37:29 -0400
Received: by mail-yb1-f195.google.com with SMTP id k4so2259736ybo.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nVOtlju8csIcNRRNwvhU29isQ3Rt4IPNLGyKSCvv90=;
        b=gkX3/j7eA/9Dj6rOAXXvFLWl4m4E+rlkxxmn+g/fKNORNs1hO6b8z1g8OwGu/JGEfn
         buOFuAB4ltgph5dqxxu2zCyygo9C3C1bhWaALqEyy8xYxfRQNeyhuGVEeopJSXCGMNDw
         7f4ld/9jEGn1F3TSYnIdlNypUjmtsk2V/yBzgcGX9htotPephx45YpG5Q5gwIxSbl98V
         kAzDXC8tariAgUcmYO2HvzQ1UKNLmSwHqdK26R++vTbGlUK0NWDBpMG+eTQ07E/8+0QR
         0FNU8m3XuvAkTeL4NCOZkcW06+0L4mrrtFU8dGufBw7VzNqIEFaFMxG0gpmSSNbA+0Ax
         sOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nVOtlju8csIcNRRNwvhU29isQ3Rt4IPNLGyKSCvv90=;
        b=tSemAe2YAXborojtyigHSiUPSQ9ENSZ99+/aZKPybg7f5QUCJJG0hfLrQIR/UP7yV4
         5PXzRWNEXvHVwbSqh9Z4OnOtaKlRj08p8blwQ9n1ktj5T/SZ9n03RGCZTQ1dC0irE8M5
         V3+Y89jUfiokwj7/AOv29QgSRiPuPnL0Bnq9D2dK7TkdfSr9c7d7laDc59mtMRZ/Wyfx
         9IuFhPRKhPOTglbsu2k72Yfbt1Wl20dHz/bfxVW5S/tIpVBA+dooSK/+BMf9yJaCJbVQ
         NInqixY8JpKIZcRzyiRzwe/CIXge/UOB2X4koPRxBxsgswSYUNH0ylxqlL6RnNRb3erh
         wSiA==
X-Gm-Message-State: APjAAAWG009ZX8/IqYZVD3zM6sE44CWYxzPcJFf2sDBGeM8PpkkcJFy2
        F+ed/TUG3RJlDzaVXMClverSC1ORsFeI0Vd9uZ8=
X-Google-Smtp-Source: APXvYqxnZwKL8uAKFwqU1Al3NryHFgkeA2TGfrZeraalix6k1RfRY5XylEBxf580X2ZkhSDVbbQOmYYNQD9ZdNWnuKc=
X-Received: by 2002:a25:7397:: with SMTP id o145mr218166ybc.329.1561667848946;
 Thu, 27 Jun 2019 13:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190627070052.8647-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190627070052.8647-1-yamada.masahiro@socionext.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 27 Jun 2019 13:37:17 -0700
Message-ID: <CAMo8BfJe6va+=oB_VWG5F0xWFQv+Qbx5DXdjJbO2XLNh5rs3=g@mail.gmail.com>
Subject: Re: [PATCH] xtensa: remove unneeded BITS_PER_LONG define
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Thu, Jun 27, 2019 at 12:01 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Xtensa does not define CONFIG_64BIT. The generic definition in
> include/asm-generic/bitsperlong.h should work.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/xtensa/include/asm/types.h | 8 --------
>  1 file changed, 8 deletions(-)

After this change the file arch/xtensa/include/asm/types.h is effectively
empty, only including uapi/asm/types.h. Maybe it should be dropped
altogether?

-- 
Thanks.
-- Max
