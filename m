Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B13C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88392075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WAxrkLng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgAGLQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:16:00 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:47058 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgAGLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:15:58 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so45337729ilm.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 03:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kypRA7JMHk1v7MxzKCcUZ8vO8CJrvSfBF/vgrYLZzLs=;
        b=WAxrkLng0N51YO/HxMWdKmP3MBdFhRH67U4dYNeGCc2DeCf4y5JrR8t6Bl4Rws0uQm
         AlZe8/enQtXFoR/MO0heuEPF0/jJWV4p0xPLr9UGr1BUTC9Vvm4+8/qWV6KJoZwK1KWn
         4ALVtnFGttzFci5n+Lzz2HnlF1xy3+bqPfxhFNHzp6yrwyJa8Fq1FF9jHMI4b4DznHmC
         BXK6XbyGTVIwhXBnfGLdDFt0ChyJqBQWJtzNrhgonSiC6+b9jVvpfb7vSPP2FSqJczFI
         PHK7nSquh3JFWDZdhhVvNCUvdqRD5j5lpglbe9dnokvJp6SyNGYIo0eUVJknWudJHGRk
         6zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kypRA7JMHk1v7MxzKCcUZ8vO8CJrvSfBF/vgrYLZzLs=;
        b=BK+uk6dGTi1wDFTIgrdl9NhU5d+odSUUGEDwJnSzWOkv/6MV8i06W7DNO8KfphJJoe
         2145N//PenKhuRxOYmAJ+Tg2Wl5y4bCtkDYspYnRf2okzW21Pdy0QRUQJ3dPF24dBFJX
         yAPtnvd5kW8R5vWEc/8QqtadeIFyAZSUlm9UhTV5PjhhQYZJqTbjEemR9fC69rvIgJ8T
         iLP65OIkwWnjscuZ9AWr21mxE6Kw30QjX0rpVabWfmknDcKWd80gqtZG1PC7lB9FqZuu
         do1Ewrep3TNb5FblLTnFhMh8HOq+wNgvWQp4e9OJd5X4cBTLYKnctmgoT3x1oXivmWPr
         eRPg==
X-Gm-Message-State: APjAAAVRnXXmfJhmDuSZAlduno+maYXHRQnDjHBH2/hPdUIJbMFjilIr
        IDeozBi3TJ1yLCT+dIBqrfb0yw==
X-Google-Smtp-Source: APXvYqxrIj55LYycBTrbBE+ljCYOHB9ysZ8mMBJp/6ZfUJDQG+HkGsk064dRkXUbjSZcuErja8iRng==
X-Received: by 2002:a92:5ec8:: with SMTP id f69mr91584935ilg.8.1578395757558;
        Tue, 07 Jan 2020 03:15:57 -0800 (PST)
Received: from localhost (67-0-46-172.albq.qwest.net. [67.0.46.172])
        by smtp.gmail.com with ESMTPSA id a12sm17977316ion.73.2020.01.07.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:15:57 -0800 (PST)
Date:   Tue, 7 Jan 2020 03:15:56 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] riscv: change CSR M/S defines to use "X" for prefix
In-Reply-To: <CAOesGMir810kVTDyoTFuhK-PdFe4J2u2VM+L8jOdO8DghAELQg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.2001070314050.75790@viisi.sifive.com>
References: <20191218170603.58256-1-olof@lixom.net> <alpine.DEB.2.21.9999.2001031723310.283180@viisi.sifive.com> <CAOesGMir810kVTDyoTFuhK-PdFe4J2u2VM+L8jOdO8DghAELQg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020, Olof Johansson wrote:

> Sure, this does the job. I'd personally prefer consistent prefixes but
> that's just bikeshed color preferences -- this is fine.

Thanks for the ack.  For what it's worth, we're in agreement that we 
should prophylactically place RV_ prefixes on the rest of the CSR_ macro 
names.  I just would prefer that it's done outside the late -rc series, 
since it's not technically a fix.

> (Builds are still failing for some configs, but will be fixed if/when
> you pick up https://lore.kernel.org/linux-riscv/20191217040631.91886-1-olof@lixom.net/)

That one is on my radar - just haven't had a chance to review/test it 
yet.  Thanks for sending that one too! 


- Paul
