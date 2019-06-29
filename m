Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E6C5B578
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29982053B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="Bkw8E8uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfF2CDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 22:03:04 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:43439 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF2CDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 22:03:04 -0400
Received: by mail-pf1-f175.google.com with SMTP id i189so3831379pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PxNura2FtwVYOyi81GbViu2+hM88Pn+e9x0rTuDTcoQ=;
        b=Bkw8E8uPLA9IENhj0LHLfwCv6/akD+dFdPBMlt6PSHTSEtAaUiCESMuCkaQPmwYlr8
         lcz3ffzW0bLvjRMVdmokrkJgUgUAPNzyWWHyJ+sVfS0n+61kHGaIufPvdEo2ISwHQLOm
         9rFcypdFd1rCxsXuuwaEcrzwjE7Fz2AsD6GXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PxNura2FtwVYOyi81GbViu2+hM88Pn+e9x0rTuDTcoQ=;
        b=XARshyE5VtnzwM0HIOcAc9rkQarloLiNEIdMfpJp1afgv8Non9u0UVndzIVuWE9rCk
         64bVP0Si+3JwKBbOKgEQcjKuCl217BL1ofYXScQOBhNCsFmWzrANoxCI/Xo5IY42WSzD
         MsQ80u3s6SX0L5edLtvbos7ML4V7/OHW/49naC3SBLqE/UkUJfo+AxOfTyem9/y7cXY+
         l5OdC9HsijI0dsTkTVK30ZafjUNHSAuJt/FG4J4giuAYe6HzXtKRS12vcz+FN1XJo40D
         kF034dUvVbG12sisSbJudLc7GhmMsW+fvJaPcEV70OIfSefVI7Oq4JbXHryaTyfkqEOF
         sPiA==
X-Gm-Message-State: APjAAAUqwwUJ4i/Og4oCs8Ud37G/y3WkGFVjzGgfAmYC9nYBtewwjB/h
        MkwVTSO/AI30t/qNKucPa7iw
X-Google-Smtp-Source: APXvYqyQZ91FJGl69eFa+kT8wyj4k2TSKOyHgkNb6ATuR5CO9tDeyA7QfWt7PQQx++WbS2IOKPHKQw==
X-Received: by 2002:a63:e53:: with SMTP id 19mr12025624pgo.137.1561773783541;
        Fri, 28 Jun 2019 19:03:03 -0700 (PDT)
Received: from [192.168.1.144] (64-46-6-129.dyn.novuscom.net. [64.46.6.129])
        by smtp.gmail.com with ESMTPSA id v3sm3399769pfm.188.2019.06.28.19.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 19:03:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: net: check before dereferencing netdev_ops during busy poll
From:   Josh Elsasser <jelsasser@appneta.com>
In-Reply-To: <20190628225533.GJ11506@sasha-vm>
Date:   Fri, 28 Jun 2019 19:03:01 -0700
Cc:     Matteo Croce <mcroce@redhat.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Message-Id: <1560226F-F2C0-440D-9C58-D664DE3C7322@appneta.com>
References: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
 <20190628225533.GJ11506@sasha-vm>
To:     Sasha Levin <sashal@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2019, at 3:55 PM, Sasha Levin <sashal@kernel.org> wrote:

> What's the upstream commit id?

The commit wasn't needed upstream, as I only sent the original patch after
79e7fff47b7b ("net: remove support for per driver ndo_busy_poll()") had
made the fix unnecessary in Linus' tree.

May've gotten lost in the shuffle due to my poor Fixes tags. The patch in
question applied only on top of the 4.9 stable release at the time, but the
actual NPE had been around in some form since 3.11 / 0602129286705 ("net: add
low latency socket poll").

	Josh
