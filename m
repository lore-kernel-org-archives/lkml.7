Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726EAC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4518D206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmOkGWme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfHONDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:03:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41033 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbfHONDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:03:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id m24so2145866ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dWebL9fI0U8v/Hpo+dz8Sut2HpNVnveufAiPqP0BQw=;
        b=FmOkGWme0a9zngByt8Xx69NGtzkfYQoKULWmL12BZ2cCel3xo9BWxubi9OjatpqIqa
         aCblyK/wBtn4LHnnByVR4FkegV/JwUl6aY5bnqtdVQLwtSTU6w0E8FXGwiwGtBwQfhyQ
         1JVGMgzHRIlY4UXyQriDsZFP2cdhFeyc1HbJRyOzuWxjQomyJM1V+qrCyl3BNnkYTAVu
         ok0fgZ5VuX3x7AI+Ve0xGQg2kqeYy1kg7OVkRp2VOwzeNu5BTeXusBlqXVAPhVZ4k83W
         anplh+2FtjGKTwwlufYZFFPtJPPN0vuHErIzzrGWR6BJCeQMLPrC6u+PFzzjAuH26anN
         2vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dWebL9fI0U8v/Hpo+dz8Sut2HpNVnveufAiPqP0BQw=;
        b=P3pV1Qih09RiZbe9AxSk/x7941sNyEcbFcr3r16vDop+/TQZISJ7hjBd5o43qOCd+W
         Ody+atMb7SGO7j2TBSSHizGLfwWKraANvw2aelFYoYPfeB9BCNsL3jMns4iU9sOq9L6y
         gKSx2wdgeEiXljA6eS0SsWw49NrCdkdpGOiOlG9B8E6KLvOakR2vwJUyjKzAzsqWp0LB
         lMP96+jm57Ry5duByAA1Lfo1BjpyFUms/2r0aalGDHz2YNLMk4WRKBU80vUM8KJ6n3nv
         OZSOgOn5FqHjP9jt13NYvipe3WOZBg7NDlKffq2kTtFSJ5nCQyLtGOzxFbYUsdgt7LK4
         xWWQ==
X-Gm-Message-State: APjAAAX+7aDdflwYlt6zUqV0/3BecOj8daSMos5JULEOVemUL48n1PzY
        IqzAg4XRwOWG1Kji4vLel5lQxf/hhzUuAmc0nCVPXA==
X-Google-Smtp-Source: APXvYqz1/QQoHBf2h86ZFsG2s6PVvHb8R6MnNm7oO5lIAJpXQ5PL7Zmvi79AuEfoFIn8Z79YsusZkO8EhOrspBcsfmU=
X-Received: by 2002:a05:651c:104a:: with SMTP id x10mr2522077ljm.238.1565874226938;
 Thu, 15 Aug 2019 06:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org> <1565789078.10490.10.camel@kernel.org>
In-Reply-To: <1565789078.10490.10.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 15 Aug 2019 18:33:35 +0530
Message-ID: <CAFA6WYPU0oREaHROhhRsEXJTijvER8G4riBk4e4=Bd5XgGFqtQ@mail.gmail.com>
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
To:     Mimi Zohar <zohar@kernel.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On Wed, 14 Aug 2019 at 18:54, Mimi Zohar <zohar@kernel.org> wrote:
>
> Hi Sumit,
>
> On Tue, 2019-08-13 at 13:22 +0530, Sumit Garg wrote:
> > This patch-set is an outcome of discussion here [1]. It has evolved very
> > much since v1 to create, consolidate and generalize trusted keys
> > subsystem.
> >
> > This framework has been tested with trusted keys support provided via TEE
> > but I wasn't able to test it with a TPM device as I don't possess one. It
> > would be really helpful if others could test this patch-set using a TPM
> > device.
>
> With the "CONFIG_HEADER_TEST" and "CONFIG_KERNEL_HEADER_TEST" config
> options enabled, which is required for linux-next, it fails to build.
>

TBH, I wasn't aware about this test feature for headers. It looks like
the header which fails this test is "include/keys/trusted_tpm.h" which
is basically a rename of "include/keys/trusted.h" plus changes in this
patch-set.

And "include/keys/trusted.h" header is already put under blacklist
here: "include/Kbuild +68" as it fails to build. So its that rename
due to which build failure is observed now.

It seems to be an easy fix for this build failure via following changes:

diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 7b593447920b..ca1bec0ef65d 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -2,6 +2,9 @@
 #ifndef __TRUSTED_TPM_H
 #define __TRUSTED_TPM_H

+#include <keys/trusted-type.h>
+#include <linux/tpm_command.h>
+
 /* implementation specific TPM constants */
 #define MAX_BUF_SIZE                   1024
 #define TPM_GETRANDOM_SIZE             14

So I will include above changes in this patch-set and also remove
"include/keys/trusted.h" header from the blacklist.

-Sumit

> Mimi
