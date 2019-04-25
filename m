Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD96C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A04C217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGDa8SME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfDYI0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:26:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52221 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:26:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so8095694wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xfPPioJbbc/Zt6S+etVhQVHFSJBq3WvwUIOCFFaMDOM=;
        b=dGDa8SMEckRJ9laAkXeGsi+VkunzX7Td2C6qER3syczvKvZd+7PFDk6/0HO6AXAicp
         Fajo/gDmepJnl3DwXd8sNvPm5tsp4eiLozKUKAiO23JwUVHadznUZ2MkZ6gPKD0LYcCr
         6vM4XA55HpFIbKKqapgrwFQAQph0VdeANUpioVur43Ts/riEI17rjO1ruiKOmGn9TXEz
         EN+B1z8vmhx5QsYxhS12rM+J7KBgQCJIDlmVFFa/UcEse0ixH37L+XLLLooN6qIULEEp
         mT6QAUOajuvibIpHMHVXOC7cUMy951+e52gIpzL6LovLApWV5KKMk+Ot0TJkUYDxbYtV
         MOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xfPPioJbbc/Zt6S+etVhQVHFSJBq3WvwUIOCFFaMDOM=;
        b=uNVfv3jT+UyVuadwd0IkOfXiiEGsSqfhjf0wQoPnlZUfpoXU9jxG/83IsLAeSCsnfR
         uYmKFk3bdG89OxP3oYEKdxEb4+jhtyDdcqb8lTYWS2frfJI/wUOit+ttLISSmTuFD3+u
         +N7MYsJ0oJ6mEAI4s5A9n1sZDgIy96fpXn7lvQ9H7co8UYIl2R+BMGwPD5v3fJUfBegg
         jXEKsbwy4b9xYCIiD2BJR6l94VU6JMqmjDZIWkZbg8z7r+ummZwsIdIEmedYW+xggPf1
         Juslkpikc6ADciatYgJo7M6XnBVkbZE1AlXfZYbsVxpHhbYLLSUNgi/oY8WzCCWzyaYO
         PewQ==
X-Gm-Message-State: APjAAAU+CFZZEHZxq0du2gxUccqpGO+wZVLECn2xDZbsG9I1be4Df0ut
        AUg9YXYvCfw8C4wVPqLj9vA5Ag==
X-Google-Smtp-Source: APXvYqwd/WO7/5rQ5UXlNqOCPX34TJ886vw2NdEETfa4CHVTW9qlXWnz7CzTS8h6e8A34mqKozlzPg==
X-Received: by 2002:a1c:c910:: with SMTP id f16mr2213516wmb.118.1556180795753;
        Thu, 25 Apr 2019 01:26:35 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h131sm28083894wmh.1.2019.04.25.01.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 01:26:34 -0700 (PDT)
Date:   Thu, 25 Apr 2019 09:26:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com,
        afaerber@suse.de, treding@nvidia.com, david@lechnology.com,
        noralf@tronnes.org, johan@kernel.org, monstr@monstr.eu,
        michal.vokac@ysoft.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
Message-ID: <20190425082633.GC14758@dell>
References: <20190409144250.7237-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409144250.7237-1-TheSven73@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Apr 2019, Sven Van Asbroeck wrote:

> This patch:
>   1. adds a Fieldbus subsystem
>   2. adds support for the HMS Industrial Networks AB Profinet card.
> 
> 1. Fieldbus subsystem
> ---------------------

Not sure how I ended up on the review list for this set, but could you
please remove me.  Thank you.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
