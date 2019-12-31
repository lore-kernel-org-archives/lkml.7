Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93FAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 21:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DC0206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 21:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="KSTVd+Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLaVdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 16:33:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43221 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfLaVdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 16:33:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so15216737oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 13:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+/nS1bdAxCnLkhXguRUBX1Cxhqk1gjfbFD8rLHJu+no=;
        b=KSTVd+GfRi/YLpRPtxRRr6LimCHDIj31fr7kYo0b4b//giRCT9jxYhDjG+EpaZ/6RG
         ap6x1CpzZ2uAw5WUuAPb/JQw/GrBRIdZCijDPXgiPm3KAKUTxgQ2gqadIvSHnpff62V9
         YGzXRuwvpFgIlDLFHBEdX6qpco0KqrD4fmXNk6SVFluB58AuYTA4NBDtWQ2N8erb1ej0
         /sk1ewrQjiglHofxjL2m5AZ0i+mDgPyq9kyRQ+kgjFVtcNbopsV+xoK3NMXqfQOcUIZz
         wUVy48+zKViRQBV5cN1fb7DY/aBoR08KB9TjsGMmE+Pzk5ebWgogWYBp6+nIMqzkd1zx
         f03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/nS1bdAxCnLkhXguRUBX1Cxhqk1gjfbFD8rLHJu+no=;
        b=RpHaXvJIYGOk7S2J+TyjmyhcBLAwxWdyK+EsNADfdVjPoTA9L1cjgsKktdgKblEVlN
         ZiYwI+XZibQfmmgjANCWT2b+WQGEkLaDGjAQGb5tUYWRojsvAhkf9EoR5/0ppcZGmiiM
         rcGj3Z1gb8mtAe8Hc7Aq/zFcrsI4i/XonbXEu+wQVp8pA2nJUXWte0lpeujFHCJHLQan
         zM2cu/1zTlwEVZkPxee4uISBxcidMN2gG35fVjMcJhjzfAOBqzg1kEV60a0XsasV9Wh7
         q3Iz4LHZzfoqNgW6eN8Z3SdouvKc30nudCqrwL/Xfou3IvnPmJOSbZcBkm13W7UeOeT9
         SbQA==
X-Gm-Message-State: APjAAAXZ3gRv8inuNWzuYqV89gNGjrOM95iwVNjom5Frq1raHOZxQEK1
        HqoSmtdSLu+te2ZnavAXxuQ5Mg==
X-Google-Smtp-Source: APXvYqxtZiNK72dgg3cXUoHDp2WuYGKWETZ2MLtVvL1tUGpM54gbYZ+6lBcjsS4utpNZTl51pQWvaw==
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr70074856otn.140.1577827977935;
        Tue, 31 Dec 2019 13:32:57 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:d193:7acb:1243:c644])
        by smtp.gmail.com with ESMTPSA id m68sm15241741oig.50.2019.12.31.13.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Dec 2019 13:32:57 -0800 (PST)
Date:   Tue, 31 Dec 2019 15:32:55 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        tony camuso <tcamuso@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 089/219] ipmi: Dont allow device module unload when
 in use
Message-ID: <20191231213255.GC6497@minyard.net>
Reply-To: cminyard@mvista.com
References: <20191229162508.458551679@linuxfoundation.org>
 <20191229162520.260768030@linuxfoundation.org>
 <20191230103218.GA10304@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230103218.GA10304@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 11:32:18AM +0100, Pavel Machek wrote:
> On Sun 2019-12-29 18:18:11, Greg Kroah-Hartman wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > [ Upstream commit cbb79863fc3175ed5ac506465948b02a893a8235 ]
> > 
> > If something has the IPMI driver open, don't allow the device
> > module to be unloaded.  Before it would unload and the user would
> > get errors on use.
> > 
> > This change is made on user request, and it makes it consistent
> > with the I2C driver, which has the same behavior.
> > 
> > It does change things a little bit with respect to kernel users.
> > If the ACPI or IPMI watchdog (or any other kernel user) has
> > created a user, then the device module cannot be unloaded.  Before
> > it could be unloaded,
> > 
> > This does not affect hot-plug.  If the device goes away (it's on
> > something removable that is removed or is hot-removed via sysfs)
> > then it still behaves as it did before.
> 
> I don't think this is good idea for stable. First, it includes
> unrelated function rename,

Umm, no, that's not unrelated, it was renamed so a defined could be
done with the original name so the module could be passed in
automatically.

> and second, it does not really fix any bug;
> it just changes behaviour.

This is true.  I assume Tony asked for the backport.  I'm ambivolent
on whether this gets backported.  I'll defer to Tony for justification.

-corey

> 
> Best regards,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


