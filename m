Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2094AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F80218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 12:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MblQ3f6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404860AbfIIMQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:16:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46828 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404838AbfIIMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:16:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so12441778ljf.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cptlCQ347g/R/oxFT9VOf0f0wPB+y+T4B6Ay9zWG1MM=;
        b=MblQ3f6qW8Sm1i8qW5NiNRMcPRzExDnVXKJHg5yOSUTVndoGnT1tby42vpbVpfyE7G
         AQVWXL9lD++XGK8XR177xahdz2UHQDZofcLU/PUv3KhoVX+FuVrjchvCfR5RtY42uULZ
         5LY0Hcx1yA0GCi2UxUZY1bRnkswW0rvRCClufMtWBl0o+iHVlJOhr5XJB8pVZTHYx40a
         wLbUHwey6zm7dpGAF+5SRgS7NOvff4uY1Hu0d1fDHfLYJ6pvF4jERFChMR2orzktwJUY
         xHlBQGYUZ1ZkQFgZSjkVYeKk9GAENJMZFcfE/SzFyZQPyTUbvu/JQgVJDlpJLJMLsBmF
         0CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cptlCQ347g/R/oxFT9VOf0f0wPB+y+T4B6Ay9zWG1MM=;
        b=bhT20Ad7K9jDl0bXLo63aLKvT8Bhqk3MxJ4YAraQfjIJf2QBlH37TEYRC+qo75KRHV
         B0yRFdZPp4aomgdaZFxyF/S2KG+vtmX+6qmAhVvZTLDW+0VoGc+yH6zxYCDpMuyBf/eR
         V10wiFMY0/jQQzYeCzv4zll6iJ4mxYDBIyVHzCTHoBcMvOCVgpifHftH4rTpX4W72x5A
         MtPXYjW1TcgxWxbWt2xSI75bgKdKbvV/998eG52O7Eq8/VEypgpadJV9ylV6lPqYvwrC
         dEMWtSfRnfSkjvPGLkfNIJBePfRL9x3rDvMIsqLcAgouyP+vC0XWK7ArdFsjy6Gr9eSJ
         9mZg==
X-Gm-Message-State: APjAAAWGTyOEGjodhxdGiWqMJC5KDpEKbsAVj17iupsc4DogREwaymTW
        J7hplKsKcaolpK74E1eBUAK8GEFjxdjMfsvRV4+0Qg==
X-Google-Smtp-Source: APXvYqxD1HgwI3Ux3FuXQczreEPhWMnP1kFxwAJJ1OlX8aR2HqW3YVNGQT2/PewJjfBPRtyq5gXk7bMF6Sf+iQA1sgc=
X-Received: by 2002:a2e:8091:: with SMTP id i17mr9692244ljg.13.1568031415705;
 Mon, 09 Sep 2019 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567740135.git.baolin.wang@linaro.org> <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
 <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com>
In-Reply-To: <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 9 Sep 2019 20:16:43 +0800
Message-ID: <CAMz4kuKsk7ZN2BnD4zp53PQE22jD-BTsJLL53SL3ndZ5=OCHYA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: Add virtual command queue support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 9 Sep 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/09/19 6:52 AM, Baolin Wang wrote:
> > Now the MMC read/write stack will always wait for previous request is
> > completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> > or queue a work to complete request, that will bring context switching
> > overhead, especially for high I/O per second rates, to affect the IO
> > performance.
> >
> > Thus this patch introduces virtual command queue interface, which is
> > similar with the hardware command queue engine's idea, that can remove
> > the context switching.
>
> CQHCI is a hardware interface for eMMC's that support command queuing.  What
> you are doing is a software issue queue, unrelated to CQHCI.  I think you

Yes.

> should avoid all reference to CQHCI i.e. call it something else.

Since its process is similar with CQHCI and re-use the CQHCI's
interfaces, I called it virtual command queue. I am not sure what else
name is better, any thoughts? VCQHCI? Thanks.

--
Baolin Wang
Best Regards
