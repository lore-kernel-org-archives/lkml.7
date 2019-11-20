Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F81AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA262230F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+L7D9D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfKTOOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:14:46 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:40316 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfKTOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:14:45 -0500
Received: by mail-yb1-f180.google.com with SMTP id y18so10377443ybs.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2UDmGEazRzqVtYbIxqCFln3SsijfpyFXVxgcc1E0qU=;
        b=D+L7D9D1RSu8VCBXuc5ZgSzBSEZQyB3qHGmvN2f/NYWFHzQjM+He4nX5410BItlAvR
         n5xCLGLS+YOHuphnpo1Mq8MCVh1JF5dRAiMlQ8C7xXSITB6vuVIdion4Y/1MuJ46n1fc
         rhKVFB48YSyNHB3Wkbh8UBeqoTzwZEZgZ8JvkAfc/LXRzmHEbk3BUxCqD9ATBuKcY+G1
         0AAtcnXHMf7YiXDuCMbKUCNhfWFjsebL+L4eGzzhe1kF6/Pcs47h8BBxJDhSsuK1zpXX
         Cxx47Op/tVUo7eMYJ6Ddu9Frws5T+yoKlbmxB5LjPKjTuWbzMtv42nQFNTYWyvHLa4pw
         zVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2UDmGEazRzqVtYbIxqCFln3SsijfpyFXVxgcc1E0qU=;
        b=JR1Z9Oa1E3joHN0hzOyUuGsOBBBAsqJchF++5rO3E4oZqeTYGpBIiaGFzyeaNegpgi
         DB9hI0jpZ8ti8q55g5aRBTEdPzAHh7rh0a//p0MFGQ1b3W/XWw9wc+3sHCCLGrvtKArf
         hXBjW6oEFHgprk+p8Htc7jdrvzVBByolQ7BGTJf5TVmZj5+qrJbvw13N9r+1zQCWvQKo
         KV9JdAtZFmN0vlRM/px8K5rZcOMGUuCyDAl6w9VMp5UTMNecCQdVmWe/4/kj2tqQQvDw
         Y9zwccAfEt7QGDpaioxg1IJStPIYXDZRXH3InzzRFoKAqJtwWP0WeP6/06b/ADX+B4Xq
         fsuw==
X-Gm-Message-State: APjAAAXz943LKvFkf603JY0XQdwjnNJh2yCF75nuK7jA3VgVuNTdCCRT
        FjKDYGyyEnEnNfBYur5oKNH/xvPY
X-Google-Smtp-Source: APXvYqwNhr7F604TDqN8uj62t1wjD2tDaEKy0cVCXJWOejlxNY4QDksvpUKe36M0572D3MjFrRtBeg==
X-Received: by 2002:a25:c58c:: with SMTP id v134mr2082585ybe.151.1574259284392;
        Wed, 20 Nov 2019 06:14:44 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id y196sm11126311ywa.5.2019.11.20.06.14.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 06:14:42 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id v84so8687156ywc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:14:42 -0800 (PST)
X-Received: by 2002:a81:53d5:: with SMTP id h204mr1633399ywb.411.1574259281698;
 Wed, 20 Nov 2019 06:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20191120205009.188c2394@canb.auug.org.au>
In-Reply-To: <20191120205009.188c2394@canb.auug.org.au>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 20 Nov 2019 09:14:04 -0500
X-Gmail-Original-Message-ID: <CA+FuTScVjG_jWH-O-57Q+gTcx0v+Qm5TR4WxsWrQUTEajS_wkQ@mail.gmail.com>
Message-ID: <CA+FuTScVjG_jWH-O-57Q+gTcx0v+Qm5TR4WxsWrQUTEajS_wkQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 4:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> n commit
>
>   d4ffb02dee2f ("net/tls: enable sk_msg redirect to tls socket egress")
>
> Fixes tag
>
>   Fixes: f3de19af0f5b ("Revert \"net/tls: remove unused function tls_sw_sendpage_locked\"")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
>
> Did you mean:
>
> Fixes: f3de19af0f5b ("net/tls: remove unused function tls_sw_sendpage_locked")

Indeed. I messed up the subject line, sorry. That is what it should
have looked line.
