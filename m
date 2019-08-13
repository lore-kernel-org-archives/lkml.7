Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F878C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkZXLCWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfHMIyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:54:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36461 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHMIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:54:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so5854312ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/NjDHCBpNI3hTJvACxzfGuX2r0xk5dG/sv+AEvcJ7A=;
        b=gkZXLCWkhjhC/5Lmktp4rggT4C6E0LPBwrZKBVvaXiVXxRFx9HFppSXsslq67fs5WB
         XNx8VxnNJrc2WJwNoMJdm4UpFqhLVQhnQHSqkGmnOncQR/AD9PK7acOBJG5R/L1j7EQ7
         BbkfyN9ETUiohOpnhbk1DvSENYmp50pUggggJiYMHMLYKWODQf+I7yzSkLTREFXGR9K0
         nsjOatCJdmvzRktGC0T6PQvVrTEf+Ri3VFMQdtmO/vABf4oXFqwpAeHvPh4CS+tq2lJb
         +tqVGk1pqEEERIZ7dGBprSh7bLSlostsK/7SVS44/ME6AtuP4w0o5BpMqcj++UVe+l04
         6h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/NjDHCBpNI3hTJvACxzfGuX2r0xk5dG/sv+AEvcJ7A=;
        b=JgbxXuu/WEIZ1MwUn55F+HawN65xZ7RMb0mgmIAlBFSNMx/ezV06Lv73DxX47uUQnC
         BjiCuKX6+rCfoo5+j9br55N02QQIafeo74CZga/xtyLhDkuC3hmdVy+SkaoTkjZH6Vxh
         7wM8/3vcuB1aS6IPDQLXSOLK40HkJxltJQybEvkuPZQFifUjfIPLqgnMgrk99+WYQPFS
         6sZ32Y70/XGph2sXbyBGx9cRy3AQU/jsLUSO8fj3lFO/9Kxe8sBoJ79RiLa0jlS3TPXk
         F7mK4hHyRdQfY2WEXT4Yy3z1zG6DHK8pms2n8Bg5MwaMiqnsusvmHzmZdaVJYem34ccZ
         WOww==
X-Gm-Message-State: APjAAAUqCz7j209xD0RM2RcVFBZIdaYkhCiGAvD7pUdVOYXLhF+z2zTE
        nsFVcNqSGUWsoy1uTMWDNd/XeiRiGESc6tlqUclgA+a3vds=
X-Google-Smtp-Source: APXvYqzNUJF+d1XDwgYxjEbgL9UQ/nw8H1K68K4k/nmhFRTUbn/REEdAzOZ0fxRXpAWLugosAYWf9uwKnRePvW4bqkI=
X-Received: by 2002:a2e:810b:: with SMTP id d11mr2047486ljg.62.1565686485396;
 Tue, 13 Aug 2019 01:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com> <20190813061547.17847-1-efremov@linux.com>
In-Reply-To: <20190813061547.17847-1-efremov@linux.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Aug 2019 10:54:33 +0200
Message-ID: <CACRpkdaAE6RA1iQ-iqK3GGHOovTkuDDqi8vcoFnmG8UBwuim8w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove FMC subsystem
To:     Denis Efremov <efremov@linux.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@cern.ch>,
        Pat Riehecky <riehecky@fnal.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 8:15 AM Denis Efremov <efremov@linux.com> wrote:

> Cleanup MAINTAINERS from FMC record since the subsystem was removed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Federico Vaga <federico.vaga@cern.ch>
> Cc: Pat Riehecky <riehecky@fnal.gov>
> Fixes: 6a80b30086b8 ("fmc: Delete the FMC subsystem")
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Do you need help to merge the patch? I can take it in the
GPIO tree since the subsystem was removed there.

Yours,
Linus Walleij
