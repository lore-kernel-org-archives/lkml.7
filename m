Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EAAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193ED2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaPJMLk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKVM7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:59:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46319 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfKVM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:59:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id a17so5407836lfi.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 04:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8dmnxZ8Ub8Bxc2H8I3mPfzbqfpB7OPPdHaZygHcHFE=;
        b=DaPJMLk8AL1aq2ByFGb2IWSuYlXpiez43Oi25BeBN7wROv9RgVJ815FEIM9S8LtBJZ
         UtonKNOJCNB+rDeRCfVWO5NE1S5bLZRNGDZx5UjRfDgZm2YJuJxWT3yNlrS0LoHq2F9k
         VmT47cxRT8H/xf7AvyCN4gT1bdBoBYAV65OH4MLbzwZBnPytv2hJUwu3qpR9fvPqCcFS
         42q0IyZgsuI1qoYCQAr18hOe6tsMEwOYuN6ucIdogf/4horoUpS9E6Gyl91z//4QGT81
         7TaGOV1qU8P3so2gBU0fMgkq3aA5Sjpa17HQ6ejQ77o4kRSxZAXUcPe5NBsEVnvbzrEy
         lyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8dmnxZ8Ub8Bxc2H8I3mPfzbqfpB7OPPdHaZygHcHFE=;
        b=kJfyBqu8CbIhukUr6ji+slETTxjFudM7kgohQ+B7xAVjmQgyzWFtqfuEcEvn8lZHos
         I3yHXacuuoH1QZRDqgwHMCE5nZuMRx/WlnVq5ek/P4G+P8YF+Fru7oVEHbm8yJ33OvL2
         Wn7oA2dPUGGQXT1TNh3rS2hyFgG0kekhT29U9tX7pu6q9/URnf4SrA6Ry8aBGrEPDC/d
         FnS5JAQiRnQk+TqWSo/UheYBZ2KZbbsHSYTD2MmYV+hJaDImVAvVeUS/P2q+IyF609Aa
         YfRasis/CqG0ynzkNnZGuM8ijqyxT4VL4UFf2QiaKOQZY883PxxNhyq3y2KsrwcVD1Ui
         6pwA==
X-Gm-Message-State: APjAAAUCN8lrNRYgnx62mBR9BAPQEVoSyk1rVT5yusvBf9tbMmFMP1z0
        Pit9rErnRqZ8DRKRPtLKNfwmWdgd/HWsXM2EOd0aoQ==
X-Google-Smtp-Source: APXvYqwYz+6QGdIRe/6VX6sUO09vd4ONwLVaGPGso7wwY07jjid5xDn5gxKiF4dN+YxhEi01937w3jc/iLYs/k5FSsM=
X-Received: by 2002:ac2:5b86:: with SMTP id o6mr11970188lfn.44.1574427586437;
 Fri, 22 Nov 2019 04:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20191122034702.58563-1-dwlsalmeida@gmail.com>
In-Reply-To: <20191122034702.58563-1-dwlsalmeida@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 13:59:33 +0100
Message-ID: <CACRpkdbaDEmZ4JCnWGinVVjzbVB=efTjMSTa+mrzuuaK_sCqmw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: driver.rst: Fix warnings
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 4:55 AM Daniel W. S. Almeida
<dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
>
> Fix warnings due to incorrect rst markup. Also improved the presentation
> a little without changing the underlying content.
>
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Thanks a lot, patch applied!

Yours,
Linus Walleij
