Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6889AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4F52339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rczdY01A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfH1W6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:58:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34443 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfH1W6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:58:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so1842399edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=MWIFKIzouiKNiGjOqNU3Lg2whivTBv+XNz2yxpVpVdk=;
        b=rczdY01AKrKa0uF52azBBxJb1SYipY6u79S6FnAjJZbqKBaWR4bEt5Q1F/z+gPOmV8
         2LgNnTLUtcsNPBxAimDjDrKhK0XRpX2UbKs39RWkqXGG9vFmXddS5Chm8nmO/ctPLS/W
         7Q3E4uzkWIt60Md8eSjv8qlbJC/ug1geug3/TgIL/4PFwjIPXZfAbBt8c5t0Zy4vZbJE
         zAOpSAmCM9V6Pw/rW6+TDwunxdFqfAuY2uHJ24RM3iuy1UP6oeVKO7wlEexYBwI5EEZG
         aCfhrSzLY3b5JnFMCUmlK4fswrNsctSFSCY1XQ93oEnydxJoaICx83awfv8BwNZUXeMX
         4aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MWIFKIzouiKNiGjOqNU3Lg2whivTBv+XNz2yxpVpVdk=;
        b=KABrNWvMQL8Gm5+mkriu8gplizDBt7cr8rQoFvA/x/GuuZoGqo550bl289bs6XHE9O
         2NXw6Aqpg00UCCyl/Ucu+P57SGjUOscwlYkLKlba7YOpBMpQqC1jac1LKHqUxPALW/9z
         jueY03VDpli2YYF5kYdQDMQVQj9ZrESt5hCCKKjkGBJOXNNzOre7EAYwBy4SU/dQpq2W
         76Z/DoD5i8/5M3m7nnv2CjWmJQMBv6c6bmBWQuk41hhHHrgO9kSw84d0qA4XUHBdZCPH
         76t9vybdc2XfCIMIhkiKk0HyixLV4FRStMdJbGDGiNG4J11CrmY55raW5H87PTYDsfpa
         N/kQ==
X-Gm-Message-State: APjAAAXCbVbFxKX8AYg/0Ngjw1DItmkoUD7N/ONcDooVkL/W4Y7EOpu2
        kp9DdShcGe6e/pxBZOnjhhWu3ceafd8=
X-Google-Smtp-Source: APXvYqzlwrSyUeO/iZbE6dDzW6rjW3NYftlJjlyPkx6b8TsSKh+G73SS2+o4rdG+5KdBZyEOmHOotw==
X-Received: by 2002:aa7:da4d:: with SMTP id w13mr6716505eds.224.1567033112940;
        Wed, 28 Aug 2019 15:58:32 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k15sm101111ejk.46.2019.08.28.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 15:58:32 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:58:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 05/15] net: sgi: ioc3-eth: allocate space for
 desc rings only once
Message-ID: <20190828155809.5c155bee@cakuba.netronome.com>
In-Reply-To: <20190828140315.17048-6-tbogendoerfer@suse.de>
References: <20190828140315.17048-1-tbogendoerfer@suse.de>
        <20190828140315.17048-6-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 16:03:04 +0200, Thomas Bogendoerfer wrote:
> Memory for descriptor rings are allocated/freed, when interface is
> brought up/down. Since the size of the rings is not changeable by
> hardware, we now allocate rings now during probe and free it, when
> device is removed.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

So the rings still get freed and allocated from ioc3_init()
but there's a set allocated from the start? I guess that makes 
some sense..

Most drivers will allocate rings in open() and free them in close().
