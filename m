Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C797FC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C8B20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9VXu4fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfEWGvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:51:49 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38674 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfEWGvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:51:49 -0400
Received: by mail-pf1-f179.google.com with SMTP id b76so2697001pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 23:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/u0IIMx4hUCDdNNCAAoMiDqyTD82uTXkcVFUZRhEi0=;
        b=C9VXu4fkhhrfGZVtSFDkAp/Wc6zMZvt/GCRKxukOaKgeWbzLMcPGHzhGqYW18B/OWj
         PsqmGAPOLcMBAul7xRbb7yfsYJGM75YjkZFUsYdSm2XBd4Li8+x23GyYzTDqmOJnS2Mu
         WZrIrCPVklFBn4+TULaP4FFkalb3qmiqueqx4ej99umz4t9wWh1j4UCjfQT/OyIK4piT
         gmyrniKcBUlprddNOYeEh02h1YGGrBPm5YdkdM/qIr66FVuwLvUbvJJL51VBgE52G+IV
         zBhOtVmkUNeBmHZF2MkqMPM0smbnfZZCGwXeh5Xt5dXd5gHf3wgEabVHBpV6dfH5ldaA
         5q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/u0IIMx4hUCDdNNCAAoMiDqyTD82uTXkcVFUZRhEi0=;
        b=Gbdxh1xO8lxXZU/63CJEJOqvsiTBcIu/4Yi0WcrqlGp8VpkpPeGmvQUBAKqh317uwP
         mishTqJst6/qfbfoNGYFpizZM2FRieZAzYfrNWw1edIjEBGSlE1EHokCngLFwCZ9emdz
         psXdqKcuXWFqNNcTQn4O4hMdpZG30gN+F+WZAAdWJlDHhjwYGpbwY+mUbqNXFIx/PIgl
         I47f+Yp2JxIOsNdqtotIjDfxwXvDF2W50ug2aRqqWqWcBQ2DDQAD8zAjhk2+cIeIpn4H
         dYlQzhxCGiDwdm1lMi14puCDmy+CZNCTzw9aQk5vVokuyFtOMUFd5fCI9ocIjvwoKM1d
         vwCw==
X-Gm-Message-State: APjAAAWGDpjabhDcIT26dAxhAMIz+jPLxioEXtOiIiCYJadsF5r72Hji
        +ccWEvP2Xh/BqDczD2vOkOQ=
X-Google-Smtp-Source: APXvYqz2f25ppTcQwc3cqMFjB+n3EpDRXhaD45enSMNC18HNv/h1iXIOF3bmwSDJgtdk+oMmxkRbJw==
X-Received: by 2002:a63:2844:: with SMTP id o65mr10443042pgo.297.1558594308191;
        Wed, 22 May 2019 23:51:48 -0700 (PDT)
Received: from localhost ([110.70.27.122])
        by smtp.gmail.com with ESMTPSA id s19sm27543295pfh.176.2019.05.22.23.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 23:51:46 -0700 (PDT)
Date:   Thu, 23 May 2019 15:51:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 3/4] printk: factor out register_console() code
Message-ID: <20190523065144.GA18333@jagdpanzerIV>
References: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
 <20190426053302.4332-4-sergey.senozhatsky@gmail.com>
 <20190515143631.vuhbda6btucrkskx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515143631.vuhbda6btucrkskx@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (05/15/19 16:36), Petr Mladek wrote:
[..]
> >  
> >  	console_unlock();
> >  	console_sysfs_notify();
> > +	console_lock();
> 
> I have got an idea how to get rid of this weirdness:
>
> 1. The check for bcon seems to be just an optimization. There is not need
>    to remove boot consoles when there are none.
> 
> 2. The condition (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV)
>    is valid only when the preferred console was really added.
> 
> Therefore we could move the code to a separate function, e.g.
> 
> void unregister_boot_consoles(void)
> {
> 	struct console *bcon;
> 
> 	console_lock();
> 	for_each_console(bcon)
> 		if (bcon->flags & CON_BOOT)
> 			__unregister_console(bcon);
> 	}
> 	console_unlock();
> 	console_sysfs_notify();
> }
> 
> Then we could do something like:
> 
> void register_console(struct console *newcon)
> {
> 	bool newcon_is_preferred = false;
> 
> 	console_lock();
> 	__register_console(newcon);
> 	if ((newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV)
> 		newcon_is_preferred = true;
> 	console_unlock();
> 	console_sysfs_notify();
> 
> 	/*
> 	 * By unregistering the bootconsoles after we enable the real console
> 	 * we get the "console xxx enabled" message on all the consoles -
> 	 * boot consoles, real consoles, etc - this is to ensure that end
> 	 * users know there might be something in the kernel's log buffer that
> 	 * went to the bootconsole (that they do not see on the real console)
> 	 */
> 	if (newcon_is_preferred && !keep_bootcon)
> 		unregister_boot_consoles();
> }
> 
> How does that sound?

Hmm, may be I'm missing something. I think that the 'weirdness'
is still needed. This

	console_lock();
	__unregister_console(bcon);  // pr_info("%sconsole disabled\n")
	console_unlock();

is going to change the visible behaviour - we need to show
pr_info("%sconsole [%s%d] disabled\n") on all consoles, especially
on the console which we are disabling. Who knows, maybe that's the
last remaining properly working console. Doing __unregister_console()
under console_sem will end up in a lost/missing message on bcon (or
on any other console we are unregistering).

	-ss
