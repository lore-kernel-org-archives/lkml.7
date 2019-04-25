Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47063217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZzNbTCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDYH4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:56:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33648 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfDYH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:56:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so10727231pfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gqR+suGuCzTfwFli5CHSv4hISBtvSI6QGDh8jVhJOAw=;
        b=NZzNbTCR9SHWBwVdaf4Xy6CNii53bJgkKASv2FoDSm8tjjo7vXaaFegKaMFVzVFve8
         ymcE8qzMZrVcqQhG95N0EPctP6y2FFIf0fF8C+O68HWJjry7iCD3B6G3CBAx3AUihuua
         /Kgaq5cHADAidX1olOY5M6+xEbHB6hD/RsJvKI5bOeo7mt7tA5OPBTHhLhx+40/WiC3j
         +34B3lhSzeQ8NV1zkG67FVBDSxEnSOQGMZzz+e0x0jZJzaOMZ/WiR4IDUW6nmE4cR75K
         5jRv71WGNXNCzHAt4cG5/jL1aqxTkYXQG8WyUIJJYU9Cv3GCeELl1XE7nE+pYUalhtnH
         acJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqR+suGuCzTfwFli5CHSv4hISBtvSI6QGDh8jVhJOAw=;
        b=VaY4ldEVWyOHc28jRjxCbHoJR5Zss9djP94t8WGSy8n1oe1pQ/yNtwBE/NR1vw3vGL
         KbqgZqGnNIgtm3t0FLX9oCTEQQ/OoZ7RqP53v/iqoSLBTg7tWElji7zKIU0pUCgs++5N
         tCr9eeHBcW0FbfQusHQsWEBWKtSfPZC+NS8LfakU1z0l15V2MYF131qPyZzPJoDRqVz2
         O9jVbfk5uPNLYWDdtQph33aI+Zn/6UJ4BN8HtuccIuM94Fy0qfiOEt+dGMbKDomlDjrw
         B9CtkXspYiTXBdaq/A13KbzAvaSPSXQY1gMNDq/bY41AdhZf8KNrZC1wNlZBI1Nz6YjB
         PPgA==
X-Gm-Message-State: APjAAAVvFsBY57KDxsMmHOScMQzl8onZrZwZesEyUL3SrgQFEEr6QXPl
        t2yIvidOO4U37ZQY8r/RDwo=
X-Google-Smtp-Source: APXvYqxSDVi/qtSgwTSIXEAEae4elZ9hGmeGxw+V93agvWLuu+v61XmrDxGynIuRMWZJ9NZj5xELvA==
X-Received: by 2002:a65:6259:: with SMTP id q25mr35627274pgv.103.1556178971539;
        Thu, 25 Apr 2019 00:56:11 -0700 (PDT)
Received: from localhost ([175.223.37.83])
        by smtp.gmail.com with ESMTPSA id t64sm44069098pfa.86.2019.04.25.00.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 00:56:10 -0700 (PDT)
Date:   Thu, 25 Apr 2019 16:56:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190425075606.GA16917@jagdpanzerIV>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
 <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
 <20190425035233.GA8532@jagdpanzerIV>
 <20190425075002.r4g325fyh5jmabzs@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425075002.r4g325fyh5jmabzs@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/19 09:50), Petr Mladek wrote:
> > Sure we can.
> > 
> > We also can take extra care of pr_info("%sconsole [%s%d] enabled\n".
> > Right now we do
> > 
> > 	...
> > 	console_unlock();
> > 	console_sysfs_notify();
> > 
> > 	pr_info("%sconsole [%s%d] enabled\n",....
> > 
> > 
> > But we can simply move that pr_info() a bit up:
> > 
> > 	pr_info("%sconsole [%s%d] enabled\n",
> > 	console_unlock();
> > 	console_sysfs_notify();
> > 
> > 
> > So the message will be printed on all consoles.
> 
> Great idea!
> 
> It would deserve a separate patch that moves the pr_info()
> and removes the invalid comment.
> 
> Actually, the pr_info() would deserve a comment explaining
> why it should be called before console_unlock().

Good. So I think I'll drop patch #1 from the series, add
two more patches - invalid comment + pr_info() - and rework
locking in patch #3 (this should take care of a race which
patch #1 was intended to fix).

	-ss
