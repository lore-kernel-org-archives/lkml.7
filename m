Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E835FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1772171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9hCg23u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbfHHSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:05:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33948 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:05:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so60283098lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRx41SN/UeMsfXrgx8amCRruCAm4ctD4uK2Q17+e/Lo=;
        b=e9hCg23ueSt8S3vanzIVZJ8xMk/o7SJBx2C6KSlHMNNjvuFi8m6lB+xQo4TgmBmfAy
         pCHxzTUZERbc4khVCHeiwJcZ2Dvz5eJct7mpqPsRXujfOJrkea5+XSVVNVSnj8WzdQPt
         +67z8Y18b3uPBB1kFL0Fxw5K//skMJK6TCZ7rJ7heYR5c+EVvM+aPd4X0OufjGE8ZBPb
         OFmYPLx4kIvB2uR+2Zvx8griAHclIBrnaqwegMuDpbQH8pcAu/XuNxAFKrICstSbnic3
         Zw/ZwwnasD/o6ZZLnJHcRvmujbFoj4YIhONhjtnFeGqVdXrPFWOV2sB0Xy38twjFZeMQ
         kqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRx41SN/UeMsfXrgx8amCRruCAm4ctD4uK2Q17+e/Lo=;
        b=b9Mx43CokiNKGgxk9xwKfFLBvEbCw7c2s7KYTYn+vcTh+CoO0n5A9zxVH73+lM/VPI
         XJZ7sFceFs+C+RaVLw5BowGKiLHvdHR1JuBIf3IjMgVgD6UV8qQO31z50YfeQAaI/aDe
         Ofds8LyWj1JqU34nk4667RNf1GC2/BgKeXjwoXo3QwKTIWjG176Jl7BEqXaZn5haeLjF
         k32QtCF9mXNHMFFquH8YJqtHBACdC7CqqTnasoHcTPAPIhZdpjhxEM6nHwkdaF161J8e
         UPxK1QVfv7rBwYw8ZtFpyJjCWV/J41n2Rf1IkS5QRfsG3YY/gsrAUoq0idSsaUgLIKH+
         aGpg==
X-Gm-Message-State: APjAAAXTEDcwY1F6cSH+v/z2HBc2S80IfJbGFGotHDhUU7wGV8jJ5QVq
        BHttCKRzQbzPyecdMztAk2f0jZUOgGVlNXAFUgjfnp9o
X-Google-Smtp-Source: APXvYqyJ8N+bloB2fDRNGRVGswTDDz+vGZrq97I7zEbUhsWjmXVJdOB7GK/Mc2+Tc8Cya9hHQbrKysySyxA0Uxpp6CI=
X-Received: by 2002:ac2:5a1c:: with SMTP id q28mr10814709lfn.131.1565287541465;
 Thu, 08 Aug 2019 11:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190704193354.31617-1-mans@mansr.com>
In-Reply-To: <20190704193354.31617-1-mans@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 8 Aug 2019 20:05:30 +0200
Message-ID: <CANiq72no02HC1+pVLzGwyMiGp+3aoZfcs26sK3s_p8A5eihnrg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: add help text for backlight initial state
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 9:34 PM Mans Rullgard <mans@mansr.com> wrote:
>
> While the individual CHARLCD_BL_xxx options have help texts, the
> menu itself does not.  Fix this.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Picked it up and added a bit of extra explanation, thanks!

Cheers,
Miguel
