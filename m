Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C154F2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xyMgxJpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfC1SxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:53:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35632 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfC1SxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:53:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so24413736qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=2+yVR/eXhUEiUjrePeNYCTy0DJkUbLGQw97cbREmMac=;
        b=xyMgxJpIBqjdCLrPI+9R+Jpw86PrmPPBqJhbUAYbNRk0GojOgnyfPNID7hmxHOmsbm
         OJwgAFVIlQpwuI86EOduv24+Thph9lSA++yjp97ao48qo3q8hs5e1CmymAzLEssIjG5o
         zsKvjE/jFuAuFrk3Wgv9u28OKmi5A5nhjN7z9WWXzDwWFuqFLPuB2+iX7v9Y7OThTCsY
         BAmC6cHNs0FkMZ7WkKgk0rlLB59FLWFFxNtt7uEXvixQkxPUa4AcM6AMS8+YfXOfFbk4
         xBpdZ2lNFQ/S2zJQrAAqwKtFNN0fL1xOdopRu5+zs5HUK33xGeR13ov9KyZWhRXK+46T
         96pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=2+yVR/eXhUEiUjrePeNYCTy0DJkUbLGQw97cbREmMac=;
        b=TWvFi9pUYKt1/tgCPD+t6noaYPVeI6V0N7RVLo8zIalkOiMCbFVFhs1c1Kg6xw8vyV
         QtcrLcAv6kp84fb2KH8fThbcOXxQN43qaVijkWVZAjUSpZU08902XCY1lunU0UIejXEC
         GmHQ4WQaVcKJsQ5QKzph+7u93lLQBuShPtSA2a3BhXvJjBYYKODxWyR+y0yO6PpV8I3J
         n1VJIXmo/tUcPpl6ITGGRqM5SqaKxtkLf4uFY+2Kef2w33tDr3v5Xbf7+57F3BRK9kQf
         v4QT39PuWHQ8KigsAD+YBzuAKF1/mIaIGFU+6zV/SKgIVfetKeJjxHJS1q+2kFzqNNrJ
         sWIQ==
X-Gm-Message-State: APjAAAXeHEvuxtIapRZBOpRGtiVVxDnhTun7VbShOgvc2rsjJysyH8+Y
        TU1YDPeb1Tz0HW/SN229YSsyhA==
X-Google-Smtp-Source: APXvYqyQ5J6QlUKzzv9dntPAJFkFRNBeFRNWBQ21QpYKgoqKwPPUATbQ7OwlZTylZN832WqvUPZHTw==
X-Received: by 2002:a0c:c950:: with SMTP id v16mr36267284qvj.204.1553799180940;
        Thu, 28 Mar 2019 11:53:00 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d17sm13741961qtl.43.2019.03.28.11.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:53:00 -0700 (PDT)
Date:   Thu, 28 Mar 2019 11:52:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190328115256.2a7cb952@cakuba.netronome.com>
In-Reply-To: <20190328173524.GR14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
        <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
        <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
        <20190328071853.GY26076@unicorn.suse.cz>
        <20190328134313.GO14297@nanopsycho>
        <20190328140428.GG26076@unicorn.suse.cz>
        <20190328173524.GR14297@nanopsycho>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 18:35:24 +0100, Jiri Pirko wrote:
> Thu, Mar 28, 2019 at 03:04:28PM CET, mkubecek@suse.cz wrote:
> >On Thu, Mar 28, 2019 at 02:43:13PM +0100, Jiri Pirko wrote:  
> >> 
> >> I don't like this. This should not be bitfield/set. This should be
> >> simply nested array of enum values:
> >> 
> >> enum ethtool_link_mode {
> >> 	ETHTOOL_LINK_MODE_10baseT_Half,
> >> 	ETHTOOL_LINK_MODE_10baseT_Full,
> >> 	ETHTOOL_LINK_MODE_100baseT_Half,
> >> 	ETHTOOL_LINK_MODE_100baseT_Full,
> >> 	ETHTOOL_LINK_MODE_1000baseT_Full,
> >> };  
> >
> >We already have such enum. The problem with your "no string" approach is
> >that it requires all userspace applications to (1) keep this enum in  
> 
> That is how it is usually done. UAPI defines ATTRS and values, userspace
> assigns appropriate strings.

+1 FWIW, I'm with Jiri on the string situation.
