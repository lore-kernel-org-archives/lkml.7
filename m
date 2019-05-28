Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97633C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4192075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf+VYvwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfE1EPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:15:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35193 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfE1EPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:15:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so8431767pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 21:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b50zMGTOCc0fwRDaXhdX+Sowx0oH+oWPSMB5/jqWRtM=;
        b=Jf+VYvwOtZiS0/PGjs7HbiDMtvfu2MLrx0Z5DuC69eabsbASuUr4g+RTrej3zgmdok
         RkeuW4uIPWY203T4B+03N0RJwooy/qW2XsvzX2MdNPO56S60Cyl3uJTihw5xPPvuL5M0
         6IzniUwTAh8cyBofYYOb1d8AdqfvcC97SGIyjqZZSCEC9DNUy0onEW3mXTjovw4J26Oj
         ImA9I2d9r+DMAn26HnGCbhyFki2sz8tpJZS2KSZkhKjRmI/TQvjkZHPxo17eHRHOBTVL
         EjZwyxoYhdC46CXfUC14KHUq8LKL9Vp9q8nSAh+dKdZ0STnBHFcluQzOi7xY2a2TX/ti
         0uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b50zMGTOCc0fwRDaXhdX+Sowx0oH+oWPSMB5/jqWRtM=;
        b=D4t6236xoMRWKUx4K5a5FyvraiIbEQPecDvYVlB/NnShtgKyVGuQrmFsjW1M5cZL/m
         S4syfutqIqXNN/jgvfTjEtiJ2Uy146iJmUKjdMCVP8QGeZ+cUgsVl0iqVcpjynUPekKP
         77JT1kZT9MP3ebj8FZMFWRrnUun+z6ByCUPVxNi/HywDXJBHs4XSAE0ZbBk7PKf47hgq
         LjURuYLa97TY9U55Sxnf/CHGiwRrqSAC/FDyzyeUVxyWA1HLPDzj4D1PkqJqx36K2f+U
         BaBEY5jLdJXfClULpfBOH3w9ZMSppK7vsi1uj7NbMc2M1Inoc66Ye6jjGt/3aOJKfq9k
         mdng==
X-Gm-Message-State: APjAAAUldRT48rd+56if58CfsbKMq8WOiPPBo1/4f0nv/c64M8vAajRz
        QpVEJOtiKgW+uYBtCT2Mm9E=
X-Google-Smtp-Source: APXvYqwsGsVlg0TXsoL/yvdeiXQXBN0QQogKvzjwA7G7Y4xc3Ey3QzXYWw5r56CCfmDhi/pgsA4Cxg==
X-Received: by 2002:a17:90a:9a8a:: with SMTP id e10mr2954564pjp.109.1559016904379;
        Mon, 27 May 2019 21:15:04 -0700 (PDT)
Received: from localhost ([175.223.45.124])
        by smtp.gmail.com with ESMTPSA id q7sm980578pjb.0.2019.05.27.21.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 21:15:03 -0700 (PDT)
Date:   Tue, 28 May 2019 13:15:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190528041500.GB26865@jagdpanzerIV>
References: <20190528002412.1625-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528002412.1625-1-dima@arista.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/28/19 01:24), Dmitry Safonov wrote:
[..]
> While handling sysrq the console_loglevel is bumped to default to print
> sysrq headers. It's done to print sysrq messages with WARNING level for
> consumers of /proc/kmsg, though it sucks by the following reasons:
> - changing console_loglevel may produce tons of messages (especially on
>   bloated with debug/info prints systems)
> - it doesn't guarantee that the message will be printed as printk may
>   deffer the actual console output from buffer (see the comment near
>   printk() in kernel/printk/printk.c)
> 
> Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
> Make sysrq print the headers unsuppressed instead of changing
> console_loglevel.

I've been thinking about this a while ago... So what I thought back
then was that affected paths are atomic: sysrq, irqs, NMI, etc. Well
at leasted it seemed to be so. Hence we can use per-CPU flag to tell
printk that whatever comes from this-CPU is important and printk should
eventually print it (next time it hits console_unlock()). One candidate
for such per-CPU flag was this_cpu(printk_context). We can steal high
bit (next to NMI printk_safe bit). So the intended use case was something
like this

	sysrq/etc  /* atomic context */
	{
		printk_blah_enter();

		for (...)
			printk();
		...
		dump_bar();

		prinkt_blah_exit();
	}

printk_blah_enter() would set that special - printk_safe_mask_blah - bit,
and prinkt_blah_exit() would clear it. Whenever prinkt->vprintk_store()
would see printk_safe_mask_blah bit set it would mark the log_stored message
as "important, always print!", and console_unlock() would always print those
"important" messages.

	-ss
