Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E9C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39E620820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDG7R2p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfGNPrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:47:41 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:34552 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfGNPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:47:41 -0400
Received: by mail-qk1-f170.google.com with SMTP id t8so9936467qkt.1;
        Sun, 14 Jul 2019 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ERsJOUhZ69q67v05/OTH8gBbcr9lFonDpDMj90Lxvc=;
        b=WDG7R2p8zuxvhmA6DsTOuwzo8M69Br6Qi+jiCTvKacYh/68IrsyMLf7/hR8p28UDOA
         KzjSKBcTnvrwh4Paj19UM/zmgvK87eYbja4HQSUqNB7p9rJGaluLcSkVICq1dn9jAwTH
         iBpy0Otfi/8IA0laskB0HlwaIaQ50ZTbsMRL0RGqIJ1KWqRfKx1thTxD9C7xd8heCv44
         6g2o8O1AwoMCCy7qxXsdhmBgKDa2u1LCUNvPfff2QjpmN48HYj/WjBrlToMDJaOF3Ego
         yWZEPecJnm0evQJUVkwQM4KcStXp43df29bN49//o6lgojDF1dH+Hxl+AVyhMUMDPDKy
         kDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ERsJOUhZ69q67v05/OTH8gBbcr9lFonDpDMj90Lxvc=;
        b=IpVC1LUygyLV8bY5vCuk6/AC4VdWOgps4IX5FQpH7C++ODolXhORxb+WX62tKdfYdD
         PEk+3/vUrLtZEeQsGMVbcbE5+EHZxZvt+D2xdftJPPbL1ebZQaYrpzLyTUeBTIGGt8/u
         QbN8oqvUmvxdo44f/eWrzYv52z6BLwmsW/GKZgoUjwThXn6MVz4G2YMi8o1dwIlALHuH
         eVV8KEOziVfg9LlpWkpZE0+q9HTJbOLnLBpMhKyqpAWA8YH7JVPrCofASj3dlkiyMAi2
         gycm1m8gLPBUfb+X1ifntt7bxLxJo+eiTJ5sn1W9gVzrgvhks1eMdSSmlxtOu2caE0E6
         F+3w==
X-Gm-Message-State: APjAAAXOqUzkaKYh6V4i9JjtPbIBL9ssk8wpnUVOKeH4/R7mxC4VTBAc
        UHup7KVGlxhWCeQzauLyug==
X-Google-Smtp-Source: APXvYqxe/WqFz+YIifvverZwLiiGuU2VQkkfAqdIL4kqrU5R/xRQUcP69roH6+AsSglAzfivJgc/8A==
X-Received: by 2002:a05:620a:41:: with SMTP id t1mr13427321qkt.423.1563119260333;
        Sun, 14 Jul 2019 08:47:40 -0700 (PDT)
Received: from keyur-pc (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.gmail.com with ESMTPSA id g10sm5977934qki.37.2019.07.14.08.47.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 08:47:39 -0700 (PDT)
Date:   Sun, 14 Jul 2019 11:47:37 -0400
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>,
        Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v4] staging: most: remove redundant print statement when
 kfifo_alloc fails
Message-ID: <20190714154737.GB32464@keyur-pc>
References: <20190714150546.31836-1-iamkeyur96@gmail.com>
 <06fc2495-dda5-61d2-17e8-0c385e02da1e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06fc2495-dda5-61d2-17e8-0c385e02da1e@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't get you. I stiil need to update changelog and send more 
version or not. If you say so, I can send one more.

Thnaks.
On Sun, Jul 14, 2019 at 05:23:34PM +0200, Markus Elfring wrote:
> > ---
> > Changes in v3:
> 
> Thanks for your quick response.
> 
> I find the change log incomplete (even if corresponding information
> can be determined also from public message archives).
> 
> Regards,
> Markus
