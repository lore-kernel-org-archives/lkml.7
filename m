Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DBA20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Ugjbh8+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfCZKZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:25:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44224 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:25:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so9529403wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FEP2vIWtIIZtOytYQ4ZzP9M+8ozdnBMtqu0aWgYDeh0=;
        b=Ugjbh8+iVJHPN7IKH0Aw+9Q6OqvsM4kRRmnJWWDiV14KPOb5o6iSf0F6iyQcR85WXM
         yGhLlbLc/KIdsje2315PcJPnKBdxrH738QZRcju1JQdWoZHXNcHn824GJQC2gyZvaBgJ
         T8EtiFtdUC9BtDzMqlQDhwlABUGYEs97tVjvmcQNWf70koqM5LD0/0vU/g1z9TNStKz5
         rSxeMRh3cX9ibMK6wGfXbq/zLTTSSFa1lP5te1yiAmGi440SznIU4mB7IHVkqhsqy7Qc
         ix94nbCz9/N+bpMQFH0M4l3/lHWKNSPQNjGENGpG7EClgENntBL9ObN1B5LFeutcQ8lL
         7oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FEP2vIWtIIZtOytYQ4ZzP9M+8ozdnBMtqu0aWgYDeh0=;
        b=HFa6YEFY0LiH7pSvXyb/HLORmT5tPy3NAGTICFCydMcrpPT4C479uco8EzkbjHeS8L
         jJI2EKTEofYaAFc4fZARd69dcodsSq7ndk491bJGhS+Oi5N1DIRG7LnhsPK8zXwDxG9s
         ZA3+XPrTCkY3J2ucjs1mIRE4WIYYlT16vIw7/9QisM/TvA5j6Brd23fc6ZISzfugSBOt
         iSErnRzw336DpzWZgn0W2WZxaUtCwfC16ECMVtkYZJgmfTGSe7if54IvaeARcAX6bRLQ
         VaSm567NU9xtDTaRvSBVU6LrW12mo6gq+oWNAcZVSY7Toqf61ppClsM4P0jbJX7dIslM
         Vnfg==
X-Gm-Message-State: APjAAAUMJeaAcMVXS6yoE7GBXYpkMobim0tQ0vzoqwr2U++uo//m+jxI
        c8StDacoXLTPZKRuGO1HktdKYA==
X-Google-Smtp-Source: APXvYqz1SKWXBz1QQIT42YBV0qS/QoD0VKREuI16GwVw/Y/EjAgWTa+S9razJRT7Sf2u4KhR7GBzpg==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr16049517wrp.92.1553595942118;
        Tue, 26 Mar 2019 03:25:42 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id y1sm44366519wrd.34.2019.03.26.03.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:25:41 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:14:54 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/22] ethtool: move to its own directory
Message-ID: <20190326101454.GD2230@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <9f7e273e8dbba11b085dda960f16223cd5d716ed.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f7e273e8dbba11b085dda960f16223cd5d716ed.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:06PM CET, mkubecek@suse.cz wrote:
>The ethtool netlink interface is going to be split into multiple files so
>that it will be more convenient to put all of them in a separate directory
>net/ethtool. Start by moving current ethtool.c with ioctl interface into
>this directory and renaming it to ioctl.c.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Acked-by: Jiri Pirko <jiri@mellanox.com>
