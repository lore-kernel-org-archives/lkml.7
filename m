Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D496CC5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A544C21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DafuIMzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGDB7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:59:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39792 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGDB7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:59:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so2204234pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 18:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBNyJBnqU/lYe/Ozz1jmxOlaF/PmqyD3BLJwt7wrtGU=;
        b=DafuIMzRmRoFk2EtihZ6K9OJnyDWcYNsPH7F4xqO38yVAcGxqFgy2ppKW0kLW2CB8l
         +Cl/DKFQwgopwOtQNq4x/amG+iW9DSq9UFXBxoP7PzwQ+x8lXt1l3II/rmf46niXX0YQ
         l+7PSi6Z3xLB1hFmW4N5rwVxWS1r0RUseTBaXBBT+pdO5TfHVgfLSoQVUzUzFNn6LLLk
         tklOtKZ0IsayBMkMNGdwT8Kt83LjaLPI1PoU8I2KHegSuHkMF42Xnbkcg2R8ykbiLv5s
         /PGeadBgf9cOKDIvujjxOCkmnPobO44M4GTLfFevleShqEpZvooKdQemKCO8OXTqBNGM
         UU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBNyJBnqU/lYe/Ozz1jmxOlaF/PmqyD3BLJwt7wrtGU=;
        b=RnT73tVyrDiiiEuvwzRF4eTYZah9BnVZODtS0uA5CM4YlNrOJxwZzv7/aWNPSr9ss7
         E36x0QB4mo/zBJ/2eihP/bd40/XFlgKXIKfbvaiaAvthAHjDzh2lzSnnTBZeYavd5H4j
         aCPZ7ZS9pwBO6CzG+W5cfdq5zjdBdG5q24g7KQj02VLNPa62dVUSYr6tA3fJWW9iWZv2
         Ham1aACg/g21O6YEtOBDKMz4w1q5IfSkTyBIQ63VeMLrCzpVnxC7GrTpWY3ekGLh6UoA
         X60Yz6Uu7TF49wpa4DN8MfbqiF7IEweLMCw4H0be85DujQD9LbMuZS2fStM9TmGV0iCz
         Wcpg==
X-Gm-Message-State: APjAAAXN7Z/1cdmt8iPVvpir/kP0DR9AXQlKXbKHAnZGSB1/U7DKTYE/
        R1HEJHMoGqOazgr+777Xtn4=
X-Google-Smtp-Source: APXvYqwzCTWt23oxzdyRl3RG83l5rEiHGsDuTVXrO82oG40/lICiq6krwvwERXdF37c9iMzrvV7HNw==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr46612654pls.278.1562205555190;
        Wed, 03 Jul 2019 18:59:15 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id x25sm3582345pfm.48.2019.07.03.18.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 18:59:14 -0700 (PDT)
Date:   Thu, 4 Jul 2019 09:59:03 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        devel@driverdev.osuosl.org, huyue2@yulong.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190704095903.0000565e.zbestahu@gmail.com>
In-Reply-To: <20190703162038.GA31307@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
        <20190703162038.GA31307@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 18:20:38 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Already check if ->datamode is supported in read_inode(), no need to check
> > again in the next fill_inline_data() only called by fill_inode().
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > ---
> > no change
> > 
> >  drivers/staging/erofs/inode.c | 2 --
> >  1 file changed, 2 deletions(-)  
> 
> This is already in my tree, right?

Seems not, i have received notes about other 2 patches below mergerd:

```note1
This is a note to let you know that I've just added the patch titled

    staging: erofs: don't check special inode layout

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-next branch.
```

```note2
This is a note to let you know that I've just added the patch titled

    staging: erofs: return the error value if fill_inline_data() fails

to my staging git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
in the staging-next branch.
```

No this patch in below link checked:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/erofs?h=staging-testing

Thanks.

> 
> confused,
> 
> greg k-h

