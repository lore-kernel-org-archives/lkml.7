Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2163ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24A521929
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t51LIKBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfKDMlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:41:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36199 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfKDMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:41:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id j22so11244962pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f5ml/8tDxj4v4KVNQHKkwoSqt5ZyjL0e+C11QKr4g6Q=;
        b=t51LIKBQSy6DSnJbsbh8C6wkPSdOxEIgMyfLqvPfm0xKVy+HpmNCS7iBJVH8Mnjtem
         Cmg8WhGm5lYPozuXPhaqBpDYIVChPFB17r729Rqj8bhPms/4WI9i7ZPu2FjbOLQ9wxuA
         mkf4a8iGl+MH8EbNuTjOnyZ+6Pf/P41yV2t1XktLnfaz8VNdk3kUH8aNwMavEJ4k6OVV
         IXTWgnDbkmblJccfqLAxTK2e08hKtU1OTri2VES+gDUN5vU8D3FixFDavrkmZXUe+5+B
         xdurk+xKYJ50nFOFJPVuAzDY0GXLOCxN7L3UV73btCLujhw2Bp7rGb9ec2BX10WgKyC3
         pnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f5ml/8tDxj4v4KVNQHKkwoSqt5ZyjL0e+C11QKr4g6Q=;
        b=MKd7PH2hfLTV+sfkl2SngDrcwX+ZSE5fr9CxAA7+rheXRLgPxARlaAXJk59SmB54pZ
         rvwZtiU54TkClhdMaqeH5uwZ1Y+lujOoMGwTDlls110xRC9lGZEfNwMV5hss0pROHk0n
         p7Zm1aqKoI8ccz09OOhWuKATOGdQ4mMA4HTFi+8oyB8pR1+EihdVX10V8kg3GH+sEo4r
         Zy9OvWiNB+6A+yoL9uhjw2YGWaraeTXbI8szELfYGfI7yEPuKkZhYTMHtlQSmbF5mHx4
         +uJS2nXyBxTUiekeF5dyaSKR3H9rJyj6KHbfWVz4hkHlvotuBGuJhgUhzttA2ZdAVbhZ
         BWAw==
X-Gm-Message-State: APjAAAX9MIkrDcjRpL1P28uJ/3M6K7mMdTrm3QcUoLyp8q4OwcjZgkYB
        Pxm5H2wIz5Bwd/COor2am/KrFiiKREI=
X-Google-Smtp-Source: APXvYqyaC/yXuT53FbCODSPTnspNPx8aFiIplmlErNU9+PiTZQFQUQB6sscZzQoMZk7X24mx8JdHyg==
X-Received: by 2002:a17:90a:de0d:: with SMTP id m13mr35158675pjv.32.1572871310271;
        Mon, 04 Nov 2019 04:41:50 -0800 (PST)
Received: from localhost (221x242x255x113.ap221.ftth.ucom.ne.jp. [221.242.255.113])
        by smtp.gmail.com with ESMTPSA id z1sm1578989pju.27.2019.11.04.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 04:41:49 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 4 Nov 2019 21:41:47 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add VSPRINTF
Message-ID: <20191104124147.GA11977@tigerII.localdomain>
References: <20191031133337.9306-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031133337.9306-1-pmladek@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/10/31 14:33), Petr Mladek wrote:
> printk maintainers have been reviewing patches against vsprintf code last
> few years. Most changes have been committed via printk.git last two years.
> 
> New group is used because printk() is not the only vsprintf() user.
> Also the group of interested people is not the same.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked

	-ss
