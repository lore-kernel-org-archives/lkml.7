Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB13C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F6F21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/k63lAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfDWLJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:09:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40555 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWLJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:09:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so13100120ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+xe+/fEDCug80Wa7BLTgwvZ5pxEfr9xm1w8A+R/Rfg=;
        b=b/k63lAiWq3yWD1RwBKa9+llfdJrLT1FSea2YEPoASRBPEjiG9rWtZVFFtAU/0W8MT
         eB6IWlS5yz10QXgaFPQ6b7hLjV2mZmiFbrWROp8PPhZYVr3S9M1YnHU41cEcrowGP2p9
         z5Rzk/z4XJ2PsVPDNCR9nQAXu+CBQ+HALX4SFIcieousM6ke6/PGmMlotYhUmfJmoErT
         4JRAZbLvNuS8fbETB964b2Gm8bsF+vUKOAMUcMPTYIxRJWDV3w91xvjzCEmjXLAUH8KW
         nfDiZkaxJhi6TFQDN10fNQofWvI/kuFTDPMw7UcfAJcGSojteIcP6QMJElo4XDj5FHGw
         izhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+xe+/fEDCug80Wa7BLTgwvZ5pxEfr9xm1w8A+R/Rfg=;
        b=kLHIbOOSCvA0VZbdCGf3qHIjXoIL1NxVWYr3lxm/sKluVO19TGdf4qVhUnDtk38x2b
         NuCmIL8P3HGsm0KTgfDQi0bAtu+ty/EEpFyYtzUtjbg8rBQxrZrY75/tGIi1KIN5z7oK
         8LChpmAAe2jsToJDobzd+JRqogZNAlPJBQ9tfpqCxBZpQQGPXGq3YAJMkHpUcU9uZgVh
         Dz3vrjA5puhCYNr8vssP/YAESk5HYjE9QbK2K5jtDDYZ4Z8O/xzTTNTaoxwcaGnwMO9L
         Xt/zpzatQZCEJr6LBBRJwQniHCQamMmE6fkHJXBDGWLRWbhH5B7HdwxRzO3tUzIt2h7j
         ygIA==
X-Gm-Message-State: APjAAAUdRe4omnspxXkRtOuA/XKoxHtI7VUc1IS8j1HKjs72N2cT/oAn
        46JUrwdw/g30RUCssFDh5fAlMY0bde6w0Uh2E4oKdUCV
X-Google-Smtp-Source: APXvYqxrdIKTO1ry75T7Gko61yd6MzBXL4kkTF6NqTW3nzEWWsGpY04U0NFiHrz6sWtNpLOfOe4gFQfm3ruH8mlHd0o=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr3174400ljc.126.1556017752843;
 Tue, 23 Apr 2019 04:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555579429.git.jan.kiszka@siemens.com> <1d2dafa4bfcd485cf28bb8e3a6e169d220edf555.1555579429.git.jan.kiszka@siemens.com>
In-Reply-To: <1d2dafa4bfcd485cf28bb8e3a6e169d220edf555.1555579429.git.jan.kiszka@siemens.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:09:01 +0200
Message-ID: <CACRpkdaTea+++KhhSCGoGq2R3SDkB9Em52WmZF3yxz3GK1EMWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sch: Remove write-only core_base
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:23 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Dead code I see.
Patch applied.

Yours,
Linus Walleij
