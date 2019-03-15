Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D06C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F5A218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552660161;
	bh=KrTZpj4yLdlYHdOsF/SA1H7Z9SlODj7ASCuz1gICevE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iR5uBWS4M+xArUsRaf+J6jDq563l8M9OQrZvqvJsvNwv2RkO0QSdgopt60t4jbWwq
	 VrR7FSNIF4M1rEbn1GSjqqAbHhiTIcu2VBVHUGOMGS9tGu546iVqSEmiCI0Sf5CGDZ
	 81rVw3iwEqNFEuIaCKGhpKpxSEgvQC8lp8k+QbvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfCOO3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729171AbfCOO3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:29:19 -0400
Received: from localhost (unknown [76.14.1.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED5D21871;
        Fri, 15 Mar 2019 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552660159;
        bh=KrTZpj4yLdlYHdOsF/SA1H7Z9SlODj7ASCuz1gICevE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x2tYQsTjQ5rLUvKum1mSvmduvLM0OY2byPj+pXkh1yTI6fiwYFYpZFerWjIwgckzD
         8J5XRyRCkMIUBXP0h+sn0X04cx5oeYLaxmRWXJZ5xVy9V4vkWYNbrhM5I4d0JAw5TN
         RrRSbGWo3A7NNWb8ZV4yXKn5Gu4iBVcqvtAsjXR0=
Date:   Fri, 15 Mar 2019 07:29:18 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fs_context-related oops in mainline
Message-ID: <20190315142918.GA31099@kroah.com>
References: <20190315121813.GY2217@ZenIV.linux.org.uk>
 <20190315074307.GA31430@light.dominikbrodowski.net>
 <3476.1552650285@warthog.procyon.org.uk>
 <20190315115002.GA9055@light.dominikbrodowski.net>
 <11428.1552659870@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11428.1552659870@warthog.procyon.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
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

Ask the networking people that question, I have no idea :)
