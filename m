Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B877C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 04:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CE5214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 04:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQHbMgmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfIPEkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 00:40:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41966 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfIPEkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 00:40:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so382273ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 21:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlspV5URgvRkvXxNuJ156sbYo8cEx/JcT2NW3f+g8Cc=;
        b=mQHbMgmDPSQo5jWR6FmzdZPro6bVfB3SpjjKxve6qbbF3jZTgThJKB33kvsSmsTnIf
         SkDWiJWsCqF/NFlQ7CXSlGW3O/37K78hVAcHKlMFrgVpraUw++396y/9pbEf2c8B82cC
         TtnxKow7s+UeISoCQlJyPnWRAr0+uMY/jk8uD2cky0ezy8RyHG9reqelus3qkmkmXjfQ
         6xMqFgeBnf4oN+7nSXrd1WDl3g8OfXK2NgwoBxEmWbNdg3N0trbdJJvwGfG9vm13uzL6
         kCTbUhaw4udJfAvN+EJwM8P3C2nWjyDJsYvfLtMCKu9hQ5FgwuG5Po28u5L9Msm145+G
         GY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlspV5URgvRkvXxNuJ156sbYo8cEx/JcT2NW3f+g8Cc=;
        b=ERZkCDYOLAdHvbmRLMk1D3hS9P5K1OGhpPPtQ8d8TAyqeqEHDX0HsGxqzJH11I/6R3
         ZTANoM+AGb81+Uf8pPdXXgv+1xstVLEcBwWDXyBVcaDLUAljp9KvJQW/x3Fcb5M660/y
         hsTJnHljL/rlfWRmSRtAE1KJ9CwWtoLqgxyuYAAFbVcQTCQlIa2JvQ8K7tmjjEk1rPQQ
         x+gAyNmGq0K8WGmNYKNUet3PF8URKluBLYbVqaxV9438GqRiINxGWvotZLtxkDKs/2RZ
         qXZotXgrO/Y/G9Wewwq7QSgpKKrrYoauVWnMhm2Nl/urySoXH2x+D5Lqijh3LPEYs35J
         YD1w==
X-Gm-Message-State: APjAAAUNY/4NZKYfjByxXrgqXcGRD4uHeBZVxKoOfSnvcgY9kMGm+OUf
        hKhXZuPe9nDn8uCjkU55voxllOJRznTHRWIlowl/yw==
X-Google-Smtp-Source: APXvYqwXAhA1+KV2YeA0HMI/AFvAmR6dcXicZUXuc6v3FG609JnY/H64rM/p0aX+SdvhdtnVqFB6IeHudBlSgubI54w=
X-Received: by 2002:a2e:504f:: with SMTP id v15mr36798015ljd.67.1568608797345;
 Sun, 15 Sep 2019 21:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <1568200910-31368-1-git-send-email-sumit.garg@linaro.org> <20190913133057.GD7412@linux.intel.com>
In-Reply-To: <20190913133057.GD7412@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 16 Sep 2019 10:09:45 +0530
Message-ID: <CAFA6WYP3cYM6=sw7pAe_RmiTbxdOLHptPqmk8D=915TLF14Ecw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: asym_tpm: Use common tpm_buf for asymmetric keys
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 at 19:01, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Sep 11, 2019 at 04:51:50PM +0530, Sumit Garg wrote:
> > Switch to utilize common heap based tpm_buf code for TPM based
> > asymmetric keys rather than using stack based tpm_buf code.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Can you roll instead a new version of the whole patch set?

Okay, will send next version of whole patch-set along with this change.

-Sumit

>
> /Jarkko
