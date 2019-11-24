Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5419C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8501820714
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRwYMzHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKXACi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 19:02:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35295 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKXACi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 19:02:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so13036762wrw.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 16:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4sL4gLO/ZHIBUl1qn3k+Jb7qr9qTcV6aRv4ihkZ2iEg=;
        b=SRwYMzHDnXThIOo3rxH2fmgBfR9jTC+IvOrTOn4/Idm1BirxDg/Ix2l/0amodaZDmN
         5BHuUJFo+pAqVwi0MxdTrJ2WPzPoCxSgqq7Rn31ashmw1RlIYm4/Tn9ni5mF+EZ/GKtt
         pjwOCkd/Z6V4sVUg3gaKGYnC2cK813ol8jyaTjKqmzl3WQesGUbbkVxbQ5nGXDPiR/hf
         DnB0/oxNfzKc82Fe0lEZlJtEoeL8k8eEsNstW5dANvZeuqTEIn/ULVRu9fhguTw5/lK7
         DcPppqTII7HTcsEjjzxp7lD05vUpEIk9fAbyg4h8oe0TzZWUJ9AuCLbCPLK/iPof4Zmf
         VdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4sL4gLO/ZHIBUl1qn3k+Jb7qr9qTcV6aRv4ihkZ2iEg=;
        b=m7cOqXWP2VEPhIE7TzazzfExkP2raYcjo8a50fXm8FAuvfV0opC5nbKvik2eqJ7XmW
         ylt1bLM7r4qJC8HadTY9gM+YbUpaZoWA1nhPnQNDf7qaGmuU/zMt5T7Fnvo6HmXAqVUg
         aj3YGNIQk9ocTLwOWv3Eo2K8tSLfP4KrrHsWMgwPUnfu8l8G8EeOf5+GTdP10Qv+mCsC
         IJ7zIZsKJkwOKkt2w75hMA5Mvd5NvFwdCx1KIkrwUyZ/lq5xKPJZYHWIZD4kPqtyQCOW
         oiMIEF5zkWJXf51P9988+U7nSY5PzYYJlnXfMpKmlyvZrOm7qSLpm7ZceLniof/TMMKS
         9TfQ==
X-Gm-Message-State: APjAAAV80XlDjrQhMOnfiIuqec+BxuCF/Pov5jUQ16zSsa4PK7z7q/NI
        291KPU4BjR5EKeCqNQhbTnPSulY0
X-Google-Smtp-Source: APXvYqyUbZ9JZWtqwPPyd6Cnl5Mbt62xoU0ti76G33K8S+U7dmguDPH/qsm3/ZtBs376cAIwOu1MpA==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr5266064wrm.394.1574553755604;
        Sat, 23 Nov 2019 16:02:35 -0800 (PST)
Received: from debian (host-78-144-219-162.as13285.net. [78.144.219.162])
        by smtp.gmail.com with ESMTPSA id c11sm3882418wrv.92.2019.11.23.16.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Nov 2019 16:02:34 -0800 (PST)
Date:   Sun, 24 Nov 2019 00:02:33 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a
 race condition
Message-ID: <20191124000233.xc2rp5umut4g3mnx@debian>
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
 <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
 <20191121164138.GD651886@kroah.com>
 <20191121210155.limd7v6cpd5yz2e7@debian>
 <eef58b47-f208-2ac5-6e02-a87f9568c70f@suse.com>
 <674a05c6-67d7-f337-f529-ca1c62c35624@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674a05c6-67d7-f337-f529-ca1c62c35624@suse.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:11:26AM +0100, Jiri Slaby wrote:
> On 22. 11. 19, 10:05, Jiri Slaby wrote:
> > On 21. 11. 19, 22:01, Sudip Mukherjee wrote:
> >> Hi Greg,
> >>
> >> On Thu, Nov 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
> >>> On Thu, Nov 21, 2019 at 03:22:39PM +0000, Sudip Mukherjee wrote:
> >>>> There seems to be a race condition in tty drivers and I could see on
> >>>> many boot cycles a NULL pointer dereference as tty_init_dev() tries to

<snip>

> > 
> > Interferences of console vs tty code are ugly. Does it help to simply
> > put tty_port_link_device to uart_add_one_port before uart_configure_port?
> 
> Alternatively, you can try setting tty_port in uart_install by:
> tty->port = &state->port.

I have not tried these. will try.

> 
> BTW do you see the warning from tty_init_dev:
> "driver does not set tty->port. This will crash the kernel later. Fix
> the driver!\n"
> ? Maybe not given console is registered already, but crashes.

yes. I do see the warning but I have always assumed that the warning is
because console is openend as soon as it registers and so uart_add_one_port()
does not get the chance to link it. Is it not so?

--
Regards
Sudip
