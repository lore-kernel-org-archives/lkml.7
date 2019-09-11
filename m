Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD99BECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757F321A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osjI2/rU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfIKJeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:34:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42503 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:34:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so19294260lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFTqrDSGPqM5Rbf4MHh4Cpzi8wVBsnY38oD1BczrIT4=;
        b=osjI2/rUKypUftfsqOHyrN59YoxOwshy1+/i/o5n1NWMpuQPUpCQUKOHKTvA0LzR0l
         DJ3dM+/OF+TmuYuxQgZ4Wt5LuWd9fB5REMpxJdptzIuzXmoZwebXEvZ+Bhe6dyKv0dL1
         3b/CWDNSltOrJMoPdbhe9qpcDlEekT0D7rSSMMRoOm4QqeBVDEcQr9NvyM3utFUv+4f/
         O9Q3xd1AbUmF0lBlAANYfPYJFZav4dWuqd8lUZFEik5khcr9FIJ00+Nhm0srdVQA3juO
         TWQXAPjOuYUm9Jr3z4XMNiatqem/btCwFCF+pjGY28M4VTSZqCemgW5lwm+Vt5pCrXBq
         IpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFTqrDSGPqM5Rbf4MHh4Cpzi8wVBsnY38oD1BczrIT4=;
        b=cIvwQ6aAgpnayL/V/6b3Fw1Y7m/EKNy0ojlbBVJ3SVU94PwrAGjqfOyk92ByMehQ3g
         ky03qshSPpb5jKNeNzRiRe3m1h4CEODZBLRA0rtsQ6ovXBVCkX7ECoHjvYz4XsiWpnzU
         b7fQsbsd4p1BFTJSxXTrAmQxk6mpYSwCkEhJ8TR7DcDFJ3r6ZBdY1LF+uAX58W7fSmlm
         CxS2OCRomoXaE/DArxUR7i7QLwvtfDk0SDc2dZEwkq/RVIvRtKkWhXiXh5cbaAJcKXw+
         cOz/VBSvI6dsDlAgIQ67EAoo5WvID/QsC6vHpxWO9NYNruH34kwq6KN9XrQeEaX4M1To
         540g==
X-Gm-Message-State: APjAAAUeXvKG5rHml3NrafFeBvSogY8z69GHEHWkzddPhl/GetpXlaeA
        vZ0kZAxboD9f0QdroeX/ffLeBfBXAIbJ6915vQ3AKaGas6Lb5A==
X-Google-Smtp-Source: APXvYqzo6t7hRvy0qG83lG9IT1ljukS0U1MgOkKKQb3y96ro+RFSmsfHLUjuc7xmYEc36vZpOaTczbQjCjOq9/rUa/8=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr18956643ljj.108.1568194483710;
 Wed, 11 Sep 2019 02:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com> <1567054348-19685-2-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1567054348-19685-2-git-send-email-srinath.mannam@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 10:34:32 +0100
Message-ID: <CACRpkdZe2btC-vjRq1rPaHA9pXUi8N_cZT-RQ5m=PxjmkASieA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: iproc-gpio: Fix incorrect pinconf configurations
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Jin <li.jin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 5:52 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:

> From: Li Jin <li.jin@broadcom.com>
>
> Fix drive strength for AON/CRMU controller; fix pull-up/down setting
> for CCM/CDRU controller.
>
> Fixes: 616043d58a89 ("pinctrl: Rename gpio driver from cygnus to iproc")
> Signed-off-by: Li Jin <li.jin@broadcom.com>

No response from maintainers for two weeks, so patch applied.

Yours,
Linus Walleij
