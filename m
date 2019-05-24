Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E868C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67412133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vZaagklu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391672AbfEXTmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:42:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42632 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfEXTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:42:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so4541408plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=2dfVnj0z8UOLBg4J0DLOYq1772RUeCwK2zOSGh4/SWE=;
        b=vZaagkluwNiMRjWKl9RSzMjTzb/+1YkoKYezoNgxeEzDWoAOHNJVRD9hB1opBDxErw
         9xr5lV+VyFR9BaG556Xbp/vjkxeWkT+Hp4S7UOU7UZYUdMd77t6LqmAH/7oIpxRYyGTw
         rq1osS6x3GG1knr0FPHct2FPZQRdXEBjgnwzbFgO/Fm6od5VxJolEgong3iGe/q33LPY
         PECMT6loq99WvXs7EO+G3X2PFC9BhkDxc1L/lWQXJcJ7vUN8vOxDDwzC2YRTmBDjKJpP
         U9YYNomVlkkz70eP704r5h0sK8Zkwn0b6KBYbXBLGrkine52vJuXr20svFAgfonrwn3I
         Zkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2dfVnj0z8UOLBg4J0DLOYq1772RUeCwK2zOSGh4/SWE=;
        b=gM5zQc/lI1Wqgev7PTF9296etvFkmlZL/SDsi05Lf3v2chUzcDnyw/FX+Sx2RRpFUQ
         ed9eF2gRAnuYq8cqUUmVkyORkA9mQIiwOUt658LVsBsjjLgV5ctr9tjOGwZFiSGlQcYx
         H6ECP/UXynf/jCTtMJvwhizYRe8zcrjLpwSxOoMz6X49h9SzjwBUdFiJE6EA+Byp4B29
         i9DAKJ+YWpvju+wy0oHIG8XqA07R/MkuMPm3dYyCSO2DPmhKFuoVMgRVu7K2ymOS8YXf
         uvCd0DzHb4MG+wId/TDe/ZCGvENsy8Xc55aCJYf1VbdmBShhQtC0qqAOAQafvOM/60XJ
         qGkw==
X-Gm-Message-State: APjAAAULcQGtgVa9MsQVAodCfd3nhr7zN+8Gs1VF7928texKRekuEc2G
        EEgXK15ydGGE4AX5yQeCQPleOw==
X-Google-Smtp-Source: APXvYqyVtWnRm6ZPuzBDAHjyTx+TyF/ONuADCQywreRoi5SrfW3rQzlo+xq+gy2RDJoIMj5p7saM+A==
X-Received: by 2002:a17:902:1347:: with SMTP id r7mr64611826ple.45.1558726935160;
        Fri, 24 May 2019 12:42:15 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id r71sm8643926pjb.2.2019.05.24.12.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 12:42:14 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/1] ARM: meson8b-mxq: better support for the TRONFY MXQ
In-Reply-To: <20190524181936.29470-1-martin.blumenstingl@googlemail.com>
References: <20190524181936.29470-1-martin.blumenstingl@googlemail.com>
Date:   Fri, 24 May 2019 12:42:13 -0700
Message-ID: <7hblzr1vxm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> A while ago a user asked on #linux-amlogic about the state of the
> TRONFY MXQ in mainline. I did some research (mainly downloading an
> Android firmware image for that device and looking at the .dtb) and
> updated the mainline .dts accordingly.
>
> I kept this patch in my tree but didn't hear back from anyone with one
> of these boards (who could actually test my patch). That was until
> today where I got the following message on IRC:
>   any plans to submit your latest own version of the meson8b mxq dtb
>   to mainline? it works really well for me and the one in mainline is
>   too simple to be usedful ...

Any chance of getting a Tested-by: from that IRC user on the patch?

Kevin
