Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549D4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279F521874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ii3I42Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH3OIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:08:30 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35098 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfH3OI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YPpA9Zl2zqsHU1pB89HKtyIXhoOkhIj6hGUoPwokRkM=; b=ii3I42WauYVkC6o8iEaRrwPN4
        qK7ds6PTD6Bcz5Jt1a8oCqRaYg1mYpxp3Y8zAolFivRW51Ek4gjnaJwskyIISMUWyG+hBQcGAtTo6
        gbe/f7sHXRZUXcjYA0f5Y2JSQ2vbErPpmFyxE+o2aa2GWVVrPZV/p+6vEHgnq/4pgdtpmuZ9tRLM2
        0Fx1klzO0ucxebtPsK0hXKcLA7ocmppNag0GMhJ7xgT/HpUyD11wKghlLI35zIG1x2YhUO/CkIn9x
        jYVILHW+EM6Ucc9qYB5a6zN4qmie60J+im7VZw15u29qcQth/xKQANPyXBU/ILhbxoHDzSv4ESXF4
        TbKFjXHZQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56030)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i3hZS-0007GN-31; Fri, 30 Aug 2019 15:08:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i3hZN-0000Be-Ot; Fri, 30 Aug 2019 15:08:05 +0100
Date:   Fri, 30 Aug 2019 15:08:05 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov@parallels.com>,
        Kirill Tkhai <ktkhai@parallels.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
Message-ID: <20190830140805.GD13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 150593bf8693 ("sched/api: Introduce task_rcu_dereference() and
try_get_task_struct()") probe_kernel_address() is used without checking
it's return value, resulting in undefined behaviour of this function.

I stumbled over this due to looking at the definition of this function,
due to a patch submission for ARM, and delving into the internals of the
probe_kernel_*() functions.

Essentially, probe_kernel_address() uses probe_kernel_read(), which
eventually uses __copy_from_user_inatomic().
__copy_from_user_inatomic() is defined thusly:

 * NOTE: only copy_from_user() zero-pads the destination in case of short copy.
 * Neither __copy_from_user() nor __copy_from_user_inatomic() zero anything
 * at all; their callers absolutely must check the return value.

which means that when probe_kernel_address() returns -EFAULT, the
destination is left uninitialised.  In the case of
task_rcu_dereference(), this means that "siginfo" can be used without
having been initialised, resulting in this function returning an
indeterminant result (based on the value of an uninitialised variable
on the stack.)

One option would be to explicitly initialise "sighand" on function
entry, or maybe check the return value of probe_kernel_address().  It
looks non-trivial due to the interaction with put_task_struct().  I
suggest someone who knows this code needs to patch this issue.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
