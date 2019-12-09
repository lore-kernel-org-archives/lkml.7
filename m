Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63427C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D72A20726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S6FeY7Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLIOzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:55:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44669 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfLIOzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:55:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so6494987oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JWphYZIaNhuukxRS2IHuZu+/2+Ze27PEBDflVHdoFn4=;
        b=S6FeY7Lgg5233e9kALlOr/PKNr3GqXMMDo64M93+/CmhgAZ3TH6IZX1HXQ5yXg8sND
         qVBVamZgRPAWubqU5Qu/ebvpm0BcJ3QI+Z9riXFxQrX/Ftsd7ZTkX8INLpnU81j1Pe0+
         4GlvRqkBCJp7KaUrQrUk6ydhv6wjjLSxdedDQSk/7GGrqNp1QR0n1OBkl7DhPYrP87UC
         1qT0iBBp5scCISl1o9lGw8VWiWKB+/avoWycVIx5AF5utgSam5Ba1RtcSE2C0bt/nXdR
         OwC6VM/ptk9ZzDc6OuGm+E/m+bLpHop+Xztwk/znkqjZrD0iRRXbx4Q+O3z57ZqAPOx6
         S/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JWphYZIaNhuukxRS2IHuZu+/2+Ze27PEBDflVHdoFn4=;
        b=IAPIFV6Nd7nvNVEkoKjEyYC83GYFWSCmI8bIJtMw0aO6xha8hWGRBWfuH7fL4XXGga
         3bH3iz4IJnfOYjb9PN9azrhxbowI/IPKQ6JXWqUEZtVlEeR580zK+9u41md8lnc+1gK8
         Hha4OL2clQt6xTInGiqTOxrC6+BMHOwrcAKRMofFX0xf23sszQ7mPVKwWRigruVHZeja
         oR/EEWbF6jCRsB8skD7JJDiouPblVQrh2xlRnRISzkWfEFAqeyK2QLJ84pJTOr9JyjTP
         UATy1FXQzT8AnXL6muHkjr9TesltBiObgEtAKnljwJ6KkZzUESoCElEheGA3U9HEiq4j
         aHsA==
X-Gm-Message-State: APjAAAVXwf5RFuAtJj+EDbzLiB92NgvrO8BGYyK2VBJjVI8g8fXkMob/
        2rJWgBlZRzmpzlyL68cOdBz4cCURK7U=
X-Google-Smtp-Source: APXvYqwIf/nno5H3uogC6/QXhAZOcF9bhjfznIt/zGIcWfuuMHziIXXJDgk4dpdC8PrSQp9XkC9W/g==
X-Received: by 2002:a05:6808:14d:: with SMTP id h13mr25247155oie.58.1575903353434;
        Mon, 09 Dec 2019 06:55:53 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id a8sm3009404otp.42.2019.12.09.06.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:55:53 -0800 (PST)
Date:   Mon, 9 Dec 2019 06:55:51 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] riscv: Fix build dependency for loader
In-Reply-To: <20191207212916.130825-1-olof@lixom.net>
Message-ID: <alpine.DEB.2.21.9999.1912090655360.301523@viisi.sifive.com>
References: <20191207212916.130825-1-olof@lixom.net>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2019, Olof Johansson wrote:

> The Makefile addition for the flat image loader missed an obj prefix.
> 
> For most parallel builds this worked out fine, but with -j1 the dependency
> wasn't fulfilled and thus fails:
> 
> arch/riscv/boot/loader.S: Assembler messages:
> arch/riscv/boot/loader.S:7: Error: file not found: arch/riscv/boot/Image
> 
> Fixes: 405fe7aa0dba ("riscv: provide a flat image loader")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Thanks, queued for v5.5-rc.


- Paul
