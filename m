Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295EAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF7C23D65
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZP/HtbcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfFCQow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:44:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37329 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfFCQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:44:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so12826406wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NJGdLM5jNQqVh/tXtUBikivLLdLINsdst7u6+yswu0c=;
        b=ZP/HtbcPUvZxB9Q0MbegeMtqPRO7+j1kGAVRul2PKgNJR6K921Hz7fTUyGFQbUj77L
         LwQd6qjhY837VcYfgp2KubDgIVH9s7Lzg3PFVLcjprFfEjheLcTiAeSkw/zXX5yCNfcd
         prn3n7KEGkH+eMcgRukviovUmE4ltZgvgcocQktqHOuD/2zdBC5Kk1Qg8vAXQ9T2WuGX
         FFmn2MZ+x6+emZ+QZNoo58rGewJGTWISPv69bMByWXdYPspwjGwdsvYhUwkgc03+qMwc
         +Yga41sHdylt3zlve6g/YCUygSivY7IEvuy3y/MK8RFpf0bzVLKUI9ukPMhhksnSfhvH
         yUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NJGdLM5jNQqVh/tXtUBikivLLdLINsdst7u6+yswu0c=;
        b=QcCOuZ2GxA0/X6fSwmYI+5GV+1vRI0GtzpFn1wIl5xXWoKMJIksOLe9Qjz7NUVgSZC
         hn/2IvSNEj9wCtmwRKCvcGfcHUw6c398KWm2FPlRCFbVSxepU/U8P/U1oWvPF0Nj+6Qt
         eCkBzc7K4CkGHRnJqn9/m+xNoyZPC84p9WPXp8H79ACmlx39ds9dA1OJk8YNzIVr4a1B
         js7qqsh2CfjI1se9c6ryxgUjOkHSx3KxwcdOJF5+Qt/18K99Bo7lWQT+kK49vRJ0awv7
         q4al9ivYyS63LPM6UnFlGBsc0WjW0P/478FAm5qJIAlJQbo4U7nFIEIFxHynhcnr4jWH
         dDrg==
X-Gm-Message-State: APjAAAUbIhZ8J3Au8CS7N6dM368yXMFL9TTFUUElS+wjugyY7N66Ma6C
        JJIU2isss4gZvV1KxrtF5F4UuA==
X-Google-Smtp-Source: APXvYqylUdDthXrcelrczQuGZiYd5FlDHM36e3ws0O66EvAYivxEwAu7vFW5tazmo1WoiSWybHvoqA==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr11501355wrp.6.1559580290951;
        Mon, 03 Jun 2019 09:44:50 -0700 (PDT)
Received: from localhost ([213.208.157.39])
        by smtp.gmail.com with ESMTPSA id n4sm13252749wrp.61.2019.06.03.09.44.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 09:44:50 -0700 (PDT)
Date:   Mon, 3 Jun 2019 09:44:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup.Patel@wdc.com
cc:     schwab@suse.de, Palmer Dabbelt <palmer@sifive.com>,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and
 HIGH_RES_TIMERS
In-Reply-To: <mhng-faba08ec-69a7-43b1-b2d7-c2e996751506@palmer-si-x1c4>
Message-ID: <alpine.DEB.2.21.9999.1906030944170.9338@viisi.sifive.com>
References: <mhng-faba08ec-69a7-43b1-b2d7-c2e996751506@palmer-si-x1c4>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019, Palmer Dabbelt wrote:

> On Wed, 29 May 2019 01:00:35 PDT (-0700), schwab@suse.de wrote:
> > On Mai 28 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
> > 
> > > My only issue here is testing: IIRC last time we tried this it ended up
> > > causing
> > > trouble.
> > 
> > I've been running kernels with these settings since the beginning, and
> > never seen any trouble.
> 
> OK, I'm happy with it.
> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks, queued for v5.3.

- Paul
