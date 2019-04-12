Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B42C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303602084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="JMDuJC+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDLNzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:55:09 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37581 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:55:08 -0400
Received: by mail-wr1-f49.google.com with SMTP id w10so12098273wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WlSf7P3TCH9diLof9U6kqPXIx46YGRD1mPFbiI2xVfg=;
        b=JMDuJC+eckK/q1+Z4Y9PPJE8nP5Ng7/Qgl+GIcD8uvgvv4puM0WVzmX1tpKhEWDXTr
         8wqJ/Y+DgXSnVe1zz2R/ytsGAFqJKSIXtKFYGYKNPnOjhH/lJRRYULznnqvx2jqZZRLY
         he6fZ5Rmi1eYyignSJ2CtfDZynsbBKrOEnVGlWRphMTq4qA1VptIu33zjWuowIYmITfj
         Nb5phhRHZTvFbdYJkEfn92xh1cJ0z3KtnHqgZSs7u3jeXjmgORZdHxGNcXEiudOouvMx
         ByHCxQTkKNdAUTdIJnYpuhHaRaC4PBsJ2ZMPlf/G5r0ej2HMSPOVjkGlH1zeO1cj4xGB
         8wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WlSf7P3TCH9diLof9U6kqPXIx46YGRD1mPFbiI2xVfg=;
        b=BIyhmvEPEG3jPTLGBtKGfSjpKuEJRO7UyjhuNBo2J2URK8ndhzEKMYexpEsoIdrcmF
         cEa0LVFUbiXvcAvfuhv4fjC91lT3XOGC28m4rFbLbMM54+JbbTCflk9vbOhMpJFlV5FO
         b0FGnixqJIeftvfBK7RF4DoDjBuq6NHw3e28TN44MiLaHjGjlogX7kXrdj3+bDj3FT/c
         iPIQ+oJboh1DottgFx9wHGIWxWz/muzN3AubMkcsoeFpwHjk+0SDFoPgOC5lcxGe7HQL
         CLr5s7RxLCXdIBcd4pDBO4KF9nEHEHpQMTXE0/PQ4JLX7+YN4girWtMj/UM2wdMhdLbX
         bL0w==
X-Gm-Message-State: APjAAAWuFizNXo0R7UYUqejPi6rcFJDCX50yJpsFbebsOvbUytlplOhe
        YWCFvXaku2v1qhXzvc1lGZHRNNB6g5CTz176vYAdag==
X-Google-Smtp-Source: APXvYqypW7z3y7+TP0RdWGDojsZQA3l1CDpBKrD6Ccpt3lrq5epp0whZiTCqoxYs/K1nF8X9JbJJC5I43tmIdERrGr8=
X-Received: by 2002:adf:82f0:: with SMTP id 103mr36391369wrc.260.1555077306404;
 Fri, 12 Apr 2019 06:55:06 -0700 (PDT)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Fri, 12 Apr 2019 21:54:55 +0800
Message-ID: <CAFRkauD-nMSSQ7=UFzBbabPsG5UpHz0tFxQLZR6oh81+Kcfv9g@mail.gmail.com>
Subject: regulator: ab8500: Question about AB8505_LDO_USB
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
In ab8500 regulator driver code, I found the AB8505_LDO_USB entry does
not has corresponding entry in ab8505_regulator_match.

ab8505 support is added by below commit:
547f384f33dbd6171607f925ab246e25e315961e regulator: ab8500: add
support for ab8505

For ab8505, I'm wondering if it make sense to remove AB8505_LDO_USB
entry from ab8505_regulator_info?
Since it's not in the ab8505_regulator_match, it won't be registered anyway.
For ab8500, you removed the USB regulator by
41a06aa738ad889cf96f56024ddf84ecf4a18a6f regulator: ab8500: Remove USB regulator
So I'm wondering if AB8505_LDO_USB is similar case.

Or does it make sense to add the corresponding entry to ab8505_regulator_match?

Thanks,
Axel
