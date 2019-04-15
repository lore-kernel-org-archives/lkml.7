Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5AE2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555323617;
	bh=xkkT995wyHiGNkJTyDY9RuTkCF7U40vt++nhBYST41U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hq301ejcMKfmmvlpYDOS4K6+PJmUfocQnAfufuQDAnqlB745bIJey7ZRURSzDhwJ1
	 6K1ei261yShKeJSvXv9cSpqYdW3SwZi3Bb38AYKTVwdgETYILerJISNK6TdF6toDrf
	 NCywvMt3ysTBl94JovNmOzM3WOHaFBw68y5J+HOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfDOKUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:20:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40554 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDOKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:20:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so15087726ljq.7;
        Mon, 15 Apr 2019 03:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bqYAp/he9RcQe+K1USjID00PfUaljcvAy/YDV5xrNu0=;
        b=Vtf3SlckqOS7vf76vmPSNdYxbvfTbiHI+3KhZdypAzY8FDSiIh9sJgQ+mBl199wZhk
         nlorY1Jyy+s2xa367/6cEOuAiUnmZT1DBtsJU94/KrSeuwgIDtq7Hx5LMhWoYq8hAdKz
         qPKOu1kyza8JR7Lu2AWMI73MenlcZygZXHEQiZ/izyDC7jURVUBkMrXj+zRNiOk3pl/m
         QeFwnUZBzFx4Eow5s+tb7e2JpyyRA1j0T0nrybeh7P0uSbV+Ssinzrt2vwtdwXWv9MNj
         Y8d3ZMUFZk37uiPpRm2p/vWShfnOLUqE8MIu50MRE9b0zGFYS33SOvKUOarxuPIJbSiQ
         3qVA==
X-Gm-Message-State: APjAAAUM5hO6pvl0+AErmWL+sdQ8qeYeh9RwmtEIU8Owtq1rUgzj14ha
        zYbfB32kXNOoJWR+dPxoW7w=
X-Google-Smtp-Source: APXvYqw9oyN9eUrBKy8vJXhI95uC5hG4QSqFBRXN3zRYA994/kLCJpfOQgRBfoVFEynNd5XEJ4HN1w==
X-Received: by 2002:a2e:895a:: with SMTP id b26mr38057860ljk.89.1555323613764;
        Mon, 15 Apr 2019 03:20:13 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d23sm2805988lfj.64.2019.04.15.03.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 03:20:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hFyio-0000Bc-6P; Mon, 15 Apr 2019 12:20:18 +0200
Date:   Mon, 15 Apr 2019 12:20:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     peter_hong@fintek.com.tw, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH V6 1/3] USB: serial: f81232: clear overrun flag
Message-ID: <20190415102018.GD29656@localhost>
References: <1554280832-29286-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554280832-29286-1-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:40:30PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The F81232 will report data and LSR with bulk like following format:
> bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
> 
> LSR will auto clear frame/parity/break error flag when reading by H/W,
> but overrrun will only cleared when reading LSR. So this patch add a
> worker to read LSR when overrun and flush the worker on close() &
> suspend().
> 
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> V6:
> 	1: Add deferred_lsr_work_needed to re-trigger when f81232_resume()
> 
> v5:
> 	1: Source code base revert to v3 and remove all v4 changes.
> 	2: Add serial->suspending check in f81232_process_read_urb()
> 	   before schedule_work(&priv->lsr_work) to avoid race condition.
> 
> v4:
> 	1: Add serial->suspending check in f81232_lsr_worker() to avoid
> 	   re-trigger
> 	2: Add port_priv-lsr_work_resched to re-trigger LSR worker
> 
> v3:
> 	1: Add flush_work(&port_priv->lsr_work) in f81232_suspend().
> 
> v2:
> 	1: Add flush_work(&port_priv->lsr_work) in f81232_close().
> 
>  drivers/usb/serial/f81232.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)

> +static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
> +{
> +	struct f81232_private *port_priv;
> +
> +	port_priv = usb_get_serial_port_data(serial->port[0]);
> +	flush_work(&port_priv->lsr_work);

Note that usb-serial core doesn't manage the interrupt urb for you, so
there's already a bug in this driver which should be fixed in a
preparatory patch (i.e. resubmit the interrupt urb on resume).

And if you stop the bulk-in and interrupt urbs explicitly here, you can
safely flush the lsr work without any races afterwards.

Also note that the interrupt work is currently never flushed on suspend
or close either... Another thing to fix first.

There's also a layering violation here, since you're accessing the child
port data from a parent interface driver callback. The port driver could
have been unbound and you'd get a NULL deref here. Iterating over the
interface's ports, and checking if it's been opened (as you need to do
on resume anyway) might be enough though.

Johan
