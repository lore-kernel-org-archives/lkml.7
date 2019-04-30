Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F5820835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfD3PIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:08:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbfD3PIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:08:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AA3DAD31;
        Tue, 30 Apr 2019 15:08:12 +0000 (UTC)
Date:   Tue, 30 Apr 2019 17:08:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] livepatch: Use correct kobject cleanup function
Message-ID: <20190430150811.4hzhtz4w46o6numh@pathway.suse.cz>
References: <20190430001534.26246-1-tobin@kernel.org>
 <20190430001534.26246-3-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430001534.26246-3-tobin@kernel.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-04-30 10:15:34, Tobin C. Harding wrote:
> The correct cleanup function after a call to kobject_init_and_add() has
> succeeded is kobject_del() _not_ kobject_put().  kobject_del() calls
> kobject_put().

Really? I see only kobject_put(kobj->parent) in kobject_del.
It decreases a reference of the _parent_ object and not
the given one.

Also the section "Kobject removal" in Documentation/kobject.txt
says that kobject_del() is for two-stage removal. kobject_put()
still needs to get called at a later time.

IMHO, this patch causes that kobject_put() would never get called.

That said, we could probably make the removal a bit cleaner
by using kobject_del() in klp_free_patch_start() and
kobject_put() in klp_free_patch_finish(). But I have
to think more about it.

Best Regards,
Petr
