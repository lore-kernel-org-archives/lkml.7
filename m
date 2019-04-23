Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D5221738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEROPevX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfDWLK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:10:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44399 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:10:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id h16so559243ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfAIdLMDWSDX6aLBS5HuPc4uMhQv0DH4U9PzfmTjZmI=;
        b=aEROPevXrc9Jm+WRwZxIpdsVhV7Ccq+pqEL7zzibRLPxdMeAmzZGHbXN3qgycs1U4B
         PrqFeX/+ckvX/qBSxobvM6C8IS9Rqo+dRsfzOmvffzoUFqJNUc7oIBwaGPenV1pReGtA
         gLJ8LQll9n0TS7/cWci87yIRe1vIxw3J5tgpuc7wtsykHPaPh3QL6+GBgY2/mDC6PVax
         HxBetBVqyNV9sno7BpXXpuS0zNYfUb+mwnh+0jjyL2YQyi/zKi0M0ToTpLMfYAo1M8hG
         MTudeNUSx5YxQsCMY+Apfmw8JnGLFFeVqnQdv3+EDgWCxKf5livsfbAsvBynbjKh7QT9
         DKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfAIdLMDWSDX6aLBS5HuPc4uMhQv0DH4U9PzfmTjZmI=;
        b=aGAvICRPlm3qnjMbdVdYRLBud4bDWRiPv9QHTmyf3vEjOGkM7gCggEfdD0JDrmtFfu
         reFcvtpSryBXN+e6G/zJSmb3HfBKs3y583VWUicClacnxtbJQM9qtLtp8D6Mu85KTJ0h
         u3hkoWXf9gGIL3RRIYfzqQs+stIM44B+RRJvX2b8VeEcWTxvhSbS6XA8IF0jGZit5rUk
         pZyTm7QJauHI2kzHibKv5mort4D+RMZLiMYRyxNbhU9wZ+IRcvhrG95iuo+IqpH2uMjE
         kHqHj+qk0zN3PMMtSpUcxCQMy2vxuQpDZ7OOxiSa2gbvrEl8iLVjWigjcogI8VcjyyMz
         KFyg==
X-Gm-Message-State: APjAAAVU9b+6NcoW8KXu8CA63Ir2eaIlKyUY+CNzDF8Gl/zbwvzEkgCc
        0CrB2Cf++34njDMqRGpBJA2TbrcAeKS88fs4NNHXgw==
X-Google-Smtp-Source: APXvYqyC+G3qHyRXLy8XyebiPC5xjY5Wj7HuF9fNtorT8sWQjg/FS46BpdwDaYfW4xfeWp6Ay3rq8gqB8RGOAMczjCM=
X-Received: by 2002:a2e:834d:: with SMTP id l13mr13720989ljh.97.1556017855817;
 Tue, 23 Apr 2019 04:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555579429.git.jan.kiszka@siemens.com> <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
In-Reply-To: <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:10:42 +0200
Message-ID: <CACRpkdbAmtnZez_hYEU=bKDOKDVr5V11cmBeXQ-2JAnxrpeTqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:23 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Validated on the Quark platform, this adds interrupt support on rising
> and/or falling edges.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Since this utilizes ACPI I'd like Andy and/or Mika to say something about
it before I merge it. I don't know how ACPI irqchips are supposed to
be instantiated.

Yours,
Linus Walleij
