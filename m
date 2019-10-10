Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC05D208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dW1SUYjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJJN71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:59:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46510 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfJJN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:59:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so7993801wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2WQZBYa815qI+SGRD60IQB0uLSUfBk1gmVJVi+Ixn+I=;
        b=dW1SUYjqNQUkj1Kq9vEEnarMawZv45GBhVCsNi/ARDDgLoeFUmWmw6464Ny+DZItty
         T9tVLIdRgKQ7SUzXloE2D1cuhE+OpynyXYveyB1GJ2MUNMkXSSp71XT+BSv9tOPHjRiH
         SLZIFItbrMx/GAwBkbKuzWyQwIqCb99SX/cjFGIDgs1BjMW1PxjNiiwxa/teDmBFC0uo
         PfxuXU3aXCWlOsbmuO7E0UTInelYaNh4BF6Wuw7DgQrggI7Lyyyf1if/cyOhWiWKaRil
         0BhGNTvWl7vSv1CB/1vrz3eEjU7PNit1756qrm1EGl83NG/E4FOY90uSQs4YXEoXt4he
         OMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2WQZBYa815qI+SGRD60IQB0uLSUfBk1gmVJVi+Ixn+I=;
        b=hGM5UKRbwo5LPqdJoQPG2NYBzVBqcz0LKBOr0X+VajO/vuj56zEZcZniOMucJb0cP4
         4TPr3Iqp2FRaS9Xchf8Cy+VaAo7qTfYMakNK3Xlc6C1e+GTtyoyMlCgeed/1GGVzREgG
         9IqJCydhBN/MmQsZAN8o8YPjQ775A9vOIq9jt1Mf0HZBEaYCkKlg+G+c0UlLhaBSs8JP
         J9Nr3bvROggwSMgjZR5AJBwxcYhGBKGyjTBuUmZMQ+DRQ0FG6AGWYj+NaNL7pfhz5Hsj
         O9UJnSfROoM3fZw5QN7Q0K0G8930hwecrE1MIVI6CzUOGsIEBaEIANFHXngu9MXuesK0
         0r2A==
X-Gm-Message-State: APjAAAUfydiCRWrBCkJJFHGWPCtTW9n6yyaDu3u1l1rSaRtCIUdReZ4E
        MkghrTBKqX11Kl9+pgrYoM1dPA==
X-Google-Smtp-Source: APXvYqwB88rdETd7uewu+ZbWl7jywalr3zZGgmDMbF4pGb0EI/J5hyeworGvOimAulLSaWkMKU4tew==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr8884694wrp.69.1570715958919;
        Thu, 10 Oct 2019 06:59:18 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id w3sm7889355wru.5.2019.10.10.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:59:18 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:59:17 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 10/17] ethtool: provide string sets with
 STRSET_GET request
Message-ID: <20191010135917.GK2223@nanopsycho>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <62cb4c137ea6cf675671920de901847d1d083db1.1570654310.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cb4c137ea6cf675671920de901847d1d083db1.1570654310.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 09, 2019 at 10:59:30PM CEST, mkubecek@suse.cz wrote:

[...]

>+const struct get_request_ops strset_request_ops = {

I think when var is leaving context of single file, it should have
prefix:
ethnl_strset_request_ops

[...]
