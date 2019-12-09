Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F29C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022AD2072D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irbGLck+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLIJT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:19:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36330 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:19:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so5463588pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rblqrVWgHOkLe8re4/2fq7AZG311veSlNYjEA4Bdios=;
        b=irbGLck+knp1Ju7e9pP0NpD0AzNpAOlf8ABivW0Ml5lBNACQwxbCqw/lIuUQizc3ib
         Q39CrDMnBtHy6nZ4ffYTzmFtVgCPgXeaxEwC7sOuahuvXz3logOsd1CHSEqCmTmjvFcm
         HoMTL/HXPWOcQWNsKWs44ZibzyoQpOiPd6j6mYchuVyS1hEEt5Q0PyzsXr2IRXIB1MV6
         8rCxtypGhoVBovjl7cZFdfLYsZg+zZa7RVIZmPXwgQ9j6yivgaIl+XEJyK1+vrsNtspY
         gs7pgnuI6VDhcVzKE1fQ9mT9V0x/5Zja7pJG5ZZeRvBGAqroID0CX6KivVSqEkyHPJO6
         HJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rblqrVWgHOkLe8re4/2fq7AZG311veSlNYjEA4Bdios=;
        b=oveTnLp7iOpTu01YrvDveBJEllulH1M1lpN9Hm4pRCDbZsvGLpVabvTYm6T6ZwYLdk
         /McuPyaE2e+Pdvb777uspwIYeiNTbRZDbf6hL/M2gteYiUmnun1GuLBnvFvh++pePCom
         HOFfrUlyXAkCYipkehBIepGhOv6m/RuTFVnJw5FuhwnREejr7b86eq4OUrvD4v4FVRl0
         hE6ngNO2ZfdhF+M2lYR8+b0a9pDs6fuFGQhc6oRMmi5b1jlDSUQtxt3n00ZDcWEySRcG
         ZTgtY4seMA9whKvJlsyes9I/SWtv3ftxtmGN2AIXyUZkz2Q5y9/bZPOzwPOapQxRVbB9
         jkMg==
X-Gm-Message-State: APjAAAWd5S4wE/D0PGmyuws/J9oAYMXdqxQnuROYA5OxRwaL0gbXj/S0
        K7T+RRwE5VOwLUlGDfpzNPE=
X-Google-Smtp-Source: APXvYqw2ZlZOWUS2rME9afylFB5pXb3oqENJCiCE0CvOZ4S8LNdoJJ6zejKVkEIpVL2q9JwflgtFyw==
X-Received: by 2002:a63:1447:: with SMTP id 7mr17603167pgu.22.1575883197881;
        Mon, 09 Dec 2019 01:19:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id z64sm26719931pfz.23.2019.12.09.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 01:19:56 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:19:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191209091954.GG88619@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/02 16:48), Petr Mladek wrote:
> Hi,
> 
> I have seen few prelimitary versions before this public one.
> I am either happy with it or blind to see new problems[*].

I guess I'm happy with it.

	-ss
