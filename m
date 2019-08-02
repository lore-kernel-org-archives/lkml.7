Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04873C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5BC20665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="GaMOsF13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395194AbfHBVy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:54:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35457 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbfHBVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:54:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so36686129pfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyeLKPzC0XuP8gjAGSTKzaHtBOr+XkQRHretmBzwq5w=;
        b=GaMOsF13xxb3cD8xzf2OmnaaSbtiMzON8fo3xA3vPmsrWVsWsYdLUNrKFxJcx2GOJ0
         Hf+j9m5qaI0cA9ItiutImpnjd17gBDapDOyNUknduvJ0s3uZKttckWEwh6/TaqPb1NuK
         MC+xNZlOytC+TjDD36ADL1bINhIbgY2uLhUPpElNVWEw+YsHmuamej7D0mP74+Srk496
         60N4HTArbE3YzdC5S6kdKMKfqpZBgOD9OPX17vjm7e6Iini9LdUGlPOSWf1LmHLdO+RB
         9xM1m8xJw4J33uPtbtqirl5MhIHcmyCjTqI0OjmGrLbDCPflVJ9EY6JisOEy/teLwzpB
         5siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyeLKPzC0XuP8gjAGSTKzaHtBOr+XkQRHretmBzwq5w=;
        b=ZBWvlxpqOPyh0IRCQ47ZFliYzZ75/aRUZn84QDZQRfI2dwfEgQfQBuHq4FDUYLfKk4
         fttpoUU6saWLUFL18bTqa8cAvA3ZpqfLOht6xCVeINskh+wAOWrT2ICag2AXKbV298AG
         DgLL2ka/bw/YWr9hULOdoQUhiEYGtz8X/+p5FR+irMmHZe/gkZOEKqIlsNgob100ZRqB
         u6Brq1OoTJF2P9EjJ2lfRYsU6asMGPsX1O8ItLvOJWcDKNkmwR7N8sLOHWbicgLBiU72
         ybqxx9hoU1aNVkHL2zOqelABZswSmbHLqqhIHXUc96ehxp9y4qTlNoa0Zs4bUFuiFe3X
         PMZg==
X-Gm-Message-State: APjAAAXJ/3txp3p2Yc0wkQHsS3Ao2cb8MuCkGqSkG5pC03LcWT+EP478
        K7uye61iqjgSZBUH3W4Ca3OZn5Ot
X-Google-Smtp-Source: APXvYqwbHMg3jNoCFZHog7Hxf1IYqhk4HkeR6DqQNTGvD37LG2dD5fYELrYf9ed2PrIB1VZBXPindw==
X-Received: by 2002:a63:3147:: with SMTP id x68mr63386647pgx.212.1564782895104;
        Fri, 02 Aug 2019 14:54:55 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id m16sm75782068pfd.127.2019.08.02.14.54.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 14:54:54 -0700 (PDT)
Date:   Fri, 2 Aug 2019 14:54:48 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Ricardo Bruno Lopes da Silva <ricardo6142@gmail.com>
Cc:     isdn@linux-pingi.de, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] isdn: hysdn: fix code style error from checkpatch
Message-ID: <20190802145448.0bcd5374@hermes.lan>
In-Reply-To: <20190802195017.27845-1-ricardo6142@gmail.com>
References: <20190802195017.27845-1-ricardo6142@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Aug 2019 19:50:17 +0000
Ricardo Bruno Lopes da Silva <ricardo6142@gmail.com> wrote:

> Fix error bellow from checkpatch.
> 
> WARNING: Block comments use * on subsequent lines
> +/***********************************************************
> +
> 
> Signed-off-by: Ricardo Bruno Lopes da Silva <ricardo6142@gmail.com>

Read the TODO, these drivers are scheduled for removal, so changes
are not helpful at this time.
