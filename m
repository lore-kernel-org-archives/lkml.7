Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5908C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CC5215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZpeSxI7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbfJCVKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:10:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41327 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJCVKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:10:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so2469559pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=TZu2ZOfBt4zOQYcx7ts+ww1a8wZ3i5klQLAM70cz5EM=;
        b=ZpeSxI7m/QWltN4KyEEzLW1mbR3sjyIll0DL6bBVA9iBnHBwBECbV4n7v/1zZXw1tq
         zM4xBiDcxDDwTgVD5vECVOL8EhXs7sAMqJdY1jzUf3wDZ926Mxt9mV2hZcK1AXkxbODE
         /bXkbGxRjqj5+s785Fagw4SbqIOefWgenyLqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=TZu2ZOfBt4zOQYcx7ts+ww1a8wZ3i5klQLAM70cz5EM=;
        b=nOXDwYnoPptdmPKHwfgLXEyi/38rhtmy38Z5Og/QJNg3UmtVnByHaZ8Dc0Rv+ygTXf
         HlmgZJmdeTKBy0XyU2kBSEZf4igjeWsxOWazXenJs41lTNMaIVJr6842MbuUk4HXE1zr
         +FLbNjzAsxInkMR5JxveGnEGeW5nhfMXrt7xgC6fyPAAtbljuNhnncdfDfqPuqdh1kb8
         uJFSNAdlVN9GJWWokoRZ3na7SxYQa/cOdzIzfqPtS64FJbzGXySuaCHneYWKD4VzRTdx
         jX/lSPWp+2tQ5EYzvb6eyviK2wJwTSZU5xx/lFlTtnplTIxm8pZbwzFntuslCAberqt+
         NHZg==
X-Gm-Message-State: APjAAAWqqQG7Eh4DQ/zyy6gQX9+D2ftp+Jarb7Zx7xS5FTU5f04IauUB
        mpzXXLkGyQWePwg6q17dXAZY7w==
X-Google-Smtp-Source: APXvYqxRNBvkg2TMNLnFboSrLgS+N0S0t6bmJh6XqO3SPIjYAzw3ZpxIyPcyB1kqZ4AiwJpxPFtwPQ==
X-Received: by 2002:a63:1521:: with SMTP id v33mr11802366pgl.9.1570137039483;
        Thu, 03 Oct 2019 14:10:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g24sm4399113pfi.81.2019.10.03.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 14:10:38 -0700 (PDT)
Message-ID: <5d9663ce.1c69fb81.e941e.dccc@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190730212048.164657-1-swboyd@chromium.org>
References: <20190730212048.164657-1-swboyd@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] idr: Document calling context for IDA APIs mustn't use locks
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 14:10:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-30 14:20:47)
> The documentation for these functions indicates that callers don't need
> to hold a lock while calling them, but that documentation is only in one
> place under "IDA Usage". Let's state the same information on each IDA
> function so that it's clear what the calling context requires.
> Furthermore, let's document ida_simple_get() with the same information
> so that callers know how this API works.
>=20
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Tri Vo <trong@android.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Ping? Can this be picked up, maybe into the doc tree?

