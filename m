Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C004EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C620645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xEmw/Gmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfDPJEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:04:12 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37753 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfDPJEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:04:12 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 439a91c8
        for <linux-kernel@vger.kernel.org>;
        Tue, 16 Apr 2019 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Nvnt8uQOpufV3s7Wtm2WoeBe1Es=; b=xEmw/G
        mqpobGoNazQXilr8g9b4q1MKNQ2c3NJgzpLYfTfWj6kkcMzoU+B7ossgWnZEpo4/
        JHEiEE06Mhu0+K3xWjzMxg4+P9SV4VQRc/FjxAjOuCEGNodYMSa0dWSEoxc55owj
        vt4WsosjfE/zow3pQPgOOjehghW06pabJ2AcQX7QIZdNDyMtEmD9Tu15op7m17q5
        gLzib89Cprnz/DokQLcfdSICxw7d5pN2UgZDwuug/VGN0nOv/oeyMJXuJiy1Y44F
        WnYHr5JGX49y1c1q/qStlnFSE4oVQ5TYi/klo3DVzA/9FPdhpXYcOaL+UUJfxp04
        9U+5aCdGeMfzyVfw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8a3a1142 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 16 Apr 2019 08:39:14 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id j10so16985088otq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 02:04:09 -0700 (PDT)
X-Gm-Message-State: APjAAAU8XBTDyX5H/ycLdLvvzovsXltS7PO8ZWHhERmeFbzDqIlPk0Xp
        e6Lm0i2ZMM42u71DbO2uGNUgr0aTMq3x7Ud4eQo=
X-Google-Smtp-Source: APXvYqwqpR1IwsAQtDhUU+7WxUfjbklER9aKyF7WrPiC5ir1rsZTIkVIA6bFligAJ2raRquX63eJGmHjJiqXCYtoDTU=
X-Received: by 2002:a05:6830:1114:: with SMTP id w20mr48436601otq.29.1555405449189;
 Tue, 16 Apr 2019 02:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190416172720.68e8b95f@canb.auug.org.au>
In-Reply-To: <20190416172720.68e8b95f@canb.auug.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 16 Apr 2019 18:03:58 +0900
X-Gmail-Original-Message-ID: <CAHmME9rycs66KYXhxa5t5=7B9JkrotU1MMxXDFXrxqCM27ysBw@mail.gmail.com>
Message-ID: <CAHmME9rycs66KYXhxa5t5=7B9JkrotU1MMxXDFXrxqCM27ysBw@mail.gmail.com>
Subject: Re: [PATCH] lib/siphash.c: mark expected switch fall-throughs
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:27 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> This patch aims to suppress up to 18 missing-break-in-switch false
> positives on some architectures.
>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Looks good to me, thanks for this.

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

Perhaps Greg can take it through his tree?
