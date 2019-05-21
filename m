Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02DAC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9814520856
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMTHaU+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfEUSkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:40:45 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:37573 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:40:45 -0400
Received: by mail-ua1-f54.google.com with SMTP id t18so7003121uar.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2+tv+y1o8dBk5cC3wMn4pe61w3NNgSIr6Vgz49bBOZc=;
        b=uMTHaU+nO1fyXF17yaLqfbzq2tUqIwa56+SC2isNEGdGhobva1c/DvWl8FqMip9KUk
         sHMJERBsNJFgzbYwHNbV9J7d5nQiuQcOxA7I0hVjpR3fvjHx4if3u6invBsnPtSoDb/D
         O+WCzp8IcT35Fxrf9Y/T0bMMC4rJ32wwRRxxxpg7s7mkSJjrhj3Up9XOmyXy9ZNwdYRC
         IZmUgcrVQUTIyTVh1qgh61qO1DuHWWkVTZsPDjGaHhrvPaCoGRVDz1XmZzOj0Nf4jrd/
         Tefs7JmXbD5vsFDDdAbsIdAc7utp2RvVlVtdSDQ1jSuvl181+erafKbpwfvZAVbsKhFJ
         /6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2+tv+y1o8dBk5cC3wMn4pe61w3NNgSIr6Vgz49bBOZc=;
        b=p+3fzJQR1JMgTiwNeOnVOhLwl4ZTDvm8AHNRH/LMlmM7LYsA3QmH1tMZ2GeVu5R7vd
         ii42DnFg2zVodgGruYRDprSUe8uBfBQThKK8xLekDX4XCVPLP3CghamHr06KvgUzsQMQ
         3fd57X+tz8hV9N7Ten3LjdB2zLOewx2Xy8hYTQfJS6U+irQLTKW5SwOaNDvt+HGM0Imd
         Cutd5vlV1wh5ubGbY0KaJ7REyhAcMpQDyqBVZsrVTouxw8ElIyasfUlhbszVt7D1Nily
         fH+OxzDkzNf9h0pP7gzV5HzkEtJcZewT3haL599Kx66End1XE5RFOcjRfaU2ACbaSiQH
         GGoQ==
X-Gm-Message-State: APjAAAVWeDMBthuUTPPAbCmOxut8FZ0CKlAjQPJxS8gntXWKrpIAllFR
        icN8/USPZu5bDmQ9DjJBo3B+LG0tcfgh3ffcTHSZ8g==
X-Google-Smtp-Source: APXvYqznRmNxF5T0UZr4kNxatVC0iC4FHSs5B8j2YnlwrOaasVjY9yEgIj9iWTApqQbQdqEg1zW/z+CzI6sCKitybvI=
X-Received: by 2002:ab0:413:: with SMTP id 19mr35464397uav.93.1558464044213;
 Tue, 21 May 2019 11:40:44 -0700 (PDT)
MIME-Version: 1.0
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 21 May 2019 14:40:49 -0400
Message-ID: <CAOGqxeWTh0NJ177cH5a4ph-W49pFehjdEcVv+SLm__TiHJc_aQ@mail.gmail.com>
Subject: Generic PHY "unload" crash
To:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing an issue on a system where I have a generic PHY that is
used by a USB XHCI driver. The XHCI driver does the phy_init() in
probe and the phy_exit() in remove. The problem happens when I use
sysfs to "unload" the PHY driver before doing an unload of the XHCI
driver. This is a result of the XHCI driver calling into the PHY
driver's phy_exit routine after it's been removed. It seems like this
issue will exist for other PHY provider/user pairs and I don't see an
easy solution. I was wondering if anyone had any suggestions on how to
solve this problem.

Al
