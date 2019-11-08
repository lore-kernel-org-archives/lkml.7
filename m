Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE573FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8466A2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573246197;
	bh=NU9LZfDj7rqOVx1J7c1N4B2P7rGl8SnDbxr51wObu+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z1MbDXLawqrpmHTs0dUb/53Y5PF+9pECaqWnGsKfdmh6ZP4GXOl9PzOK7zrrvq6pv
	 yxzZ+OaqTR9J90zG0DYxsfn/zFc8KlQRC6RYQ9R8gxtZpShWyhVYookRh4RVhZEqsz
	 qkK49f/CHH5c9UEm4aY7vV8sJtt8NCQknV6h65Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfKHUtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfKHUtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:49:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1052085B;
        Fri,  8 Nov 2019 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573246192;
        bh=NU9LZfDj7rqOVx1J7c1N4B2P7rGl8SnDbxr51wObu+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQu/a5LlcxVJr1NlhxtPKZEo8isDcsKQf1jrbx65DhI2Mk/x1B8b2CMhWbJmzyY8B
         WMAPI0s44fePKYJDz+mSMTIcp07QVIncncPCmnMkjO/pKy/W9t7iKwoMwxfsEXsgGs
         S+z+kZq1HzH0i4cQb69PzIo/7vk54ok0R+rJoR0I=
Date:   Fri, 8 Nov 2019 21:49:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Omer Shalev <omerdeshalev@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media:usb:cpia2: Properly check framebuffer mmap offsets
Message-ID: <20191108204949.GA1277001@kroah.com>
References: <20191108215038.59170-1-omerdeshalev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108215038.59170-1-omerdeshalev@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 09:50:36PM +0000, Omer Shalev wrote:
> The cpai2 driver's mmap implementation wasn't properly check for all
> possible offset values. Given a huge offset value , the calculation
> start_offset + size can wrap around to a low value and pass the check

I thought we checked that in the core of the kernel now, to keep all
drivers from not having to do this type of thing (as they obviously all
forgot to.)  Why is this still needed here as well?

thanks,

greg k-h
