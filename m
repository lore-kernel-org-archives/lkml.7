Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C98C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920202082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaDuif1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCDJYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:24:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43957 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:24:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so2661264pgq.10;
        Mon, 04 Mar 2019 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IF7H127Mec3DwhioLVb5hvtccLY/Bj0MkHX01YSXDS8=;
        b=AaDuif1P55s85xp8o3BnQvi1BAdrQqIwgxk+zfsKcDCeraRB333NJqKsHD6/WQ1/5y
         eFRPUZWRmpOGRn49uR3WG76zm4ukgSQnXUuJ/gzEMkt1MQ5F+eSfGTC8IVR/d6K0huIm
         oJQXTJN9YrT+W0q9S7iRm2+1xsRTqYXa7dYnr+X4Iqxu4Cbjw0UGM3FO/dEu6BSTUC1j
         OdzJXKVW5uVip6TFWaq7YGkRF01KlDIBydT3HTyn9jfTUD9fsns+2ip1v4r2XkvAqFXp
         8dCrU3ITXErpsl6Kn0uo3umdDfdFA6UEMBVeAugUGM7qF2oShnirbSZybBEwrL4KhQdk
         pxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IF7H127Mec3DwhioLVb5hvtccLY/Bj0MkHX01YSXDS8=;
        b=OxmeD2mUBvAz2ro+UMVlqFun53y9nbZAZ1m3aUrOPEs2AscLwIYZvwx1CKwur353qf
         cZZCFazA7VYSoiYvpb8k2+uMEbY5M3G8bxoU+SyXf7SHPMMK8DpS500XDFoY+hJY5inq
         M0au0z+wl9J98/6Qp2RP01DfSc0N+eQdPs7TN8C2Xa6rWTJ+k5CiL9yaiFDzoTyuM+el
         yekPVOvXdy8cxd6NPoZNhgNCvLvruIM/0ZjyRoJ52UaZZo3wBMh/92hGTBAtIM33iWn9
         m0x5HKHNQdfLW7Aky2OBXYcJq3Uad5q0Zht2MVKDt0hbtmxb+/KIeHRxXaaCd/OktaIx
         n7Bg==
X-Gm-Message-State: APjAAAUlGjQVT/cp9sCJ0Lv9lAHfx920wpDGdGEKiROCG4LPz2oTSBtO
        SCIOCq2s4zV1U56SLl7rVrs=
X-Google-Smtp-Source: APXvYqzQRVimhRbw8KBYIT6BeK3CQ9kRynDhpSLhpGxwoFBCI90sqdI876XiMgobcQXo1FL7eMFGPA==
X-Received: by 2002:a17:902:147:: with SMTP id 65mr19398651plb.116.1551691488681;
        Mon, 04 Mar 2019 01:24:48 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id x23sm8075810pgf.10.2019.03.04.01.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 01:24:47 -0800 (PST)
Date:   Mon, 4 Mar 2019 18:24:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH v1 15/25] printk: print history for new consoles
Message-ID: <20190304092444.GA21004@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-16-john.ogness@linutronix.de>
 <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
 <87o96yziau.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o96yziau.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/26/19 16:22), John Ogness wrote:
> > This looks like an alien. The code is supposed to write one message
> > from the given buffer. And some huge job is well hidden there.
> 
> This is a very simple implementation of a printk kthread. It probably
> makes more sense to have a printk kthread per console. That would allow
> fast consoles to not be penalized by slow consoles. Due to the
> per-console seq tracking, the code would already support it.

I believe we discussed "polling consoles" several times.

printk-kthread is one way to implement polling. Another one might
already be implemented in, probably, all serial drivers and we just
need to extend it a bit - polling from console's IRQ handler.

Serial drivers poll UART xmit buffer and print (usually) up to
`count' bytes:

	static irqreturn_t foo_irq_handler(int irq, void *id)
	{
		int count = 512;

		[...]
		while (count > 0 && !uart_circ_empty(xmit)) {
			wr_regb(port, TX, xmit->buf[xmit->tail]);
			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
			count--;
		}
		[...]

		return IRQ_HANDLED;
	}

So we can also grub NUM (e.g. max 64 entries) pending logbuf messages
and print them from device's isr.

	-ss
