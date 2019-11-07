Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836F3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E4C206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iIUnznkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKGS2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:28:47 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37756 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGS2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:28:46 -0500
Received: by mail-il1-f196.google.com with SMTP id s5so2724437iln.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVsX0plG7kWfm3P02pO+fo14WiW2OYmEjfrTlpA57Kk=;
        b=iIUnznkQM8+LTZslY51nCW+B88zOyii4j14WdIukoWImRfz8QKMRl33QBS49coSy4M
         YmmT9hBqoki7nZGhBLwF60dc4nTY95dXha4rWOLQWT6Hf9fGLbA1hXIdfT/MY0zXlD0h
         aPdFGp7drvTMApV7XE68Sv4+ukcrjoEKvPymyJvsXdk5G82ItFK2bVD7HDHKJmx63rxd
         7VPNwO7yB2QyPxvT5ouXo1caxbPj58Anhx8gWqhX4xWuyXgybVcqHDOFRhHFa/5pHwhW
         M03JmXaHa9M+GMHZtPymEXj7x+4pNNw84Hhz7ZA4ZCapH5R35lUsz9tpfrZ/0g/3FTIU
         ehUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVsX0plG7kWfm3P02pO+fo14WiW2OYmEjfrTlpA57Kk=;
        b=sV34+rtK4sxjsa1lwmo5zogROJQYW9CSFzy7DypvoqY05g/sI0JGtPdavw3qzEgrTg
         wikmUyLx0dA3OPZ5yDk+AOAcTksH5PLC0V9vMecw8VSBqgRzjrfHhqLsJ9LbTLWSaGKa
         ZixEDuJMezAOFCchINWu7VmNPMGvc8l0MVqIjLRTAcPAHbHhwBRdnbvGsu3A7lWXkF7I
         KFDVPIx/mQUVavJ+NmX5XUFq/ZyO/nRRt9hyhlCwGCKz4u9kmwnZHDB/q3DxoNYenRTb
         wvZOQLAhAv/tsTru6DUC0IVKZ+23U2WseTgnmVhNGii6fnHAdPW4gjrh5KEaYpNE5020
         yhTA==
X-Gm-Message-State: APjAAAXEeCsWSFSMt39cQQ3RuB3i8IeUwQXIiMfNfe6VE+PYvOasno8G
        q2vQGZQEj8swmNUDcMUuGZUyH6l1SJ8o7VGzU2twlg==
X-Google-Smtp-Source: APXvYqxuwrk3iVRkNJTertThk+4YK/U7XV1cVay4/cEzR5BLoIUVQPSOkQbwZsIHWnjkWHUNQMQerInq1AfEEEQ7Pg8=
X-Received: by 2002:a92:1b1c:: with SMTP id b28mr5944903ilb.278.1573151325737;
 Thu, 07 Nov 2019 10:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20191107121159.GA9301@jax> <20191107161644.GA8304@jax>
In-Reply-To: <20191107161644.GA8304@jax>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 7 Nov 2019 10:28:34 -0800
Message-ID: <CAOesGMjO5qsueUkmdJWpKtxzza7NNa7HGWo7N8nmTmdyaV6Shg@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys fixes for v5.4
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     ARM-SoC Maintainers <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:16 AM Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Thu, Nov 07, 2019 at 01:11:59PM +0100, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull these OP-TEE driver fixes. There's one user-after-free issue if
> > in the error handling path when the OP-TEE driver is initializing. There's
> > also one fix to to register dynamically allocated shared memory needed by
> > kernel clients communicating with secure world via memory references.
> >
> > If you think it's too late for v5.4 please queue it for v5.5 instead.
>
> Please ignore this pull request.
>
> "tee: optee: Fix dynamic shm pool allocations" is not good without other
> patches, which are not included here.
>
> Sorry about the mess.

No worries.


-Olof
