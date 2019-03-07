Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A941FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5A620652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfCGPjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:39:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45062 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCGPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:39:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so17528415qtg.12;
        Thu, 07 Mar 2019 07:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3k2lma2Puqk0MSFXxkRfZTENZpQ+XSMDh5zgkAONM3E=;
        b=rDZmxHbxRnV3xgghQPCRy6uKjTaeBDp5Pp7Wzt38067UN4z3ENSziGqX6lK6xTlfcd
         0fAhb3oct9yRtmsC74pOKOuGnAVxMKatSbtmRSX42B4RKA0zf+Czu5kCw1o+lOAuT1W5
         SVxKtjT/sTlRF0kseUrhYBycXpggRQqtXJ7+p6oyje1pwAP6bE988j9uEMw7W5NbcDRp
         bXwSMD3qS6wDe0mN+QYMac3/TfDs0XqhwxFiB/a+GG4B7hcgGATK2cINMESp05sECkH7
         y95ovPv3Ei5EnRSxWxaYQ5yNITFEbfMM0YEzjmNiTgRwjAl0H7JvRVCed8SkJMtbAI1O
         166g==
X-Gm-Message-State: APjAAAU7g18+2z0p/lH+VMoAI++HrXTfRAEl92ZLxIpZ4HGIE5WdSsLg
        R5E40C2FM4bzVjUkM8T9QRCQ6JIsWAQ6FOj2Ock=
X-Google-Smtp-Source: APXvYqwoBzCqt1Vbv7SeQpDsZpOGRjOd9e8QH5H/8a+20u8dWBXrCjO3zKqXDHoWxbywgOuzw8SndQQ2VRRMoZOrzxA=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr10644803qtb.343.1551973151574;
 Thu, 07 Mar 2019 07:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20190307103219.1539316-1-arnd@arndb.de> <20190307153143.GI20201@archlinux-ryzen>
In-Reply-To: <20190307153143.GI20201@archlinux-ryzen>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 16:38:53 +0100
Message-ID: <CAK8P3a3zxEKynY03m5Z67Zo1WMO=fNdKu1PXp0r=21x_QRNqUQ@mail.gmail.com>
Subject: Re: [PATCH] peak_usb: fix clang build warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-can@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Mar 07, 2019 at 11:31:55AM +0100, Arnd Bergmann wrote:
> > Clang points out undefined behavior when building the pcan_usb_pro driver:
> >
> > drivers/net/can/usb/peak_usb/pcan_usb_pro.c:136:15: error: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Werror,-Wvarargs]
> >
> > Changing the function prototype to avoid argument promotion in the
> > varargs call avoids the warning, and should make this well-defined.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/109
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks!

> I wonder if the format specifier in the pr_err statement at the end of
> this function should be updated.

I think it's still ok as it is.

      Arnd
