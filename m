Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0CB2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fqX7HAuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfH0V7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:59:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38241 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfH0V7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:59:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id w11so199285plp.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=TdYOcDy5jsMWziyheC0sLWKkoIn520mmauZjzHRKXw0=;
        b=fqX7HAuzT5KuFfsn8d+HExjzxkOeMp9ciR59skQfXichfF0DxduVaNwQa72F8i2JRJ
         RcqtQKXAMQAjfhy1CJChhtF3Sv538PUx6V+L2FZJ/YtfvFAsJYwh2hca4OiQtCwBo9OU
         VwkmnGUC9flIc+hJlh+bpiWQN35phBb0UYpHysFLpKvvDRLPvxMvJ4WUB5kl579mWgYs
         bAQindBZCEfngbh3o6ERCSUnxUSw2SpKuPE4eKM1o1jcYpeviPzHreexlsNAf4KHD2cN
         pDTAB49gxvQx3+ZQK9tVGn5gGVTDK2oG3ZS1sD4ab4bIaRI8r81jBAQbtua9fkMRiijQ
         63CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TdYOcDy5jsMWziyheC0sLWKkoIn520mmauZjzHRKXw0=;
        b=jfD1LvBSJvgi5iHpnvVFywteTcCIVH26EPSK/51TDykEODZ3imdtvJ2XlqC6U+0y6+
         2VWg45PSoi9CMDP27n8Zu0tUVX4Gy27lyw1SfNtOMwOtqbbGgnxdSDF34jY7jmDo1EZr
         UTWjhzic7I4o5BLv9KNKy03R+0i0/RgoZQJKVpihspws/3SaWol5d7RsiBPyS2ocvNoJ
         Oyg8ArVUkrWHgs7jcjW8UxF13TVYeKkAbK7wav/GbdOHO0XGQGQyvR2vCBczwnjyFx9m
         tX2eyzOMwyAfnHtKc2yWkxitFy/F2KkxjykS5iej0gnnw4hXznpblL2YrEg3UAXadR+n
         wJsQ==
X-Gm-Message-State: APjAAAVWA6TmNSxxs/d9RowEZA88sJMwwi9L0R+nXCcomCRgVElBvEU5
        HatsHp/KahZ7b7ZoX/fA/29LOA==
X-Google-Smtp-Source: APXvYqws8hfOSYTfuqQpuIYlzKB7o2Sp5rFJ3VOL35Gaol7mqdAOiWBTbpZz0mLm3qMRR7/MJdUF5g==
X-Received: by 2002:a17:902:9b86:: with SMTP id y6mr1087338plp.217.1566943152953;
        Tue, 27 Aug 2019 14:59:12 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id e17sm175950pjt.6.2019.08.27.14.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 14:59:12 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RESEND PATCH v2 00/14] arm64: dts: meson: fixes following YAML bindings schemas conversion
In-Reply-To: <20190823070248.25832-1-narmstrong@baylibre.com>
References: <20190823070248.25832-1-narmstrong@baylibre.com>
Date:   Tue, 27 Aug 2019 14:59:11 -0700
Message-ID: <7htva2uv68.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This is the first set of DT fixes following the first YAML bindings conversion
> at [1], [2] and [3].
>
> After this set of fixes, the remaining errors are :
> meson-axg-s400.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
> meson-g12a-sei510.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
> meson-g12b-odroid-n2.dt.yaml: usb-hub: gpios:0:0: 20 is not valid under any of the given schemas
> meson-g12b-odroid-n2.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
> meson-g12a-x96-max.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
>
> These are only cosmetic changes, and should not break drivers implementation
> following the bindings.

Queued for v5.4,

Thanks,

Kevin
