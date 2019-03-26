Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66CB20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="GKN6TdnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbfCZKUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:20:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37826 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:20:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so13636781wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oGDK3PbhKNJWW4lty9R1MVSikr2RPSdtx2bt/jj9n5c=;
        b=GKN6TdnGEFVDK+EhCz92UnTLWLPDWnLzjzpWbd3Ytb07y1JBX43GSEnsRjHsTMUIL7
         8DabvGAM2xqgqd/QI0pVg0lQcbRWPl2QHjJP90anVv0apkkOrHUwYtq7Zt+gM+2MwYZE
         zj0F6jTQxbVwLkPQbzSG3W/X+ytb3u2ZS60KnTKP9MBagchF+61JYZRR0tlXESLejW1Y
         4nX97a7m1PVyHmjaumUkzwyU3fZFyohMCHODsDM54w4rYYimEDKdlkkUAJkqEiB2nIzX
         PqnFi0u07mDicHLTT+up5Cvarbe2zSEbt5vulyHVbTiAuE5NmX/MG+SaxX7095GMbU17
         FgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oGDK3PbhKNJWW4lty9R1MVSikr2RPSdtx2bt/jj9n5c=;
        b=uNXLU9kFgRXm4FScm27a8gyrM+yzoki7TEypC5NV3fgXqF7G7wycmeZruYMNnQHA3H
         Vkq9rjEDr1hQop2Z/OT0IyobD+Y8QiY7HP5djLAEfKj86TV7WuAQXPx2/uGmMqozq7Ad
         zWfiPfMDBn6La1TGYtjW8yGDSJblPgL5d3XXAnLScieE1+sdy1r4Vx9ZVg7zgb2XY2uK
         LMRGK3zFN8kBfRuMobDsibfD/mvoJ668MCmmxCi0KkCxHmMDpZjpc0FIeV1wlyGVFxC6
         8R719O0DOK9u5FyKi1lmq8nH1yJbCMwSpfQcxQ8w5MoG8tG8ydddn1ByskwT/OFMqE93
         H7pQ==
X-Gm-Message-State: APjAAAUnb0u4/AU82xxO6kG/C0C/dDAXlQJp5gNF/Udy+WMoHY3G9NME
        xtNtOLKlb0Q/FQbIZJURpjZGLQ==
X-Google-Smtp-Source: APXvYqz8qLopzK822aHzhtvW7NFYnyoO2ZbWyWOkbIyLCnBWTfxIfCcF/tNuCbgpdmpS5vQAngKpFA==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr19135264wrs.278.1553595639234;
        Tue, 26 Mar 2019 03:20:39 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id x84sm1256184wmg.13.2019.03.26.03.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:20:38 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:09:51 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/22] netlink: introduce nla_put_bitfield32()
Message-ID: <20190326100951.GB2230@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <94ec4068f6767acabf6bd795818f5b7ce2dae00b.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ec4068f6767acabf6bd795818f5b7ce2dae00b.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:00PM CET, mkubecek@suse.cz wrote:
>Similar to other data types, this helper puts NLA_BITFIELD32 attribute into
>a netlink message. It takes separate value and selector arguments, if there
>is a struct nla_bitfield32 already, one can use nla_put().
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Acked-by: Jiri Pirko <jiri@mellanox.com>
