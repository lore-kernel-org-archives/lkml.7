Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47935C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2E02077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlIrY07n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfLKW2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:28:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfLKW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:28:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so24290pfb.3;
        Wed, 11 Dec 2019 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUyXHjX3PYUM9nKm/LBHXohlHydzz+X5MYoM1R3UKnk=;
        b=DlIrY07nZUpFfOZumiYwfvGQsjWziSLuLYYk0u7cfTR9mrbgjKyuMd5nIFIc64yhuW
         GcRRxJf3NkABfPegZhceytl5qOyYrvDrDV/aBhiBTXeS6v6u5sPY5TSPRvjkx4q2Oi/i
         eRaSMr5jcGPDX0kq73qvnAtMLsMwSEKlDbSv3QNbkWh1AR8bEHgwnOfa/wJWqxHMKgxL
         VjL6DCJjVRR0f4QNVAPMTJm1iKH2z8oJiCjGd3nRZZqQ5jMtHsW4qIrqkRn4TgU/fmGT
         FBZOqHzbhmqPfZxERKkpoIek+rADA3KSeICpHN+4g4y4asHuvsgyuTPi6ZyGijl9aQZK
         a6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUyXHjX3PYUM9nKm/LBHXohlHydzz+X5MYoM1R3UKnk=;
        b=F7IWVq9hxeX//191JcDXDsMNVyiiHjOwnvkUdEtDwuSk7iWQBk0DLdR3PJZtxWYg74
         +WHpUwBWDReMO25RZCW/G1JBAZsOl/L+3cLoJX2YQyZMQ1eEPOGWfJDDweIMoJO5Z9MT
         XjF3fxa/KXe5hUAQRm9lAw0RWN9HNHL8XU8bIfV3GBSmlu9Sz5TSmx8IHgReWAnEvBI0
         dIu27//atlAcqDIYXuiFCDPMib+HSXvegeZ0Xw7m3q9nal4Dg8mXdWN15dzz9Ltu2YUW
         7PLzy49aZUcGOFb7e86DwDYkNWwHbDYVzBJ+uAyyEYocbmn5tcTmG1uv+NO0lI0w8CCd
         MLEg==
X-Gm-Message-State: APjAAAWlKqlwhSkNb+T2cH+0vb8ae1Pe2byrLQLeM2/EIQlq7NasTc/a
        vRqTumFwAgf824+yl7I1ZTo=
X-Google-Smtp-Source: APXvYqxwKjD3h+li5pd06Ogk9jgvc7NsUBZEri5ZUl/uWZW2mQ2IR6/uARTmg9E9Edg/X5XISeramg==
X-Received: by 2002:a63:d00f:: with SMTP id z15mr6780305pgf.143.1576103312802;
        Wed, 11 Dec 2019 14:28:32 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id z23sm3844841pgj.43.2019.12.11.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 14:28:32 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:28:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
Message-ID: <20191211222829.GV50317@dtor-ws>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga>
 <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 05:17:28PM +0100, Marc Gonzalez wrote:
> But I need to ask: what is the rationale for the devm_add_action API?

For one-off and maybe complex unwind actions in drivers that wish to use
devm API (as mixing devm and manual release is verboten). Also is often
used when some core subsystem does not provide enough devm APIs.

Thanks.

-- 
Dmitry
