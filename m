Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819DAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FDE214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfLKMxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:53:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:50374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727457AbfLKMxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:53:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE92AAC7D;
        Wed, 11 Dec 2019 12:53:04 +0000 (UTC)
Date:   Wed, 11 Dec 2019 13:53:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191211125303.3s2ck3sfr2ypkt7w@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210080154.GJ88619@google.com>
 <98df321d16adb67c5579ac4b67d845fc0c2c97df.camel@kernel.crashing.org>
 <20191211020149.GN88619@google.com>
 <38b543cb91e936d7bd9f8885e585dd55032d83a4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b543cb91e936d7bd9f8885e585dd55032d83a4.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-12-11 15:02:02, Benjamin Herrenschmidt wrote:
> On Wed, 2019-12-11 at 11:01 +0900, Sergey Senozhatsky wrote:
> > On (19/12/11 09:26), Benjamin Herrenschmidt wrote:
> > 
> 
> > As far as I know, ->match() does not only match but also does ->setup().
> > If we have two console list entries that match (one via aliasing and one
> > via exact match) then the console driver is setup twice. Do all console
> > drivers handle it? [double setup]
> 
> I don't think it's an issue but I may be wrong. I had a quick look
> at some of the drivers and I don't really see why they would break but
> I couldn't look at them all and I might be mistaken.
> 
> We could skip setup if the console is already enabled but I would
> advise against that since the two calls might have different options
> (the firmware baud rate could be different from the command line one
> for example) and we want the options for the last one.

For example:

  + ip22zilog_console_setup() calls  __ip22zilog_startup() that does
    some initialization of the device

  + pl011_console_setup() does some non-trivial things as well.

Honestly, I am not familiar with these devices. I am not sure if it is
dangerous or safe to call these functions twice.

I am not sure if anybody would know this for sure. Therefore I suggest a
conservative approach and avoid calling setup() twice().

I think that it is dangerous and error-prone design. The best solution
would be to split setup() and match() functionality.

Best Regards,
Petr
