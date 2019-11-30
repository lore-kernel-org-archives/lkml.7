Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45845C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B8C20880
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1ABPsjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfK3XBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:01:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33477 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3XBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:01:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so4030107ljr.0;
        Sat, 30 Nov 2019 15:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Whzdku0abQpHBeeiCCZ3/aENDMafY9GI5DWjx/0lTkI=;
        b=t1ABPsjUqCFayQUQ/mh4goARt5Cu4TxJ5iOeoPNSmlOc9/ayXPGSezb3QxxLYbZOZ2
         yMqwEfo7sSI8jvnug83X/HEPthLQytSCjZNr/wu+dgb6JmuE/P0KHo9HoW/Py5FbAZSJ
         aBUTBzIuqUOPubJ4muv0jSS40wmK/ZrtkZMRWytmIjo8/vAn/AYw+Qyh9aTcH9qcnqQm
         lnc/C0V1I+0xpsG5BFwJAj4nsee4+ZQvo9Rs0cC66i8/HjYvt6f4eozeYfq6DYpC7r7d
         2ThZEYamDDVRT8Cn4PjWdetgizSd6yp8/HR4AaWDsFfyD7ci37wAN4sUa5UFbtXgdjqG
         DJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Whzdku0abQpHBeeiCCZ3/aENDMafY9GI5DWjx/0lTkI=;
        b=mEdhVEIyFbKmOt8FBVXSuUqCEgzeT7EYAp4ob7fBa55CtAYlEn54IuuQJbi/IbDoiy
         YEtlohlVopGpQlwgEJms+E5AlUC4SBP+rp8wnFiqg9bySNPRSOmk5tshksGKHYExpDPu
         pwtZGIwDVh4MaN4XqRxd4UnYE0/DqeYiR/7WkmLq6knF1RdGiIjYWJXnvxatC6y4edqM
         W5r/9QKRBEDoEbmch8VnRPo07Ol5fasfugxX8+Km3qDQ1hiIEq1t2SLLiMgl30UYwoYC
         ZfmivojcOrSwIXXC9G23ath3kgGh5jt+PGi90YcqKjWnAHWGg/VJzHemx/ndLZ4bsz/F
         qSMA==
X-Gm-Message-State: APjAAAUirqOjLAz8kg3A3bAZe0g1vC57wij3qJxHbVUojfC/PNLkah3X
        4hVYeWgm+sO1UJmlx3aCxdSJV3JI4hCXkgDuZmI=
X-Google-Smtp-Source: APXvYqwpO7e0hF0+Fk+TswWaGZIR50uVZZ3aI7Cg2frtlXcVMJ+36DwkMSSrB21yv88n1w1i2QPqtn6Vcp3q5WFrJUg=
X-Received: by 2002:a2e:b5ac:: with SMTP id f12mr3379147ljn.0.1575154895735;
 Sat, 30 Nov 2019 15:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20191129234108.12732-1-aford173@gmail.com> <20191129234108.12732-2-aford173@gmail.com>
 <CAOMZO5AyLBrsxr5rqkWgf44X0CQdqHcdaCLRaWLC25b18bF+xw@mail.gmail.com>
 <CAOMZO5ALQQxoWFC9J5ZwT6DtsuVg-FaWCcGbcPK=psokWWRF8Q@mail.gmail.com> <CAHCN7x+zJt3i=Yw=2HjdtQa-rR4yMMvCMf319+wgMW0XQ=nF4g@mail.gmail.com>
In-Reply-To: <CAHCN7x+zJt3i=Yw=2HjdtQa-rR4yMMvCMf319+wgMW0XQ=nF4g@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 30 Nov 2019 20:01:50 -0300
Message-ID: <CAOMZO5Czqqe0p1LEWt11S-zXnejg_9Zob5wPf2Df5ZJh2dT0qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: Add GPC Support
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 7:50 PM Adam Ford <aford173@gmail.com> wrote:

> I held off intentionally because of all the txt->yaml conversion, I
> didn't want to get stuck in the middle of that.
>
> Would an tweak to the txt file be accepted?

Yes, a patch to the existing txt binding should be fine.
