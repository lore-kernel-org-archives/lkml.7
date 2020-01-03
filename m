Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B6DC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033FA2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578091489;
	bh=IIWl5Kz23+z1rT84VFyxnh9pgrS4jE5ggnaKO8oPehY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zAhzE5qRr4XK7ruRzhzj8uFlX69JAys5v0nZkFCvB4hEELqEQWt2h97x57Rd847Jo
	 bA9FQmM7GYhANLjZCW0OAaQPFPT4MmtOpaAjfZRW3cMItZ+KvAgwbTVWxaCpD7cMGE
	 IW3JlMpd+Jm8ibTcC/M04JInS4+jH1SgZNyhEP3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgACWor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:44:47 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38274 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgACWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:44:47 -0500
Received: by mail-io1-f67.google.com with SMTP id v3so42974946ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1X+uA4KwbOlDW43uh4WTk3rfWonQFJL9jlxrD4of9Dk=;
        b=lvDXaKdyOl8/dOs0DVkw0wOwWkVZg6c7zQ7Ujb8FJaKssl/s5QaAKTnhzBmMioI/Pf
         zUimDBFTmstD4JhZ7LHfyFCPhqvnsX4CpOyaZrD+a3QM6upBnWxoq9t8z/ZcURP3+pD/
         l7Hq0PbfNdR3jv5ihBa3HFnt8l00VjFBK6xPQaJ6Ibrqr+426LCiCiruVPpuAGrnG+kt
         H0S2qP+dijfFXCbsfeUehI5JNhdxwPw6dyw6elsyjY3n89L39bUVvmXGKZMVkcqwf/6o
         TYy9MdOuskEN5uLsYBUgLaBezkwLjykCYXZ/ATDWR/E2XrSNcVv53boVITRW9HKKEneq
         G/Ng==
X-Gm-Message-State: APjAAAV7oQz9CduImd6DYXiBRp4SlugX6VIowcExKtdrxC9iC2qaXTIk
        xdj4mIUZZp98xGnWSIdXyPHYyt4=
X-Google-Smtp-Source: APXvYqyfiC30qZHsOxyOYuP8KwSf2c+boQHUoz8M+D3mtV6wCkDahLoVxIUe9ZtuVAh7bu57RiTYjQ==
X-Received: by 2002:a02:4e46:: with SMTP id r67mr71015371jaa.118.1578091486329;
        Fri, 03 Jan 2020 14:44:46 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l72sm21538843ili.18.2020.01.03.14.44.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:44:45 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:44:43 -0700
Date:   Fri, 3 Jan 2020 15:44:43 -0700
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: Add an entry for Monolithic Power
 System, MPS
Message-ID: <20200103224443.GA25756@bogus>
References: <20191226222930.8882-1-sravanhome@gmail.com>
 <20191226222930.8882-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226222930.8882-2-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019 23:29:27 +0100, Saravanan Sekar wrote:
> Add an entry for Monolithic Power System, MPS
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
