Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FB120851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY+Zb43v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfCHDL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:11:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39644 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfCHDLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:11:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so13034872pfo.6;
        Thu, 07 Mar 2019 19:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sU6L662VWl9FEPdqU7e+L5Ut0nmMlyYAXEzcVxhLIho=;
        b=AY+Zb43vPJ1SyUw0wDBY3ScDQTLHs2IpIh+A0VIE16mtONfLg2Hh446VxcQ9uxW5Fq
         Km6cKAI3eXHggGqiB2zTS/mIzennFlLPYTTfg/YuRmVm70862fYOY9M6DhB4OLwYhGkT
         +5lUanoBNsSNio4sEj4f0Coa3J12uIw0AmuqrXYiNce0gWrgR2SRK7zSIYfeKOxc+zGp
         qt0myZPKk3HBM0Jag/M0zZiPJAr8Jb/0qw7N6Jtx0opbUMbm42o94I1l8NKn1qI+1zan
         byRdCR1FdfLLYNNYV4BbiCPojiCveYlB4/saHjvzBesbwT1nWZKxUajVnrfVfNHI9fsJ
         Smvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sU6L662VWl9FEPdqU7e+L5Ut0nmMlyYAXEzcVxhLIho=;
        b=r8rq5Hmu4g8fP65vZ3Z0G9AygS1fMmTfFV3jFMRPYrY+v+0ysbR8JzG9g7G+rl+XNb
         zoQrv7O3Kq0D76a4Zh/iKJB64fND2i7P7WqIzLN0lhgPq7ww1IPhhL+e/MrhYBNKiy3j
         IooPZLOZaQvszRHafN9+kh/n7RyhC4O7Urlc5lRNHXHjfF+v17YzNaf2gKgdhu4CKcwv
         HHYR+3zYgK/+2oBXBknF2cdMj0+6Bo9NLZS9JEMo7qnevidSMWLBkbdfQCLSF+gzsclH
         VJk493nc0P3GM/WziMOgj12I5slz5+Aqt4L/4suaXPe9YGr2mlU5BmjbbdtqriekHqFm
         pfmQ==
X-Gm-Message-State: APjAAAVs19zv76/SY6wp1rlCiI0aTjD1qwYMUroJagMa5I7wzPv73M3i
        LMYF9zj2xC0yXOSuOXJHanc=
X-Google-Smtp-Source: APXvYqxZ30RvW2AKzFgEpRY5QdGvfVjH68ovJl2EhE28tPHDhra+qwJWwgprg28TH5r8lL+RGykw5Q==
X-Received: by 2002:a63:360e:: with SMTP id d14mr14715870pga.179.1552014684842;
        Thu, 07 Mar 2019 19:11:24 -0800 (PST)
Received: from localhost ([175.223.36.163])
        by smtp.gmail.com with ESMTPSA id m9sm10015330pfi.31.2019.03.07.19.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 19:11:24 -0800 (PST)
Date:   Fri, 8 Mar 2019 12:11:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 4/4] printk: Add a device attribute for the per-console
 loglevel
Message-ID: <20190308031121.GA2480@jagdpanzerIV>
References: <cover.1551486732.git.calvinowens@fb.com>
 <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
 <20190304080630.GA4495@jagdpanzerIV>
 <20190304191006.GA51516@calvinowens-mba.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304191006.GA51516@calvinowens-mba.dhcp.thefacebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/04/19 19:10), Calvin Owens wrote:
> On Monday 03/04 at 17:06 +0900, Sergey Senozhatsky wrote:
> > On (03/01/19 16:48), Calvin Owens wrote:
> > > +static struct attribute *console_sysfs_attrs[] = {
> > > +	&dev_attr_loglevel.attr,
> > > +	NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(console_sysfs);
> > > +
> > >  static struct bus_type console_subsys = {
> > >  	.name = "console",
> > > +	.dev_groups = console_sysfs_groups,
> > >  };
> > 
> > Do we really need to change this dynamically? Console options are
> > traditionally static (boot param or DT). Can we also be happy with
> > the static per-console loglevel?
> 
> It really does need to be runtime configurable: there are a lot of usecases
> that enables, like turning the fast console up to KERN_DEBUG on a pile of
> machines you want to take a closer look at. The 'kernel.printk' global
> loglevel is also already changable at runtime, and since that setting
> interacts with this one it would be strange if only the former were able
> to be changed.

Fair enough.

	-ss
