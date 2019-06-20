Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E85C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C687720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z1LgyUti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfFTDlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:41:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43755 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFTDlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:41:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so826295pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yXSKF3KCooCH6IcstSdp1nFOTcORw0aEc+AxKmLDy7Q=;
        b=z1LgyUtip5NsTjNacdDhfzm+Ed6a07P8iqtB9CkZy7wdwCNLokZLIx1qf3aZs7jPAG
         nOh6YKx/Z5pcYp7y259rMlClr9ZC+be8UUIpLARGpIgiObtp3gTY7/biPfl9XSCdwr6s
         esKA8N81cqVr0Ep7GVeSZUWkMSsWpVMaJDjdfFltMhvLKTSM9HMgTSruQZzIZNODM8Jf
         cscCRC9wc2valBsWioyVDgHelvyjxkN+jpsWl1itwjIBlDJkJfqje+lshczT9n13RMpI
         LGBYc00TMUJvGqRz4a6CZRHawT4XaUQ105jrvvZL6E8QvcXN3WMHzrVBXbjLQwcSjMLn
         eX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yXSKF3KCooCH6IcstSdp1nFOTcORw0aEc+AxKmLDy7Q=;
        b=n+QJBzPNvW5PjlGNUP9ycATHuYbjCIBiIeVSInnSbA0PT4qAK4aauIpoOwfb8FAzZm
         w5eThsd7RMeK207RasVYu9YfsoTipJPAX4xR7HiFFwTmYmBprydD8J0wsw7gwokNhxqJ
         dzbR074OrMf5BrJDzEneCRKDsA0Fm4Hb7iIVV/bfRC+LT8EluO8qQQtFWDF5MDb4Ibh2
         zd7nTwQYHB4cqULnFUkQubxK6BabBZtVLY1S4WmUqTEvBuvhMfh4285m2jxJjwzomb5V
         hC2ZVgbnJ8BdRrijfogE+MEG+EZErXWu62jKMI3dSBbUOIQOe+hOwoziB4lD4rcwdtG7
         kPLQ==
X-Gm-Message-State: APjAAAW5zK2qiCQJeEZCD93MFjN8uZAlY6fhpoxxigTGG6aBDXEJDZ0z
        bQZMiPJ6GKJ3xoG6F5Ke4Svv1A==
X-Google-Smtp-Source: APXvYqwic/TSqTqVCd7HklEgT+a+qLMKSeZd98mTFCizUJYVZby3+cXpM1Hiwh7Iqam7m5933+GUjQ==
X-Received: by 2002:a17:90a:cb01:: with SMTP id z1mr724373pjt.93.1561002067810;
        Wed, 19 Jun 2019 20:41:07 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ec6a:e4cb:28b2:e322])
        by smtp.googlemail.com with ESMTPSA id h6sm5198434pjs.2.2019.06.19.20.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 20:41:07 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: g12a/g12b: add the Ethernet PHY GPIO IRQs
In-Reply-To: <20190615104351.6844-1-martin.blumenstingl@googlemail.com>
References: <20190615104351.6844-1-martin.blumenstingl@googlemail.com>
Date:   Wed, 19 Jun 2019 20:41:06 -0700
Message-ID: <7hd0j8j54d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Avoid polling of the PHY status by passing the Ethernet PHY's GPIO
> interrupt line to the PHY node.
>
> I tested this successfully on my X96 Max, but I don't have an Odroid-N2
> to test it there. The reset and interrupt GPIO part of the schematics
> seems to be identical for both boards (and probably other "reference
> design" based boards as well).
>
> This depends on my other series "Ethernet PHY reset GPIO updates for
> Amlogic SoCs" from [0]
>
>
> Changes since v1 at [1]:
> - added Neil's Tested/Acked-by (thank you!)
> - rebased on top of v3 of my other series
> - updated cover-letter since the GPIO interrupt controller support
>   is now merged so it's not a dependency anymore

Queued for v5.3,

Thanks,

Kevin
