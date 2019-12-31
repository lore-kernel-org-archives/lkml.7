Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3ECC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7E42071E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLaC3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:29:02 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55512 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfLaC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:29:02 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1im7HH-0001Xw-V2; Tue, 31 Dec 2019 02:29:00 +0000
Date:   Tue, 31 Dec 2019 02:28:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Why is CONFIG_VT forced on?
Message-ID: <20191231022859.GB4203@ZenIV.linux.org.uk>
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 06:30:15PM -0600, Rob Landley wrote:
> On x86-64 menuconfig, CONFIG_VT is forced on (in drivers->char devices->virtual
> terminal), but the help doesn't mention a "selects", and I didn't spot anything
> obvious in "find . -name 'Kconfig*' | xargs grep -rw VT".
> 
> Congratulations, you've reinvented "come from". I'm mostly familiar with the
> kconfig plumbing from _before_ you made it turing complete: how do I navigate this?
> 
> I'm guessing "stick printfs into the menuconfig binary" is the recommended next
> step for investigating this? Or is there a trick I'm missing?

config VT
        bool "Virtual terminal" if EXPERT

IOW, it's only conrollable if EXPERT is set.  Finding CONFIG_EXPERT, setting it
and turning CONFIG_VT off is left as an exercise for reader; ceasing the
indignant whining for long enough to do that might or might not be doable -
up to you.
