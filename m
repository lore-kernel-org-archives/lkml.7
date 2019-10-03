Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C735C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356320830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pq/jSr1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfJCRad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:30:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46878 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbfJCQLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:11:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so2037206pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=WCl0BJ/xg5z2POfrHRFKcHi5xkDivkEW/iGK30/2GP0=;
        b=Pq/jSr1xmzlqjDuxBQh7dFDV5hRyr6MZtXVubXctjAF8kRjt+U6xL1O1zUsbiV9qug
         ygNsoBsTe8l9J4vQh++/GIEgBZ3tc+dCBa+tnW6tuf4O22v4fqwHlcvMDTQXutYl4bj7
         bWJISwhs7L3e2klQ4E9mPH1vemoDoOFTbhMxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=WCl0BJ/xg5z2POfrHRFKcHi5xkDivkEW/iGK30/2GP0=;
        b=pmbUJmBXwHY2sLgkCkrF496xUDkpx02mEiYv6TTnS35TJ3Xh+boqeX/JUdENiXWFcS
         wifaUky7L0uS+1JIBeMUBixQ3OFFB2qgjImy9lhM3tq8r2TUPe71TgfzQRNzBHLLIgie
         l1D0zGU0cwsD6s/KReT46Dsh+ljl2/fweibH9TuoNGkZTceTPQb/yu5YbkRspw6rAEEu
         QTGre/jqXvQePsYySROptuSa7j/aB4bd53bTM1hL+o46ltHPXwkkQiR36/XCkAm3HVW/
         3o+QhOvpEycBHar8H31a6UJgCMgHHSOPKkhT44RHKQRrtwL06+WTVpwCdFSwvRjNFUm0
         KTHQ==
X-Gm-Message-State: APjAAAXDMJ3XFVg3tRni+GzOtgjhK5K/Ydr9MkUUoyhWbN1fQfFeiudW
        cq6JTs5KDLnRW+Rvrxj/WRPkRA==
X-Google-Smtp-Source: APXvYqwgRSbE1eF4YKGVz+xu6rX+ntZRdmjPXT4BO1EQpfB2LWEVRFrJK7RpkgO+T9w/1Sx9rAIAHg==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr11602435pjr.8.1570119078443;
        Thu, 03 Oct 2019 09:11:18 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j25sm4527578pfi.113.2019.10.03.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:11:17 -0700 (PDT)
Message-ID: <5d961da5.1c69fb81.f4dce.d93e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191001180622.806-1-geert+renesas@glider.be>
References: <20191001180622.806-1-geert+renesas@glider.be>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Only call platform_get_irq() when interrupt is mandatory
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 09:11:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-01 11:06:22)
> As platform_get_irq() now prints an error when the interrupt does not
> exist, calling it gratuitously causes scary messages like:
>=20
>     ipmmu-vmsa e6740000.mmu: IRQ index 0 not found
>=20
> Fix this by moving the call to platform_get_irq() down, where the
> existence of the interrupt is mandatory.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

