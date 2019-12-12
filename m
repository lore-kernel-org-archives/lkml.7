Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9225DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8D8208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzWGsDSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLLBXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:23:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46013 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLLBXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:23:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id r11so288962pjp.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3JnTxmN8bRkEHsxonCr7JuulpHDsIp/mbioLEIpCtLo=;
        b=OzWGsDSWOHh4LCnZfVnogP8qxHuXMKTE6ClCai9ULySKFzMaz+rwU4bDRtYNOvfAdf
         Mg+rzFD+6nSC95jAVllMVgm81bdHnTuLce6EY2TFQy4G0UmWR7tQCp8cJfGgY1IGBG8X
         H6eiFCG4vC3F7V3Z9OwOj61KTZsZYBkXecHc6F+gF83Gc4w652OWla91sQQTKQdnxoFo
         BHnjrnGYAaWi8McCfpa6z9lWINyu55vwcLVlqFJhcKgU7ys/k3TN8VZgZX2hOZhzlwWs
         vP2vhCOgBShw/SdlFqKfNm8F9QMr98/yP8KdYXXuVktbI3vY1jHD711lM8qBjYmmSL0U
         4Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3JnTxmN8bRkEHsxonCr7JuulpHDsIp/mbioLEIpCtLo=;
        b=EtuLD7iW+WFs/94wfV/+RP8FZ7P8LwP0Z3TSEr9CTgYgpSekAklFzzd46T4O4X9a0H
         9ILFis+VDlbykrHkXBT+S0TPvJjsreFGZomYWgoDrazi7t8omFz5Yu+F0Ii+QdhjyVo4
         siu9Wj8wyEYg1umY0aolr6IRQcJxWA99Ry8husVgvxvoTiFXmUwfmkNhbF2ETvNqiZ7c
         B9KhO0WbUWvGmdFYdZO211SbiV6PXhu8OKmuUBc5kr8eN52AXEFSVc/Rt3swfuupr+jW
         X9fAf9Fo6e0njmMWHc9UQcvWTghRyk0340cD63GLfbxK4NxBsEzhXXavyIyJbOmnjxXY
         yrkw==
X-Gm-Message-State: APjAAAWMwKp32x9/GsB/y0Pzi0UJTzHHC9WzPF19t0xX3z/n2goLR7OQ
        vyqEL03m+JYvGCeLHvoA7l8=
X-Google-Smtp-Source: APXvYqxNfrxsMFmz9h9f4OxUO9xfYOR7l6Lkvi1Eim10U8Sr8QVAoKR6UH4mCd0SA6s5jCyZ/nPbwg==
X-Received: by 2002:a17:902:aa8f:: with SMTP id d15mr6884521plr.80.1576113802399;
        Wed, 11 Dec 2019 17:23:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id q9sm4305225pgc.5.2019.12.11.17.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 17:23:21 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:23:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191212012319.GP88619@google.com>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
 <50d2c44a15960760c6a9d24442a93fa4b31b7594.camel@kernel.crashing.org>
 <20191211091740.p6bgjy7sy75maenw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211091740.p6bgjy7sy75maenw@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/11 10:17), Petr Mladek wrote:
> And this would exactly happen as pointed out by Sergey. match() does
> also some setup operations. I would be scared to call them twice.
> 
> > This looks indeed a lot more invasive. Is there any reason why what I
> > propose wouldn't work as a first patch that can easily be backported ?
> 
> Your solution is not acceptable because it might cause calling
> match() more times.
> 
> The reverse search of list of console does not work for ttySX
> consoles because the number is omitted when matching. And the messages
> will appear only on the first matched serial console. There is
> a paragraph about this in the commit message of my patch.

A fast path for preferred_console match()/setup() sounds like
something that may work. There won't be double setup()-s and
we scan console list in the same direction. We just have
separate match()/setup() for preferred_console. Do you think
this won't do the trick?

	-ss
