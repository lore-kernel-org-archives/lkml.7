Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186DCC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E738921835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cRxAVTCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfJNOxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:53:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38648 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733085AbfJNOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:53:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so25809066qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PW4dLGOu0G6vmgzC0OiOGD0cErQ2nKSsOL/RWiAFO5U=;
        b=cRxAVTCLGwQVzpxkkGI3xpEq9eB35FTosT9zUTaFO98lmY9LYe61TmdjvWvNyq1bF1
         fU+caLmvr2eX60OFJmQQXudIZ/yvbE7rChdr2JJ4CJYl+H4Fx8SH+3ktrWQ0v+g8stPQ
         t6VAd5zuydGWSKG+CaJ9HMtwNsDy74/VQqVtBcehCw3J3NFVldOR40wUsh3Sl0yx2rvB
         Mdpk3RLXgsX7HaZSsRz9SdkvFEfPJMaYy6mFAtvQsppmX7yifZOszzgtwI+i1lR/pdbx
         xrlXvqU5th1+RSDNsPdu836nIQDIpQepahEuXF/Jny8jEm4vBMNMurEZCQGvGrrlRzQM
         WIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PW4dLGOu0G6vmgzC0OiOGD0cErQ2nKSsOL/RWiAFO5U=;
        b=iTZG5LuHMC8T9/VmwNV69+n0lwDENSnl9NG6vra2NO13y785DVk2UETMA5MEL1w6US
         in9m7jPMxogjbwbRKb4f066y9dbx512rkuKexxUdGDMkXvD5rAEqZzO11ty4VmAf1gfD
         l2QpYEPQq1jTLuvupHIqs9OqHV63nwzCRVS5oTbh4PrXZgUgb2pw8RSBohn45HwDR1aS
         W6nplwwzV8Po53UjGcx4YTys+AGVTS4ruN/vSXRM6+gcmtOlFFmsjIH8WyYaqigufYvT
         9xutTHbJ5KUPn0aVLQ0RSXH0gnLb5heu3RO/RD9Xv0u2aNnfKNfgdDC/YoKSLkE3TxZL
         lcZA==
X-Gm-Message-State: APjAAAUsfCmqGAI6/Ilp8smNN6SWtBv+dju0Om616GxcUdFI8oH7kN8L
        5k8YI5vt4Aw6oC9NPVy4VBu3oHUg3Sc=
X-Google-Smtp-Source: APXvYqyjHl+VvE+l5oagDo8fcPwf+f3sMtn5/JVWfT9V7LYxkEutHjZ5jV7ENvkRMxVpMDHTN/tlYQ==
X-Received: by 2002:ac8:29c8:: with SMTP id 8mr31511933qtt.32.1571064821043;
        Mon, 14 Oct 2019 07:53:41 -0700 (PDT)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id h68sm7959128qkd.35.2019.10.14.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:53:40 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:53:38 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH] arm64: hibernate: check pgd table allocation
Message-ID: <20191014145338.hc7dm6ypzvzrgxrw@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20191014144824.159061-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014144824.159061-1-pasha.tatashin@soleen.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-14 10:48:24, Pavel Tatashin wrote:
> There is a bug in create_safe_exec_page(), when page table is allocated
> it is not checked that table is allocated successfully:
> 
> But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).  Check that
> allocation was successful.
> 
> Fixes: 82869ac57b5d ("arm64: kernel: Add support for hibernate/suspend-to-disk")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Forgot to include nit from James Morse: remove empty lines between tags.
If required, I will send out an updated patch, otherwise it can be taken
as is.

Thank you,
Pasha
