Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F8BC468D8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F384520862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560177977;
	bh=FQJK1JBRrqxEU8KBQ1nxhtuOOcsP2AwKZ2zJ6Un8dqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xPPgT18YqNQ5sbHjgDSL/R/0GenqU1ZQNaCkuIkTQUf+FBFjsDKbr/uwKw6lyVYqQ
	 ZM9NE9HOWdnciclKefWgfTF5f6phOzqBEk72e0GPA0RsxJm2OIJDGxTtVzgB4QHIXc
	 //WrgOMq30mJg4Wc+Jtrv9G8KQcHY1rpqQfeBaQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390945AbfFJOqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbfFJOqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:46:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B1C2085A;
        Mon, 10 Jun 2019 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560177975;
        bh=FQJK1JBRrqxEU8KBQ1nxhtuOOcsP2AwKZ2zJ6Un8dqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9UAwWKSNdLkFAxqVXa4+9RWRC1wO/5o/fNxxbwE/2wTtLmhJDLTB2/7bYRqCgyaa
         9uY4Is8+qyFwnBiHmsZEVTRfQjkXvQc1iXE8HEFa3Q3l1chH5s8aqnq4mWYB7y7yaU
         +TkMdSaYZYkt3yRnFCTThGY9PW0vvtrIX2Mx/4Rs=
Date:   Mon, 10 Jun 2019 16:46:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bluetooth regression breaking BT connection for all 2.0 and
 older devices in 5.0.15+, 5.1.x and master
Message-ID: <20190610144613.GD31086@kroah.com>
References: <af8cf6f4-4979-2f6f-68ed-e5b368b17ec7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8cf6f4-4979-2f6f-68ed-e5b368b17ec7@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:31:55PM +0200, Hans de Goede wrote:
> Hi All,
> 
> First of all this is a known issue and it seems a fix is in the works,
> but what I do not understand is why the commit causing this has not
> simply been reverted until the fix is done, esp. for the 5.0.x
> stable series where this was introduced in 5.0.15.
> 
> The problem I'm talking about is commit d5bb334a8e17 ("Bluetooth: Align
> minimum encryption key size for LE and BR/EDR connections"):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5bb334a8e171b262e48f378bd2096c0ea458265
> basically completely breaking all somewhat older (and some current cheap
> no-name) bluetooth devices:
> 
> A revert of this was first proposed on May 22nd:
> https://lore.kernel.org/netdev/CA+E=qVfopSA90vG2Kkh+XzdYdNn=M-hJN_AptW=R+B5v3HB9eA@mail.gmail.com/T/
> We are 18 days further now and this problem still exists, including in the
> 5.0.15+ and 5.1.x stable kernels.
> 
> A solution has been suggested: https://lore.kernel.org/linux-bluetooth/20190522070540.48895-1-marcel@holtmann.org/T/#u
> and at least the Fedora 5.1.4+ kernels now carry this as a temporary fix,
> but as of today I do not see a fix nor a revert in Torvald's tree yet and
> neither does there seem to be any fix in the 5.0.x and 5.1.x stable series.
> 
> In the mean time we are getting a lot of bug reports about this:
> https://bugzilla.kernel.org/show_bug.cgi?id=203643
> https://bugzilla.redhat.com/show_bug.cgi?id=1711468
> https://bugzilla.redhat.com/show_bug.cgi?id=1713871
> https://bugzilla.redhat.com/show_bug.cgi?id=1713980
> 
> And some reporters:
> https://bugzilla.redhat.com/show_bug.cgi?id=1713871#c4
> Are indicating that the Fedora kernels with the workaround included
> still do not work...
> 
> As such I would like to suggest that we just revert the troublesome
> commit for now and re-add it when we have a proper fix.

I agree, can someone revert this in Linus's tree so I can revert it in a
stable release?

thanks,

greg k-h
