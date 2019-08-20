Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A16C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC5E22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enLo1ZcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfHTJ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:59:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46649 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHTJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:59:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so3063398pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o15KXmaxH2/gADXZDmhPtBesd8g7XYX73k5yCjzHx6M=;
        b=enLo1ZcGWwnOPUuiZD1xPDHEHOCaQJ/wuly1Ay535TGqIBB5rOYa0nu84CQQT8PaoN
         L8uJBHSHjTFJeEZZFkL8X4qLodujcvy0HHBiobgB2a36bVzBRZEKC52P6shMuNSBSQY6
         45LKtzViEKzFB86Lh76VxFAREt409VWIJGofHgXSwuPyWOgreovZZcTA48a8QxmPGEzW
         Bcf2uLR/1S7wxCMyW9OqGYOW3doiG1ls42Y3PttMa77GQ08BpTRT3hyMweh+2INAqXvU
         C9MJ3unl2DAABtNIXYQ5s0OZ1B60aZ0iZ20H1RrS1zYWDPG+8MGQEG8C3f79Xfgsml8G
         xjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o15KXmaxH2/gADXZDmhPtBesd8g7XYX73k5yCjzHx6M=;
        b=R/XkjRgKPDMazRrQnGCTNssL8YKuZIO0FVxHxawEvfSRBPVdKkdNo6lDAuR+ISEv0G
         Cjly7UK0MYXQo/SRcxm600Fkz1GMg7L6t3mMRj7ivu4J21peYdFEwHzSerkVvGPxgI89
         n4J4BTEuhKQ08+rtNFrzGaDWi56cFr8/qZ0l9jCaxI8djBRTksCzn5sNDEIVlEiZcWcO
         MI7tH2WnIXRo8LeqOBzdH/Pjsnmv5jvAQCovO3OpPZaAGe/DOB0O7PmpKFIEm/URrjP+
         YMUVFHqlXD2aELeBVhzLqRpxcsJTMQhCwdfEeY4hfrBojH51fsBlSWN2JJkk/bSgSNcR
         TCuw==
X-Gm-Message-State: APjAAAXXEFGSvnM2umNnMHIJIDrOrragcxI9G1eevFu/5Rv9ynBUheXt
        0B/P+NjZrMy6a+8YrQlwmgU=
X-Google-Smtp-Source: APXvYqzAIMhY6Zdnv2lpushSlhgBUByF4DIx9WlhnvlUwDly1zq7OdDiwebU19wyV8uYhH3Ccd6m/A==
X-Received: by 2002:a63:7e17:: with SMTP id z23mr24101863pgc.14.1566295163014;
        Tue, 20 Aug 2019 02:59:23 -0700 (PDT)
Received: from localhost ([175.223.16.125])
        by smtp.gmail.com with ESMTPSA id y188sm22045896pfb.115.2019.08.20.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:59:22 -0700 (PDT)
Date:   Tue, 20 Aug 2019 18:59:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 8/9] printk-rb: new functionality to support printk
Message-ID: <20190820095918.GB14137@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807222634.1723-9-john.ogness@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/08/19 00:32), John Ogness wrote:
[..]
> +void prb_init(struct printk_ringbuffer *rb, char *data, int data_size_bits,
> +	      struct prb_desc *descs, int desc_count_bits,
> +	      struct wait_queue_head *waitq)
> +{
> +	struct dataring *dr = &rb->dr;
> +	struct numlist *nl = &rb->nl;
> +
> +	rb->desc_count_bits = desc_count_bits;
> +	rb->descs = descs;
> +	atomic_long_set(&descs[0].id, 0);
> +	descs[0].desc.begin_lpos = 1;
> +	descs[0].desc.next_lpos = 1;

dataring_desc_init(), perhaps?

> +	atomic_set(&rb->desc_next_unused, 1);
> +
> +	atomic_long_set(&nl->head_id, 0);
> +	atomic_long_set(&nl->tail_id, 0);
> +	nl->node = prb_desc_node;
> +	nl->node_arg = rb;
> +	nl->busy = prb_desc_busy;
> +	nl->busy_arg = rb;
> +
> +	dr->size_bits = data_size_bits;
> +	dr->data = data;
> +	atomic_long_set(&dr->head_lpos, -111 * sizeof(long));
> +	atomic_long_set(&dr->tail_lpos, -111 * sizeof(long));
> +	dr->getdesc = prb_getdesc;
> +	dr->getdesc_arg = rb;
> +
> +	atomic_long_set(&rb->fail, 0);
> +
> +	rb->wq = waitq;
> +}
> +EXPORT_SYMBOL(prb_init);

	-ss
