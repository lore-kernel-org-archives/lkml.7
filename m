Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B27C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5557C24378
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE2Xce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:32:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42020 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbfE2Xcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:32:33 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4TNVk1Q018708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 19:31:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 444C0420481; Wed, 29 May 2019 19:31:46 -0400 (EDT)
Date:   Wed, 29 May 2019 19:31:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Trevor Bourget <tgb.kernel@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] vt: configurable number of console devices
Message-ID: <20190529233146.GA3671@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Trevor Bourget <tgb.kernel@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
References: <20190528043117.169987-1-tgb.kernel@gmail.com>
 <b52aaaed-5efb-ae1f-68c0-80b150388219@suse.cz>
 <CAG0f_nYQSn8eFHH3EcV4zxia0C6v7PfCvXybx40em9KgtzMGqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG0f_nYQSn8eFHH3EcV4zxia0C6v7PfCvXybx40em9KgtzMGqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:09:11PM -0700, Trevor Bourget wrote:
> Sorry, I hadn't registered that was uapi. You are right, as a
> configuration setting it's an odd thing to expose there.
> That define won't really be any use to user space except for type
> range validation, and as such it would actually be unhelpful for it to
> be other than 63.
> 
> I will add if defined(__KERNEL__) to improve that, so that it will be
> constant for uapi.

It's by design that MAX_NR_CONSOLES is defined in a uapi header.
There are userspace programs that rely on this value (they use it to
declare arrays, so the version that we export to userspace MUST be
largest value that any kernel might support).

That being said, I've done an eyeball inspection to see how manytes
might be saved if we were to shirnk MAX_NR_CONSOLES, and... I don't
see that many bytes.  Maybe 24 bytes per console, so that maximum
savings would less than 1.5k?   Am I missing something?

Yes, we should all worry about kernel bloat; but it's not clear to me
this is a great place to start.  :-)

					- Ted
