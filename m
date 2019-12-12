Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53820C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC7A2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sL9QHEKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfLLTin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:38:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46801 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfLLTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:38:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so17460pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nO1Xvte7AHlIbFQy+ePVzlUeHQ3CsGcG48YlqFHOTlw=;
        b=sL9QHEKUW7AQpOsREX++fq+CABCPzEVaWhNpvN+2nVXu97o+mwotR0gpjkBNB0WDCc
         BoZLZld9YORyrUkh1GWkJoK4M+o50hULQuYMjuSvr7+WHJy3Q76DF0xyzyJjzow+gI81
         CS/44yThSAuTvgNo+qTEf/JNSns4UqYQJP4hYjOWLmA1EOmlTEfDmsAtCfFZD8k5pqsW
         H+gDh1HVb8dee7euqzphzNu16t4IJufA/2nWid3ePpjh7Nym6pDnbXge6dutrXncdvrv
         1CwP9xRoj9eLlFP0YOOs2oWye36ZnrTAv58m6A1CwE31VsIOMI+TxUZ9lpf+5QoHJvdj
         tFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nO1Xvte7AHlIbFQy+ePVzlUeHQ3CsGcG48YlqFHOTlw=;
        b=qZM0NPoBX7izedHWMCDmLX5PYVmJeViG0fgaYMV61/aWz8aeXeY7LzVtUSD0+48PN/
         xNKtGBvR5LtKodypJCYjOzke0CAp1+wmWJL18cjE/UY/V4nOsJ/MLcGECy7gwNTN4UpN
         R2ATF26w0RhMwq1EmnBHl1exH6yYgj5/+LXGm3uBSzP1faQKF778sBhGKj4VtH9xw1a+
         S6OKsSY9mAbPccC8PV8qj9kb/015x8m2asuWDQoruW1snpPBekLpbXEH6/mWo2D+bXPG
         gSg6ukZ8FvhIceLEbS4vwZfRO2D3ilKsrCeaSKNac6o9lk88MdHY/dKB7nAaszaGr+r1
         Fplw==
X-Gm-Message-State: APjAAAWeAsGrVcQ6wVGb+clsUymBIxiotC9kRGloUVb+o4ar7dUFp+JB
        2ijYjjby2jlZalLMFOScPXqmDw==
X-Google-Smtp-Source: APXvYqzLzdjr2HqsdVrX5PuBO0uJYGQpjtYnz8xrey+lYpgLwL0QgLIlxLijTHUj4J1SIZPlrthuyA==
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr12527612pgi.159.1576179521721;
        Thu, 12 Dec 2019 11:38:41 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x7sm3542837pfp.93.2019.12.12.11.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 11:38:41 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        narmstrong@baylibre.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, devicetree@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support of CEC wakeup on Amlogic G12 and SM1 SoCs
In-Reply-To: <20191212145925.32123-1-glaroque@baylibre.com>
References: <20191212145925.32123-1-glaroque@baylibre.com>
Date:   Thu, 12 Dec 2019 11:38:40 -0800
Message-ID: <7hpngtjpvj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> this patchset add support of CEC wakeup.
> We need to set logical address and activate some options in registers before going in suspend.
> Registers address and options values come from amlogic driver.

Tested-by: Kevin Hilman <khilman@baylibre.com>

