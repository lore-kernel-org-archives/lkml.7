Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A36C2D0CA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6370B2465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 20:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="saRF//Zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLNUxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:53:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45381 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNUxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 15:53:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id r11so1221442pjp.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 12:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rtMnnzrU27f2aNSxJLAHQ6Cwu1ukVL6sYLz0eOE3Mwo=;
        b=saRF//ZzbRWEm3tRLHhMJHD1+oHatpjbgJ8nJ1Wm7ZlO0Cai+SfYEmbby5F0o2MjQe
         G5BpWPIx/ljGN2310DtLHIjuDgyS5+3lsyuK/ZyGQeUuX53PRjxsVfy1RB76zo1EplHn
         O6BgdLK3oweBenlhBxDnnEvtAoWLwJziLXMcAgr3F9JE05MORDWU+moJb+Rlh1+IghzQ
         EU3224uzSvxKmYAcNSaZRkUWbMNoSKbu0FOPS0PEUZbNC4qremw8GPiBa4orax3OuOO6
         UEdawv/yksYHFkRP8un4VuTAveXrcnG100O0yQSL4qVUzyuyKHBl9z+KK0Q0bjD6klN6
         XKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rtMnnzrU27f2aNSxJLAHQ6Cwu1ukVL6sYLz0eOE3Mwo=;
        b=Mx+mA50zruNfH78LdNMDLnq3u577MbCZmqDXCAUtGD0BctkBIL9sV3qpV73qhMeysP
         hAU0pLMnx0NBpdfSK2Ad7zBZORjN5hlg/PJuXGQdRT4cWCRPx1FqGJgMQk0YtVdj3jc7
         LGWZZysemk80xgoSBk2sNCes5Li7h6BNxIXS098OmhiRWMOByrK742GhM6zHphTlBbtx
         EGxTca6P2fk8zwEcXr7DldklG25kyZO/leQfDfq4uSnJr4amrcdlUoValKs7nos/sHSQ
         Uw2HDqmbtOHHLMMdt8IbtdhNJfQPMH9dhgZCWLeD5TLgtRIgvUP8H8SR/bYWX5v7YWmr
         G+JQ==
X-Gm-Message-State: APjAAAVZwdcP9Erde9jgzL1EodUPexCk4yHwFMhmD053bphCWnGrSCO4
        J5SlI8ApGSf4WF3HpKotFX32FQ==
X-Google-Smtp-Source: APXvYqyrV3DH1IJy1jJ/ibvpQxmiRqHTjGz1rrLT453ZdR3lLV1Yi6kx0BS+G3Vw0w0U5inCxPodcw==
X-Received: by 2002:a17:90a:3586:: with SMTP id r6mr7766095pjb.36.1576356792040;
        Sat, 14 Dec 2019 12:53:12 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id ce22sm13768058pjb.17.2019.12.14.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 12:53:11 -0800 (PST)
Date:   Sat, 14 Dec 2019 12:53:08 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ethernet: ti: select PAGE_POOL for switchdev
 driver
Message-ID: <20191214125308.6551a6e3@cakuba.netronome.com>
In-Reply-To: <20191211125643.1987157-1-arnd@arndb.de>
References: <20191211125643.1987157-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 13:56:09 +0100, Arnd Bergmann wrote:
> The new driver misses a dependency:

Applied both, thank you!
