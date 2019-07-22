Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE29C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C04218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IJ79AYkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfGVT7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:59:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45428 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbfGVT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:59:48 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so76693339ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/OH/wTTBC4X8SVdlUJnb/Ot3whBKsHxdPt8gk14iyRI=;
        b=IJ79AYkgljjvskCTjQpSnN1VcH07Jaf0C4IA1a0choaa0aexD+z3BEclu3qrc9dm3n
         lBK21ZNYuMibEYuUgygq+2qS2ESPxBGKUwXvVigWSpRh9CwNlh/ZUXg/MmPBdBUR6ATS
         YBi5nY2XkwV5ILZWw6+gXVamBXBWc7oqg1/guzrXAmEDgJgrn/KAyHYEd1jIUJ7RWN3s
         uWLy87j5aKFkEkCNP7wNl61lZeUBVV7FlRWlRE/C0p1pHbYXu1oqr8iyYY/GrvFZMAUx
         IvaNafhhR7IsprcZ8ibKROvteizgzd7sF6M2zQzbCOghqLdEORkE8voLl1fPRzEn0Eq3
         oqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/OH/wTTBC4X8SVdlUJnb/Ot3whBKsHxdPt8gk14iyRI=;
        b=hJk5LY0ZmjpiQZttER0uL3Hem3+3h3mGWUkscrgtvTe4Q/0gUyj/dxXUY4ZpPx+9cs
         gF0LW6GXZBFp292TnsdMy1Vj4oaxj5Buv9YA9s+vrpYDhIhVt+DLPmUByUSrzwMIPrHO
         WXUU3dL1dFbW4KfMtqfU1aJaDon7krcV3LlVCLzNWVxwEWAujTJ3GtBA19vGHsbecZ26
         fzRH6/KVha7zYfsUYdi6B9xwNyYzg/xX4Hq7TtdUhmNvofmb/5C2F84THn8urAB9+Lhi
         XR2yq5pVAsv5aWz9JlQDEDf5OzOCiKTGYQeVFn5Dzx1El5H1XXKJeeVMveqg2w3zeAEq
         MwNg==
X-Gm-Message-State: APjAAAW79kySSdlq9JNlJy7wQz0R9HS5ydxzCqJ+SWtSg7fZqMpSy08B
        G0tzi7C13MQj02VUADnZRSNJVEOa5/0=
X-Google-Smtp-Source: APXvYqzscqmldHBLHAIijDkbQwm+paiGghQKVRTUe6alP23cCGUxgKPjiGuPPJhasKI7fp5io+M8rg==
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr69303919iod.204.1563825587225;
        Mon, 22 Jul 2019 12:59:47 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id m20sm39336195ioh.4.2019.07.22.12.59.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:59:46 -0700 (PDT)
Date:   Mon, 22 Jul 2019 12:59:45 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     davem@davemloft.net, robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz, sachin.ghadi@sifive.com
Subject: Re: [PATCH 1/3] macb: bindings doc: update sifive fu540-c000
 binding
In-Reply-To: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907221259300.5793@viisi.sifive.com>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019, Yash Shah wrote:

> As per the discussion with Nicolas Ferre, rename the compatible property
> to a more appropriate and specific string.
> LINK: https://lkml.org/lkml/2019/7/17/200
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

- Paul
