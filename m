Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958C9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E02020863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RtwNPyQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfEWRUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:20:20 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:40256 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbfEWRUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:20:19 -0400
Received: by mail-pl1-f171.google.com with SMTP id g69so3013800plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=E4wCoZelzPeF40n6KWK0Y8InfWhm/K7CvH4QAAtzBuY=;
        b=RtwNPyQOVHmIh1T5LywtaHaQv0gUQC2wSVqDRCMdf6v5fEN0lOB7Wy4mhpAVvcOnji
         X2f8edBEstoW6OLuJBViDx8eELKUghmBrEYuHgKjP8msuxfePYaE30lChQWcpGmJrDqW
         tyHeHXuN95G++JbqxJJ0/oLUc0lOdHb6D2/8mJrKvLool1D5uLHHU/AJezZLkKR6Aa0e
         aLu9WSCHJXzY+nleeVo/T7nyXg4IMCH59oitG2uOqTWdr7M15tV9GX77wKgOZUg7DhcR
         HeBXRtSGiG1bMulx+/NJnBqzLYUBnURuoiWCwbqLG5mFPNPpIExSaMQSWafXcBG1hYm5
         nTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E4wCoZelzPeF40n6KWK0Y8InfWhm/K7CvH4QAAtzBuY=;
        b=mPk3MMlKXDwvn/o+39km0RtrZBgIEq+p8zfYaClVf7B0SDZqcyePTUlaCkpLxQ7Ws3
         PgXn0HQu7xReoX7Y+TLu4WjqzZvmhX524Z1Kz3cHl8Glmu0XBxE71oT3JT96BhPRRQbr
         5YbEvonIwwKGMdWp1D6Sao/kmQppmrSp4uAwgfRRkp+SehYlFXt9yuwfoxGvpCHHokt5
         6WbWlUPQtJQwFv6GU5H8wgOzkNw3dZmPvHGn50JAikluqKu1uCWRL3oHQilHdq70RJ/w
         uu26BII3AP6kJ+Ii2iVYLct3fN7UuUy6rxm3LIavHVGwpjaG6iiDXmWUkgwuVxx1YxXo
         Pmlw==
X-Gm-Message-State: APjAAAV7eEcMBHTdkHN6Gv7RW2i3m8hXe04grw0NZNyNy1oN7KBJBgog
        D4sE7f5yHsIz1+hJAgplysF+Dg==
X-Google-Smtp-Source: APXvYqzRWzAaALeaMqNcd2ribS2Qvh8R8/MueP7qkpKKvwUsbI6KltgJMx0zYzvqQbThLYsJ61MOKw==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr96916175pla.239.1558632018359;
        Thu, 23 May 2019 10:20:18 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id k3sm20805pfa.36.2019.05.23.10.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 10:20:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: meson: g12a: add ethernet support
In-Reply-To: <20190520131401.11804-1-jbrunet@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
Date:   Thu, 23 May 2019 10:20:17 -0700
Message-ID: <7hzhnd2ilq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add network support to the g12a SoC family
>
> This is series is based on 5.2-rc1 and the patches I already sent last
> week. If this is not convient for you, please let me know, I'll rebase.

Queued for v5.3.

> Also, you will need to get the clk tag "clk-meson-5.3-1-fixes" (to get
> the update MPLL50M id) from clk-meson [0].

I merged this tag in to v5.3/dt64 before applying this series.  Thanks
for explaining the dependencies.

Kevin
