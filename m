Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C448C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC082175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm4J+96f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCTF6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:58:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41616 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:58:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so910035lfr.8;
        Tue, 19 Mar 2019 22:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBKnACgg4LA5EQZtvX3Zpb8wfDqVINapO69IGgP684o=;
        b=Qm4J+96flZ/dKh2tvb2468Pm6P/Rd2Y3wMnx6EzmOzho5UYuEeH6FkfkBcP2+ITR5b
         QnrldXt0hVqxoBBHVwHIMGbHwnZKSgYOltTuOV4rNmjEjob+Qc9XXfXA8nMlQgfQp5s+
         itN+pxnKlEXH+0JRnf1P+MLQBI5ZPj4m/f2k3WXbUKtXb6rge9DTUZEviZteunvmKa+i
         c2Sn926V24a+q9qTrlkBXmScKncmqE8YhnKr69KRT4aiKZlG1nAYpvTb/+uBAF2npiZL
         Q7YvzhCDLxaW/aPVoTYNQ5oI/98+ZVq2dtYCyk2VAylc+3ilrcvDaRjXRoPr+lVel5jq
         /cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBKnACgg4LA5EQZtvX3Zpb8wfDqVINapO69IGgP684o=;
        b=ozPvccBA3ihDCluzkgXWZTlp4PRkFG32sCFf+jdcFYahaku+uoO7NRbJruo8nLOJRv
         LhezzMiZBdX4Gd6cuYMAICK1iMY+Q61UKkAUfhr2I3mbEu6eMh+AXQMXAEEq0DE626Tk
         1FugYgCJLTEMWmbuRnSh1fmoyDv70rGK5eup6fCozXplEAAYj124eNADPl1XbUqfLhox
         KEcmGZ8nYXG1S56i4nqCZ2OY0AZsoV8u/xBjGxiIRBKRf+zrAveUP5f28kosaDrw5GBT
         6sAzo1Yw4hhK6Gfmdxm0uB4jN/yBSw7QDWFLQeZuRWsYlNCSzEsENWJpE7BLoEsUoh30
         l36g==
X-Gm-Message-State: APjAAAUTn02cYej6tiZfYt6vgo8nUqQB6ZcwfbBFrwp8aqx5Ay4Yx//1
        vFFmI7kkqz2IFvxbRKyCwH3l4/qOA7qvGpsSAetKPg==
X-Google-Smtp-Source: APXvYqx3JKc4ZspavXUwir8g2fYMPMixzB1nErQFN5+DqFgc59uJQRZwNDk4qUvqHZN04LZEmEAGwWPpyeBTD9KB27I=
X-Received: by 2002:ac2:52a6:: with SMTP id r6mr5280251lfm.27.1553061484567;
 Tue, 19 Mar 2019 22:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190306162018.GA3187@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190306162018.GA3187@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 20 Mar 2019 11:27:52 +0530
Message-ID: <CAFqt6zbwdPnkQ3YrrcELzAHuMFxvKsf=xg62Qj-056T03ThRQQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftest/gpio: Remove duplicate header
To:     Bamvor Zhang <bamv2005@gmail.com>, shuah <shuah@kernel.org>
Cc:     linux-gpio@vger.kernel.org,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:45 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Remove duplicate header which are included twice.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Corrected format.

Any comment on this patch ?

>
>  tools/testing/selftests/gpio/gpio-mockup-chardev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
> index aaa1e9f..d587c81 100644
> --- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
> +++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
> @@ -12,7 +12,6 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <stdio.h>
>  #include <errno.h>
>  #include <string.h>
>  #include <fcntl.h>
> --
> 1.9.1
>
