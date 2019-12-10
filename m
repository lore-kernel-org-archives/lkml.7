Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F4420836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mt115MN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLJRvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:51:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40934 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfLJRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:51:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so198376pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=fW3Ref0PHQ5io/FZ7XeWN9s3SNVfAIL+FiYKUeQn2KE=;
        b=mt115MN0ewRf9mbMFfp3Iuy2d9FfypEgxpQPsNISDAUH+rYzYYoVGNS6eQVx4xwi7P
         yTtaMc7LznoM3N9LJtFlmsznQ0SGCA7fpiGDFmINKs/wZ+ddeaDvS5XJj5isX8gCWPn+
         cfh+7/hpwkswXJwkPhciglEpdSvkWiZithOzgl+FdoDdWMXk1r1uRSPSvEi6e+dPZzuW
         M2SkMSiHHj2cbV6o06Ph2ggoSQQ6j1YB1OhHfP8YWBCLhnAcvJ3C7RwuftNOGuJE0E0w
         zGZV1mQY+gTcqgcLn4dgrucRHY4oamVhHdAXQH0goEO9cb2BEEs2PZNrayEg8nkaVLPv
         v1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fW3Ref0PHQ5io/FZ7XeWN9s3SNVfAIL+FiYKUeQn2KE=;
        b=EEOzGLt0JVx01gIx2MofH5yiFofY3zVVNTs6xG0ba5nks9J1XEAfFxf1fmgzxhmocr
         Ul5Uj4mZyQcQMVvogtqKIbV6b8NuifQvDrJvhqkeJoNHRyW4o7enE5T0NFehQ+I0i3g8
         HyGkd46LeNtkznM7MwtW79jCuMDWGq/2D079GEqYscomXOVCVbCtmHms+yIdfkBAO80Z
         GNLf0y9lNLgrzwTIgr2AW2Sj2LEU2BFrOEpj+FzhA2KECDef+iM7tUpgO/qGFlm1dlsW
         tObOVhMkhBfKxha4cbqUASy0s5CDC/KOahga9o5gnb62On1YpBCwshdPanPFwZal44wY
         BWGA==
X-Gm-Message-State: APjAAAWUnqTfGDicWSG5pnTUy7MPkOKjhnYoyp9tvLEStI93zwGzWXrU
        YL2vitbMCSNswnRYE33uCPSG5w==
X-Google-Smtp-Source: APXvYqwcFHWWm9eTWrLu+KNteuLcuDUJ3dB0pTgi9WFTG+6hBnstYp4EgibKkKe5+8YCV2iFmQrQKg==
X-Received: by 2002:a65:5608:: with SMTP id l8mr26335894pgs.210.1576000298286;
        Tue, 10 Dec 2019 09:51:38 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::3])
        by smtp.gmail.com with ESMTPSA id y128sm4103464pfg.17.2019.12.10.09.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:51:38 -0800 (PST)
Date:   Tue, 10 Dec 2019 09:51:34 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/5] ethtool netlink interface, preliminary
 part
Message-ID: <20191210095134.27f46a81@cakuba.netronome.com>
In-Reply-To: <cover.1575982069.git.mkubecek@suse.cz>
References: <cover.1575982069.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 14:07:48 +0100 (CET), Michal Kubecek wrote:
> As Jakub Kicinski suggested in ethtool netlink v7 discussion, this
> submission consists only of preliminary patches which raised no objections;
> first four patches already have Acked-by or Reviewed-by.
> 
> - patch 1 exposes permanent hardware address (as shown by "ethtool -P")
>   via rtnetlink
> - patch 2 is renames existing netlink helper to a better name
> - patch 3 and 4 reorganize existing ethtool code (no functional change)
> - patch 5 makes the table of link mode names available as an ethtool string
>   set (will be needed for the netlink interface) 
> 
> Once we get these out of the way, v8 of the first part of the ethtool
> netlink interface will follow.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thank you!
