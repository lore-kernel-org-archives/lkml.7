Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA69C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B2E2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E1LzayqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDCV3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:29:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35486 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCV3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:29:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so198252ljc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6s2XSSoHOtMVCxpdvmYOOMRlHJOO/ylwJMv5bFtOHMA=;
        b=E1LzayqPbKTJt4VoRrXnaIdXMINVpf80HRQgZP1kUQdvdU7bAlB/aFFoRrYvo/mUMq
         iksafKeRFCJ93zxvoWnEm5XzYsxxPPeAweVa0N/t4Fm3+xGXIWt71y53UTF7Pc5/Du4Y
         jRYgG68oI/LC81Ph5FepenifQnTLYuoeA5Seg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6s2XSSoHOtMVCxpdvmYOOMRlHJOO/ylwJMv5bFtOHMA=;
        b=GaemuvPRtkSG8tmE3Ie3fNzY12/wd2mGK4EvAlietB+8TEjIZMBDAw/QsWk6v2aB+2
         rtTYadi8apaQYniDoqVgwPhPgaqMC0mDHAzXbzUF7/lDNmomEkRwemWUWK+8HjcpHcwW
         jbCXEVvHYfL28dAuBQh6hvzGpNsmNC7vfKAo4W9TqzIJf1Fd+KoVfPPLfSXH+w8fpIUH
         wKOSbFYvTB5gluusGCBYvsH1e9h4eaaZtoKilXGSfitKjNZ+7v9MoC3pkSUzJpBygKhz
         S4eSJcnD63HO1CNJd87hZq+LtO9/U88jpFHBDN2ChGF4/84+flMz0NShfgJ799YtdO1z
         ruKg==
X-Gm-Message-State: APjAAAUszMBYWCyhVDdrGZq1K7ztSgQxd1zTIngdSHQG2EESWqZjOEWi
        uOPwNviS4EqGErwbMjdVLtJvv/PDwf4=
X-Google-Smtp-Source: APXvYqz2mDOa7e1jnLtSSucDTxG3AfSf6G1ReJOOF2ffm4vwV03jylGBUlJEigu/dIWQEKqOw6NRug==
X-Received: by 2002:a2e:2f06:: with SMTP id v6mr1178078ljv.139.1554326658080;
        Wed, 03 Apr 2019 14:24:18 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t23sm3453967ljc.13.2019.04.03.14.24.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 14:24:17 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f23so198643ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:24:17 -0700 (PDT)
X-Received: by 2002:a2e:950:: with SMTP id 77mr1107800ljj.113.1554326656532;
 Wed, 03 Apr 2019 14:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190403210148.77908-1-evgreen@chromium.org>
In-Reply-To: <20190403210148.77908-1-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 3 Apr 2019 14:23:40 -0700
X-Gmail-Original-Message-ID: <CAE=gft5S-jJRAUQsTS1NG2dcSh1Gk7RLJY5UQ7VHf2ZVdsm-8Q@mail.gmail.com>
Message-ID: <CAE=gft5S-jJRAUQsTS1NG2dcSh1Gk7RLJY5UQ7VHf2ZVdsm-8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] platform/chrome: Add support for host sleep event
 command v1
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I missed a piece of Guenter's feedback. Will post a v3 momentarily.

Apologies for the spam.
-Evan
