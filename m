Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ACDC282E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3DE20815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfEZTld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:41:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfEZTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:41:32 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hUz1O-00045D-N0; Sun, 26 May 2019 21:41:30 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: report eip and esp for all threads when coredumping
References: <20190522161614.628-1-jlu@pengutronix.de>
        <875zpzif8v.fsf@linutronix.de>
        <20190525143220.e771b7915d17f22dad1438fa@linux-foundation.org>
Date:   Sun, 26 May 2019 21:41:28 +0200
In-Reply-To: <20190525143220.e771b7915d17f22dad1438fa@linux-foundation.org>
        (Andrew Morton's message of "Sat, 25 May 2019 14:32:20 -0700")
Message-ID: <87d0k5f1g7.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2019-05-25, Andrew Morton <akpm@linux-foundation.org> wrote:
> Please send along a signed-off-by: for this?

From my response:

On 2019-05-25, John Ogness <john.ogness@linutronix.de> wrote:
> AFAICT core_state does not need to be set before the other lines. But
> there may be some side effects that I overlooked!

The changes I showed were more of a suggestion for Jan than an actual
patch. For a signed-off-by I'll need to do some deeper looking to make
sure what I suggested was safe. Also, we probably need a barrier to make
sure the task flag is cleared before setting core_state. Or instead, we
probably should set core_state after releasing the siglock, setting it
where the PF_DUMPCORE flag is set.

It seems to me that checking for a non-NULL core_state and checking for
the PF_DUMPCORE flag are both used throughout the kernel to identify
core dumps in action. So I think it makes sense to set them "at the same
time". (Or perhaps eliminate PF_DUMPCORE altogether and just use a
non-NULL core_state to identify core dumping.)

I will take a closer look at this.

John Ogness
