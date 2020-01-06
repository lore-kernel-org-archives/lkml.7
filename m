Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF7C32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE4620848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSp0yqDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgAFFPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:15:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39733 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFFPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:15:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so26401615pfs.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 21:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQ4dLbLTXcTsqLxkRXDmA81aLMecCPVammCzSLarEZY=;
        b=cSp0yqDTpoL9oCte+SWhRNVDo83fs8D5JQRAmcTBPjAxbPdQjoBf7lEIwk812b76c1
         xqfBZFUjaVEBI5WvbCS3x6zL8b/2s4jmpbygW1dUqs9NOtDFSCJVKUIOb1gs6vyz7T36
         JwUbsoJxeDZLR7nZFwllIatimP88MhozxuwxIJ+QiWIciKI2/NhN8DVWsyUolg3rlhDj
         Ny1SLgveqKLY+atHi8ikfEo4v59acfUmA+oEbGaZbfnyDeP0h4YZvzM1rJc6DkOp+0wc
         8Jam3FohP7p3ShURpZzfoPMvM3ubLu0McAZIaNzop2Ims9uL2dl114GlS7JwT+A6TDHh
         mNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQ4dLbLTXcTsqLxkRXDmA81aLMecCPVammCzSLarEZY=;
        b=YQi1VWX6HCGAf/8rpm7GWskKLvoBupc3IfJ6lyEgpoaZQmfhMqsUXkFnzVkRnQK3bC
         lgIaVNC/qp0Dt+QskjvmZQb42iCeDhiQfXCC1TXDv3RPYwVpDh3xYevPDeF3tAz+bXOU
         tGcrWrsrLmttRcOF60ZSoxS6diF+SFmw+dl+kDSoAo2t1hwpDdfYWaw+YDhwMrovbxDu
         nXSJDTV2FUGxdlChQfnjMjtK6tiEaFA86jLwOZ8NtSa0upoqAxeYugM+OBUzomUgKjgs
         GM5l8oYh5Kjf0GV357e3eiZCy4McBPfauSgJG1sUPGdFXN45OsdfGHCGKFHUNpG/7wjM
         ES0w==
X-Gm-Message-State: APjAAAV0RoYnrBLOzMrUOFHWeICsYdeTdlJ3rI1YgKTVtwhCv5JVwLKE
        aCOttCPP6J7DSxUZUAYn8/Q=
X-Google-Smtp-Source: APXvYqyMUfQfhlUEHPV/HZqgz3Sm84ZOTzTHltl2gEGhmoWIQySPiBj8wiCDmAu2HTbDuwiJ0DiShw==
X-Received: by 2002:a63:454a:: with SMTP id u10mr110935513pgk.248.1578287711764;
        Sun, 05 Jan 2020 21:15:11 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id r66sm77209408pfc.74.2020.01.05.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 21:15:10 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:15:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] printk: Fix preferred console selection with multiple
 matches
Message-ID: <20200106051508.GA17351@google.com>
References: <2712d7e2fb68bca06a33e2e062fc8e65a2652410.camel@kernel.crashing.org>
 <20191219135053.xr67lybhycepcxkp@pathway.suse.cz>
 <32fde8cd451ea0eaff38108d9f2f2d4a97a43097.camel@kernel.crashing.org>
 <20191220091131.4uifcbudwppjspf4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220091131.4uifcbudwppjspf4@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/20 10:11), Petr Mladek wrote:
[..]
> > > > +enum con_match {
> > > > +	con_matched,
> > > > +	con_matched_preferred,
> > > > +	con_braille,
> > > > +	con_failed,
> > > > +	con_no_match,
> > > > +};
> > > 
> > > Please, replace this with int, where:
> > > 
> > >    + con_matched -> 0
> > >    + con_matched_preferred -> 0 and make "has_preferred" global variable
> > >    + con_braile -> 0		later check for CON_BRL flag
> > >    + con_failed -> -EFAULT
> > >    + con_no_match -> -ENOENT
> > 
> > Not fan of using -EFAULT here, it's a detail since it's rather kernel
> > internal, but I'd rather use -ENXIO for no match and -EIO for failed
> > (or pass the original error code up if any). That said it's really bike
> > shed painting at this point :-)
> 
> Sigh, either variant is somehow confusing.
> 
> I think that -ENOENT is a bit better than -EIO. It is abbreviation of
> "No entry or No entity" which quite fits here. Also the device might
> exist but it is not used when not requested.

Can we please keep the enum? Enum is super self-descriptive, can't
get any better. Any other alternative - be it -EFAULT or -EIO or
-ENOENT - would force one to always look at what is actually going
on in try_match_new_console() and what particular errno means. None
of those errnos fit, they make things cryptic. IMHO.

	-ss
