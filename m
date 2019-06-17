Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C59C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AC420863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JyNz3YrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfFQKFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:05:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33814 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfFQKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:05:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so15359527edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VGA9c22y9jIlHDQMx4uvOibs7sOik31ZYkHYuUn6B2A=;
        b=JyNz3YrQXeZQihiVS68RHnnLZ6o5UO46RUXYmjIXxMarXHjp3quUe0sTP89h2RU8qd
         t9xqv9wTj260UdX5wH35ZuuOvUBtisoit/qwfK5Kgpmzpzqi1hm9ICfiSCaa6aeOrD/O
         fnDMZPUTZVNhS3eCTNHUSRvBTwqgFi5qzNsMPubsWuJaAZyy/bf3WT0jpYzk5F3cpjGJ
         VbGYngxQwu3kBOwmupErYz+LZog68KzmNfkuKtjTK6pxTOoD474ZOc4ZxGlZV/+5UV+C
         b3tIuf1NKkxfHiXsESOMMHBxCIMFfYJ0qDfMiA9QurTcSwBttbk/tx5IZROKrZGAFOrw
         XN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VGA9c22y9jIlHDQMx4uvOibs7sOik31ZYkHYuUn6B2A=;
        b=Hdg9QizBtqVt8zpmjJGISwcZrwmW1FHWfOQ0sddHMcbUpDr7m1Fn9yYFfnxONjHRia
         qAKLy/cO0qMBQvlIDwZVhuCYL4zscBTrjcX6KZ5i3VYZgEDF4kdaYK1uBCmsA0+Kl1ub
         a+ZFqh+caoSsDR1ygj554UgMOowVGG2iYOlfFmRBmj6+f4SzKmMbQU0VfdW66M7AdVpu
         +s5AHyYEyYeCa0CYX7/bxLrfywlh/RzgvA8oTeASQZTLh+VXN+J/KalfuAe+puSP+UVn
         3c2lVLvMqKhXeY+14BJPVOCBNZnFxoZ7g5pVKFv2g4g8m9F8jsLjYMgAC9Lmlyg8BsbQ
         uYqg==
X-Gm-Message-State: APjAAAXAgjxcsiq9UgYtJ+7VEORU4t4f7W7iL99eT2baIPOmJmCODrTR
        XW3uub6RyAD2tWaxkBApChC34g==
X-Google-Smtp-Source: APXvYqxgX3WrGXoEnt9ZLFi/AcNRTFEhFUprMEbyI8apql360t1iTkxRuRY3ryohJKMoEwBxTzhyYw==
X-Received: by 2002:a50:b962:: with SMTP id m89mr53812367ede.104.1560765907918;
        Mon, 17 Jun 2019 03:05:07 -0700 (PDT)
Received: from localhost ([81.92.102.43])
        by smtp.gmail.com with ESMTPSA id m3sm3433752edi.33.2019.06.17.03.05.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 03:05:07 -0700 (PDT)
Date:   Mon, 17 Jun 2019 03:05:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Andreas Schwab <schwab@suse.de>
cc:     Yash Shah <yash.shah@sifive.com>, davem@davemloft.net,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, ynezz@true.cz, sachin.ghadi@sifive.com
Subject: Re: [PATCH v2 0/2] Add macb support for SiFive FU540-C000
In-Reply-To: <mvmpnnc5y49.fsf@suse.de>
Message-ID: <alpine.DEB.2.21.9999.1906170305020.19994@viisi.sifive.com>
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com> <mvmtvco62k9.fsf@suse.de> <alpine.DEB.2.21.9999.1906170252410.19994@viisi.sifive.com> <mvmpnnc5y49.fsf@suse.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Andreas Schwab wrote:

> On Jun 17 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:
> 
> > Looks to me that it shouldn't have an impact unless the DT string is 
> > present, and even then, the impact might simply be that the MACB driver 
> > may not work?
> 
> If the macb driver doesn't work you have an unusable system, of course.

Why?

- Paul
