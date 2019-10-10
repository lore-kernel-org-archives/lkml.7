Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABFEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A32208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q72nsd7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfJJFOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:14:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34483 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJJFOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:14:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so2898908pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2JtlwthTW6hFWiekVbPDmarJgI1J7zGrLckc12LVkH0=;
        b=q72nsd7mg4Uze7Fcrqpe68fqDYxb7JXfBCN5QGPxrNa9HA8BQLVdS4TSIm7QnMzGuf
         Hevt44P6qTE83HMAiLKzPQx6QJgx+z1fxSqVkJ5sLKV7e3My4YLRtOjMS8+D3wveLxNK
         BaorDlHGJPYMMNZA02kj31LP4bM9dr0BkqplPD2fGjFIPFotADyvBLYRZ41bdh98ftmM
         W35VVHhrIB2OZFdettxDuiIA6GvdPBw+ZS4L28CIUTSIXVM80MUJGODPpUATVWRptQMW
         DtxWbKIzlChhcU0TMisqO7BM4I/sw6WiarAeI7vVyIZ48vNr6JH/X1aJp/1YcYfTUWLw
         On1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2JtlwthTW6hFWiekVbPDmarJgI1J7zGrLckc12LVkH0=;
        b=FIvTLhc5p6THMsFNa0736yvCWLT51HAik9ijSALpElKK9LOWyMVzQouoLxX+Q4U73q
         uoiXr1EHBlhRstU554F988OWSBAs3Qzcm0G9RpMMCs0N4mQc5YS/x01T8vLUh0lNyY2h
         UG7idGONZTgIC0sQopWzI2ZH89gCVCnDr2iF+Ykv5pS6i2h/LsDK8fQEyJlxpx4gjkec
         xZUnSLvDyYLgAIO09vJBd0r8AegC+zbjnbRIKwe5EzDOiSTTD9qx46NGuG1uzHPcGhoM
         VSK8GdhpKrw+pBnH1somNTQRXxHyiKEaBGEPkCm0kj4iIVjEmGw7cjffTqLrut1oF2yw
         rtUA==
X-Gm-Message-State: APjAAAViFKd1XcutnlAqeMDFF0laRbrQrZ+T0wIsgyrgQitcbDtan149
        yeJZDHpzbAFGHVbrWAff7dM=
X-Google-Smtp-Source: APXvYqx8RUPy1EuZeoc+ueM7KiNHmEPZXYU12eb3qW7ogXsKwo2eodVANxFCxnhf22pAlnVtItC1Mg==
X-Received: by 2002:aa7:99c9:: with SMTP id v9mr8575142pfi.38.1570684459628;
        Wed, 09 Oct 2019 22:14:19 -0700 (PDT)
Received: from localhost ([39.7.28.208])
        by smtp.gmail.com with ESMTPSA id bx18sm3109042pjb.26.2019.10.09.22.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 22:14:18 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:12:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010051201.GA78180@jagdpanzerIV>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
 <20191009142623.GE6681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009142623.GE6681@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/09/19 16:26), Michal Hocko wrote:
> On Wed 09-10-19 15:56:32, Peter Oberparleiter wrote:
> [...]
> > A generic solution would be preferable from my point of view though,
> > because otherwise each console driver owner would need to ensure that any
> > lock taken in their console.write implementation is never held while
> > memory is allocated/released.
>
> Considering that console.write is called from essentially arbitrary code
> path IIUC then all the locks used in this path should be pretty much
> tail locks or console internal ones without external dependencies.

That's a good expectation, but I guess it's not always the case.

One example might be NET console - net subsystem locks, net device
drivers locks, maybe even some MM locks (skb allocations?).

But even more "commonly used" consoles sometimes break that
expectation. E.g. 8250

serial8250_console_write()
 serial8250_modem_status()
  wake_up_interruptible()

And so on.

	-ss
