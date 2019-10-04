Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042FEC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C176221D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jG39lY79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfJDRsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:48:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40009 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:48:14 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so15309642iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=pM1YTjlwiPrYotTby5FDrTXDJRG8vk7+BJxpR78IozE=;
        b=jG39lY79bmqDKqtOM3vYnCrbvO+bBiSXGugKL5lgb5PCAjAFW0nfGLP0MAP9eaCIVe
         19Scayt9vYGxuqUGnSw4ABvrlLJTd9eTjSx9w/CWpskDoArl/FaUFuPaAXtN0rDJRSeo
         Lu7jHadAPgYa4jI1iA4RRK/sT4VeQ/wpWtr5o4cvcKdgCG5ZrSL5u5p9Diyrtg80jCwo
         84XH9ruSKo/Yuty7HnV53+sogdsvEUZmGW4Ka7ff8ouDcAgtthgeZJb/TN6G+re6k3kX
         5n8rwwExX5VOOvJWgAh7NRhS4FCbINDp6s++z2xZuSBa7QYD94AVjsIS3KrDvYbLu4ga
         KJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=pM1YTjlwiPrYotTby5FDrTXDJRG8vk7+BJxpR78IozE=;
        b=h1dMnKYKVMusV2jcgdKxvkv8uUvC10VKXich8P4JhcVHvH8KTbLYYlMZERSmzFbiTW
         /mrVAUtCwxc1q0udaZMH0xIuT7DVtbBlFrlYXPJFdOd9w+NelermfuHgeq0Ex+TGSUp+
         XsJn0V4tiDeuc0ZRX6dnh1aISj60JiG49iokxuJtZtksRy1ne7hYW/oHFh17Zq5EqNQn
         g/gvK4ib9SawXVrAzpHp3tMeQnSAW5XEBf4AieesN4DK2J3nCf+xPs5cdYX9/ud9nft3
         vE9F/GAhMByWZCwJHUrQ8Jh8+2iCdD/Etn5SP8fA64y4sCV1TPLs5UHbCfuoZ1rtGQUg
         fNCw==
X-Gm-Message-State: APjAAAXK/HE9VyPzsr+wbT9L+cqsCpl0EByHDrSEwd0rV7RydogDp2Ix
        43/KC58ia0/OmlUDOBNusYR5N1mprcA=
X-Google-Smtp-Source: APXvYqz0O0ajY2hstRrpT2cQQoo/4Ud4bFBYaXsREbXER1wzT3F6U7DSZrhxOWA1XuAlok/1ZV6cjA==
X-Received: by 2002:a92:8583:: with SMTP id f125mr17735949ilh.39.1570211293973;
        Fri, 04 Oct 2019 10:48:13 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id z16sm2299283iol.64.2019.10.04.10.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:48:13 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:48:12 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com
Subject: kbuild change breaks HiFive-U boot here
Message-ID: <alpine.DEB.2.21.9999.1910041037590.15827@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Commit 858805b336be1cabb3d9033adaa3676574d12e37 ("kbuild: add $(BASH) to 
run scripts with bash-extension") breaks my kernel test flow that targets 
the HiFive Unleashed board.  The boot traps during BBL early boot and 
stops.  QEMU is unaffected.  Reverting 858805b336be fixes the issue.

I haven't yet had the opportunity to root-cause the issue.  The issue may 
be related to idiosyncracies in my local boot testing process, rather 
than this commit.


- Paul
