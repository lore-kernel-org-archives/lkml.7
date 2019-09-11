Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB632C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 23:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9044520838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 23:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stvvdzBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfIKXGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 19:06:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36208 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfIKXGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 19:06:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id l20so21759787ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7883Z7ac+Slfbx+cQ/2DuLT6CRyOLfw8ut+c4CPANPs=;
        b=stvvdzBxZQFTptGzgB/17WFhzTnI1B5cqiDZnDkMkXANt53ZBZnICa4KmgDHALXJ4Z
         ceqxJg6ZCM19wPr6NoqVAfdXmq92wMFSjhrjO/mEvPHbSPEL2W3tY5Pp73XBcwlJbLS0
         2WuWg+Cap9oK26ETQLk2Gq3N1LqEEniPaHLY5v89o0+3ac4Bd0L1B9/UUVZCiQ4juLNq
         VsZkeRCO317GHUAKVV3p70wbMiN5fnxDXyY+gzY4KR7g3vdXSpHVZNxxoF/dUAmCxcR6
         TDMuzkmGqJp1h/YjGE0OdZXSapzBN6SNO3tNwfFqvcn/VPBFewtPs7ZE+wP+kw7YATpa
         ensQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7883Z7ac+Slfbx+cQ/2DuLT6CRyOLfw8ut+c4CPANPs=;
        b=nzUtBSd8QSDdmqMh1CnPOuZIfCjEEZRA45QTlINWfjvDmDNOyIu0hUeQhyece8JL8L
         2UZOc6XS82KtMBnGCLUGX3qirotva/66JIOKg7AHxkzcmsr+kdLcSN/H34b3vVd4ZK1J
         Tl7xtX6WVh4pI4GX7HWfMsyr5pyP7bKPgMHKcWoEqaKqdEEWzRlxsIgo1ct83yVJp8kA
         mcJh8PlIXecAHj0r1fllRdb/FCosnht9fnDp6DkLNhnTJgZQa5dJIWPUssi+XkmsA5MF
         MoEs9fBvLOVNNoPoLYGLEvv0ErNwAz7bfGruiX01M8Ne7PBDeF9ODSjzWvuRXtdDv3/o
         tiNQ==
X-Gm-Message-State: APjAAAWU9wjpRhB1lqjkiw0y1QDDEsBTCTvm/awhwPqDWphLKdHF4+Mc
        OPdT7k4yTiQMA+L8uHdqr3gDzy7MGWexjd5kb+e63w==
X-Google-Smtp-Source: APXvYqyIytBBqNqsUppL3242vttfgTVNOPFJ1CgaZu/wYMBC5ORTHbehk9CWW/zvK6SNx3rRlGlpknUWJWHBMsh8L9A=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr23708970ljj.62.1568243176898;
 Wed, 11 Sep 2019 16:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190907173910.GA9547@SD>
In-Reply-To: <20190907173910.GA9547@SD>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 00:06:05 +0100
Message-ID: <CACRpkdYoY9nRGD+4m7yzSci5n0YS3XeL+tgPDKWuaoqh3GSTyw@mail.gmail.com>
Subject: Re: [PATCH] gpio: remove explicit comparison with 0
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 6:39 PM Saiyam Doshi <saiyamdoshi.in@gmail.com> wrote:

> No need to compare return value with 0. In case of non-zero
> return value, the if condition will be true.
>
> This makes intent a bit more clear to the reader.
> "if (x) then", compared to "if (x is not zero) then".
>
> Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>

Patch applied.

Yours,
Linus Walleij
