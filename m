Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0FECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAAE20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="AvvoG/Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfJJPXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:23:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38030 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJJPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:23:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so7236878wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDz+r4rM94VL3+Pl5xzdTOjfOO1RdD3vAbbm0BQ2hHI=;
        b=AvvoG/BsjH8RyUfVf8qxu9E8+6nBME5ejysBka+LWWdHaophcj951/cLzlbdzoGi7m
         gncEsje2qdJsbuQDMyUKEsHahQF45XYIBaw/JxHTfMEu7RnUNGZHjp11WFF+ABFIyULU
         47f1KrwwzO2d27shcf6fYNMlzt3ATuNEAyRNkBfXmzoth6dN6Kl8MuQJi516+Hwpzq29
         7QpTfWmNKyUuVDHQM7fYIg9NQGqLhdIT987WN61jimmIrPHdPndhd669qkd1EdgJQaL6
         LpIkZQahdfVwCXWu+TH40v1xgFtVFmdPPgY0EnQvUamqDrwFnkN8xExmOSk4EmoInsme
         jeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDz+r4rM94VL3+Pl5xzdTOjfOO1RdD3vAbbm0BQ2hHI=;
        b=BzVhG7VF+b3eZfL+YvAKhLqKRQWhvKER6pGiA/xsPEfonR/uIg3saoWMRFhyyGHqdP
         BLR8hulKg/aj995/8M5t+MHQI4wwXdGjKsJNEphg9b6NJxrEbBIffu7Ux6tx4Tv3Gg6v
         kiP3Y7jpglKY1XBhdeIp+Msf2P+mtGrJ4dSLZrq5n5Db4B8OMtpgDca4pxqbjK4vA0kK
         UXZKGyzkvcBvg/NIEe6KJDKoNvHZkNnfKoGxFoWG4QPiybKFEGbwa2Gtq1YP7vT1Y5LV
         4i5koDLYbZC0PLtv/cKfUwqjV+ctgO2wBKxfaO+gP+fg2MTNZn/uTVfOqGY1LM1tG3n4
         YAUw==
X-Gm-Message-State: APjAAAUsgsoGIw90JRFwElO8GDZyCTaisQci3ZIgFnPWl5JOPwDuuu71
        Lu+fQOJNOEqcwxToSIX1TCRxHw==
X-Google-Smtp-Source: APXvYqw3Ud+Ro98c+TTzCOdXnjL0w7AL/IQDWdsh2/DyNRPzCEiNBX/grfAVzOVYXuihjhT9E88tjQ==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr7765333wmt.109.1570720988703;
        Thu, 10 Oct 2019 08:23:08 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id e3sm6028321wme.39.2019.10.10.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 08:23:08 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:23:07 +0200
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
Subject: Re: [PATCH net-next v7 09/17] ethtool: generic handlers for GET
 requests
Message-ID: <20191010152307.GA4429@nanopsycho>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <b000e461e348ba1a0af30f2e8493618bce11ec12.1570654310.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b000e461e348ba1a0af30f2e8493618bce11ec12.1570654310.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 09, 2019 at 10:59:27PM CEST, mkubecek@suse.cz wrote:

[...]


>+static const struct get_request_ops *get_requests[__ETHTOOL_MSG_USER_CNT] = {

I think that prefix would be good here as well:

+static const struct ethnl_get_request_ops *
ethnl_get_requests[__ETHTOOL_MSG_USER_CNT] = {

[...]
