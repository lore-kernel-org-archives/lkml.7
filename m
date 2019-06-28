Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4387BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C8B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0VbzT+pP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfF1XcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:32:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46767 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfF1XcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:32:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so36811pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pCnZsFeXtEhsGu5hcikExC62+4Wo/EuuXi1fmzeilKA=;
        b=0VbzT+pPAZ5Cw+l50LsV6VxWXKVmzUDbFzYuh8RNn9jDhvwYrGLpdd2Zox3h+s5z3d
         NsHcNsx8UNYIl/Tvfb7cXa/FuLVj1zcEON3iB5PUkGIp07Nt8sBjGk1VhpQX63mE5GrQ
         v50tAcJD87eCeRoV0wkDeOzOz3jCuLO00fUJ3whOaPkolh4Bk6/8PU8zR+cwJsZAHMz/
         ScenEHfkRqLUKlPcxdU4QjR3X/mOrXFzVippr4fAnNlaDmVhjqINrruhID6v634TKkd/
         y9tKRsD6McBdP4RBm7SdgnNQYnubc97zKWxXjwt3g8AgXpwKyyd43Oguezk1zdCnyWPI
         r/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pCnZsFeXtEhsGu5hcikExC62+4Wo/EuuXi1fmzeilKA=;
        b=XJXM0WSoI417dEczoNm0U8kkLHalH1eTqUAsm1GoKXzOgoYX7F5r64sHh8W5vUCKtc
         qdh7yZhwNi1SjDPhruS3390xZvatWY8NZI4W+AZhLKLuXh6EAkyrjGK+WobVvV7x+7RA
         vHsbQRl7D/fvXnMC/gV+Pt5s3qb2GinKWvbjWxqT370MYXWghS2LIxvPLjsL3NeGhNLZ
         XSLDTexCOAbwCfZPh+70hd31gXDtbP/hrDXC5xcgPpHT2ZvaIes7I0QyRK+RsUWIbVsx
         wJr7TJdiKpemOCyPlQgfNn5nqIoM+30hXktq72EGmTLgRWubTYVxRd8dH2v4nKq55ppG
         DvaA==
X-Gm-Message-State: APjAAAV7zTmZccargV/TE+oUXj3RC3cz2GK+ylhs87ZAz/rYCBm0bk0I
        IwKTXK6fT2nnls+Je6qbk/DGBQ==
X-Google-Smtp-Source: APXvYqzJ2MLMBi8iA3yNVUvYroDxbXL+variJXnbCGCuqZ3XKDF6o6+6MYhexAh/V2sqsNQR1LhPNg==
X-Received: by 2002:a17:90a:3210:: with SMTP id k16mr15622156pjb.13.1561764742710;
        Fri, 28 Jun 2019 16:32:22 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id s22sm3569018pfh.107.2019.06.28.16.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 16:32:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     ryder.lee@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Steven Liu <steven.liu@mediatek.com>
Subject: Re: [PATCH v1] arm: dts: mediatek: add basic support for MT7629 SoC
In-Reply-To: <a8ca0018ac8a4c5f61a7a1efc9dc5dccd768628b.1552449524.git.ryder.lee@mediatek.com>
References: <a8ca0018ac8a4c5f61a7a1efc9dc5dccd768628b.1552449524.git.ryder.lee@mediatek.com>
Date:   Fri, 28 Jun 2019 16:32:18 -0700
Message-ID: <7hy31lp9q5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<ryder.lee@kernel.org> writes:

> From: Ryder Lee <ryder.lee@mediatek.com>
>
> This adds basic support for MT7629 reference board.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Just noticing this is not upstream yet.

I did a basic boot test to ramdisk on the mt7629-rfb board donated for
kernelCI (thanks MediaTek!) and it boots just fine.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
