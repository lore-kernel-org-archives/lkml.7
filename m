Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8BEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C302218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="w4xuo4fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfB1HMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:12:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46870 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbfB1HMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:12:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so20624279wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGQW2oahYAlSOpXiq1BYmliYKUyX7rZf8rdI0t1YZRI=;
        b=w4xuo4fK0mVxOujM6yKrf3yPj4QU7eW7zSXC07Pi+xyh/Jlzx3rSzSPAnBrD2hx51T
         CeqW3fRpupXhSLZaKASpexJSHZYjzyeFWa0Ylc7DqoH9bfrSFdcmvuONdWL1HjHGSucP
         eBPlk8Oa8+U5S+nHgd//Jubhpt9/Ge1P7wO66lpZy/CdX9tBSQHgy4/P5TOnGbYQrWZ6
         ehosX7fND9VYzvfqCLOOxyplQSGm2SQm+hLBncKzDnf1yuYXZg0lG4sMS4H5GcO1m9Dd
         fzovK1fJttYdfLFwf15josa1XfAjHG8ug3eenHY7HkPAMistydyKXFmT/2OLhI7Jd3Wx
         ZqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGQW2oahYAlSOpXiq1BYmliYKUyX7rZf8rdI0t1YZRI=;
        b=RHBnIXzStMn/ojF19uG1a+NKL1muTtd5O+WvvWhliXrEQadZoV8+e5NULhl2RTkrl9
         rFozQOVCRepCmEuCfcDHhKVypKLyiDWkRqcfDQVk6WCWRgSSqp6Re0vwAhGTIM7B+KBA
         1vqBV54AEzsy55R2S46SVPGkIMpT43CkzCeh/weo0J5vkL2El7puYYfZ5pcI2zoKPlNB
         K4JjIH8TL/J9DABK5sCKZZ09V7Afh2zoes2BgLAuLyrX//AVPVuDgutpUjM5gR4n0EZU
         4Ne0uVvkJokxGj4eDGIIX6OfodDj/ArJjroWejZ8v+Kn8aiiYVL/qlFcNG6ghfrzn8uZ
         6kyg==
X-Gm-Message-State: APjAAAXdNdDthlOd9igLGeSQ1lnvcOaXGJonxV4Pdd8+mCYPBRYRam32
        2gd/MrOGlGxdoI2JL26BRZTskQ==
X-Google-Smtp-Source: APXvYqyofw4cnM22+R03XPJkLCpbnKRQVaMuMKYSL0s1QnJuoEc8cdEImwzM2hWtgNghgTYdsTuGOw==
X-Received: by 2002:adf:824b:: with SMTP id 69mr5282737wrb.24.1551337965040;
        Wed, 27 Feb 2019 23:12:45 -0800 (PST)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id 203sm4536916wme.30.2019.02.27.23.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 23:12:44 -0800 (PST)
Date:   Thu, 28 Feb 2019 08:02:50 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next] switchdev: Remove unused transaction item queue
Message-ID: <20190228070250.GA2324@nanopsycho.orion>
References: <20190228002916.24904-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228002916.24904-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 28, 2019 at 01:29:16AM CET, f.fainelli@gmail.com wrote:
>There are no more in tree users of the
>switchdev_trans_item_{dequeue,enqueue} or switchdev_trans_item structure
>in the kernel since commit 00fc0c51e35b ("rocker: Change world_ops API
>and implementation to be switchdev independant").
>
>Remove this unused code and update the documentation accordingly since.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
