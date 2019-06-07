Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E41AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA10206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EDRoEZ99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfFGW6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:58:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39382 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbfFGW6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:58:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so1889797pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vA7iPSfOkgn9n9Lxwnw4ESV8GeztXdxLFk+OG9qi8cA=;
        b=EDRoEZ99CHv10cAFbNfRoc4bPXZoorDcRpw2VbYfhED8yUZGDxB7fmOs7gYz09/POO
         1dRqh2mN/+U3Y5iGDQSI1Dv0MkvElhhHEBtC1Il7lElMCF9DUeIpRxzodvWHWpaU4eRc
         pgMylh2u2oFIWFIjxyfDI3/+FMiJJGz1jlD6CXcESOagQIpuC8qnivZE8TCT4GDwwuwU
         TsyXmdWFbQ4r9Zc3ztcC+A0E0gDPlI8HNQvdfh8azf5RcyicRyD5x1TrdMnDIxnTZ6rr
         tr7XDs0c7oEpAiITXpd+fIpmKhFlgITbvEGAK7ChBb1q0QZ5vR9KAzbmJEXYTClgKRs8
         Tmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vA7iPSfOkgn9n9Lxwnw4ESV8GeztXdxLFk+OG9qi8cA=;
        b=uF5Crz4o4DS6c0u/RTS1FHNvjO987nZCAJ9VAy8eh+LPYSX8gUhOkrHV0VdO4PFYUt
         bkV1FQ0a6QJCeDXaJS2xfaJv97QvbceeWiojHntO6p1Qf/yHC+L/6tuQItLHip8BpnHU
         7KaC8T8aSTgnXsmjLYpJCb3qHC9Fmlb8/utxT7xGASCOCAroHNgAFwtJjZkYKe4p12Wk
         uOZI/k2YlC38X2IrPfORtzw65sjs9ohwgzAyBKZrMnaC6bXfNvCNfpD2Ey5t4Ai37HlH
         uVZUl6EQsmtXxFptr4rNIGeD2aILdSIDSCrAIPVtYuHe0LD4toOTkUDaIGE8pxf9kVOm
         Xsug==
X-Gm-Message-State: APjAAAW5lY3azR3vA+DzGzwARlF82+kWbYA+yGitfO02uIOKUV+T7NxD
        3EAtDtMTJJiCr+0eRktUQ6/SSA==
X-Google-Smtp-Source: APXvYqwiBWoaaveRWBPUG0jXO6rGa0EnNmkAq9RGYUkVwh5pzlb6H8dOTi44KPQ2H+7hsZEvMN2DEg==
X-Received: by 2002:aa7:8219:: with SMTP id k25mr63254539pfi.38.1559948321852;
        Fri, 07 Jun 2019 15:58:41 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id b7sm3041930pgq.71.2019.06.07.15.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 15:58:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: meson-g12a: mmc updates
In-Reply-To: <20190607144735.3829-1-narmstrong@baylibre.com>
References: <20190607144735.3829-1-narmstrong@baylibre.com>
Date:   Fri, 07 Jun 2019 15:58:40 -0700
Message-ID: <7hd0jpatpb.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset :
> - adds the SDIO controller node using the dram-access-quirk
> - adds SDCard, eMMC & SDIO support to X96
> - Add SDIO support to SEI510

Queued for v5.3,

Thanks,

Kevin
