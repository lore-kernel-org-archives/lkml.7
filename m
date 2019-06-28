Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B84FC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CF42083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GiHzQpHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF1R6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:58:35 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44243 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfF1R6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:58:35 -0400
Received: by mail-pg1-f169.google.com with SMTP id n2so2906614pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Vl3V/b9d/YR3BoBzMucBuY8z9bflVwMcEzHAzE43M8M=;
        b=GiHzQpHEBzX787s/X1QIF6dApBZZr+1I94MMXG75kyPqsnypZvvVmyPXmqQ4DDWDP1
         BzcS004uag+6zBmiVow3iazQZwCovOnO+ZHlIt9I21QnI0F6Nflvj4dUWBUbhq7AbO/m
         SynTdJ4H2/6gv6sVDQ/Y6+Xb3rJWkBq67DXPBHgz+cu1AXl9k8kEn7My8wk8Hf4WKSc2
         DZFzfS/MxxvfSALWkxuMLiVFMJYmOEgRUhfPMprrAJXGAmg42GEl4SGnDGCvrnJcyTse
         bBCzUsjp+9FQDvCouNixum4aYfj7dm7fTO1MgaM/A1Gdfa8Xw4iAsFFkjztnwVtxortw
         zQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Vl3V/b9d/YR3BoBzMucBuY8z9bflVwMcEzHAzE43M8M=;
        b=MM9eurjkj2o3CZ8MPT9rJnQv4eUt3DUdB/JAtkPjLl/Gf5xi81pGPUuN6gIPWXhUMb
         nU2KfwhBNfPhitDiF5v5O5RXctgDyN811Ux5qnihVhQW8P5kPz6Wm51eCj+285UbklUa
         paSahdFPtsEonD3H7OazhTjuG1hF6UrUbO4oZ4Ia8kDZ2n0nKc8+EAyA5+rVbki3cFCh
         5jmPKhISQvrH/HwtKvSI1GhD7c5WnyrQjPEITVFCBFYYv4umg4UANV8C13Vov+I7iTcT
         CeDiCXmDo60p0LvM0vZHl1QhMUjHo57K7nruMLSqQ7BpKdV40vKymAblWLR9DE0HLs8o
         Mw6g==
X-Gm-Message-State: APjAAAVfHAOduHLZoLn34PuYdy8UenN1VCeArxtd77HfRLGKVTBZwrA9
        Aog3EhFAapp4rRIWwarEe0fWnA==
X-Google-Smtp-Source: APXvYqz3zRSNG8ksCoG/kgVrFj0M6c77+R2i6vSlgO/BJ1CePZMBP9OvFZEvXFjF5JaAwCqI6GsMBQ==
X-Received: by 2002:a63:e057:: with SMTP id n23mr10491079pgj.228.1561744714489;
        Fri, 28 Jun 2019 10:58:34 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 3sm2963791pfp.114.2019.06.28.10.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 10:58:33 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC/RFT v2 06/14] soc: amlogic: meson-clk-measure: add G12B second cluster cpu clk
In-Reply-To: <20190626090632.7540-7-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com> <20190626090632.7540-7-narmstrong@baylibre.com>
Date:   Fri, 28 Jun 2019 10:58:33 -0700
Message-ID: <7hpnmxr3qu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add the G12B second CPU cluster CPU and SYS_PLL measure IDs.
>
> These IDs returns 0Hz on G12A.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
