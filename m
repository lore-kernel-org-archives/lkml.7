Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24790FC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8DE207FA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 23:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kxCPnkll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbfKFXiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:38:54 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36961 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfKFXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 18:38:53 -0500
Received: by mail-yb1-f195.google.com with SMTP id e13so238622ybh.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 15:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=NXCGiVKTXXEjzDxDKPWm4qRbQINthtPG/DF3mE8dX04=;
        b=kxCPnkllRFkeV9ZKT0vPLK4zwrVw+ZIGPflI0u5vk0j5pV5zLWHRpkAzf35kkz/5XC
         RIlII4oE7WfBPgvN2mVCbQYEo9K5fyHa0b87urxXjOe1LqWcNYx1mQ+M1OENSM6qPNc1
         KKlDhCAKesadT+zSpoL5FMzs/ZDI2z/yuaG4z8Lh7st3mJDDhqDucU7bYyX8r6Tx8tTv
         IvWbK17y0NFyGnmfQKAGivMO8CFlccpSFp0KyWcXwip0cWszVzs5oguhC41DP9kdj+vc
         uzSbWQgVizDX0lT+3W8BRm8iLDVZd530GuZg1sYszeXs4yPAj/n7rNX/rkb6bP6sTFt1
         SRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NXCGiVKTXXEjzDxDKPWm4qRbQINthtPG/DF3mE8dX04=;
        b=sfTarDzSu2lROpWp+kc7YokLRXIJMCd0JB8YBbY997H9FuDwmz0gtaooz3tuqqxgfp
         6OQFhDLVaXGTbsTX+uwxeT2MCtwoqjTbeUjlVb6WDghtvU/WjMPx95SLbjjQ7Pan0yBV
         nOCt3gkD5kkFR6WyrUO/zv5Szr0Z9sKpR2/n5a3jz050RElJOrOzSypS9X4c35b67kwf
         THMSXySKo6fdpwIZmUvQT021UuIZsMyR3/E6HHhdQsbKGW/aKBTmdcycwosKhPgh2Sfm
         ttUkt7X3lC30rKM01hnVtla8PAFyJ+PPNyFgN7SXHF8pt7SXNrxl91XIjt23/7Tq08ns
         62aw==
X-Gm-Message-State: APjAAAVNhKFuocX+YDVyeErLUyGzj+RzuvfoWLyhRvscgIHk7+pCECcA
        irkDdx5jDIXakZzbu5MEOIpyanxa3PM=
X-Google-Smtp-Source: APXvYqym0i0romvCrdOaz7lsINZQYcGiuzpul4r2zM7EYgZuhgx34Vaj0wOMFqNyMeyL778+8rXK9g==
X-Received: by 2002:a25:af05:: with SMTP id a5mr633074ybh.155.1573083531576;
        Wed, 06 Nov 2019 15:38:51 -0800 (PST)
Received: from cakuba.netronome.com ([64.63.152.34])
        by smtp.gmail.com with ESMTPSA id z127sm194842ywb.38.2019.11.06.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:38:51 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:38:48 -0500
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH v2 1/5] rtnetlink: allow RTM_SETLINK to reference other
 namespaces
Message-ID: <20191106183848.3b914620@cakuba.netronome.com>
In-Reply-To: <20191106053923.10414-2-jonas@norrbonn.se>
References: <20191106053923.10414-1-jonas@norrbonn.se>
        <20191106053923.10414-2-jonas@norrbonn.se>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 06:39:19 +0100, Jonas Bonn wrote:
> +	if (tb[IFLA_TARGET_NETNSID]) {
> +		int32_t netnsid = nla_get_s32(tb[IFLA_TARGET_NETNSID]);
> +		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);

No comments on merits but you should definitely run this through
checkpatch..
