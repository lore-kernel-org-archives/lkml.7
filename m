Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F042067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNbvNUtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfHEJJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:09:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34415 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:09:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so50086139lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=we40PSHlZcOxSoyjGnWbnysPRh2RslKgTYfYTrx4ljQ=;
        b=pNbvNUtKF/9q9ltk2TsL3NqSOiSv19d2QktmuQeuUXUC7lk8q7NT3e/mPI5qMWp5yS
         xKRloHAisfxOxleeUi9WMo/LZPyMSiAWaQR4uHPmwbllv9vi8qEzGVfs9Y65ON1ef8/M
         B6sWo+42hoSa4T016XMsu0ihzA4pK4Q2jNtgRPtKNQjyxtf7NrIsV6jPbTk1XNFLolmy
         pkS9HkIbYtlgBjvVWRde0IDfyj0NyekwW+s1xM8Wfe50LMsnwTczu7Y3PqWtDy1PT67H
         B0jfFUAEQ0/ALtZ7mTS5jR7W43SKoCnPgoO1JiU27kNeDKd0k8Gx/hZlrhXPXtG+n2zr
         JbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=we40PSHlZcOxSoyjGnWbnysPRh2RslKgTYfYTrx4ljQ=;
        b=BE9no7T+BTCef1p9pQLzT/sxHh4oQXZTX1p/6XFh9CJeGk/jGxmBhecKCWLpx+rhiH
         qty7RXmfjGVbjFYp6MH9A+qK5ng1LTB0CeNldpubjEWUPCbOPzz3XfZdEq/aoCPK4XLY
         pCS9NsMAgJ6f5/AIKW9iFoCsGSor/3FSw7UVW6voxua0e9r9JNEjYujLhl0ZfmEZtPsr
         qk9YMqaC/FhkwyNwGl7FzYRi5G4CFV3T6UflN33TM7HOEDbhXy7fWAwzF26ti7yeT03R
         T0AZId4Re6TkKs8cgRFSN7RblnvTt1wZC9kB9UekvxvpwrwZcCBrLfzWYRIvKazIBtpK
         7lGg==
X-Gm-Message-State: APjAAAWeL2b9i3hYUWttnIU180Q+Ygn6XwrqSsVXwLrbdZrs3YKiP9G+
        3I2n5wKsVz2Kj6kGk6IWoYdXQJLaPdl27TdXeH12yg==
X-Google-Smtp-Source: APXvYqz6lz5lL4sC3NkfmrYMnYZuD0za5lS2pQ5bSuHLV78yA7wTNHy4EMHe2DRNqzlOvex1FYZgczgR6TP9x508tKs=
X-Received: by 2002:ac2:5939:: with SMTP id v25mr1192804lfi.115.1564996172018;
 Mon, 05 Aug 2019 02:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190720115858.7015-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190720115858.7015-1-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 11:09:20 +0200
Message-ID: <CACRpkdYFAKFniNOUG9Gbw-mrO=WsC8+8n1wQEgqTpVK-N0cbCg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-single: add header include guard
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 1:59 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Add a header include guard just in case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
