Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D6C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E40D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="p5+MgVUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfGBL5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:57:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38201 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBL5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:57:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so6271600wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 04:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twoed304bVANHmzTBGu83qACybedl04wF9pEcLlsQ7g=;
        b=p5+MgVUg30QZOEvU3DNgmUA3aC46BhnbMqOeupqqsWTqAXZSMCgbzOB+jammgHIiJe
         SBoanEe6kV+few/FCFhJv+wqst9rDwGhBbeUIzciEytg9mjufMW+0tBNnYkR+p4e2z57
         tnu7X4hXVAJBD0WhvyRUp0o1AQsHAkD5OYlstXyB0waLFkOIQbf/FJTZ7r+WJfR83aGJ
         R+VSjJugI22/GaEC5k4W7PM5UofS0vjDOqMmRKV2dTa/HOdFJEivTSQhFP7tNYSmUIRh
         IqxjP0KexxLnKoiUM8NBQnyQcll7Swi8PFRr+AqR5vvBmJStxGkIk7jh+i//oOOrLy8B
         8C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twoed304bVANHmzTBGu83qACybedl04wF9pEcLlsQ7g=;
        b=h0PtqOb5JsvKDdDMIm8j0asekpy/YPsot6rbrrrhLDLLaUIvvKZeK9T+LNl7Zp7Lpb
         Rb8ybmdeYFfYipF95JpoQggKgb28j4d1CT9+FR6TpgYAf1YAehEAsYQouy1cVh1jyw4G
         9JV/WcRpjL2H4ZjB1bo9q4vDVFhrr78XuE9RTLgxUVwepagxTk2j83LRLUK8vrs4uYGg
         WVm4JaqdbdtBiByDrMsXoqJFVAn/64kAcssQOJylE6tjyov/pbR0Mdytg/Vqgl4qbQVZ
         VdFj1VZG541v+1PQqf+vhH9J4vvIr9Zuwc4H8aQhLckO3edBCF0mc7K2WpJHw7T02sSr
         WSrg==
X-Gm-Message-State: APjAAAUI+JP26kC2QdZdYlGvUVJ8ilNPLHgEwLOSb86GvO5OrQlxr7o7
        nsi10QlxH8OHqn1H6wbLKnUu+dCve2A=
X-Google-Smtp-Source: APXvYqwikzNFnHZpdxrcgln2rDmWrFAF+J4y5fKblz1UG9SGZcsUr6O6KdmPdmTb/GLXfW8cLJTRmw==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr23127089wru.195.1562068671649;
        Tue, 02 Jul 2019 04:57:51 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id e20sm20148618wrc.9.2019.07.02.04.57.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 04:57:51 -0700 (PDT)
Date:   Tue, 2 Jul 2019 13:57:50 +0200
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
Subject: Re: [PATCH net-next v6 01/15] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190702115750.GL2250@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <b6e0aefbcb58297b3ec0a12ee4be8e5194eee61a.1562067622.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e0aefbcb58297b3ec0a12ee4be8e5194eee61a.1562067622.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jul 02, 2019 at 01:49:44PM CEST, mkubecek@suse.cz wrote:
>Permanent hardware address of a network device was traditionally provided
>via ethtool ioctl interface but as Jiri Pirko pointed out in a review of
>ethtool netlink interface, rtnetlink is much more suitable for it so let's
>add it to the RTM_NEWLINK message.
>
>Add IFLA_PERM_ADDRESS attribute to RTM_NEWLINK messages unless the
>permanent address is all zeros (i.e. device driver did not fill it). As
>permanent address is not modifiable, reject userspace requests containing
>IFLA_PERM_ADDRESS attribute.
>
>Note: we already provide permanent hardware address for bond slaves;
>unfortunately we cannot drop that attribute for backward compatibility
>reasons.
>
>v5 -> v6: only add the attribute if permanent address is not zero
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Acked-by: Jiri Pirko <jiri@mellanox.com>
