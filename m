Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1358C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B193A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FL7Oz2xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDLTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:30:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38944 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDLTa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:30:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so12569191qte.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y8X0Dk1w7Pr/VDO1gX6XyPpp1ruAkfbYk30ihhUqYz0=;
        b=FL7Oz2xva//03EFq1Vhk6xTmH/GeOlLAbQKqEGhV6slV33lDhPm0if5iMWW9KlqyfB
         QFxyzsI9rHnyVxVWBwf004su3ty8WbyvHd9FXNpp+onEYRY3V+lRUUBAFMV+rLsKNnwB
         gFwS/2afJOvpNda+NFLgYoOWlIPbDW2k3mXpFkxqY5bktZpTRlo86FcvH06XhgVlSgUw
         wEA6RmsbxsRZWxKThnLGTUjaFdQ0JYyYHXE0vY2LTlzsVQBI85cqgJdq5esIRb+BC2i7
         ZhkyKD4hqErmHTCQWrAOBzZDG9kEHTdlcdnXCy8idF9cGJSSnLdHIqdKotZg1zUYA6v5
         SS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y8X0Dk1w7Pr/VDO1gX6XyPpp1ruAkfbYk30ihhUqYz0=;
        b=QnRrsiHYWTprZI18FKCFw9DKIi1VXmfc7unQ7FvpOCjiA2WPqGfuD1GQ5bEW2eKOL1
         qIcA5rT6Vk8RcthgHCHRJp5ixuk6/Jss2lCoxUki6wYQP0kiawvc3g3ML2zrN6eE7McQ
         5pIv1ExuqrVwxXmoF248onuBEwdz7rA5NaadxOKEShWmZZWRmL81KDZGzYUpGHB9mSrp
         IwEPLMDSECiZZ3/w150+5azDHwtHydVktaenML0+ItcQ5ExZhgJJWu8OBtQWpAlu1G5m
         0Ps46kFfvZQ6tdjpfMDYqRS+IYytaZIznMf5/pv6B6Rar4JQpJh+K/QuwSh2AQZ4m25f
         yCLg==
X-Gm-Message-State: APjAAAUdIIKEuhBZ0xXpbZGHBv4hK2850Q7szChoZD9nsafb0zG0+L36
        t4q4NxCyLMZArfLnBxg7hzecgw==
X-Google-Smtp-Source: APXvYqxTk0e1xX3bR/DBgr+SQ3tEKfypYwqWElhccioPRhLK69DPFA/8IRdZWDdqGgXYVQUgVlu05A==
X-Received: by 2002:ac8:33dd:: with SMTP id d29mr48549652qtb.320.1555097427619;
        Fri, 12 Apr 2019 12:30:27 -0700 (PDT)
Received: from ziepe.ca ([207.164.2.188])
        by smtp.gmail.com with ESMTPSA id v8sm27290887qtc.69.2019.04.12.12.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 12:30:26 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hF1sW-0001Ih-OH; Fri, 12 Apr 2019 16:30:24 -0300
Date:   Fri, 12 Apr 2019 16:30:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Steve Wise <swise@opengridcomputing.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Make CM response timeout and # CM retries
 configurable
Message-ID: <20190412193024.GB4690@ziepe.ca>
References: <20190217170909.1178575-1-haakon.bugge@oracle.com>
 <20190222163637.GA9819@ziepe.ca>
 <afadc799-b547-5c20-64d2-75fa0f64cd9e@opengridcomputing.com>
 <C7922E85-CA43-479A-8021-DADD59FF5BE7@redhat.com>
 <20190223084930.GJ23561@mtr-leonro.mtl.com>
 <VI1PR0501MB2271E8A704DD21EF81C7DC24D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0501MB2271E8A704DD21EF81C7DC24D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 06:27:26AM +0000, Parav Pandit wrote:

> I think we should use rdma_nl_register(RDMA_NL_RDMA_CM, cma_cb_table) which was removed as part of ID stats removal.
> Because of below reasons.
> 1. rdma netlink command auto loads the module

This is probably the best argument to stay away from sysctl for module
parameters.. It is tricky to make sure the rdma module is loaded
before sysctl runs in boot, and I don't think sysctl autoloads missing
modules, or somehow copes with dynamic module loading, does it?

To that end we should probably have the entire sysctl configurable
available in netlink

Jason
