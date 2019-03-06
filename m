Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8590C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8959620684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhmrFqkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfCFO1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:27:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:27:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so8552779pgf.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 06:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ur6CM+sNXTaevL8nWKMTAC/jXdbjcmLF+bLJ7jYIwXg=;
        b=ZhmrFqkkxyy5DCA90po2qCej7E9kzJaCkK712VF56EmrTl1mOEWqYLGPZSKTv+zJSC
         MWnD2cn3UO9Fnf9aIP+0BGk0dNDOYz7pGsRzE8paralbkbUFsE6LP4zURwJ8w9Dl9kZ0
         37gVpxXyqFaOvQsUbQK6ghg5GL3iMBJT7YO1UBsrYN4CSWzXldxDcZkqjSe6Rp7fWMn4
         OccsC4tD0QBKWtUoVhrxpee4AXEvPNNYc70Km62lXlS9oX/anlQ9XeXyO2VdIVfEuGjC
         5bHWc005i2usjAy1CMQ6JUiInNRa3nEYBqRGUSXQYVjSL7r6RZXXr/lB51d8V2/KRhjx
         ceMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ur6CM+sNXTaevL8nWKMTAC/jXdbjcmLF+bLJ7jYIwXg=;
        b=F12BTKCsmNhGTeE0VEzryxgbB7oTNvXd5CkkfBnCAaRJlYCt3nGqgTrpHPK871n+SO
         Ir/z+w66nktEsq7xJSeGzmX8MtXhSwOhP+qiZDRTaIVpr3hD3sKLUDr0L7hlP12Uzo1h
         NOQTjazInlZFrX+4s1eXvgj7mIzr1W0GCp42zMHLPbiUKDdCOUiSd1W8yQJi/fhONOCg
         zLuN2H1EUVmXhMMFLeyqQUkNvOAhPDwiQQk/LF1JaQPgm19Ol6fCA0mF+24sdNbiGZrv
         KQpN6SV99nk3tlJXVHkEogfBBAPZDFRgscpI29epghkQL/dVASiDf1spHIqTvCGv7fdZ
         dNYA==
X-Gm-Message-State: APjAAAU2T9NvglIIef3fx/no1xopmbedbxp/EZVrCsQWtb+PVXCW8uyK
        04K23Us4o0I2DG43oB6DmtPmIFZk
X-Google-Smtp-Source: APXvYqyxv8uUmdwW6ZdUFpRIg8cL7sDFlkcqw+xfL9Q9IaM/+UwdXUg9gakCQ475Fk0vUPcJ5foJvw==
X-Received: by 2002:a63:4247:: with SMTP id p68mr6576561pga.30.1551882465721;
        Wed, 06 Mar 2019 06:27:45 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n10sm3010105pfa.139.2019.03.06.06.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 06:27:44 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 6 Mar 2019 23:27:41 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190306142741.GA21163@tigerII.localdomain>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
 <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/06/19 11:04), Petr Mladek wrote:
> > I'm suggesting to use a non-async printk() for $trailer_text_line line. I think
> > that changing all printk() called from out_of_memory() to async is doable, if
> > the caller of out_of_memory() wakes up a dedicated kthread described below.
> 
> This is error prone. The trailing printk is not guaranteed:
> 
>     + It might get lost by code refactoring.
> 
>     + People would miss that it is needed when async printk is used
>       in a shared function, e.g. dump_stack().
> 
>     + People will not know that it is needed because they
>       are not familiar with the API. The would just use it
>       as part of a cargo cult programming or so.
> 
> For this reason, this API is a "no no no" from my side.

Conceptually, this buffering is just pr_cont() with extension
from "1 line" to "N lines". pr_cont() also waits for a special
marker to flush the buffered data - that marker is pr_cont('\n'),
which forces printk to log_store() cont buffer. In Tetsuo's
proposal the marker is different. That's the only difference I
see. Should any other CPU printk() anything - it will print out
buffered data, same thing as pr_cont(), again.

	-ss
