Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F3DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A792068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmOgiwnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfLIUon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:44:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45806 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLIUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:44:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so7289618pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P6A5+rZhTptmYi/XXvTMUxMhuaBe3WlijHoR7rvgnBA=;
        b=SmOgiwnKT67WrEjvZqB4vlKa7V/9WaeW85L24/yIVj4xe1O7wvkpkyTkoOf6uBavQJ
         WCxT1w3DL1XCYg9IRrIq2KzQgsrbFVl9ep8dYKN3cH8RNRxXjODwv2Ahw6CMYmN5ioaV
         8Wqc0VxAfQZtb8wDHlAkCBQO+yDjV5qoOnpMxzi9I+Ir6YnaC+i/lXbENNh3OXM54w2f
         C39VFqSVak0aN0fLmi0jNzkagWndrb/Ns4mYEuzIu8jvhaYytZOUYKTeaJXejjtgD4gE
         JvdS82p+CPVCnOGIjxXgbNAdNQHmjUuQ6G6V80UopznS75aermlda9QLXeA6OfYiympq
         ic/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P6A5+rZhTptmYi/XXvTMUxMhuaBe3WlijHoR7rvgnBA=;
        b=HdBhku2uMUSRNPTEtthB+c42lPBlJIj8oadtsHpCN5gSe/NkpuDVJafxLxodAsVDZW
         8jlKqNn3U7mXKtHkADVXz9TXfwFNukl7Ps3MCfXTm+9QU4WPm1SKMGUsgkuo5oROs+Rs
         DoC3iR56qpMpkfPPNMmRyTxbDDpCLC8LeWTVd9m+YJZGnMBT6vH9im2Z55BtihIWbFUc
         ZNFprq8BYrKdkwWQ21eQP1PTSvuf1sp1K8/3nsF40NeBR/KsVe2mD0OFpWBmecuVKJJ5
         i2bfxs76bqVKy6Hng1kGYY8/rdNgn9mSdTm8f3GfSkA+7thbdHPieg/NSbbfEBSazr03
         +3kQ==
X-Gm-Message-State: APjAAAVgZlXWAYRBVhdtAGIuccd3L8SiimLtA6Q/vrDAlhUmMgf7adol
        EyxIkWZj8HCbrNOOmoS/o5k=
X-Google-Smtp-Source: APXvYqx5zuFSs70Zm4tuzPqhBiILuMoQQ4hLWqqX7caxL1/j2f7pAa0eTIUH3bFhuunzByguYf//cQ==
X-Received: by 2002:a63:6787:: with SMTP id b129mr20703137pgc.103.1575924282880;
        Mon, 09 Dec 2019 12:44:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4sm361891pfx.68.2019.12.09.12.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 12:44:41 -0800 (PST)
Date:   Mon, 9 Dec 2019 12:44:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix test_async_driver_probe if NUMA is
 disabled
Message-ID: <20191209204440.GA1584@roeck-us.net>
References: <20191127202453.28087-1-linux@roeck-us.net>
 <4a2aa8554933c2d004761d5f3e8132018be5ea27.camel@linux.intel.com>
 <377feb00-9288-e03c-b8a7-26ba87e24927@roeck-us.net>
 <b5826338cd4479b724835ea5469c5a8318e88e2c.camel@linux.intel.com>
 <dfc50096-d95f-8e57-4ba2-3fc122626af8@roeck-us.net>
 <f82041432512481569071a83e727cfb9f128126d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82041432512481569071a83e727cfb9f128126d.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:18:28AM -0800, Alexander Duyck wrote:
> > 
> > I thought the code is specifically checking devices which it previously
> > created, which are well defined and understood test devices. After all,
> > the check is in the test driver's probe function. Guess I really don't
> > understand the code. Please take my patch as bug report, and submit
> > whatever fix you think is correct.
> 
> Sorry I had overlooked that this is the test code.
> 
> I suppose it should be fine since we specify the node ID for all instances
> where we register an asychronous test device.
> 

That isn't exacly an endorsement. Would you mind submitting a patch
that is acceptable for you ? I'll be more than happy to test it.

Thanks,
Guenter
