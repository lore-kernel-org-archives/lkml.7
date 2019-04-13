Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA13C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D292084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="vM5e/Amx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDMU4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:56:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37257 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:56:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so16491910wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZVknf/QMJ1bLLpsG7KajIss6Fv94wLP3AVyfA6BbiA=;
        b=vM5e/AmxR0WvzZkm1i3CkN7yCsO4Z8tObWauLMKj6K4laDSu7zZXRHEMqTaiSGuefl
         SOIEHZnCBoDfVIY129KCmYJHZJFDjn+OsGlyWLQcqVoJnbXURZFkCzUirW6KgimymYQo
         OeYxT+mMDxuDClgoxiAFq1dAFAL8d/LTsbcfb9VRcxbNqvqMd6NJal4oq2PeXs7pvJDh
         dErRJqRmM9T26PgRUQV71tHKe0yW7hlXbF93IuFXiXrq3ZGiK6ueciE6FiLtxxt7iNGT
         BTOcj2myKGKGRHrDNQvXnTNKYVxs4sLztpETSpS/b/6bdkUAi8a8DnMKLIvkECHbtSyz
         MaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZVknf/QMJ1bLLpsG7KajIss6Fv94wLP3AVyfA6BbiA=;
        b=QZHebh7oJR/5scKpi514aTXwlgF6M2I7+HsUptTG6/2WfgQaUZecGlVF2PGXo9WAbJ
         C89e4Bx5S/mndfKvF9D5dFLtH4aiTHcQkFGB7Bl3bwlG9FMW/Fb78mPLdpPdqvwYl+E/
         ehQ1T3yVX7BvxMydu8n0wk82mNLHqbB3aD3JJY90djXQJhCJO1U1XCeNpdyIEGD+Qgzm
         NcCOVv2DvhiFu1saEDO77x72MIOInQRLnP7WH6h1Qp5KTyyKlwvDcLpvL4wTlvlr6lTq
         ay0iAj6HeJ5tGs0g6ppiHruLHiQB/uuXbl4Nj3L++Tysc7FMhRzWnAqvcKAx51/zkSqT
         g9YQ==
X-Gm-Message-State: APjAAAV4nVgCdfUrdE2mgn3E0aVPZ5XzhTBdMM2vAcCqepxcqJ55cQJq
        msjfkOw+BrUQ89tcGkw3wCxJvg==
X-Google-Smtp-Source: APXvYqw5lOyYbLgTbdfmJlE8mrHZOcuQnt9k6ZxwLncESs0nKge3Y7b9duQ5FVc1BEafcuTH6tJHxA==
X-Received: by 2002:adf:e648:: with SMTP id b8mr40472472wrn.132.1555188990908;
        Sat, 13 Apr 2019 13:56:30 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id r30sm147229381wrr.46.2019.04.13.13.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 13:56:30 -0700 (PDT)
Date:   Sat, 13 Apr 2019 22:56:29 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 16/24] net: dsa: sja1105: Add support for
 VLAN operations
Message-ID: <20190413205629.GD2268@nanopsycho.orion>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-17-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-17-olteanv@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Apr 13, 2019 at 03:28:14AM CEST, olteanv@gmail.com wrote:
>VLAN filtering cannot be properly disabled in SJA1105. So in order to
>emulate the "no VLAN awareness" behavior (not dropping traffic that is
>tagged with a VID that isn't configured on the port), we need to hack
>another switch feature: programmable TPID (which is 0x8100 for 802.1Q).
>We are reprogramming the TPID to a bogus value (ETH_P_EDSA) which leaves
>the switch thinking that all traffic is untagged, and therefore accepts
>it.
>
>Under a vlan_filtering bridge, the proper TPID of ETH_P_8021Q is
>installed again, and the switch starts identifying 802.1Q-tagged
>traffic.
>
>Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>---
>Changes from v3:
>Changed back to ETH_P_EDSA.
>
>Changes from v2:
>Changed the TPID from ETH_P_EDSA (0xDADA) to a newly introduced one:
>ETH_P_DSA_8021Q (0xDADB).
>
> drivers/net/dsa/sja1105/sja1105_main.c        | 254 +++++++++++++++++-
> .../net/dsa/sja1105/sja1105_static_config.c   |  38 +++
> .../net/dsa/sja1105/sja1105_static_config.h   |   3 +
> 3 files changed, 293 insertions(+), 2 deletions(-)
>

[...]


>+#define sja1105_vlan_filtering_enabled(priv) \
>+	(((struct sja1105_general_params_entry *) \
>+	((struct sja1105_private *)priv)->static_config. \
>+	tables[BLK_IDX_GENERAL_PARAMS].entries)->tpid == ETH_P_8021Q)

This is unreadable. Please have it as function.

