Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162A2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F0320672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ5UutHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUVCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:02:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34084 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKUVCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:02:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so6183793wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KhhCdcenu8JT9fVRRF+JElxTcseh8uLlM6hjFlflU3o=;
        b=aQ5UutHQBuXkrv9M84UPYripNNscWYe6D13MxWHjk1yqKjMHcqyiq6aOOKc7twFITr
         v6qQ/921HHCLC8jz+0Lv9qhOrEeRjUoikbD7v/mNzQ8LZJpZ8QDleBG0ObYgmAMiHXw4
         /tjkR9NGqco19+mI33LsgYoqb28/yZTX0Q4gm1uzwVPnmuezCKjH7+YxY724AXP2puic
         E+5XILxRfNM33WJZIx+05j1jwD6hhkNQuoXoooDP4aAtcTm4sVARmS8QM+14W3JiUfn8
         +pDy+jMS1GUj/SR62zTSSCeLoSdlPN373bXVmEuNDgYBouon4iThZlmAf0+sYabxK5mX
         11RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KhhCdcenu8JT9fVRRF+JElxTcseh8uLlM6hjFlflU3o=;
        b=TBa3RdZyigNAY6L2rQudf6GqJ1vf4CpeD372Uh3hqmEcXTy7hjtOpthysCiVKQcSRf
         bJzWuHk3tNyPXVHrX1Coyq10lIwozO+WCME2UXJmFLtkEc63axv15kspCFwsFRFhbgOP
         iL2o5n7zyfDtRxoOo8nN3EVGrwOJdOOj9lzP1XnQ8qOdTJrUlqGAf04I9pQidkiZOR4D
         siI8zvL64NYVoqTkS0cCzqT7fJ4ou8DcqpXZtfklCRYIN55IBXoZux7t9FrILanByNpd
         Xsx08TkM31nTmAmYCEgZFsBe5yrliyTPiv+CbngTRu+rjZlsGuGGCcufZAKoU6NzuWJo
         rOQg==
X-Gm-Message-State: APjAAAXHsWEBOXN82pwqFv7vCO+iw84dIA+G7Bl5b9AxlGwhvf5CKrr7
        pKPNtNE5/BYveu2+XeeWmmYddUBQ
X-Google-Smtp-Source: APXvYqwq2JlYeIu+6mVOQkeUgo9gvK2zoKiQsoH+85wKzLXsau2IvdRIVSP2pfUvE5tgO3ucOcXQ+w==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr13597678wro.122.1574370118024;
        Thu, 21 Nov 2019 13:01:58 -0800 (PST)
Received: from debian (host-78-144-219-162.as13285.net. [78.144.219.162])
        by smtp.gmail.com with ESMTPSA id x13sm911927wmc.19.2019.11.21.13.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 13:01:57 -0800 (PST)
Date:   Thu, 21 Nov 2019 21:01:55 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty: use tty_init_dev_retry() to workaround a
 race condition
Message-ID: <20191121210155.limd7v6cpd5yz2e7@debian>
References: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
 <20191121152239.28405-2-sudipm.mukherjee@gmail.com>
 <20191121164138.GD651886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121164138.GD651886@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Nov 21, 2019 at 05:41:38PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 21, 2019 at 03:22:39PM +0000, Sudip Mukherjee wrote:
> > There seems to be a race condition in tty drivers and I could see on
> > many boot cycles a NULL pointer dereference as tty_init_dev() tries to
> > do 'tty->port->itty = tty' even though tty->port is NULL.
> > 'tty->port' will be set by the driver and if the driver has not yet done
> > it before we open the tty device we can get to this situation. By adding
> > some extra debug prints, I noticed that:
> > 
> > 6.650130: uart_add_one_port
> > 6.663849: register_console
> > 6.664846: tty_open
> > 6.674391: tty_init_dev
> > 6.675456: tty_port_link_device
> > 
> > uart_add_one_port() registers the console, as soon as it registers, the
> > userspace tries to use it and that leads to tty_open() but
> > uart_add_one_port() has not yet done tty_port_link_device() and so
> > tty->port is not yet configured when control reaches tty_init_dev().
> 
> Shouldn't we do tty_port_link_device() before uart_add_one_port() to
> remove that race?  Once you register the console, yes, tty_open() can
> happen, so the driver had better be ready to go at that point in time.
> 

But tty_port_link_device() is done by uart_add_one_port() itself.
After registering the console uart_add_one_port() will call
tty_port_register_device_attr_serdev() and tty_port_link_device() is
called from this. Thats still tty core.

> This feels like it should be fixed by the caller, not in the tty core.
> Any reason that can not happen?

tty_port_register_device_attr_serdev() is part of tty core. Or is my
above understanding wrong?


--
Regards
Sudip
