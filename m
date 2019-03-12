Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D806BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE43214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQCvoe7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCLBKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:10:21 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38256 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfCLBKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:10:20 -0400
Received: by mail-yw1-f66.google.com with SMTP id m207so481433ywd.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXBSInv4StmhSD3zlmvNNrSxU6RGU/o+DncZzCMSEvc=;
        b=UQCvoe7sGZ/6a1j66opYhFcbq9ogJWmHMoI93WsijyciCaiL1wbNWy4EDSFbn3Ei+S
         twF9qcUTNhS1sA6liAp+y5oCVg1yY8UI1uH+oq1a7UZd/lad/OYZPiDkU2xCAvlDjZDU
         7EskyEraRLR+onXxC3z2cdqf0p23Ohd5qdjSTnc83uM1kOw0eUM4ZId5Ovm7Q9AfnOrx
         NlxPcdfOkY8r82kAUCHDfm0T3/s2tRk/oJUMSGn9Lndsw4yS0QMEBnFnAHPqZTON/34C
         N8kvkgt7RidKFFW/y61oizcT7hWAOk3FDqSakAGLYtKtFXvWGFGi1/zUl5NQuwJYVB1G
         k6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXBSInv4StmhSD3zlmvNNrSxU6RGU/o+DncZzCMSEvc=;
        b=kN2pBrHVBYNBYe7h1nwzYVQRDtg6VFIbuBP3fwUV5ak4o4Otm/ZzBMJ/dlMZo2tE7z
         teeauS5YaPqOe7CGTOB4vTWy3QY4FjdL9pTIlkbs0RXOHO6GjBT7VhwBDJ/HO639RHAn
         L3l/X71xHDwGS+5gNyKJJLiKCBeS/je+cPi4s4SqUMlD1Wu2G6oEpQ6CyL+rVsUQJb8G
         eAAK0Xy4uDfgaK4j2Nm3asVoIxGZ4CYufS75ImWEe/wmlxuCt2anoXR8toxDKI3zJd8v
         isaDU0CIrWXKU1QBCy568cZEm24zpgLHMcJq1Y7VzawCMNsSio351Lt7OgKv4eM/7cLN
         0bHg==
X-Gm-Message-State: APjAAAWmLGCUiYJPrlwN6xpN0OscSfB76dDRu44rJIHi3o/nWmqJkYuI
        +0EM9um3co69EG8ot01rBmrGgpS6MUtdpLIDAKg=
X-Google-Smtp-Source: APXvYqw1V0agqfe7m0Iy4aET5O8JsqasG5NJh1XUVEn4GgZTwwj1E3inchcxmLI1mqoHeSWCwz51C61f/TI9eCdgTUQ=
X-Received: by 2002:a25:e64d:: with SMTP id d74mr30899053ybh.399.1552353019832;
 Mon, 11 Mar 2019 18:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190311224752.8337-1-valentin.schneider@arm.com> <20190311224752.8337-15-valentin.schneider@arm.com>
In-Reply-To: <20190311224752.8337-15-valentin.schneider@arm.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 11 Mar 2019 18:10:04 -0700
Message-ID: <CAMo8Bf+iet+hQ2cbb5TjmYgUkuSAT=2VghyPs+jwttUqoHuZvQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] xtensa: entry: Remove unneeded need_resched() loop
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:48 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/kernel/entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
