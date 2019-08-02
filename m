Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB7C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4056820665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="V3Hpl9Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395209AbfHBVzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:55:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44776 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732887AbfHBVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:55:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so34098635plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3v959y3cG5ZVzOws7Yf1+skokBCt8eVG73f/LVI45bE=;
        b=V3Hpl9HrCUyugLTACvQdLDIAxuPF+z+eQixtnPJTDCaVCGqGU3IOij7fUVmLgwP7DC
         kQsEQblIgYdkFfFqFq4v2ktFDIaHIH/kCq1OBFMuF8o7rptFY8SBTg8EoRTkXEjlTurv
         KIZm3oKsVAnb4XyKjVGi+Hn+e5zG1vs7oLSePanBwPr0YzLP4aaBpuGQn8/fdTV7+6oe
         xKS1Pv+c4Ete30omsGWcP5Z3WeeZsfWBVvUefvXezmibpeBQsoFH5/4YukI8C6jrhkef
         Y+jacXlaIVVCM7PKXLNKr3dnRQPPNji4bTwvii5cKhoD05JsyLdacylOm5WB2LGGTOgI
         k4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3v959y3cG5ZVzOws7Yf1+skokBCt8eVG73f/LVI45bE=;
        b=sSYM/RuM0/XDtNRQHT6BH8+rgYPhfiJtvTnusUEwxkzM42I2XVXJB3p9ZyAxlbJ6bN
         s9D8rU4zWo1cDVU/jgcfuoRBs3RL1QRUpopo6/vq/beYrbSX6E9xGAyJ18zlGYcc7Pka
         EWCfZEqsFslk4mIWAgJPooUTjx1tBylMqWMC6ddXl7Q+fUt2JneeesZx8fsRC5qXroVU
         PVWZtIrtube6mA+92QrLJIxkiQb/YvnfIxu5WdwUOHk+uOSEocBYMjgu34YfMZ6x1UoR
         YNzyerFS2yVXVcLMBD2yB28BRIi/qOVwwy62qQ9bv5YxBX1Vp3nwniaj6gshG0PQypWX
         MpGw==
X-Gm-Message-State: APjAAAUkgcb+6d15wLte57EwJMDmSZV1M4XW6Ah/YxOBOtsj7j/fNqVk
        Yi9KFKOIbYRH+Ihom05IYcU=
X-Google-Smtp-Source: APXvYqyQ65NF5GXQddSgKFl5futnv5t9QQ5mjPDSRTrAoLaT4aq/GyBekbHTh1tXi+6AxlMyrJ+RmQ==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr91768385pla.338.1564782908080;
        Fri, 02 Aug 2019 14:55:08 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r188sm121634800pfr.16.2019.08.02.14.55.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 14:55:08 -0700 (PDT)
Date:   Fri, 2 Aug 2019 14:55:06 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
Cc:     isdn@linux-pingi.de, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: hysdn: Fix error spaces around '*'
Message-ID: <20190802145506.168b576b@hermes.lan>
In-Reply-To: <20190802195602.28414-1-joseespiriki@gmail.com>
References: <20190802195602.28414-1-joseespiriki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Aug 2019 19:56:02 +0000
Jose Carlos Cazarin Filho <joseespiriki@gmail.com> wrote:

> Fix checkpath error:
> CHECK: spaces preferred around that '*' (ctx:WxV)
> +extern hysdn_card *card_root;        /* pointer to first card */
> 
> Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>


Read the TODO, these drivers are scheduled for removal, so changes
are not helpful at this time.
