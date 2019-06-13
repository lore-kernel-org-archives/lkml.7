Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB17C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED62A20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443779;
	bh=mZOzCqx3eT/+VtqG9suaVNKtiI7GMTR02WnJhf2gRy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IZiQXJElYDvYHLxzfM5Dm6Gczap91KDT4kbt/wi+2b9d47AEwLAXNik26egjCegIu
	 5cy0NbmFimycYv2Zmw/WzZ/QAKTr2Jy9I4RXjG5s1P70ZClUZ6u2YZU7y4U1IoO3cE
	 Kl9T0j0KlUdG6YjMpdwjk5QiOwWIQ1RcFjmU3skQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392605AbfFMQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730692AbfFMHfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:35:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5FF20866;
        Thu, 13 Jun 2019 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560411320;
        bh=mZOzCqx3eT/+VtqG9suaVNKtiI7GMTR02WnJhf2gRy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7rovxjtpPBh+rST+d1xo73WMv0KBX5MDbgsTQh7mHqvXrQA5Bht5or9M6z3fwWDb
         8dNJQ9iXX4kQeXKdALwOpKoYwYqfEyvdvlEDie8W/4iAmAoJ9nxB2K0MkD4TtND6n5
         fgNjBkIt1eUhepgTsPvpsXC5xGcdIYRj8bdIdWb8=
Date:   Thu, 13 Jun 2019 09:35:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bluetooth regression breaking BT connection for all 2.0 and
 older devices in 5.0.15+, 5.1.x and master
Message-ID: <20190613073518.GA16436@kroah.com>
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

I've now reverted this as it does not seem to be going anywhere anytime
soon.  After the mess gets sorted out in Linus's tree, if someone could
send stable@vger the commit ids that should be applied, I will be glad
to do so.

thanks,

greg k-h
