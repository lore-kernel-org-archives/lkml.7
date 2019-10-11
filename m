Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBBFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945812053B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="a2HrG71e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfJKAs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:48:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40721 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfJKAs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:48:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so7376121qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QU4wqiF8JyGpQM5MISLkrt1uWMuNVRRyuUjZmBQ6ej8=;
        b=a2HrG71ePNNWoHJSw+SvYuVP4ZxWJ9fpQ/PWLjjFbbobTU81mQPXkouf5Kv5PnFvoE
         XVRbO2TUAnUhXGGi4aaUmFu38ZSgBGb9EnLIpp2tfaqufd22zXQykJpNShMnvxzwK8qJ
         i6gKV8B1a7wbjUUMdInwGR58oDZG731zm0BMdFq9yclFP68ED+FJOkLZCyZTAm/ud7g6
         8AMh9XD4cTbEXJccGmaeRcflgfC0TS2QDxkVGQmQx2l6JR5JsjbzgWSl1oeQuzzima/N
         RtM9aAo/HWx78cb7p8U+RjXEQFK0XxWcEWRY7LVw02g9RlR50lOSQk7nLaxeqO9AxDGH
         CwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QU4wqiF8JyGpQM5MISLkrt1uWMuNVRRyuUjZmBQ6ej8=;
        b=SNarlhjUWlBRPMiqxEUli8gS0Kam8Nt0YAbFQB+Mozc50bfAfBqIk+N9xUVNtoo8Jh
         54pwceeovTc0cM/CU1VM3iLJy5U0bQzrPCpnub9sFCDQGkSUVc+D761d5tcsncyHyKO9
         ouqzoa82He26U16WQMffzKoE1BarjEizEnNsgXYb7HKzbNg42VLL2MpFDMY9srrLJ9Sz
         +XgXOCNXZ3GfvSuBEhJtG6V7gTfbp1STLlTaB9LNPFoywjMmLJjsNCnM8PTU5lMx4KYr
         w6XTVivJsimhrhJonB6Eb+pYULj5Ea+Xc3fsIHoR6RZEj77fn3JphQqMYaTqtVyaZ4Rl
         iKuQ==
X-Gm-Message-State: APjAAAXo97TDQkAw/4PJpgk3BIPnUrLdNT9F5WEVZ5dgwUMELfF7+0Zy
        4Qjb7xt2ewqEHRUnnpIhfrsm+A==
X-Google-Smtp-Source: APXvYqwWZqxNag4/wYQckZ4ot60sd1xJndNWFAKPaGjjG4lMR3by1auZ9NFHfvmGV9Lq9nHyf/152A==
X-Received: by 2002:a37:983:: with SMTP id 125mr12748039qkj.411.1570754936223;
        Thu, 10 Oct 2019 17:48:56 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 56sm6415628qty.15.2019.10.10.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:48:56 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:48:39 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 00/17] ethtool netlink interface, part 1
Message-ID: <20191010174839.6e44158b@cakuba.netronome.com>
In-Reply-To: <cover.1570654310.git.mkubecek@suse.cz>
References: <cover.1570654310.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Oct 2019 22:59:00 +0200 (CEST), Michal Kubecek wrote:
> This is first part of netlink based alternative userspace interface for
> ethtool. It aims to address some long known issues with the ioctl
> interface, mainly lack of extensibility, raciness, limited error reporting
> and absence of notifications. The goal is to allow userspace ethtool
> utility to provide all features it currently does but without using the
> ioctl interface. However, some features provided by ethtool ioctl API will
> be available through other netlink interfaces (rtnetlink, devlink) if it's
> more appropriate.

Looks like perhaps with ETHTOOL_A_HEADER_RFLAGS checking taken out of
the picture we can proceed as is and potentially work on defining some
best practices around attrs and nesting for the future generations? :)

I was trying to find a way to perhaps start merging something.. Would
it make sense to spin out patches 1, 2, 3, and 8 as they seem to be
ready (possibly 11, too if the reorder isn't painful)?
