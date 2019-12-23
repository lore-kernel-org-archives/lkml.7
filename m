Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC07C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 00:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4726920684
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 00:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2xBAMxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLWASF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 19:18:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42929 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLWASF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 19:18:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so7927050pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 16:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ykM81g7sFZzCwgE0VjVpSt/KbAJ9F315uEvVACDUJ1c=;
        b=N2xBAMxJ3l9+h7QuYb+qeJYHBFZS9QBn2RhS/9WPQqt3DZbkbce28UBNohmarYUAhj
         Zxlhpd/RsUzFzxGu2Hb0Ys5a0IapF1Cx4EBfTXDnHo5zla6mvpJ5emy3emKK8/N3LUyO
         d9aUjmDL5m+O6TmmlqPH53KgagPSMbbSkfmqjxxJQ/sKLATyiiK55WTxk9WCQzDY7hTR
         7dfZgEwxWr2bqVi03wYStLdSuwbX0FC0k08YO0EgZgdDwDfOmW5wcbsj9fAJcDI/5dr5
         02F6AcTxjoxU5xuDW2t4zndKiWYmPKLNioieyOL7zV2NUW6MvJ3xDTAe7RvQFoRwks0b
         xbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ykM81g7sFZzCwgE0VjVpSt/KbAJ9F315uEvVACDUJ1c=;
        b=NGGk9tkDtsoeQQ7+MapocfzsTz6C/GHat5sirc7JHPYRiId97fqK5NUR+7Z3jbAaJ1
         NT5RDzo5nja3fyaT/VuGBkQnnlOKsRq0oMuQp4xoKNqDAfMjkdr3NZuBzB1fLOYAFeQb
         Qp0OVELNMl2+iGr5z+EqX9xUjQy7bkmhG3Zrc5B6aWsaNbQl4CWpW/lhS50JCq/s4jcQ
         83EwGkP1dAn0R5ylKfwzkzt5o3XA61M+YptWqvFIVvWNTXBDfm/G/FVmBXVlBhDWz4VD
         KfAkBA1nQExz9hQh+fITJn6fcvC0VMtkWDOUJPQdsG9qPipn7sxYe28aituUy7g9N2w2
         dZDw==
X-Gm-Message-State: APjAAAUvdPAFT6dbcbWP5XmeFbbq8eBpYqg4OleZa3ZsW+W3umev3YXW
        JcpUEu8nz+qXI5s5TMrqHak=
X-Google-Smtp-Source: APXvYqzmnq2qKRvUMkL2JHWcV1jR/fwcYaOgH4swonnOC8LcQTluI+3/Jdkd3d9b89eDhZmfySbClQ==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr27123536pgf.2.1577060284583;
        Sun, 22 Dec 2019 16:18:04 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id p28sm19600533pgb.93.2019.12.22.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 16:18:03 -0800 (PST)
Date:   Mon, 23 Dec 2019 09:18:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix exclusive_console replaying
Message-ID: <20191223001801.GA121292@google.com>
References: <20191219115322.31160-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219115322.31160-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/19 12:59), John Ogness wrote:
> Commit f92b070f2dc8 ("printk: Do not miss new messages when replaying
> the log") introduced a new variable @exclusive_console_stop_seq to
> store when an exclusive console should stop printing. It should be
> set to the @console_seq value at registration. However, @console_seq
> is previously set to @syslog_seq so that the exclusive console knows
> where to begin. This results in the exclusive console immediately
> reactivating all the other consoles and thus repeating the messages
> for those consoles.
> 
> Set @console_seq after @exclusive_console_stop_seq has stored the
> current @console_seq value.
> 
> Fixes: f92b070f2dc8 ("printk: Do not miss new messages when replaying the log")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Thanks!

	-ss
