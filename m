Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3ADC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B27D2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 06:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="QGg8it0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfEPGoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 02:44:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43590 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfEPGoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 02:44:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so1978532lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BhdVXLoJWMfzNzrRx3QHIA0XVbPekInrRo+E7wUe0oU=;
        b=QGg8it0LFXrhiHOL2cIDoPFSVJFb/6RU+b9EnGgVvbrDZwB2ufxFfQQJZyhqOyyhQL
         dh9bnFzcOp18FWKdG/vTjKN4GwXIuQMLroOD/OYw/cRqbw7+a4hIREdK43snVI5wECNA
         9X13z8jHT/y8jQ4Sveq5Zojk/JxViqrWErz10mdZ5SWuMCRPvX3WT9QUjpXMMdVah5k3
         HQ9x47BThbznmTjzLUUbPo2L2Obn5TEAqL2oFxOP1TfeBv5ytx9RyUyXCRebvO6EmREL
         6DzjXf3UZ5B5AoWTLRdbbeaOrEo0NTM874D3TtL8ZepDzl4B016HRInNFkNdFI5ioOI6
         r2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhdVXLoJWMfzNzrRx3QHIA0XVbPekInrRo+E7wUe0oU=;
        b=ckfrGfF3qwAuz91dx64CD3an4n33YjV8q8eyuBfwaaeCKeyArgpI2A7UPckvyX3080
         0AQGrD1EGjlLxHWTF+1Es1BLSJzX/YDKOh44+k0gb4LDWoDSjfgaJGoKt5hH0TqwOJtV
         cnVPuFqm9YpKLqljgVfS0ZqvkXEjfz6egEMVkJxw5e8EpW0L6ub9FvG1n+jS7hjNEwSs
         LVjrX9QTtUA6QYXS8CP13rff3WVOFfeNR0fF2kqyAbv7uwR+ftdX/b4TS5ETTJRd9lM1
         wp8tNU2R7gv67vLUBFLlCP2d+oH1HfCvD9dMohqJX7rc+hpF0sUQA8hS5JChfGL9dEyK
         5xkw==
X-Gm-Message-State: APjAAAWdPkWCM1Rc6KIuj9NChyx6dcl1O8t/ac7goOglZRvMPnnlN3nq
        GCOKc+fi1NhgcYsz5Ov61LSNDQ==
X-Google-Smtp-Source: APXvYqzYMXapYUQF89ctTMRbtZyqwyxvLzNnVa0MvQ1kSHJS3ghKK3A7SCPv/b2sh7mVxo50gpjH6A==
X-Received: by 2002:a2e:63d1:: with SMTP id s78mr23873278lje.166.1557989043709;
        Wed, 15 May 2019 23:44:03 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b23sm782451lfg.41.2019.05.15.23.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 23:44:02 -0700 (PDT)
Date:   Wed, 15 May 2019 23:27:27 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>, Joe Perches <joe@perches.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Opt out of scripts/get_maintainer.pl
Message-ID: <20190516062727.ur5bgzt2bukcste2@localhost>
References: <d1427cd2-9111-025c-1a97-d0fa498f1a03@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1427cd2-9111-025c-1a97-d0fa498f1a03@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 02:47:57PM +0200, Marc Gonzalez wrote:
> A few months ago, I submitted a trivial arm64 defconfig update.
> get_maintainer.pl now outputs my address for every defconfig tweak.
> Add me to .get_maintainer.ignore to opt out of these notifications.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  .get_maintainer.ignore | 1 +
>  1 file changed, 1 insertion(+)

Applied to arm/late.


Thanks,

-Olof
