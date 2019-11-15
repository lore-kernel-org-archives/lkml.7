Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC05C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2393C20731
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 04:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573792584;
	bh=MPH8c5t2q8tDKDcSoX1E0hyx3wDVfXgAkaiLLTOUl9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xb3HViVEj02e14X26zVT4ZSDCjse6c3t0azlhq7rPTENTOkjX2SAz4Rj69Chzd9sC
	 UMcljMjUkPmqAa2K2RgBn6iBMbl13XTGdY56PGSTZ7OCg5r2j/ypH6puQdqdaASNCK
	 xiu7zh+JV+pi0TzvHRizIMiP7OVNck2Ve15FTNZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKOEgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 23:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKOEgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:36:22 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB0B20728;
        Fri, 15 Nov 2019 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573792582;
        bh=MPH8c5t2q8tDKDcSoX1E0hyx3wDVfXgAkaiLLTOUl9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZjZudCcCLdf/g3NWLZHBvRh82XdZnMk7eJ22sQiOlw7tmajsXZKqdyDAe98emgwvY
         6nwvYvjTKteew+ll87yWHPn1c4j5ZnjfE9a9TggXJ8gjIhD6YjphSF3VjD6dWrKRdo
         PqU3R7d1u6K3zfYsHYrO7wKOKe9dIj3mDw5EZhWs=
Received: by mail-qt1-f176.google.com with SMTP id o11so9461494qtr.11;
        Thu, 14 Nov 2019 20:36:22 -0800 (PST)
X-Gm-Message-State: APjAAAWHacYoBURMDpgT1Ex/WdHh0MfqsyI5QQZ3tevfOt11LsE586t1
        AR53wt8OMxh6k+LvdtD5RCORZE4d9bZTW1kCv7I=
X-Google-Smtp-Source: APXvYqyEVfUJcKNuJBdUvGkZuJhPdcKZNhu5NkZlypIG9JAM/A9WKKwqK8Q92zF/Y3Kh5IOc/QoPwWQgkR3S7XljIAA=
X-Received: by 2002:ac8:1858:: with SMTP id n24mr11375005qtk.334.1573792581301;
 Thu, 14 Nov 2019 20:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <20191108130123.6839-47-linux@rasmusvillemoes.dk>
In-Reply-To: <20191108130123.6839-47-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Date:   Thu, 14 Nov 2019 22:35:43 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUX2cZfaQTkBdNrwD=jT2399rZzRFtDj6vNa==9Bmkh5A@mail.gmail.com>
Message-ID: <CAOZdJXUX2cZfaQTkBdNrwD=jT2399rZzRFtDj6vNa==9Bmkh5A@mail.gmail.com>
Subject: Re: [PATCH v4 46/47] net: ethernet: freescale: make UCC_GETH
 explicitly depend on PPC32
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:04 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Currently, QUICC_ENGINE depends on PPC32, so this in itself does not
> change anything. In order to allow removing the PPC32 dependency from
> QUICC_ENGINE and avoid allmodconfig build failures, add this explicit
> dependency.

Can you add an explanation why we don't want ucc_geth on non-PowerPC platforms?
