Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DD2217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNO1gEo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfDEPJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:09:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34073 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:09:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so5847898eds.1;
        Fri, 05 Apr 2019 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mf4EDbBHSkv0UqevFmwnIDKYsENZQ75otDsKfEIbqW0=;
        b=KNO1gEo0zDrMUNiXAxfBad5I/jDI4WljlmQLiRFZrIjmiOdsOeTBb4BzOZZjMAlgzN
         B41hrTqGPIHAgYIaimTAljL13dmHE23gizRobZQ65UQUP16RDGZ5VXVPAASa/aUtH3gJ
         pTH+r95D3nXHyLw01k32+QpdUi7yca+u0NxFePIYxMmjCIZlO94qZ2o1fm4bMGC+0qux
         Saagss0/hd9DBp02R6Ij3PG1HE93X6HK6Nn+NVZcSvKS6etg0w5DVdW+6XbCctPnf/HV
         29cjqR4V3u+SbL4iY9AZlpMvk98BCnEvXaEuCAsmKgWZlzz/FeZ/rufHVNdvJzaWku6O
         Xs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mf4EDbBHSkv0UqevFmwnIDKYsENZQ75otDsKfEIbqW0=;
        b=Ol5Frr4h9IVnnt8jolyBwlv1LK3w2muyWgxVLm1xD9k+GrjT6fmXhuyL7u4gbAzngC
         FujpMPFFWl0Blbko3Vsm0de1HXYgRJ/NPXccatfoq3+RnpTL0xytIdEIXvvbEl24r3CP
         wvxOYlqfS0tB3iqAowVZs0RsD0kR7SvfJg4g3lRq19vGSvQonI+ENkmmIiyokJ/YRAlL
         wvG6ObDUa3LtW+K3AHFoBR9QG+JJ19gpWMwq6OGw0B4HdFk0gdfW1sskbOu80Ye6u6kx
         5RRs9P8X2FKka2HjI+PoKvxxrakr42J6ErmPfnwU1bVN/ulHcl2SYP3Rc6a5dvsyRJ9C
         y0Ng==
X-Gm-Message-State: APjAAAX9TaPYVQAG16IcTj6RAlfny00Mf6zk36/prf4uSw7pwyuI0RGD
        OMDTD5m81eOxF2eni+ZrUr58XUjG
X-Google-Smtp-Source: APXvYqyTGC+erHpIu7aATpcTU6+EkK7d9Bzzu5zg2lBGvFBWmflJhdIR2SSS3KIgcp5732whVoh4jQ==
X-Received: by 2002:aa7:d6cb:: with SMTP id x11mr8150973edr.85.1554476991176;
        Fri, 05 Apr 2019 08:09:51 -0700 (PDT)
Received: from dell.be.48ers.dk (d51a5bc31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id k51sm6558645edd.32.2019.04.05.08.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 08:09:50 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1hCQTU-000163-Un; Fri, 05 Apr 2019 17:09:48 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 08/12] i2c: ocores: refactor setup for polling
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
        <20190403124019.8947-9-wsa+renesas@sang-engineering.com>
Date:   Fri, 05 Apr 2019 17:09:48 +0200
In-Reply-To: <20190403124019.8947-9-wsa+renesas@sang-engineering.com> (Wolfram
        Sang's message of "Wed, 3 Apr 2019 14:40:15 +0200")
Message-ID: <8736mwtrnn.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa+renesas@sang-engineering.com> writes:

Hi,

 > By properly setting up the algorithm at probe time, we can skip the
 > check at every transfer. This allows us to get rid of the flags
 > completely.

 > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
 > Cc: Andrew Lunn <andrew@lunn.ch>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
