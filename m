Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2546C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C456921872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfCOOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbfCOOYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:24:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D39D73082B02;
        Fri, 15 Mar 2019 14:24:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D14AA17995;
        Fri, 15 Mar 2019 14:24:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190315121813.GY2217@ZenIV.linux.org.uk>
References: <20190315121813.GY2217@ZenIV.linux.org.uk> <20190315074307.GA31430@light.dominikbrodowski.net> <3476.1552650285@warthog.procyon.org.uk> <20190315115002.GA9055@light.dominikbrodowski.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fs_context-related oops in mainline
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11427.1552659870.1@warthog.procyon.org.uk>
Date:   Fri, 15 Mar 2019 14:24:30 +0000
Message-ID: <11428.1552659870@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 15 Mar 2019 14:24:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> -	if (fc->user_ns)
> -		put_user_ns(fc->user_ns);
> -	fc->user_ns = get_user_ns(netns->user_ns);
> +	if (netns) {
> +		if (fc->user_ns)
> +			put_user_ns(fc->user_ns);
> +		fc->user_ns = get_user_ns(netns->user_ns);
> +	}

This begs the question why is sysfs using the current network namespace's idea
of the user namespace?  Why not just use the one directly from current->cred?

David
