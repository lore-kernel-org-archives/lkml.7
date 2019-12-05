Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC613C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC8422525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS2aL1cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfLEBA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:00:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40615 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEBA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:00:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so721077pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ft6UARj55cMd5qKu+UNVgACeCf359Q/Ufw3Kj1aax8=;
        b=XS2aL1cceootJu+8FQuJMtqkGMtj0Fgbf3se6DHlc538wfiKjstQwEO1qt9w5qcZqn
         8z9kZdyiLpr4cHQ/qxHEYM8zE7dJHwHgLrYernfV/4WFWbdTtuxanpZlw57dOyX4FHTl
         lucDYm4dGq7nFKqEfG5WAvpxvL23Jb9bqm3wCvjdpaK7guVMDRZZf3oJ691mCiXG3hOP
         NkWxffEqup0LLm1myeVyBtQ4POQDBgELbyytAxBpdUPnjGz2LsvGqPaGzAEpxcMS1vqC
         SO4FjxfkCcrprvxg6wbqThuSC9BX5sgyC3UWhTyUa1xLUaI9BsUAHb72qtHR9WhGwvHZ
         fVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ft6UARj55cMd5qKu+UNVgACeCf359Q/Ufw3Kj1aax8=;
        b=BuE3NyG34lB0c62HUQJ92npUIZfU1dAZb1BkfEst9+noLZXkeM9PldDlpGPIuQNi8r
         sw5zkUNNeq0p1G03W/p0awHTEokaBX4jC1svi4JetZlAGedMIjDzJ5nywwE0rZHJ47JF
         MRb3u/xRH8XlGyiHLM7EFm1abKlUJKKeKpoSH2eIRfLWVGR+FSVUDxFvhkPEEApC/hX8
         6diJD5nYRPkqScO4Kd72mrjsVAgr1zDMpXaBNdh9W4tp40un029qgcvZJa8U2I1CdscL
         DPfKdsT7Yd9n5a1z+fyUtjl6vwEfNfGsMjjth+ORNtIP4bBuO2fo1GAlz/aect0rXPYB
         KZUQ==
X-Gm-Message-State: APjAAAX30NPFYDCHWUZbjnk0TlDdNoijpwjKWsEY+DdQfXpObnv9mscq
        kFebwog5eC89GFXM62ew0fA=
X-Google-Smtp-Source: APXvYqyPhn14pl3Csqr/dBGwcPGc1y+PbNIl6fcKXvdKmyD9naKGcJbylv0QHX7gWswMN56VjztUew==
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr6593367pgq.417.1575507657801;
        Wed, 04 Dec 2019 17:00:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id y22sm9155228pfn.122.2019.12.04.17.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 17:00:56 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:00:55 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>,
        gregkh@linuxfoundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        dan.j.williams@intel.com, peterz@infradead.org, longman@redhat.com,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
Message-ID: <20191205010055.GO93017@google.com>
References: <1573679785-21068-1-git-send-email-cai@lca.pw>
 <637027D4-BBDD-4AA6-B03C-556060988957@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637027D4-BBDD-4AA6-B03C-556060988957@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (19/12/03 13:46), Qian Cai wrote:
> > On Nov 13, 2019, at 4:16 PM, Qian Cai <cai@lca.pw> wrote:
> > 
> > From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > 
> > Sergey didn't like the locking order,
> > 
> > uart_port->lock  ->  tty_port->lock
> > 
> > uart_write (uart_port->lock)
> >  __uart_start
> >    pl011_start_tx
> >      pl011_tx_chars
> >        uart_write_wakeup
> >          tty_port_tty_wakeup
> >            tty_port_default
> >              tty_port_tty_get (tty_port->lock)
> > 
> > but those code is so old, and I have no clue how to de-couple it after
> > checking other locks in the splat. There is an onging effort to make all
> > printk() as deferred, so until that happens, workaround it for now as a
> > short-term fix.
> 
> Sergey, could we have a ACK from you so Ted might be able to merge?

Not sure if I can ACK it, but overall it makes sense to use deferred
printk there.

[..]
> 
> > [cai@lca.pw: add a commit log.]
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > Sergey, please let us know if you are fine with the Signed-off-by.

A 'Reviewed-by' will suffice.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
