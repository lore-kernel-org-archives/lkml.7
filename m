Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F8CC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA9220866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhg4g22m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfFELJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:09:54 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39141 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfFELJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:09:53 -0400
Received: by mail-ua1-f68.google.com with SMTP id w44so8928108uad.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Y5HwIx3fzDChQujd1N/5M1n45Hod1+PxY2t0oBRnBQ=;
        b=jhg4g22mJsIJvSlpDwP+93DagHN+KMBYeEa0gjvpcvW9hE8IebuAfQu6rIDc8B45B1
         XbEI/BLU5MONyvFQP1CG6k11hw9WvO3UVwPQyQDweq/cXlpyI/xrJrKGtMCUEi0yucRL
         EDNpv0Hx/DwO4NnyyjQhb9K4FwAK9YZBeHfIUvTKbWo6b4Tu2twDS+dCBIX6pit6VVzN
         BhqGZmCTYXKg5Ua28E7sahtqGTrnOq8ibMN8bPBQh+ZBEQ5cwsvIy4hEw49ox54iK0z0
         K0bMAW7vOlRJpoSf+x1ewWiRXnOjpdURRh4bNNAKucy4Maoul5kqPlmCw6CGIbT4xuEE
         se0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Y5HwIx3fzDChQujd1N/5M1n45Hod1+PxY2t0oBRnBQ=;
        b=K4KntRYWJ/gXlWkx6qBT2AOkwWkBuFxmcavfsK2G7SaE9X/BYh5rKapKaTxPJzTEwy
         aiXlqBYdo9ruah8mxxw1ddZr9598aVtBDnP+DjQiMWmC5b1n/5vHMHtcDNLjf8Wak31n
         XttqyBhNmqLQRK42QFE570PmFUApUGlCUaZamAmC3NFrLMVF/AFjlTrRyVLt2JZuJD5m
         mfGjDBtkq53i4/I9TXquVSLptA/2rWItxjJNouokj/+vdLBHk8rfdrEmmzznVLBIV9qi
         FPKMM9/b0Dtbwt2QWiZQZvqgAwDvjgz0N3NNu+k7+NZNo3/4Gs4i3QuxwtG2LzYod9w1
         jVEw==
X-Gm-Message-State: APjAAAU99QK8Nd5OtZn4acaNDPH4ak8zIN33klwsxb1OKesy6MwKw4Un
        2XxZufHl50wuTY/TAzvn0laYfh9BWUH5ExnbHIKDpQ==
X-Google-Smtp-Source: APXvYqxAkbHwRdqB7xghLMjam6SVNoHl2PMlMYH9gCYZViKeRuwKt4rDsCauU6BAiCx5LxlKalIUzDm+9yk3JDGCnbQ=
X-Received: by 2002:ab0:238a:: with SMTP id b10mr14235309uan.52.1559732987905;
 Wed, 05 Jun 2019 04:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190530152758.16628-1-sashal@kernel.org> <20190530152758.16628-2-sashal@kernel.org>
 <CAFA6WYM1NrghG9qxUhrm76kopvBx9nmCL9XnRs11ysb2Yr0+Qw@mail.gmail.com> <20190604200951.GB29739@sasha-vm>
In-Reply-To: <20190604200951.GB29739@sasha-vm>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 5 Jun 2019 16:39:36 +0530
Message-ID: <CAFA6WYMOjgHRw9RVrjherNo0ZNbTtEonPwSFFC0dT4CZO=A1NQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fTPM: firmware TPM running in TEE
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 at 01:39, Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Jun 04, 2019 at 11:45:52AM +0530, Sumit Garg wrote:
> >On Thu, 30 May 2019 at 20:58, Sasha Levin <sashal@kernel.org> wrote:
> >> +       /* Open context with TEE driver */
> >> +       pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
> >> +                                               NULL);
> >> +       if (IS_ERR(pvt_data->ctx)) {
> >> +               dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
> >
> >Is this well tested? I see this misleading error multiple times as
> >follows although TEE driver works pretty well.
>
> Yes, this was all functionally tested.

Can you share your build instructions and testing approach?

>
> Why is this error message misleading? I'd be happy to fix it.

IIUC, here you are trying to resolve dependency with OP-TEE driver
using "-EPROBE_DEFER". So user shouldn't be prompted with error
messages until OP-TEE driver comes up.

BTW, for me this OP-TEE driver dependency seems not to work, boot is
simply stuck waiting for device. Probably the reason being this fTPM
driver is a platform driver and OP-TEE NOT a platform driver.

>
> >Module built with "CONFIG_TCG_FTPM_TEE=y"
> >
> >[    1.436878] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> >[    1.509471] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> >[    1.517268] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
> >[    1.525596] ftpm-tee tpm@0: ftpm_tee_probe:tee_client_open_context failed
>
> Does the TEE have the fTPM implementation and such? Could you provide
> details about your testing environment (hardware, fTPM verions, etc)?
>

I just did a sanity check on my arm64 machine (Developerbox), just
adding following DT node and enabled CONFIG_TCG_FTPM_TEE=y:

+    tpm@0 {
+        compatible = "microsoft,ftpm";
+    };

Basically with no fTPM TA, I expected the driver to fail during
"tee_client_open_session()" call with TA not found error and boot
should continue. But it fails during "tee_client_open_context()" which
opens a context with OP-TEE driver and has nothing to do with fTPM TA.

-Sumit

> --
> Thanks,
> Sasha
