Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7496BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461E8217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlhmZfQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfEVLOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:14:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40062 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfEVLOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:14:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so1151725pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C6OuMrDuHvrcgAJB4Ug9M+5gS8lkJoyf4CxtYg00dTw=;
        b=QlhmZfQX9P0OorgbuFi68ZgPIcKeIWLKGdFKGZ6HFlpUQKN8gH/RhMOx11fTP9me0J
         hf7DVGkGFY8BBWpZNqedXDdPKAJjihqsgLsuZD8bc5Gyf8XQSM41nXOzmuPlsAN6CwQn
         vsvOsS7v1H/sXg3fw5i/g8d7emb1yT1ggGU/LnirbYidkpmGl4GESXQbUVsA7rqn6Az1
         izmklK1KsJoEfoC9C53Sy7m3Uw5IuND2dGNwcUDvndKzX7bIM1ocKslY2RcqDy0/VaNA
         T4yPUi6yuDCCvrP2UT2DznyA1LzEFzLYEm3E/yrGIxdJBZc0+17UtvXRyKbRFgbi8TYm
         hahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C6OuMrDuHvrcgAJB4Ug9M+5gS8lkJoyf4CxtYg00dTw=;
        b=JOSKQNrTb26C0klMc7KKLIFsk2u0TebH94yGfUTrKmIvdoElDjJrJoWo+A5VblGEHW
         jlRR3vO+7oIIKJrRLwC9Zv078Z5Wii/Er6YYlIqx4rvv8gwD7Z7P5pMbynJFL9Q2exZL
         3w4oObWKETF88+GMhDOvYV6ZydHNhAf23BVWUWAPtycs9bL5VgQQhshUMrzR9REM98et
         sixpdTFyxhyEzXkz0+ARpLYlxHkpNAzm7wndgl5hjk73+HwTu+o1hFTEDz6umQdS+8Hp
         7DWmjGDLxA4qD6lSqaL/Ht8JdltARNlYxGr1y3dmHn2Hq9QgkZvTJXADPtmgvqQBMpbY
         glnw==
X-Gm-Message-State: APjAAAXRwAnDusnH7vh1TfqptJCCHWLvUCL8Ric4JeU/Ka1ScrnsEVmR
        mbiNo27dIxFHzDGU/Sbt9Vg=
X-Google-Smtp-Source: APXvYqzWYSQVt3hJ7zvJAONHgNDkVOL3p1MXZeRmpQUVJKrWcr3BCpnDLIWyhSER19ft45ChJGTBZA==
X-Received: by 2002:a62:2cc2:: with SMTP id s185mr55929040pfs.106.1558523645154;
        Wed, 22 May 2019 04:14:05 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id u20sm32310898pfm.145.2019.05.22.04.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 04:14:04 -0700 (PDT)
Date:   Wed, 22 May 2019 19:13:54 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
Message-ID: <20190522111354.GA5849@zhanggen-UX430UQ>
References: <20190522014006.GB4093@zhanggen-UX430UQ>
 <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
 <20190522080656.GA5109@zhanggen-UX430UQ>
 <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
 <20190522102900.GC2200@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522102900.GC2200@localhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:29:00PM +0200, Johan Hovold wrote:
> Where do you see that the kernel is dereferencing tty->dev without
> checking for NULL first? If you can find that, then that would indeed be
> a bug that needs fixing.
Thanks for your reply, Johan!
I examined the code but failed to find this situation.
Anyway, checking return value of tty_get_device() is theoritically
right. But tty->dev is never dereferenced, so checking is not needed.
However, what if in later kernels tty->dev is dereferenced by some
codes? Is it better to apply this check for this reason?
Thanks
Gen
