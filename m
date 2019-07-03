Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB665C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0AC2063F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="IzMsn6uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGCBaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:30:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43049 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfGCBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:30:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so748593qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NdF561jXVNweNYUoOJz5cSdmi6GYXNKILSdaVQx92EI=;
        b=IzMsn6uvAihHWC+xI4jQL5EXSlCpq89Da5vdBU8pF5mhxYLAaPUmIASa2aOAoImI4z
         ZW13ivkgV55Kn0Z3u8kGsGNRnpgkewwp65DGh2RkUZezPSv7ZlUErLxqX/fHOGzlxuZD
         VeK914OF8SpXCWrCjwBA5vVyoesm6F5V/zhjuh76NXpWTo6CbaHWisMfBk4yBSikYAJn
         Z6GcfZje1egcCihtpUjrBHW4MyNIxEU+uuKVtY1QfRyYMKv5r+t+sqoQ4eW25NWYKZ1D
         59tytOuMwbdGDIi9K+7/qswB5zK5rOp4cet11f1LJ1RpFzCo7h/X8QStr3ZKM6ehuNC8
         obDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NdF561jXVNweNYUoOJz5cSdmi6GYXNKILSdaVQx92EI=;
        b=MjOCrgs+h0dNZLzAxkERVQCh9Bqa0P6ATnv1hjYVkV9eoQIfwwmyapScG3oNvh6j6n
         NJWzhXF0djAzbcWyRSTyuCzQQNGpsjW4I+//1HRKYURwtaF+QyjA+b39Z/J/kMKKH6Hh
         aUxH2tGSWYzH3A9lfr/1Bm0Gh1hbFXI+ciNaaBDaQkPopZRlHf8rgg50PLVKjojY7lUs
         TlOcvagFf6oM5sZ5OQKx/hqbWavkgBffie33mdWsN/jY0pDZiCnwHkMti531xmGO4p6z
         f/jmPJQQB8rEYixJvsbTZxw2/SXEWxsBGu/RZd0vJTqFpwvrRENIt6CJzUKfBiLbjhb9
         N/ag==
X-Gm-Message-State: APjAAAUC76eJPHp8+RO/PRiw3A17iflE3M0Ha+7kTldo66Rbw0ZmaMyN
        BRwVuzHBOxTWl3D4O/5EnlXBHA==
X-Google-Smtp-Source: APXvYqzonc3yIGfK+TZvGWD04lDWPLi1g4Tt4GSAnz3bkEJTGn3ZfsU0P9piR1RT0f0L6874RQ59zg==
X-Received: by 2002:a0c:b2da:: with SMTP id d26mr18574230qvf.48.1562117401188;
        Tue, 02 Jul 2019 18:30:01 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d188sm279477qkf.40.2019.07.02.18.29.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 18:30:01 -0700 (PDT)
Date:   Tue, 2 Jul 2019 18:29:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 04/15] ethtool: introduce ethtool netlink
 interface
Message-ID: <20190702182956.26435d63@cakuba.netronome.com>
In-Reply-To: <e7fa3ad7e9cf4d7a8f9a2085e3166f7260845b0a.1562067622.git.mkubecek@suse.cz>
References: <cover.1562067622.git.mkubecek@suse.cz>
        <e7fa3ad7e9cf4d7a8f9a2085e3166f7260845b0a.1562067622.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Jul 2019 13:49:59 +0200 (CEST), Michal Kubecek wrote:
> diff --git a/Documentation/networking/ethtool-netlink.txt b/Documentation/networking/ethtool-netlink.txt
> new file mode 100644
> index 000000000000..97c369aa290b
> --- /dev/null
> +++ b/Documentation/networking/ethtool-netlink.txt
> @@ -0,0 +1,208 @@
> +                        Netlink interface for ethtool
> +                        =============================
> +
> +
> +Basic information
> +-----------------

Probably not a blocker for initial merging, but please note a TODO to
convert the documentation to ReST.
