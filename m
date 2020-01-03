Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DBB222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fhl9YzW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgACKhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:37:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43057 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgACKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:37:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so31622606lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 02:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e1VONZKN47Aw6juCyL/A73XM5IVvw0+2i1dyfWe9MK0=;
        b=Fhl9YzW8WppJUvDeZdTMGR1XJqmcB6TalG0n7A8zpD55tcqk3ML1vD6zvcmuxMEiQS
         aT5bysK5rQU40UUINDSUm9VXpexB7r1N/CBSFppsXxncAFIyO0y2rkiWeb95HnpwU3IN
         0OyoAH/9qybXFmig7BIO5hERgIp6aWsfDUveXBk1xf5e3kmMhvOtRrwJwpl/IEoEHiJa
         d2HaGR9FrrRj3OKs6DFpK0iYP8fizuP7vdWE0hveGhMePxt+yPI2xRhylVrBmYq5qkRk
         GTHPLMbmpnmvSWkgTOXesoO4IbicDCKbkhCuBYXkOXwcVaspOhnAevfABvK7W6xCICJc
         xsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e1VONZKN47Aw6juCyL/A73XM5IVvw0+2i1dyfWe9MK0=;
        b=CKlF+BxFQJK5e4YXZQuc6teuF1qgvDDb9Imkt5D9NrZYQVKnK8Q+r5DqTtuk5y29wH
         Mmmd9xseNLDjhkifoAQKAxIom0iQ7fbvzHdD8wwpgvkKx0lQtuOTFaPgp5/KJg0Crr1Y
         l4IOVPFut00Nx1JT3F8JjFDBsutVnh2NZNBYG/eVjTNN6Uc3U3CulzDrYmDXHtB+lV2l
         4FfRHRQtXXRv5N1pFhTDdEfTXTv4l3KXZdr0kLXNxjI21oWNmUuSAGfPy8VIboeP6fHU
         zCvmhq+DSBmccLOwMCd4EkbgN0bULheX27gB+DmlbSP0JffudfxaHzjUkwxcFvnIOnLB
         AFSw==
X-Gm-Message-State: APjAAAVUa4tLw9huyhmVv+MtLR/DiecjEemvb9USVyaMQPNlUNCD+Gp/
        8oURwp5kf8ODxmngN1838fcyuQ==
X-Google-Smtp-Source: APXvYqzeu11NzT4u0LYNO6/ynfbsLDH+8fwoOKEZ4tO/YtRCEUnX2yjqO7toLdDd2ZT8V37uMiM2aQ==
X-Received: by 2002:ac2:508e:: with SMTP id f14mr46097583lfm.72.1578047832449;
        Fri, 03 Jan 2020 02:37:12 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id b22sm15891942lji.99.2020.01.03.02.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 02:37:11 -0800 (PST)
Date:   Fri, 3 Jan 2020 11:37:10 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org
Subject: [GIT PULL] optee driver fix for v5.5
Message-ID: <20200103103710.GA3469@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix for kernel allocated dynamic shared
memory.

Thanks,
Jens

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-optee-fix-for-5.5

for you to fetch changes up to 5a769f6ff439cedc547395a6dc78faa26108f741:

  optee: Fix multi page dynamic shm pool alloc (2020-01-03 11:21:12 +0100)

----------------------------------------------------------------
Fix OP-TEE multi page dynamic shm pool alloc

----------------------------------------------------------------
Sumit Garg (1):
      optee: Fix multi page dynamic shm pool alloc

 drivers/tee/optee/shm_pool.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)
