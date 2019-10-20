Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF76ECA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 07:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DE621D80
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 07:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k23FWgob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfJTHaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 03:30:23 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:38735 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfJTHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 03:30:22 -0400
Received: by mail-pl1-f182.google.com with SMTP id w8so4971037plq.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xIEpU0tkDVwXDBE078M49Pd4kGLB+/b7BLvzvh1elZc=;
        b=k23FWgobVV1aG26lmU6fCW/9wkGn/FAte/1L5bxZf9QXSAj6cTg1EmvrTFzcDcSfeJ
         FgLRBMsVrXsoGg8Pi/yvTcE+jc/SCimqUVY0h3v7C2sLX0JyQSj5SE7BOQgjDMJN+XXl
         OOyUAJo1zQbTwsbhpNwtodrpl1z5CQQ6+5hEBfdivmKPyn4UrVx+SX4s4R3o3IzNGw6a
         Ov4aRvaqqruYxXjGHd6hrnffD6Wy5NSjz/08HnG1yLEUJiJUYgRmkd7NfTue7UznW+WJ
         5gJ06ipPlgmK2SwQ4N5t5fakl6kk9CVDmlm0ptz0h4JYj6VISBG7Vgi0EzQkH6yLVDin
         tTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xIEpU0tkDVwXDBE078M49Pd4kGLB+/b7BLvzvh1elZc=;
        b=LMne4gKj8gNKG/gtQqrdyoCvqh5BCCAL1+CjkVEO4ar956d8z+j+i1hsUw2IUSRfee
         WG5kHyMw3pC1cJqgv10DokMqhTzExSEdSA5oKRYfcrTuR4NlEJCaLTcJaJdSnDWw2tbh
         uPKgi8jceCpd3OQnGJS7Xv/9Y22CkmgeaUbHUkxWK+vFk0e3d66hBBFmgTPPn1s0alrQ
         Rxa1v9/eufOTsN/l1ObtoMZZyTSNplQ6RS+Bf8zLMThApLv8nDIurRPkggZ3Cv5ldhoR
         4NU/crBqJ906k/k/bAcXxrzx6Q00FmGN8XVZkP5+3QgYM649R2J+yxnNURTFlwAO4iBy
         rsLw==
X-Gm-Message-State: APjAAAWJ4rQSqCEECZ0NzIKlC1YKazEejEP19rtIF5JNVEowi5hrzfXB
        GYj2xlcl/Mh8E4J86kPAQTk=
X-Google-Smtp-Source: APXvYqwUY9cR1hb3IyYu+aa8dI2wtIsm8M9G3GtnGk5zbLYrnFBHgO/x3lYPcZcfThXfEDJg114hqw==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6mr18578322plb.240.1571556620184;
        Sun, 20 Oct 2019 00:30:20 -0700 (PDT)
Received: from localhost (221x242x255x113.ap221.ftth.ucom.ne.jp. [221.242.255.113])
        by smtp.gmail.com with ESMTPSA id r24sm12025626pfh.69.2019.10.20.00.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 00:30:19 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 20 Oct 2019 16:30:17 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: checkpatch: comparisons with a constant on the left
Message-ID: <20191020073017.GA247560@tigerII.localdomain>
References: <20191011015225.GA27495@jagdpanzerIV>
 <8720b5d432ca5ba5e128c241efee22674e012af8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8720b5d432ca5ba5e128c241efee22674e012af8.camel@perches.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/19 20:23), Joe Perches wrote:
> On Fri, 2019-10-11 at 10:52 +0900, Sergey Senozhatsky wrote:
> > Hi Joe,
> 
> Hi Sergey.

Hi Joe,

For some reason your reply triggered gmail spam filter; took
me a while to notice and "recover" it from spam folder.

[..]
> > Both LINUX_VERSION_CODE and KERNEL_VERSION are constants, so
> > I'm wondering if it's worth it to improve that check a tiny
> > bit.
> 
> Probably not.
> 
> My preference is for people to ignore checkpatch
> message bleats when they don't make overall sense.
> 
> checkpatch thinks anything that uses a form like
> "name(<args...>)" is a function.

For example, DMA_BIT_MASK(xxx) can look like a function
call yet still be a compile time constant.

Another example could be ARRAY_SIZE(xxx), I guess.

[..]
> but then again just using LINUX_VERSION_CODE emits a
> warning message, so it's better to remove whatever is
> in the block anyway... <smile>

That's certainly right. LINUX_VERSION_CODE should not be in the
code, I agree. I was thinking more about 'const vs const' comparison
in general, less about particular LINUX_VERSION_CODE case.

	-ss
