Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F1C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C3920679
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXk4fW6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbfJAQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:28:28 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:42284 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfJAQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:28:28 -0400
Received: by mail-io1-f46.google.com with SMTP id n197so49481282iod.9;
        Tue, 01 Oct 2019 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8+hmFvsPdH2AxLk+ZmC9ceMVwCfMcITJ8IPlQ1f0RHU=;
        b=oXk4fW6c3IC78Mk34Z8/240Gc9t+Mw+dnzmC9NVWGnGocXonXUc9gcTYiTSydV/aeu
         fZWM5hXwu9K4/HTvaHXZvpYDFSJytxsFfNqfFt0oqsmAFbNm1CQh5wBab2usmNko52nP
         LV9TGdRkVWJRPlDFe+Y6WOKf8ullDesP9kYxJ1geKZfsZIOqlM2sSCNNj64IYbVhgaSE
         54OGc59mKvpFe2yI2vSRvdOZp27MQrmvu61FLBJcbkWWp5XYj+7nmA41BYqi5m0YMuxO
         NV4b4bk62mWCWFGLGejNercqks7ZcFJTYZvbV+xiA+lN8fWuDBi0AdOoIuhKNJ/m7pCW
         cGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8+hmFvsPdH2AxLk+ZmC9ceMVwCfMcITJ8IPlQ1f0RHU=;
        b=Lo5FhpTaIYQxCQWxZcVJi0WkJUNXs8JThuHUZfCAreIT0bdzHSc69JY7QOvmyanGSs
         Z6jU3gOtZ8OgkLXYyLh5m3BJxAPWksfS4EU+2oz07J4A39v5ULP6WhSQ35P2nuuyH44j
         UvzOKdxRzLLaum79zX8EiezOFebDDNwSlfQZTYJEj7SNgF3GPqErwJMaM9wUT3d2lpNK
         HyuCkci1/lQ+hRUhr+UEi9fAi9ATPiIXGyCTaM5OQsRWyNLY1BLdwxjk6zxexlwnl3Ai
         dnSQ/ofaGSgA92Xx/2rYLiDFTY/y8G4X1mEykY/2SKH7wNuDK6Na7PJ3l2mib3pvWjhx
         dl0g==
X-Gm-Message-State: APjAAAXKLiLf6Tg1GFkl/qaLirquZ484/OjbTKpfkowcr/H3ZC2RXnFL
        yBFoWzSyyTj+Qs7/amOLuYWHCtERcVaZdCK8OuuelZ9Lgi8=
X-Google-Smtp-Source: APXvYqzs0ktj4Y0u/N+bCDM6ip1t7a53roEBHR3jnp9lMbGIyJ9YPnU4zZk8/+k1axsevcfk8b79qOwziH6ZfFs1YMo=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr27072802ior.173.1569947307355;
 Tue, 01 Oct 2019 09:28:27 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 1 Oct 2019 11:28:16 -0500
Message-ID: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
Subject: Many unexpected warnings with current sparse
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated sparse to get rid of some unneeded kernel sparse check
warnings but now get many more

I get 100s of warnings similar to

./include/linux/quota.h:114:17: error: Expected ( after asm
./include/linux/quota.h:114:17: error: got __inline

but that is simply
        default:
                BUG();

Any idea a way to quiet those - there are too many sparse warnings now
to find any real warnings that are introduced by kernel changes?
-- 
Thanks,

Steve
