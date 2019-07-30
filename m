Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE70C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC43E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfG3HMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:12:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46087 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfG3HMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:12:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so61977774qtn.13;
        Tue, 30 Jul 2019 00:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JR6rIq7i3T4m22hMN9xlWoNn6AwKQHA1u/FXd7l8LjY=;
        b=V3hWleR57E++no1HTUHeeB0kd4F4lCE70TXFSj7eqhJaVR+mQr1XW3cVV67CUz6jkK
         yeaFR9ifAwrTaKIX8wLZTHU+iGEN8BUF49yHLnf4mIJc9soVS+Xsrx70Eag/ld7+amyD
         oKpRmKPAME2jcBDeCDbfGL9FtAgmCQ2u056rJSCfQ99ff/z8QWy4ukYkuflEBoQFnHjL
         zVvDA1l5p5s2EPi04B7l/1AtCbU76EQ8Sos/1pleNK9C+M83DNYTKdNxzlX/2Pue4IGa
         wD9Jsp1O/9UgSynCoCPBK3P74NRX8ugcmKOgkZfaK4bgnMznX9Zb28YRBQ3xmCYZuYYr
         ceIg==
X-Gm-Message-State: APjAAAUV/fP1Ym3cYORRMEVkddu0hMM3lyn4fll1x3T6eCJGPPISWFm8
        0iE5AqW+TBbp3t5hvX4n+x5cfIIaIa0luCPMoI5cQAQsRzQ=
X-Google-Smtp-Source: APXvYqxsyCN2D5CCgTkLcthivbJ4WOTUous4iUpRFXdxYWUPuQ4EZKVPPsMc2c0vVxRxvWndvcgZa6lxBIeMSx0ffjw=
X-Received: by 2002:aed:3363:: with SMTP id u90mr80015452qtd.7.1564470728332;
 Tue, 30 Jul 2019 00:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <1564451504-27906-1-git-send-email-yi.zhang@huawei.com>
In-Reply-To: <1564451504-27906-1-git-send-email-yi.zhang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 09:11:49 +0200
Message-ID: <CAK8P3a233_UbX4roe-1Zr7d+3tn9me6hnBoqXsZcLToE_s_dag@mail.gmail.com>
Subject: Re: [PATCH v2] aio: add timeout validity check for io_[p]getevents
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-aio <linux-aio@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:46 AM zhangyi (F) <yi.zhang@huawei.com> wrote:

>  {
> -       ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
> -       struct kioctx *ioctx = lookup_ioctx(ctx_id);
> +       ktime_t until = KTIME_MAX;
> +       struct kioctx *ioctx = NULL;
>         long ret = -EINVAL;
>
> +       if (ts) {
> +               if (!timespec64_valid(ts))
> +                       return ret;
> +               until = timespec64_to_ktime(*ts);
> +       }

The man page should probably get updated as well to reflect that this
will now return -EINVAL for a negative timeout or malformed
nanoseconds.

      Arnd
