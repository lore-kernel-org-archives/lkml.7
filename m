Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A982DC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EF420718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xz4+oXhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfL3Sh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:37:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42829 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3Sh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:37:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so47206351otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V5tjxV4Z5VBOgEtDpAINKYzqYZFdNdLpMM9QZ7NDW1w=;
        b=Xz4+oXhJ+d4SiH2kiUJH6ZVUz4J+nRaBt1frOIR9LOTwNaQVh0jw0zehTlD3QJKreS
         qpY+oGYucQ4NeolgDl9UNswiTnu9kGnwAbmWCVK2vyVN1aKkbFhm3XbBHuaxDLEHrVXg
         gspturbBhW7JdcDedahXM21cE+3Rodlo0oozo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5tjxV4Z5VBOgEtDpAINKYzqYZFdNdLpMM9QZ7NDW1w=;
        b=lr/g+tWrJTqmxaihLrgpsaKB2JhoJ0B6uzBY75VI8RhhsMHnsiH7cmNvFaVh2Wfh/j
         jrfdUKqSsN3ktw4Xf8UJ5/vuGJzqNNda9uFpxq8qnFpZ0r1YZzdhWbc5AdC2WTd5cXxz
         wl2oDaiISDfzEPEgIbpanVXR+UIBPUtkKdw4p0mBWeIOAT0cJLuYSZTA6wIb8AkAfG75
         zAYBZV0OLuUNM6NmfQXDCq0UIKib1+MP2SLKxIM//856PnCiHyUMqNTnUv4fzHdCpWFb
         /9NrfmoL26D2W7dsAn5v4c6BdUqWUVkcXh3uCGNCedFerJT1XQ9N1DN6mKt6B5q2AEv3
         iLow==
X-Gm-Message-State: APjAAAWwMBAFcsR2zXfnl9KnyurG7BgYt/zFFVq7cl3qIx7nokbLyu+H
        cIIHp7QyrOyvk5THc6/aWoktBQ==
X-Google-Smtp-Source: APXvYqzK3X1+bZ2XHxaA+UWG5GwZHOmNOsmqxOQeG9/UhUvBx5QTgxQ5zPcBhWZod30Abnds18G7SQ==
X-Received: by 2002:a05:6830:12ce:: with SMTP id a14mr38961071otq.366.1577731046375;
        Mon, 30 Dec 2019 10:37:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p83sm14001032oia.51.2019.12.30.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:37:25 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:37:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH v1 1/1] lkdtm/stackleak: Make the stack erasing test more
 verbose
Message-ID: <201912301034.5C04DC89@keescook>
References: <20191219145416.435508-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219145416.435508-1-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 05:54:16PM +0300, Alexander Popov wrote:
> Make the stack erasing test more verbose about the errors that it
> can detect. BUG() in case of test failure is useful when the test
> is running in a loop.

Hi! I try to keep the "success" conditions for LKDTM tests to be a
system exception, so doing "BUG" on a failure is actually against the
design. So, really, a test harness needs to know to check dmesg for the
results here. It almost looks like this check shouldn't live in LKDTM,
but since it feels like other LKDTM tests, I'm happy to keep it there
for now.

I'll resend my selftests series that adds a real test harness for all
the LKDTM tests and CC you.

-Kees

-- 
Kees Cook
