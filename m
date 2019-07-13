Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BD4C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D6D208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvNgtd9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfGMGJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 02:09:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33135 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfGMGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:09:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so5245536pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WqiGEOnvmZLw2GIPiVqeh/nsRYHRSwUYib+cvrcYRFQ=;
        b=HvNgtd9gFiHhIwb10R/md5MmTIj6pHpfdX82m4NLqmzWrHiLuIICBvz+hib1SqelGD
         b/Umj+pOgsrCjY0uzVLV9BxDmcHStDVxVXXAKUyB//IKo6gIvFeQPRoUEGLx61hzAQB2
         aWtD47FH9vW/duP3nJ6NXplgA8w0KweGCyLImc0gp7BKndP/L5gfVNs+L0GPT8Ly/oHy
         0fWUH3lnS1NY58uGYjaEYxUJEYstIA1VdiyLeRsMkCb17B6vFMSoaNecgi8XxI2Tx137
         WJgOkJCumNOYwuU4qupgAb06o6zKs9JPmf/jr5iY2hhFVd93hnkLmoCUKv+74YTXsrFF
         kUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WqiGEOnvmZLw2GIPiVqeh/nsRYHRSwUYib+cvrcYRFQ=;
        b=Y6vVXaeFfAhyvV/SzYuf+Ysc/vfVBqQkRNByeaomf4D0b6oYTGNINl+B+NV9miHpC7
         4MVCBVTSvLri/TnETu9ld0sLfBvkCQONMS7dCZNjhpB7T+UTlBqq9/Glz3G/hTkKSz3T
         sDq/wnPE6sbKGd7XCumnaORvqsFkH937uievqXucjrBPt2sLIP5yBLRi+5c3+JL9zPEK
         MRMJ80NwKoXbd5A323abaNg3YrahwiJSz0hMfmB+LKX3OHYdTZuv8HbLLu6uGXoFC9MW
         Uoi7JZNWKr/CdIGjGfmysh9QeejqGg47f+zrKBVOdodvRhzhDbdHj4G3o4igPtAx5Ue2
         URIQ==
X-Gm-Message-State: APjAAAVFkY8ZehgJxlJw2DsjrE37fhT21irj/OBIKsBb27vQPFeEFuyp
        d5NvQDmn4blvRxdjSRodWIPePvK9
X-Google-Smtp-Source: APXvYqxkUQe/qy3Z0u0zS64PlAL9G0t7p/OQieqiMZ9Jaw4qJii+0Qyl5p89u0CaChhV/+8BEUqpBQ==
X-Received: by 2002:a17:90a:3ac2:: with SMTP id b60mr16790954pjc.74.1562998188303;
        Fri, 12 Jul 2019 23:09:48 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id g6sm9397370pgh.64.2019.07.12.23.09.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 23:09:47 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 13 Jul 2019 15:09:29 +0900
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump
 from NMI context
Message-ID: <20190713060929.GB1038@tigerII.localdomain>
References: <156294329676.1745.2620297516210526183.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156294329676.1745.2620297516210526183.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/12/19 17:54), Konstantin Khlebnikov wrote:
> Function kmsg_dump could be invoked from NMI context intentionally or
> accidentally because it is called at various oops/panic paths.
> Kernel message dumpers are not ready to work in NMI context right now.
> They could deadlock on lockbuf_lock or break internal structures.

Hmm.
printk()-s from NMI go through per-CPU printk_safe/nmi - a bunch of
lockless buffers which is supposed to deal with printk() deadlocks,
including NMI printk()-s.

include/linux/hardirq.h

#define nmi_enter()
	...
	printk_nmi_enter();
	...

#define nmi_exit()
	...
	printk_nmi_exit();
	...

So we are not really supposed to deadlock.

	-ss
