Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ADD2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P40GTrIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfCTF4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:56:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42839 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCTF4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:56:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id p1so906428lfk.9;
        Tue, 19 Mar 2019 22:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4xd4ZKNDB3m0ieARPPIoFc39hu3cN9+Na0ezOy9OHY=;
        b=P40GTrIYiz5RxE0hvQ472heAfnepSBXMm0HrpbsLpEeR722EaogNXkSKiHmE4v8VXp
         crq619mjOb6gPBg3u8O9bc6kl6XhkjEKW1Yg59s7rQZrcoLuOEmt+VtJXb1VHnbv7pOh
         0hh2vDfN8svrpcKwVusfKbvTazdhw/p6OGDqeUB+mipC9zTg3fof87K+mhqaRTuaKeZm
         ablKEs1zHHcHp6PwYHe1FGhBCRR5X8PXmQ1cWzJc80U6QIJXdKmDR6+7gpUNtrgpmHCz
         J/0fJOiIdp90qm2PoncN+KPDQmiw4D+jL4th4BLUSipVVVG+5t11T3qrs7WHlEbBSWQA
         lAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4xd4ZKNDB3m0ieARPPIoFc39hu3cN9+Na0ezOy9OHY=;
        b=T4yo23HkKnjlcZxTp42eZGLVOMHbh04Hs6e93XzV9QsCmZgWpS2DaNP7jQKnua7oXw
         5ultcynybtnI+ADXvrQcZcsGtujn4EdGkWICY13thY2L6rjgwRTljbYEftLS9TtWc/Ws
         LOFMB892y5fUiLfd2A/fD/Z12U61LKEIamWf077ofZQ/FPpIciIco8q75xOcitKJzP7y
         xH2PNeqBtiPVuUjmlQ/E8b7DUlxjGAbdIj+kSP+f+bmu1rSKyk/m8MqPHJx2NZAF3IxT
         p1fXpcyjCb2bORzekDGoOUvYj0WPrs67AsVr2n+VNo/HxnX7kV7GLoPSuHF1w/u87XQT
         /HDA==
X-Gm-Message-State: APjAAAXxTrGiXoRjGqp/sU7EMDWqb8xFfqZpWFQOy3GdTJDDVx9H6twF
        alU6+jG88pw0UUgxPkY2RSKOyhy8KTP+7lWAoRg=
X-Google-Smtp-Source: APXvYqzfYIqtgAvCKm9bQHmfqLOcVvxaix7CsuhuC+RyWYn3LUjXV3T9LUg9fLTyNpSeGIHB3q0oaT9gy86lcOs6suE=
X-Received: by 2002:ac2:44a6:: with SMTP id c6mr9743994lfm.31.1553061413168;
 Tue, 19 Mar 2019 22:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190306162252.GA3221@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190306162252.GA3221@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 20 Mar 2019 11:26:41 +0530
Message-ID: <CAFqt6zbqc6PX8QFXz1yFq5yEV7S-+8kafEppkLMDHaH8frBaXQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftest/timers: Remove duplicate header
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, sboyd@kernel.org,
        shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:48 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Corrected format.

Any comment on this patch ?

>
>  tools/testing/selftests/timers/skew_consistency.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
> index 022b711..8066be9 100644
> --- a/tools/testing/selftests/timers/skew_consistency.c
> +++ b/tools/testing/selftests/timers/skew_consistency.c
> @@ -32,7 +32,6 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
> -#include <stdlib.h>
>  #include <string.h>
>  #include <sys/wait.h>
>  #include "../kselftest.h"
> --
> 1.9.1
>
