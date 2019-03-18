Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9B72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMZ+ZEPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCRMub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:50:31 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44296 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCRMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:50:24 -0400
Received: by mail-pf1-f172.google.com with SMTP id a3so11182417pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8rHSP9iRmECbyQFvWEgH3WGzK3oktqWgDzA4VeVNadA=;
        b=tMZ+ZEPd8MyOFcLSjawDwBG3qwY1t8P+kKQhFAEdLiQ4infpocLSgxO1gaR0N25lUj
         mpeuwGKskVb9isi85KmO2QXfrWcRDRawglcCxe/wih+AWFjv0dVVkvgfJfbMOYidSDxd
         R5FWoLKuIl6bPhbrZw/o6MVY02UZl2Y1SFcLM6LaG4Hmg2F7vfXkXGjdJqmN1VwDqeAg
         uZm+gB8agMOe4cVIdaXiMo9pp8BvwbUJBH6YumRdNr3qwea8BdXQKnttRNSpz2cSPqwB
         WvNu2jsil4pXwf/9FihDMvsett0P9K3FbFiER6Ii4GcJ0cM1WlbbBkkGbjt3KwvV9mHD
         sjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8rHSP9iRmECbyQFvWEgH3WGzK3oktqWgDzA4VeVNadA=;
        b=b1Z0hkIG9AnbYsRL7myBRvMspJ26wwwGLPEF1PHt7C+ppXiz5nBakt1IX2BZxVnRLo
         J2tOW5U2O1lO39b7lPYpyZnswbF+tMmPnLUydovFK+Hb9LlMgxnwzlc1wWr0SsT5ukaK
         9Z+uRJrG/8Tm1X6GRmQmO78vuo8LDWCYW4nLbrW0oK6fOWE6u/pAoS0fHmOhm76FKOkm
         qwAUAG0rmKnmoeDNFNt0wR/c2kyFUB6Ps3HNcCQ2Ln7Hmi/3L++uG9SIWZNPLIerlyv8
         UwZd3dy/SCanU+tWiLKtoO9vXqRPq5vDbUNl2uU7L633nnzvO9BNoiSiJT5ClcHrisJV
         H+9Q==
X-Gm-Message-State: APjAAAUTyN/P8TFjzAheN/iAzzRd7uIeNBS7wPlm1CMyxIQsGrrCxAFK
        7BbTgjBsMp7NEzisw4hDPrU=
X-Google-Smtp-Source: APXvYqzuvYB1g+1aAscQ0IR/Nwl93d1KPrMtfh/Hb64OY6O6B0cDgQrmsvPdKiJEqqko18ACWzJXcA==
X-Received: by 2002:a17:902:e50b:: with SMTP id ck11mr20006775plb.25.1552913423625;
        Mon, 18 Mar 2019 05:50:23 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id f192sm24643293pfc.180.2019.03.18.05.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 05:50:22 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 18 Mar 2019 21:50:19 +0900
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190318125019.GA2686@tigerII.localdomain>
References: <2a48dee7-b649-65a4-be5d-8b3374013cee@i-love.sakura.ne.jp>
 <CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com>
 <201903180527.x2I5RQVp009981@www262.sakura.ne.jp>
 <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/18/19 13:32), Dmitry Vyukov wrote:
> Wait, but isn't SYSLOG_ACTION_CONSOLE_LEVEL what we are looking for?
> syzkaller knows about the syslog syscall:

There is also SYSLOG_ACTION_CONSOLE_OFF, which disables logging.

	-ss
