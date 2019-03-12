Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A17C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E26F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmHQtAg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCLC6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:58:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44611 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCLC6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:58:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so703582pff.11;
        Mon, 11 Mar 2019 19:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gb99ATYP8IlhDEeZEtQ3KHaXQAmqFzucm+eRvpv9VUw=;
        b=ZmHQtAg80aDg/eVN+P9ACBZY91QpYKBhRb+TEXmOZ6J3s7iaR4baXmIlct2ZNcJ6f1
         zUQITuP3LOTJxQFI3a4BAgYNeo9+df+xB8m7nDWol/AWvvIxSFYk87oc48vY3m4iPz2+
         V7v+QvgwUMvxUxOh36m7v8bnq7+34gYiLRAU7VMfBMTdym76vnRrH9xooeD1cISo7RKT
         bIlj3N5TsY6egnpVDefwCdkVWwgBonQOQG4U2xlk0PMpgHhUxlLlrHAyljP1vrfP38Yg
         GUfknU66vn78kgDZk88reSg+GVi0iNo4TWy7DEd+pOPcpGk6Ut7fN31m0ZKglpgQdCJJ
         Lksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gb99ATYP8IlhDEeZEtQ3KHaXQAmqFzucm+eRvpv9VUw=;
        b=TI0M1WnoSVaq3FXOZIrRu+w6iDlzhsvfvNv4vQpnXnDit+wG76A6c6orgd2HA4yJK+
         4a+/j6A5dW2JTGjAPrx//Uhk5/Wyg2YoADnfpr3DGhH0lZSvV+Cc9jShd3WFbbx7nB92
         VpBR9bJoSzlJQCnuILZwa2iW/JHc7LnwWMjpTAudLyH1cVWaUD57HFGQn95h+4Pkc7ow
         zWYjwEIXAWFQe4ZEBAzHrYfTwLWn4JZQQiGXxw0MUDpyP644BWI6t2/7hu2jWPVwDKg9
         WElXd+7Rep7/OiyWh4qxyfVbj7qgXNkdImiW1DwDxQ+AtHf6p8+bAbYV1TU5n61xcz1I
         HNsw==
X-Gm-Message-State: APjAAAXvXlEYJdZd4kQEwunzoVDtGDaO2hygPluOtuAnrWbi3pCOasCj
        mMqBkxqr+kxqJVhBOGno2RA=
X-Google-Smtp-Source: APXvYqxMkI8jg0EaSBZWbU2uEdH8Qr4UDK1F0TezP/62tZjDO4ANZC0eIt35mSlFXWLEIwkm68vvug==
X-Received: by 2002:a62:b286:: with SMTP id z6mr36240315pfl.106.1552359531560;
        Mon, 11 Mar 2019 19:58:51 -0700 (PDT)
Received: from localhost ([175.223.22.108])
        by smtp.gmail.com with ESMTPSA id b6sm11355095pfo.27.2019.03.11.19.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 19:58:50 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:58:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH v1 19/25] printk: introduce emergency messages
Message-ID: <20190312025847.GD4146@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-20-john.ogness@linutronix.de>
 <20190307073029.GA489@jagdpanzerIV>
 <20190308103127.txsgv3d6lqlf6pad@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308103127.txsgv3d6lqlf6pad@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/08/19 11:31), Petr Mladek wrote:
> Great catch!
> 
> I think that it is doable to guard the list using RCU.

I think console_sem is more than just list lock.

E.g. fb_flashcursor() - console_sem protects framebuffer from concurrent
modifications. And many other examples.

I think the last time we talked about it (two+ years ago) we counted
5 or 7 (don't remember exactly) different things which console_sem
does.

	-ss
