Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F53FC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0388421A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2BT52Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfJCK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:28:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44145 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfJCK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:28:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so2310144wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8A0SaEYYe0J2Jik12kIYDJK29NXY+H6u1d3B57ETVtU=;
        b=b2BT52Hp4jqhRvrAAbkSJwgl3k/crr/1cyvLfQmF8o178ZBQZD0srr8mKn6LyCuQwo
         F6I7lNHhkeYyp3Z/e7UXU0qSmsD2FoOe0zZ8QrRe8MNEqRnZgARvAq6pzTFj8nIOMHS7
         pW3ylXfbZsTieEyJzX6780I6YGT+38ccKJypTtKlnT7UsZR5SJQu9oVvhDQYA7dSlU4D
         3ww5GhcNMkEosTczmqkNNwWw6/DqKLG+afojn1q0gETScKVbBABjNODWLryU6yjTVcKE
         Frdr3QT+TrMdmDW0V1bki1i/VqP2++yXCiTqtxFkL6TQBQAmSXbrwtloO4oxlOGRRLF/
         jW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8A0SaEYYe0J2Jik12kIYDJK29NXY+H6u1d3B57ETVtU=;
        b=o66XxFP6LrDy3aViBYue6bT2YLPgjpk4zgNooN+HQIMXumv3cVRf7YwepT/ZQa20mw
         LuovWLyRLTfymWh/UTxeVe3+aTnkr3jmQ/9e4MtKsX1j6TCn7B3VlXzGDKv8HGHXJzZW
         8c+macybOt9IWmxgtChWSTAi5y9smbN9+A88iKpiLemwJ1viZ9YEoNQbr4JOBEshUXv9
         dBlXLyKvCKmw+Orb1yCjvb2ZIG94iKPX6B8cV33fbaV4U9rv/kjIqsYpx2e+0s0zwX5k
         YKWoSbPxNJu4S9iptMFwpZVRULLQTlkLjzs6Q3z6WeV5zN3RZRrh4SEe9qCFcAFlpX4W
         zNnQ==
X-Gm-Message-State: APjAAAWCuoeSQSswAVfaXyxrXwvZfC6bY2RbZrkUXQUN8v/uaPgWY7Wo
        qA06mTUVqRZkCSPV5o95ipEDo2/2o1w=
X-Google-Smtp-Source: APXvYqxbnqYYFrgiX8wxlXj6DtHm6R9O9KqBlknamHm+7r9SOjdm3CHXdDjccGSLPMvVjP428rGflA==
X-Received: by 2002:a5d:67c3:: with SMTP id n3mr6031099wrw.294.1570098491906;
        Thu, 03 Oct 2019 03:28:11 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id x16sm1962479wrl.32.2019.10.03.03.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 03:28:11 -0700 (PDT)
Date:   Thu, 3 Oct 2019 11:28:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] sh: kgdb: fix an implicit fallthrough warning
Message-ID: <20191003102809.ymtwu33ouzipyecz@holly.lan>
References: <20191002154756.18924-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002154756.18924-1-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:47:56PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The switch case in arch/sh/kernel/kgdb.c can fallthrough. Add an
> appropriate comment.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  arch/sh/kernel/kgdb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
> index 6d61f8cf4c13..0d5f3c9d52f3 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -266,6 +266,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
>  		ptr = &remcomInBuffer[1];
>  		if (kgdb_hex2long(&ptr, &addr))
>  			linux_regs->pc = addr;
> +		/* fallthrough */
>  	case 'D':
>  	case 'k':
>  		atomic_set(&kgdb_cpu_doing_single_step, -1);
> -- 
> 2.23.0
> 
