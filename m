Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA16C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702C52133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="im4ZvNR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfEWWqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:46:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44795 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfEWWqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:46:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so4038493pfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=bSUD2fNaAes828k1NfeXU6R4ey1jleoAHiCdbcHLoSw=;
        b=im4ZvNR1HNMngqTyNb/7ztcQ1pTutRDgLwd8yI/cT0leUnw87OlJkIbPiZZdljtljI
         8M23VJUjQ+cM3aXg/fmkRw3FaPJsnPnDEkPYPWmssXJBgxsiCOkfS3bk6Vs5GCVTyoCo
         cdZOBTy6QQ6MprI1A/H7gAFs0JZInLgU6JF68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=bSUD2fNaAes828k1NfeXU6R4ey1jleoAHiCdbcHLoSw=;
        b=pZMYKS+oWuHRx+yDmPPK7vT1KiRqjlFm7kLkSU9iEJj22X63nWCG0+UkI7GC3k6KfQ
         Cg2QuUXGBAxfIZtAo9mqq1+nRpOj9JBWNRWpIGTPZCxqmlYbkq+jUdb0XQxChJUgd2q3
         XyWuDkvyaBFzWcOfJq7S2UJWYQzoPjTxn0VB/eNKV0Hfse3N8546Ftd6fAns6IeJNBDG
         7UqdVeyNK6zCQaVABuE+wxMFSWjlL5BJk07Ib598TPjzAYrKDYkud6mmJ+iGvxRuFiE9
         PNul4X3zlm6OHoMomZFP/DbOONuvA2ckhwtWc8w3DStFsklO1ypyIr3yXTR95oZzlPTN
         c4wQ==
X-Gm-Message-State: APjAAAXUUSuW4ryxu92X4zSBK2OEqGsO3hY1GNiKVGbH7RvgTJyOVG+a
        rpEib0gUVkrHLpU4VZiQQETf7g==
X-Google-Smtp-Source: APXvYqxm+JPvdYDqwjtVcsPwPq8umm8jcgHmTC7ar8EX2czP2X/UcFXwY5DixbWA/DCguDjD6tM39w==
X-Received: by 2002:a63:5c4c:: with SMTP id n12mr102196059pgm.111.1558651565421;
        Thu, 23 May 2019 15:46:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i3sm335222pju.15.2019.05.23.15.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 15:46:04 -0700 (PDT)
Message-ID: <5ce722ac.1c69fb81.b62d2.16d0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190523195313.24701-1-farosas@linux.ibm.com>
References: <20190523195313.24701-1-farosas@linux.ibm.com>
Subject: Re: [PATCH] scripts/gdb: Fix invocation when CONFIG_COMMON_CLK is not set
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jackie Liu <liuyun01@kylinos.cn>
To:     Fabiano Rosas <farosas@linux.ibm.com>, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 23 May 2019 15:46:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabiano Rosas (2019-05-23 12:53:11)
> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/consta=
nts.py.in
> index 1d73083da6cb..2efbec6b6b8d 100644
> --- a/scripts/gdb/linux/constants.py.in
> +++ b/scripts/gdb/linux/constants.py.in
> @@ -40,7 +40,8 @@
>  import gdb
> =20
>  /* linux/clk-provider.h */
> -LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
> +if IS_BUILTIN(CONFIG_COMMON_CLK):
> +    LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
> =20

Why is this LX_GDBPARSED() instead of LX_VALUE()? From what I can tell
it doesn't need to be runtime evaluated, just assigned to something that
is macro expanded by CPP.

We should probably change the clk-provider.h header to export more
things than what it's exporting right now when COMMON_CLK is disabled.
I'm not sure why the whole thing is wrapped in a big ifdef.

Either way

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

