Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEABAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D6E2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wk5uaV1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfCZPuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:50:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35567 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:50:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id a71so1642596qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P+W+K/3y/RnrGdg1MOgN6dc4Tffsl4Rnb6+dHjOHkM4=;
        b=Wk5uaV1laPWogQOFgp6bU7KjQjwvKeCPC3EWsbZbudeX8PF9+z4cE5O3CpHORwXeki
         oR6GKE/zkP7B6s7p6gA8E6XoWsQ9PvWZo39KnBriLZGphZZ5ExW6BXxwBR9ncLdbH/xC
         Z/F/VFs98mvtFzBvbOvBwUD0S3QcuDRP7oAWIQpmaU7viDRqwQGcjYwlrj7BiZJCfmju
         Jq6oEWhjr6oib3qF3HxOpgUg6eWBb9+zRoOeDmiDfLxxSJN8YS7ae7H1uUYxbtf8FpN4
         Wv8oK93/kwwuZ+uSsTbQ984CzcUoOpnWkcpywCi5bH7oP2XIr5pAOYKabemKrjgTAFfl
         jB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P+W+K/3y/RnrGdg1MOgN6dc4Tffsl4Rnb6+dHjOHkM4=;
        b=SaD1ydjxjJvAKBR5zdpBIFbOvwN5luwMQZCnFVwETFDtIOHyZfjmGXmvB6sOe5bp47
         nOFcmq8Cv5G9UwLEB0M11SEb3Hg2zwzr3i0pQVAG1DRMa9U/2jd/TQxaD2cwGZUIp+AW
         7o2QSUSj34SZG+lJvx6hCkqRfKaRX0wndHYD9q3Lcs0cx93YVd5VcwsEOVnjSniftlal
         IgsJLfqzSMBlMoBbg5ZqGJBqe5vOLDuFZJ5JqwcniPAyVq0Mx1JPVmDUCxlvQ7dAtZ5J
         cJfXQmZNeFV7Al7xWLPhJjxX4PQd0AZvRoKHyWIpo6D3T+MBvPg08lZkvpW45mLgnXmp
         Srzw==
X-Gm-Message-State: APjAAAUehmjmK00LSFfqSaX2ygtu9NyGmu0ig48sAheQo25b+ph/1/g6
        YmcYI4FQwxgdTGnvJvsovx3gSA==
X-Google-Smtp-Source: APXvYqyop2JxwPUJOujpzAAnc5RdQe3dHtA97SNzWNNVXUBucpv+jACktDXRzyU/NmEg5rqzW1fR1Q==
X-Received: by 2002:ae9:e8c7:: with SMTP id a190mr24583266qkg.311.1553615433838;
        Tue, 26 Mar 2019 08:50:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id y5sm11290817qkl.73.2019.03.26.08.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 08:50:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h8oLQ-0002zP-91; Tue, 26 Mar 2019 12:50:32 -0300
Date:   Tue, 26 Mar 2019 12:50:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] drivers: infiniband: Kconfig: pedantic formatting
Message-ID: <20190326155032.GA11468@ziepe.ca>
References: <1551898167-18310-1-git-send-email-info@metux.net>
 <1551910125-26368-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551910125-26368-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 11:08:45PM +0100, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so just
> take damp cloth and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/infiniband/hw/bnxt_re/Kconfig | 10 +++++-----
>  drivers/infiniband/ulp/iser/Kconfig   |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)

Applied to for-next thanks

Jason
