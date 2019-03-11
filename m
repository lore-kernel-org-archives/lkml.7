Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77984C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 02:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C9E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 02:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKd4ZNwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfCKCqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 22:46:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43162 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfCKCqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 22:46:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so2586558pfh.10;
        Sun, 10 Mar 2019 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JaFvoIOwDCphJ8+B2b0L5jEjAWb1xEb1WNVlCpauq8s=;
        b=aKd4ZNwBFKr40Gaw8rK9WLR+tYG1DgJUK31sDeHU1Hi4EHgSDJEsd/UXFJFu2sAkBH
         9ZU3V6xJprGTgR3Hyy4G/THktPmI3GS6xV7TMWcilpSyxniZl/lQ7xDwWrME+64OnHVr
         BvZvmIxccIp+CKQRqfvyFIuqpinLsH1krXIi4Sb/jUAmGinEDgXVN+W19uio2ZJQVahf
         XpW5B8+uHdj2hliNZCcIW42rUqRNflcCpJxADyh1mS28EGO0TpCbKf9sMQdhVgkm0cwZ
         5nGrcTCFOAFo+fpEtb1vn/+/G2JuWUuVEvHT78XjELt8U25qergjH03cBMjfaNGMql1z
         zv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JaFvoIOwDCphJ8+B2b0L5jEjAWb1xEb1WNVlCpauq8s=;
        b=L/f3hYwoGBJ8joegAIywMDKs/NOV54gVt4fswN2rrUtLt2RgKrxqS/6YLm+piVm6fQ
         frzzVe/xltIcKyIy20rIr5qtN7zA4Lz969nwFQnhARE0dsHSZtqokVqGMHDOESKkoGZ9
         +hzaA5k6AHfUja4L3iiMgxhZyyBVErWOAaG0ZL9yLF5F38zVaxRlb7X7szR9WATRDqpk
         mHDlMGKeu/CNRaKgFQYMsFamyqNsvVMm85/iSoPuv6K1LFNxc33BkZ5spnJ+QWViZ9fl
         5xaK5IfhuV2yOvSoKF6zH6Fa0QuP5HURQwYnz269VjJ2GUTNdD/LzoFIigOOuuPMC+Rg
         d74w==
X-Gm-Message-State: APjAAAVNSmsaYSMBoS+/Jg5R0RTLWJuaY+vrsK+e0aLTa4wicv5/GG7C
        yuM+W1EXkSlbUGHKafYGApI=
X-Google-Smtp-Source: APXvYqyVPF3HqDQSCMvJdl6CQoGq5Ra5G6eKmN8cxFJTAgYoF8+wayvVpEUVBNZpQ2MiLevE/RRGAQ==
X-Received: by 2002:a63:ff0f:: with SMTP id k15mr265052pgi.301.1552272365013;
        Sun, 10 Mar 2019 19:46:05 -0700 (PDT)
Received: from localhost ([175.223.26.132])
        by smtp.gmail.com with ESMTPSA id d188sm7396921pfg.98.2019.03.10.19.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 19:46:04 -0700 (PDT)
Date:   Mon, 11 Mar 2019 11:46:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 25/25] printk: remove unused code
Message-ID: <20190311024600.GA25608@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-26-john.ogness@linutronix.de>
 <20190308140229.xje5ay7w2qtlada5@flow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308140229.xje5ay7w2qtlada5@flow>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/08/19 15:02), Sebastian Andrzej Siewior wrote:
> On 2019-02-12 15:30:03 [+0100], John Ogness wrote:
> 
> you removed the whole `irq_work' thing. You can also remove the include
> for linux/irq_work.h.

It may be too early to remove the whole `irq_work' thing.
printk()->call_console_driver() should take console_sem
lock.

	-ss
