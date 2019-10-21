Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE4CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602C4205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSPqSz6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfJUIMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:12:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45646 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfJUIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:12:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so7905729pfb.12;
        Mon, 21 Oct 2019 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=etsl/+EW28YP7d76R/imarsexm4hcF4u8WBkurY4oJk=;
        b=uSPqSz6wxUqRn3DR/m569DXHAC54oagCBxpkd7+Smz6qoS3curhM524AFf7hx6gRH9
         XCOFtH39JYfnEwpoG2xqI+wMSYf/vTnt1WAsaI5rBklhKcugXCk8nwc8YsXAQZppV7Ms
         3AzS2cfOwd1/5UojwML4hFIyV5CY40YrXzY3JvBPKiH1PT1y1in5zjyM/jUXCpznl3Rz
         QLn9lR3SAoheGN5pf1Qq9kP2aFFer4Ap2a3yO4FMcyk+qYyyb33m1vt1zYnp9430G1yC
         EqLc0FB7n6WCzliRdp1OUyxuodthvLeIbuAQ/oicFg5Xety3UDoTvwBmbqo7dl3ikzAp
         Xoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etsl/+EW28YP7d76R/imarsexm4hcF4u8WBkurY4oJk=;
        b=UkaRjzm3uYvbVGiCbQFtvFJPpY++Pbm6jW2H0mtWE/20xRluQ6neYSOq+w93ViVOHp
         kNoW3X3XeqNJYlZK3WKMYjlGD7Fh1MruCa8aGf6mbAhdSAxMUfjAtq5ioI3mCK+Futik
         h5r5mR3VyoN7NLcCXoXM9ehUYOHUxav2igtRLas20ZH1QggZqY9EoMYsW8V+ReqZJaIW
         2QOvWmRZWzfOvzPcXGwCpGIY6HmCOMByDhzR3QXnrNMZ67gySyfDS1CGvkGxxLUZuxDp
         SPdns4FwIrFTTkbZ07Bm7WgJPxEvWRt76xb3anlE41ZTv/MT9U2GH3o3pwDwBRpTE3Sm
         UaMw==
X-Gm-Message-State: APjAAAWwrAYCyvq7zULyD7Z8kvvz6mvX8jWvA7aLkDViAotcYcF8leBh
        sKrxxU8kGVnPc8ZzXola1XYbGFpq
X-Google-Smtp-Source: APXvYqz65u7cCrtYEB1HPJs+GDYOpixixLnDyXAlAbH3oDlDsahqTxWyIhyyhH++pwZTH6yKDVUjWg==
X-Received: by 2002:a63:ff56:: with SMTP id s22mr24047346pgk.44.1571645536842;
        Mon, 21 Oct 2019 01:12:16 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id k8sm11943460pgm.14.2019.10.21.01.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 01:12:16 -0700 (PDT)
Date:   Mon, 21 Oct 2019 01:12:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221) Add summation feature support
Message-ID: <20191021081211.GA5684@Asurada>
References: <20191016235702.22039-1-nicoleotsuka@gmail.com>
 <20191020163628.GA16363@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020163628.GA16363@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 09:36:28AM -0700, Guenter Roeck wrote:
> On Wed, Oct 16, 2019 at 04:57:02PM -0700, Nicolin Chen wrote:
> > This patch implements the summation feature of INA3221, mainly the
> > SCC (enabling) and SF (warning flag) bits of MASK_ENABLE register,
> > INA3221_SHUNT_SUM (summation of shunt voltages) register, and the
> > INA3221_CRIT_SUM (its critical alert setting) register.
> > 
> > Although the summation feature allows user to select which channels
> > to be added to the result, as an initial support, this patch simply
> > selects all channels by default, with one only condition: all shunt
> > resistor values need to be the same. This is because the summation
> > of current channels can be only accurately calculated, using shunt
> > voltage sum register, if all shunt resistors are equivalent.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > 
> > Hi Guenter,
> > 
> > I know my previous questions haven't been answered yet, so nodes
> > for enabling bits aren't decided completely. But this patch only
> > adds voltage and its current, and we had a conclusion for these
> > two already last time. So I think we may add them first. Thanks!
> > 
> 
> I don't really like the term "summation", as it is the process of
> summing things up, not the result. I'll change "summation of" in
> the documentation to "sum of" and apply the patch.

Thank you!
