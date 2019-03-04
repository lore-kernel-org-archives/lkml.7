Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD27020815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVQ6duiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCDLHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:07:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfCDLHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:07:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so2791831pfa.3;
        Mon, 04 Mar 2019 03:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zoeAeqYklkUqXOCmIzigfy878m+qTOIptQmkrFFyueU=;
        b=oVQ6duiG56Vu7mROqEAJwdtE8wSWl+Khy+SGOWCc8Kin+rJIdaFMbhANKbZoHUDw+2
         4HflajTBMXoQRiLPAIOpbJ3FRWXq/0HROgXSiSZGS5wwUAQdNHIaGMxNgYyvx0u3OnXz
         z69kq3PfPZZSK47JVXxEqcgvlKkv2XwUXaTygrwBe9w+qjYycIqp483W2EK6d7+pQnXE
         tcphz5j+CpvF/feVsgn8xrIIVXCiHUpN3DzIJHI68hWRMgSMlzy/XnAxewlaZjU1a7E/
         4L1CowyUMrGz8B62M8wDzFFAB1k04v32i8X3OsqU4ZyLeHs1LLm21Qj2RqqAqw2ko+l4
         bcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zoeAeqYklkUqXOCmIzigfy878m+qTOIptQmkrFFyueU=;
        b=KY+XjJavdokTeHQxdVXOTTo+exIu1sUzerH/zmXDEYx0rSBj3NJpmj3auNzeyq7hxk
         1wpZTE5SLSwxIbwx/+EXGlHWIZ4MBEbpTgKvILWK9v2uTJ2Q/qTSWQzxSvyCsXim/a0r
         pg5vo+7AvDGePH3z37FMuM77X6f1Vaa4M1/iMrCyMRvtS8RWI6e17qMPSPuaDXFwhLd7
         rU0KQC26OuF1WQzvvGMSYYDewuNdmC8Kt1IdFLRlG0dxSUtuQ0LaiVNt9gd4Wo1+4Ujt
         z9xezBWZU+0bhgRxkyWa1BJnpky72scsYMkPbRx+BD9J9vVWaLe/VZSwfdhcEbEGDNnA
         d1ug==
X-Gm-Message-State: AHQUAuZIF8AMQ1JlPhprYP53y4lNBv2+KEKzrvlgNyjMZQ6cKGa4Ooxj
        /Qx8fO9E+ckEMh/zZz3QK3E=
X-Google-Smtp-Source: AHgI3IahOILMRkeX0DB96qKnUGaBEbVJVSb2WJMF4bw7bjqeM+sGzk2BTsexWdxh2MFA+uFgF+awfg==
X-Received: by 2002:a62:ab04:: with SMTP id p4mr19450388pff.142.1551697629226;
        Mon, 04 Mar 2019 03:07:09 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id f3sm7511310pfn.100.2019.03.04.03.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 03:07:08 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 4 Mar 2019 20:07:03 +0900
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190304110703.GA960@tigerII.localdomain>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304100044.GC21004@jagdpanzerIV>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/04/19 19:00), Sergey Senozhatsky wrote:
> 
> But in general, channels which depend on preemptible printk will become
> totally useless in some cases.
> 

Which brings me to a question - what are those messages/channels?
Not important enough to be printed on consoles immediately, yet important
enough to pass the suppress_message_printing() check. We may wave those
semi-important messages good bye, I'm afraid, preemptible printk will
take care of it.

So... do we have a case here? Do we really need printk-kthread?

	-ss
