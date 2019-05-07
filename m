Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9D120825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEGMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:33:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:55620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfEGMc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:32:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E064AE14;
        Tue,  7 May 2019 12:32:58 +0000 (UTC)
Date:   Tue, 7 May 2019 14:32:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Remove custom kobject state handling
In-Reply-To: <20190503132625.23442-2-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1905071355430.7486@pobox.suse.cz>
References: <20190503132625.23442-1-pmladek@suse.com> <20190503132625.23442-2-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2019, Petr Mladek wrote:

> kobject_init() always succeeds and sets the reference count to 1.
> It allows to always free the structures via kobject_put() and
> the related release callback.
> 
> Note that the custom kobject state handling was used only
> because we did not know that kobject_put() can and actually
> should get called even when kobject_init_and_add() fails.
> 
> The patch should not change the existing behavior.

Pity that the changelog does not describe the change from 
kobject_init_and_add() to two-stage kobject init (separate kobject_init() 
and kobject_add()).

Petr changed it, because now each member of new dynamic lists (created in 
klp_init_patch_early()) is initialized with kobject_init(), so we do not 
have to worry about calling kobject_put() (this is slightly different from 
kobj_added).

It would also be possible to retain kobject_init_and_add() and move it to 
klp_init_patch_early(), but it would be uglier in my opinion.

Miroslav
