Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F722C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56390218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCOOwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:52:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33628 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfCOOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:52:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h4oBf-0003RA-H3; Fri, 15 Mar 2019 14:51:55 +0000
Date:   Fri, 15 Mar 2019 14:51:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fs_context-related oops in mainline
Message-ID: <20190315145155.GZ2217@ZenIV.linux.org.uk>
References: <20190315121813.GY2217@ZenIV.linux.org.uk>
 <20190315074307.GA31430@light.dominikbrodowski.net>
 <3476.1552650285@warthog.procyon.org.uk>
 <20190315115002.GA9055@light.dominikbrodowski.net>
 <11428.1552659870@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11428.1552659870@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 02:24:30PM +0000, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > -	if (fc->user_ns)
> > -		put_user_ns(fc->user_ns);
> > -	fc->user_ns = get_user_ns(netns->user_ns);
> > +	if (netns) {
> > +		if (fc->user_ns)
> > +			put_user_ns(fc->user_ns);
> > +		fc->user_ns = get_user_ns(netns->user_ns);
> > +	}
> 
> This begs the question why is sysfs using the current network namespace's idea
> of the user namespace?  Why not just use the one directly from current->cred?

Because it gives access to that netns guts, presumably.  In a saner world sysfs
wouldn't _have_ netns-dependent bits; a separate per-netns filesystem would
contain those, and be mounted separately.  And yes, we do have way too many
kinds of namespaces, along with filesystems that try to mix unrelated bits and
lead to something that looks like Cthulhu's arse after an unfortunate
accident with capsaicin suppository...
