Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EBC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874B021741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osNXp1Po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1JiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:38:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1JiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:38:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so10214632wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NhpLhJz6+GDF9m5U6zWuGMsno9FtNQ2w1q9YdXHXl14=;
        b=osNXp1PoN1pNhtrxYjY6DcE8SZhJaS2KskPEeSN8ztSvahvxN4BpUC+7LeDoz9PO8Z
         I0gzYdxQfGjXIb6/Z67XNwX3QDLs3Bz/j0HpJ5RwuZYlymTwqf7Sja4a+Shhg+fzbAjb
         Mg3ztcaeZsf6itIt3xHy9QPDOkbR4/u+TceDQjSv2SQyMK1k5TBdBaoIekpL35fkBKtR
         UdlcWvz4JdBQIl0U6bY46pQ2nL8qHBKyKKqeOCFBpL6v2l/n6WxtfAr8VdtFE8/esimq
         Yu0xg8AOreQ1svph/X3j3/tDkjyh4QuCeAvYcfu+4YgAVJMnwa5ZCT9FJ3WFW2Z2FJXJ
         SGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NhpLhJz6+GDF9m5U6zWuGMsno9FtNQ2w1q9YdXHXl14=;
        b=lQJiWoaEu5CqyVIBU8AULgA7+n8QpBbrFbEiynQa5CZUrEyhrWkZKeJCXmVb10fIwP
         kADnaUbqDig7XizHzpNRPCjqfNhP56VBCyLx3IVVAPEhGUMA3abrBcBGZgALR4Q8QdCM
         V8FO4hbYFd2L4hRO2q4YG177MKQ7gpeN+CipPil2rs8FrqAA+NV+Axk8mJ4FSMjU1j0R
         rI2mCnB6juxdgP2oExl1M+wsxxNHBS1ZiOGK1aMxkIEYnc77PfNIKpsyDRVGp3HZDvsd
         bM6sdhCuunwZfJUTHQsfVSh0RYNYH8J9nRbxeREF34NyzrDXhIf8QiU2MBQYwqiN0ACt
         Ijeg==
X-Gm-Message-State: APjAAAWWXSqYXn8bRaOr5fzcjkLtLzWmxuUgYf1DCyJIGwC9P2nFMYEr
        dvM6NsQ5QLynqyXretWC9bOgPA==
X-Google-Smtp-Source: APXvYqxshxI1xLIjiArznE4nEZ0G3ax1Vs9ZBK7qgqy3CJVywQrE7TmI2c+oBXwRmIS83w6jJ6LDtA==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr8563703wmi.141.1574933887456;
        Thu, 28 Nov 2019 01:38:07 -0800 (PST)
Received: from apalos.home (athedsl-4476713.home.otenet.gr. [94.71.27.49])
        by smtp.gmail.com with ESMTPSA id f2sm3076753wmh.46.2019.11.28.01.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 01:38:06 -0800 (PST)
Date:   Thu, 28 Nov 2019 11:38:04 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: ale: ensure vlan/mdb deleted when no
 members
Message-ID: <20191128093804.GA18633@apalos.home>
References: <20191127155905.22921-1-grygorii.strashko@ti.com>
 <20191128082127.GA16359@apalos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128082127.GA16359@apalos.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 10:21:27AM +0200, Ilias Apalodimas wrote:
> On Wed, Nov 27, 2019 at 05:59:05PM +0200, Grygorii Strashko wrote:
> > The recently updated ALE APIs cpsw_ale_del_mcast() and
> > cpsw_ale_del_vlan_modify() have an issue and will not delete ALE entry even
> > if VLAN/mcast group has no more members. Hence fix it here and delete ALE
> > entry if !port_mask.
> > 
> > The issue affected only new cpsw switchdev driver.
> > 
> > Fixes: e85c14370783 ("net: ethernet: ti: ale: modify vlan/mdb api for switchdev")
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > ---
> >  drivers/net/ethernet/ti/cpsw_ale.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> > index 929f3d3354e3..a5179ecfea05 100644
> > --- a/drivers/net/ethernet/ti/cpsw_ale.c
> > +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> > @@ -396,12 +396,14 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
> >  	if (port_mask) {
> >  		mcast_members = cpsw_ale_get_port_mask(ale_entry,
> >  						       ale->port_mask_bits);
> > -		mcast_members &= ~port_mask;
> > -		cpsw_ale_set_port_mask(ale_entry, mcast_members,
> > +		port_mask = mcast_members & ~port_mask;
> > +	}
> > +
> > +	if (port_mask)
> > +		cpsw_ale_set_port_mask(ale_entry, port_mask,
> >  				       ale->port_mask_bits);
> > -	} else {
> > +	else
> >  		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
> > -	}
> 
> The code assumed calls cpsw_ale_del_mcast() should have a port mask '0' when
> deleting an entry. Do we want to have 'dual' functionality on it? 
> This will delete mcast entries if port mask is 0 or port mask matches exactly
> what's configured right?
> 

Deleting the ALE entry if the port_mask matches execlty what's configured makes
sense. Can we change it to something that doesn't change the function argument?

I think something like: 
mcast_members = 0;
if (port_mask) {
	mcast_members = cpsw_ale_get_port_mask(ale_entry,
											ale->port_mask_bits);
	mcast_members &= ~port_mask;
}
if (mcast_members)
	cpsw_ale_set_port_mask(ale_entry, mcast_members, ....)
else
	cpsw_ale_set_entry_type(....)

is more readable?

Thanks
/Ilias
