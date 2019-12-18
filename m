Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB55C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3D2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aESodwS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLRSgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:36:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39741 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfLRSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:36:01 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so1600880ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 10:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Y7UoDfvvX2HqTW7Xsj5rsSRAq8b3uYZqG56P5onidP8=;
        b=aESodwS4Rc8tgxbsUNWdVvZj7N0f6pNQQfDInXOarA1skszJDOqcijgq0JfRmHfmLZ
         i4B8gNJEOvXG32i5flt6av4OrGroKvPVjm+LFM/Ln0cwoYfeWdboAEQR/WN/VEuU6LFQ
         pB55l3DA+Mx7xq7NkySXXjONmGnfK9hnZxpxrbq6xVCpZR8Rsxlq5Tgm51DKfiGhnK8w
         nnMOvkbRqSo8ZsyD4xmlCUIwKi79zVe+7LimiOykoE5w2JvMgZuIswMyEF359qHGmPjT
         m4T0Hp/pXJRrADfZZYNjshs2GgnVdzXJQaMjULFSlobhttUE5hej2qK500fI7vH6jEtO
         hepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Y7UoDfvvX2HqTW7Xsj5rsSRAq8b3uYZqG56P5onidP8=;
        b=FxDb/9jILoI8C0aDJ7Yy7qHUSmECC2MOWT7SHEakI7fDiQXiDvoxGUEPPZHrHGpIPb
         nebIXs/Pogy3DiN4Ian9jJ6TtQ9HGylX2WIUY+h2DRhlY7dCZ76euICxdtpbtF2+2ANY
         3CJlhH0uSty1ZUrSIJdhievlV6OSns129ke7924NpQ6YctUHfDnqcVY9yfPGRNDjkvGM
         ic8EK4oqsSYZ2p8AV5K9AMiDuaKEJGUDIqh9h1p3iCiby9uvq24uqaqY6E5RbAL+Lh0H
         8GHVnTpabjC1SKLys/AGg67f4EYYvXg7juPOU6pZw41EQDO1RXDvV8FZGgv5Czfq8EZf
         auOg==
X-Gm-Message-State: APjAAAURGhkx1XhjyI23jjzdDc1jfAaOXrjEuAM2lIPvwwWNErI3eM0i
        ju0aGg3uRXo8xzDWDlJNPPSj0uh6XhM=
X-Google-Smtp-Source: APXvYqyh2Fla+hdRA8p6ZfU6BLMMzNOAxGNOF0009rv3oAyLIaxDtI1aVjabeCotDr9EHgSv1iQMxQ==
X-Received: by 2002:a5e:8345:: with SMTP id y5mr2645645iom.122.1576694160882;
        Wed, 18 Dec 2019 10:36:00 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id w21sm623330ioc.34.2019.12.18.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 10:36:00 -0800 (PST)
Date:   Wed, 18 Dec 2019 10:35:59 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, maz@kernel.org, damien.lemoal@wdc.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] riscv: change CSR M/S defines to use "X" for prefix
In-Reply-To: <20191218170603.58256-1-olof@lixom.net>
Message-ID: <alpine.DEB.2.21.9999.1912181030090.14542@viisi.sifive.com>
References: <20191218170603.58256-1-olof@lixom.net>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019, Olof Johansson wrote:

> Commit a4c3733d32a7 ("riscv: abstract out CSR names for supervisor vs
> machine mode") introduced new non-S/M-specific defines for some of the
> CSRs and fields that differ for when you run the kernel in machine or
> supervisor mode.
> 
> One of those was "IRQ_TIMER" (instead of IRQ_S_TIMER/IRQ_M_MTIMER),
> which was generic enough to cause conflicts with other defines in
> drivers. Since it was in csr.h, it ended up getting pulled in through
> fairly generic include files, etc.
> 
> I looked at just renaming those, but for consistency I chose to rename all
> M/S symbols to using 'X' instead of 'S'/'M' in the identifiers instead,
> which gives them all less generic names.

This is what Christoph did originally.  I asked him to rename them to the 
generic versions to align with how we discuss these internally:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1910181647110.21875@viisi.sifive.com/

I'd propose that we just start by prefixing the IRQ_TIMER macros with 
something like "RV_".  By prefixing the macros with a namespace 
identifier, that seems to solve the namespace problem more directly than 
sprinkling Xs around.  Then if it looks like there are other symbols that 
start conflicting, we can do the same in a larger patch for the other 
CSRs.

Of course we could also do the same to all CSRs up front.  Do you have a 
sense of what the current conflict situation is like with those?  The only 
one I'm aware of is with Mobiveil and predated this patch; it was fixed in 
the last merge window as far as I know.



- Paul
