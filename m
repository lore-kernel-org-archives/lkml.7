Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2132082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGYWb7Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfC0Xgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:36:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37000 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0Xgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:36:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so1905486wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5Dvux6ocl2t0ptmnwpPqVvc51Kf5RxioNPXdEE2ueY=;
        b=JGYWb7QhbKU9WeDN8yMrhgCVGOfgvTPrusFe1WydTw8tYzLJk8uw/PjL9LeoARX3wH
         pLgE8dIfIpPNGHtH3EMHr7KsWr5AiD4uBIckeqIJZ2u+WHvJsooHiTqvrVGxbuB5mVqn
         lvrwUoLWZbr7G2Ip0cEL/EO9uFVXnYp6o5X6wzHIdQRk8ft7EPVV1PhD04K39kjYnRop
         seIJpGoex92U6HKkoMAe8+CgvLpZy+wAWL11SpzKIrfJhWfjuWh0ZKVONf27Dr5QtZeT
         9+oi6TJXB8Vcib3nmKaWD3fn5zAm4gO8A+irJdYxDSLo1EbUgPTiE2fsKIWnN7uDuLxN
         AzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5Dvux6ocl2t0ptmnwpPqVvc51Kf5RxioNPXdEE2ueY=;
        b=po1B2GMGzI/XroSZnTKfkDB7mo16f7dBaUgBGrbQVoOicvGQSzP6ElWyll/YhlYUuI
         W87+mkaAi7zjf8LbfrCfJOPydxaVPd6g1HRbfCN1G9g+5cGABGLrPqMsCbX83HZxr8jN
         R95aIqT2Ya3/faKywBVUBhSI1g3khQ3rW7fFK55poJaK0iV8bSak8S58+5krAVahq0to
         wlU4iDgd9wxE24RQa353qb6YMF81RsAQtCyFv6NdGaxvN9sTBs3p8fXhaNw4kNKpBSE8
         oyGCwRljhZVOEUAywtpHCC8cD6JSxFXXzsXIKTryPybc40j4wDgScqdCAZq7vxTML3Lz
         9ojw==
X-Gm-Message-State: APjAAAW97ePWJo1BQMwBlbXS5WBsvv8asapK4hF/xWgKDZ4sT4P4b3qn
        pe4VTs4ByZdL0BAKHKC7UBhPJ/G2oZvEzXuj0QvqGA==
X-Google-Smtp-Source: APXvYqyIXLhmymvtJcD/N63PMb0x0iplVfOkgQWRAoBMlJqfhnh5Q1O0dodLUxjC61Q941sgsf9937P+xua/1OKwH/8=
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr21187422wmh.9.1553729801307;
 Wed, 27 Mar 2019 16:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <CAHC9VhQavjf5M2wDU2jfFe3NpsxCd_mFjtrUC-0jujZFj2tTdg@mail.gmail.com>
In-Reply-To: <CAHC9VhQavjf5M2wDU2jfFe3NpsxCd_mFjtrUC-0jujZFj2tTdg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 27 Mar 2019 16:36:29 -0700
Message-ID: <CALAqxLVbGRgJFgNU-45QvLe0SiPP+VMw3Jx_jrLQvAhgs2ZQqQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 0/2] audit: Log changes that can affect the
 system clock
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-audit@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 7:50 AM Paul Moore <paul@paul-moore.com> wrote:
> These patches look fine to me, but it would be really nice to get an
> ACK from the time folks before I merge this into audit/next.  Time
> folks, I know you've looked at previous versions of this patchset, can
> you give this a quick look to make sure everything is still okay from
> your perspective?
>

Sorry for the slow response.  I briefly looked it over and it seems
simple enough, so don't really have any objections. Though I don't
have as sharp an eye (or opinion :) as Thomas, so no promises he won't
step in with an issue.

I do want to make sure folks are careful with future changes to
audit_log(), but that's my usual hand-wringing.

thanks
-john
