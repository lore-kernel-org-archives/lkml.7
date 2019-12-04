Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC039C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA03D2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OTaLNAYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLDTiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:38:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39128 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfLDTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:38:52 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so898036ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 11:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dnl8sq3/Y6KZEMi16oi7HdkMoIiTgYXzOZkT56rB0us=;
        b=OTaLNAYiBFoVe8AeZgU3tkYdNoZ3BTso4c3fdw4P/4T4P0n7+SpDqtKDI/Zs2tpQxB
         na89AJmRZQIniUs8k7YAcMzt0QUtO3jy/asn2AX3pIhmgZZ/V0r0dHrA9cL3l9BWSUm8
         8+FsvtA1M3WmSM9k/RFiNrZHqUDZX9nHgaUH/EEVfWl0HIuaD3E7g1YLROvdPBaoDcfP
         2SThcxKOBDjXxnyE88JUKfNwUv9oart/q/YlC27z62EUi28fJtGPJkOjvDOt/5nbkz6k
         JcOhw+vXSHKdjXjkWfVWb4XIN9FkwxPg2vieBbPs3j95WZlM2A6eyYfblv3Q9CHi77lo
         yNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dnl8sq3/Y6KZEMi16oi7HdkMoIiTgYXzOZkT56rB0us=;
        b=eYIsMdAgl9/B8MycHENCIeYqYQN8KDvB46rLdkiD6d/uORKAKMpZPEyUvsWj0gAdb2
         lxY70un3OhVWBYOhClpuTvDZlKyVYdoquuGWEsyYpWm1SdhqquDJm6Z9MOZkQFrGAi3a
         TRZpCUN+zQQcquwM5CgvFDY//rHFR1cF6OT9m9EVNT9q5WZLrUlEc1g2JoMuJD7D6xt1
         G9E/LoE31rz6/rQ5kSeMN2a4um5m+2GutqhanNn6+ityEZPEi//r7/X3IaTYQlCrjjVf
         cLaddLPQ+5eF9b7Cfs7OdkhykHRXjwINV8au0k5gh0PoBZl1N1p0QFG/QaM3fKf5UVBQ
         woNg==
X-Gm-Message-State: APjAAAVUxWeKvs4aocxPsql53dIOxYQp8ZSe6nubIEOM8ddcvOJL2mfw
        Rd4wVqNiqZgc31x3D9vMVAYXiQ==
X-Google-Smtp-Source: APXvYqymOP1UPHAJ1vCK7SiRpUc7QAm62tq6NxqLA7O7BzVqLOB4a/lWy6LZPcmT2tiD42qxSAXAtw==
X-Received: by 2002:a6b:8ec9:: with SMTP id q192mr3230104iod.237.1575488331468;
        Wed, 04 Dec 2019 11:38:51 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id o83sm2061039ild.13.2019.12.04.11.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:38:50 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:38:49 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "anup@brainfault.org" <anup@brainfault.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
In-Reply-To: <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>  <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com> <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair, Anup,

On Wed, 4 Dec 2019, Alistair Francis wrote:

> On Wed, 2019-12-04 at 18:22 +0530, Anup Patel wrote:
>
> > I had commented on your patch but my comments are still
> > not addressed.
> > 
> > Various debug options enabled by this patch have performance
> > impact. Instead of enabling these debug options in primary
> > defconfigs, I suggest to have separate debug defconfigs with
> > these options enabled.
> 
> +1
> 
> OE uses the defconfig (as I'm sure other distros do) and slowing down
> users seems like a bad idea.

While I respect your points of view, our defconfigs are oriented towards 
kernel developers.  This is particularly important when right now the only 
RISC-V hardware on the market are test chips.  Our expectation is that 
distros and benchmarkers will create their own Kconfigs for their needs.

Going forward, we'll probably add a few more validation and debug options, 
as Palmer suggested during the patch discussion.


- Paul
