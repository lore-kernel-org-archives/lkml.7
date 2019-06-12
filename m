Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D599C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CFA205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZXhYOCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436547AbfFLHK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:10:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33329 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfFLHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:10:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so8248290ljg.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDfqw9BoikhPY0Dh3SwCqBjJ8PAOLKi854XNqLlMVzk=;
        b=yZXhYOCTOo7pIE/Y6X1tztbts791vhqKWYR9ND6YurUQHkPpLW0lfVsBIo/XypbEnJ
         PS2MiMZWypqPhQOItzAZUtxqHZLXCMwwT3RmMqaQ4Ujfa7971kep0Py1s3AUrRMm7hBA
         x4dXsg+lsTj25JteAUKoPkjL+O4V7sBmqTFA1e89ZWfCs6AR5p25o4wfjdhLGT9yEs3r
         22YZt2zh107nLueurni6ZAuHPhGS+kexlKmmjfRqiZLpMu01BLEZVvI6dr6guYGaoMh5
         CqVxay7fjTn4xgX0HvpF2eapSf2Kl6xnOiH403W2RJTmFp38UQJ6p+44uTdlOGAYLMk5
         gj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDfqw9BoikhPY0Dh3SwCqBjJ8PAOLKi854XNqLlMVzk=;
        b=aupIuSv4hbVXj5A5bCPxDxZjqREUV1jnTdNscSjPL1tNEcnYuHLnYgcXs7pBzgtUDJ
         W4bhS8NQFr2KHC7NSXByz/cWH7AzUUqPLB3ztw8M1kbft+Vi3BCcaKr7h1GxoS7Z57+k
         Z0IIh8VNwGJF1b48UGS/JD2IgDEPxfjW3MXqEoPxpS75XLqvXo/JFmJoHZE7SppwD2xh
         nOCWb1x7c0nB66McQ2e7gYXJ3C5/t2c8Lk4HpVEuX/hab4qFls1hRxFUl5yo2cF9pORO
         f54fzU98cY4Mgw+8b7HlrNEDm/sZuu+uhVp21CJ3w5XSI2VtNNgLO/f0wYRZSHDosvuB
         l3Mg==
X-Gm-Message-State: APjAAAXS1Vc260J6YIALbbjK/iLcWM0cTIIGuF1K65SL4kafH0yYAowW
        6ZyxQN2pg//+zvmCwSYkZt/tHdFCitZI45d3l3+wKA==
X-Google-Smtp-Source: APXvYqwNAOR28KWVsRSGhKRPpy6Cz1HQFUNpqvVydgFwWVjRazfmyZ2wGtlHtx3v5KLBIGZMOLibsHpRrNRfkw+PwWg=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr5288468lja.94.1560323424436;
 Wed, 12 Jun 2019 00:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190609145537.7953-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190609145537.7953-1-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:10:12 +0200
Message-ID: <CACRpkdZ1B2b3DLdFrtYLfZgJH2QWBYmnX-mBHtO3C=EPc=UC_w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: remove unneeded initializer for
 list_for_each_entry() iterator
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 4:55 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The iterator is initialized in list_for_each_entry().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
