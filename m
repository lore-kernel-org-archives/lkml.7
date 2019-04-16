Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90777C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E10320449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pP2+6HU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfDPShz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:37:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32902 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfDPShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:37:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so10770896plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9cVQFHR8mlhd2qAgp1/A+upDixV+gKw7JndWUFbqxEA=;
        b=pP2+6HU9yIXMEk8QoT0BdgDUKalqsOuuADRceQ4juogT1XbHniL/i9C2j7WU2tO08s
         Tcb+qh27oquq5DgxW14+z00yY/QpCwudFJvoN6PlB1qqFsheHGyvTVwoxvmYJNjiJybd
         LEqQQodI76thGtGQY1T5pTAXooP5PyYERSquBz8VdEC2pSZMrStn97LSeC8mAnEa8ewa
         8gjg+Kf78KFszRSs0kFgkWXB5rEOMpaxH8ez9RjLhR0hjwHzTAm+uWlvzd7T3iK+AqOF
         DpUgfhFTLLyypUh8Vdd9JQhrD53KTIxsPklTx0fheKpbyd3G9VAMWwCGQAIN6Qq8+ZfS
         UXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9cVQFHR8mlhd2qAgp1/A+upDixV+gKw7JndWUFbqxEA=;
        b=INSwUaNIvRa/hG0EZkhvE/LzxOrO2euhzjq01gHRhgmzZ43jnzSrySntrk7tcW7E6a
         g3ASITlD5tnRt52aiMvfrKVVLy8j1ggpgJPKfF7/KSnbYRHyHSiaWKu/8mQUQF+MCtYf
         KaEuFdjoevMdaSvYX1HFj7qiFFn7cBxztpx77Dd44oTKDZNR8Ir3femR8D5Uhh5B82nX
         Dj6Djrq04OGOjftEJlUOMgDNawYMUP8E5XcVioaZtYp6NlbFitqIjJRqyZdyYN+cLDZu
         Qdv9ExFiUAThTgGK+BY1LlxJYynP63KIUDDcp6sYykdlcTp9DYwpF76EPclwtl+eX1dQ
         dRTg==
X-Gm-Message-State: APjAAAWLLTHqYELX2hcjJZs5t/ebnPmG14TAmog14Etcjjhx4urkwjJF
        VlusqO9OUga0xPEogPxZDvRrEw==
X-Google-Smtp-Source: APXvYqysvmcrxZ6m5GUlNH0uC5OfmhpVn5pkDQoLrADroBTlhKYdwoIdijD5VMD3rBzLe65bUnZvFw==
X-Received: by 2002:a17:902:a5ca:: with SMTP id t10mr81142767plq.234.1555439874080;
        Tue, 16 Apr 2019 11:37:54 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:c45e:7ed8:c242:3563])
        by smtp.googlemail.com with ESMTPSA id v20sm77778521pfn.116.2019.04.16.11.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 11:37:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: Add initial support for Odroid-N2
In-Reply-To: <20190404150518.30337-1-narmstrong@baylibre.com>
References: <20190404150518.30337-1-narmstrong@baylibre.com>
Date:   Tue, 16 Apr 2019 11:37:52 -0700
Message-ID: <7hd0llpzi7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patchset adds basic support for :
> - Amlogic G12B, which is very similar to G12A
> - The HardKernel Odroid-N2 based on the S922X SoC
>
> The Amlogic G12B SoC is very similar with the G12A SoC, sharing
> most of the features and architecture, but with these differences :
> - The first CPU cluster only has 2xCortex-A53 instead of 4
> - G12B has a second cluster of 4xCortex-A73
> - Both cluster can achieve 2GHz instead of 1,8GHz for G12A
> - CPU Clock architecture is difference, thus needing a different
>   compatible to handle this slight difference
> - Supports a MIPI CSI input
> - Embeds a Mali-G52 instead of a Mali-G31, but integration is the same
>
> Actual support is done in the same way as for the GXM support, including
> the G12A dtsi and redefining the CPU clusters.
> Unlike GXM, the first cluster is different, thus needing to remove
> the last 2 cpu nodes of the first cluster.
>
> G12B clock driver is very close, the main differences are :
> - the clock tree is duplicated for the both clusters, and the
>   SYS_PLL are swapped between the clusters
> - G12A has additional clocks like for CSI an other components
>
> Dependencies :
> - Patch 1, 3, 4, 5 : None
> - Patch 2 : Depends on the v5.2 meson-clk PULL request
> - Patch 6 depends on the G12A Display DT patchset at [2]

These deps are merged/queued.

I'm assuming you'll take patches 1-3 via clk-meson.  After you have a
stable tag there, i can take the 4-6 via my tree.

Kevin
