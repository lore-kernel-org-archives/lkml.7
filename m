Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99926C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9612067C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576279882;
	bh=i++YmxM71Q4igoCkkRDyKNUgl7ov0lAsVCZa7Oi23TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lYFEQYDH7Z8UV/TqnWfKn8CPyF87xKAnbfOAb3p+Ss8YFm9FYUhXnDyppw7MdxdOA
	 YzWWHnufUBsZJVk4HJdWm5WkiIJRUsZz3XZcI+LRXgNKMHY0wFd4guuMXa8eNiyvQb
	 ad7Db1VH+qfntUwxIWxc7dZ7/j4gEZwhej9TBGIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfLMXbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:31:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39070 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:31:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so2080881oib.6;
        Fri, 13 Dec 2019 15:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lYYUvtIQs8WyhTXsYcezAWvXZJDnKnplm9KVthaIERg=;
        b=Bet8LrhwjjE8eretmz9FHYjjl1qnTTVVj6CgUzjSlOyGve2tk/ApNJnXb94+jQ5w8f
         wYJlyWKZocqF6zJwudbU/F+jwvzR9MabdDp5CaBK6d7AQN3kjhWU+DftwLinuGj6i56a
         b25HW685h78XHleb0GAnnUEl3CRZDC+VviW1IOqZKPgBU49K4edd0nMJu+KWK3jKgF45
         UnZmMeARbm+rx5mMmJEhC9Lr7YNcM/AcNCQ2iAKydiZzEgJlwQ1iulb+MeEfkPTYVbIc
         eNqRj0hTez5Y5bwLpVVm6Dpf2Lim9elN1uUOs/NgTyvIQDVUgHpdqztX2KTtneMjGKem
         bKpA==
X-Gm-Message-State: APjAAAXnRtIKD5GAcq48jC3tHsxJnjC+9b/NJ6G7te8qylUeCAT84AvT
        1IJwAs65rnTUxAhbccAs+g==
X-Google-Smtp-Source: APXvYqwCTc58Djh9hMNiNnWpcIxHoEkGF4j2hZ7JOin8EDxNpLJNc+jiPrzhwea3x0TrNzvIiQGFJw==
X-Received: by 2002:aca:c493:: with SMTP id u141mr7230624oif.62.1576279880179;
        Fri, 13 Dec 2019 15:31:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n25sm3783019oic.6.2019.12.13.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:31:19 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:31:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 14/14] dt-bindings: reset: rtd1295: Add SB2 reset
Message-ID: <20191213233119.GA28838@bogus>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-15-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191202182205.14629-15-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Dec 2019 19:22:04 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Add a constant for reset3 SB2, based on downstream crt_sys_reg.h.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  include/dt-bindings/reset/realtek,rtd1295.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
