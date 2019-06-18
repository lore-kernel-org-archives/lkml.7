Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C11CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EA220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560880203;
	bh=2s5JXaKAuAm51+zEi5iSTey2SYDXY/3li7doYYkuVg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zNcaywEDZAgXFOe0GqQbCssFtUIv4iK8lMygbiUAyHu0wYQa3DkDGj/9m8bF7Isxx
	 xDt+T4X9NUV6QNRuAcdcpVA0ZGCCPsijwpN4Db7gzpgkE5qsj8F0vOaisydaPZr2wh
	 XOwNJpUbZGnYVnVBCC+sehGYWVn4Jzy9Vc6A6upM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfFRRtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbfFRRtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:49:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946F420863;
        Tue, 18 Jun 2019 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560880192;
        bh=2s5JXaKAuAm51+zEi5iSTey2SYDXY/3li7doYYkuVg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQoUj4xgzTjeYc9oX9DHwNKU15/cbzRwP5rwHjYZX7eZOT38i9SZVV8DI5lNcgdWH
         ofgyy9gef30zDQ3fF7YSsh+C+XHCaDDyBTWPx2TaumYwAbk0qCCaetUCEXZk/ntGs9
         QCMiK+unMa6ml6T/2KteVIrZFfSDnJ4hz1P+2R5Y=
Date:   Tue, 18 Jun 2019 19:49:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Feeney <james@nurealm.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 5.1 003/115] HID: input: make sure the wheel high
 resolution multiplier is set
Message-ID: <20190618174949.GD3649@kroah.com>
References: <20190617210759.929316339@linuxfoundation.org>
 <20190617210800.096317488@linuxfoundation.org>
 <a90f3536-8833-498d-c9d5-ef460ad153da@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90f3536-8833-498d-c9d5-ef460ad153da@nurealm.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:22:55AM -0600, James Feeney wrote:
> Uhm - could someone please "clue me in" here?
> 
> When I look into:
> 
> 'move all the pending queues back to their "real" places'
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=c5da0df8985ac2f29ffdaba77bae201121bc0e10

No need to worry about that patch, that was done because my scripts
normally assume specific directory locations of the patch queues, and I
had to do a kernel release that did not include the existing pending
patches.

> I can find both the "d43c17ead879ba7c076dc2f5fd80cd76047c9ff4" patch, "HID: input: make sure the wheel high resolution multiplier is set" and the "39b3c3a5fbc5d744114e497d35bf0c12f798c134" patch, "HID: input: fix assignment of .value".
> 
> I take this to mean that these patches are "in the stable-queue".  But then, these patches are not "in the kernel".

Yes.

> So then, how do these patches go from being "in the stable-queue" to being "in the kernel"?

I apply them when I do the release in a few hours/days.

> To the "uninitiated" and "naive", as I am, to outward appearances, the
> patches are "just sitting there".  How do the patches get selected for
> inclusion into the "next" kernel revision?

I already selected them, sent emails saying they were selected and to
what specific branches they were selected to.  Then when the -rc
releases happen so that people can do one final round of testing and
object if I messed anything up, they get sent out again (which you
responded to here.)

If all goes well, when the "deadling" passes (usually 2 days +-2 days
depending on stuff), I'll do a realease and apply the patches "for real"
to the different kernel branches and cut a release.

Then I start all over again...

I understand that seeing a git tree of patches in a quilt series is odd,
but it is very powerful and works very very well for what we do here.

Does that help?

greg k-h
