Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF44C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174E9216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558549156;
	bh=Lj+UQSKOBWjtRSU8mmwyChOpiwRlOQuuXNdlNMg9qOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SpzK03T9sSG6UDXK/PV02R8UUiPImzPkaT/RqNkidbFKxQdKjCYdT3GcZDgkgnh4Q
	 q5Yz6iNMxuru8k1jKHN9H6XghN8+JJPJ6+E71lo0/4FzC+r9IT0Pl3oR4sGFjiWMjU
	 4gZ9a8u75qxne76CVxUB2Nzkh/hOIgFgNNCvLPdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfEVSTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729517AbfEVSTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:19:12 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC36121473;
        Wed, 22 May 2019 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558549152;
        bh=Lj+UQSKOBWjtRSU8mmwyChOpiwRlOQuuXNdlNMg9qOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kxch2P6yoqn2ghOf6Zu5Akc+n+E7NcUW2VuwDGYxynrln25xvzIwwgleLCMAr+Cjd
         dOpYDPHt3h+O0vEg9NqJj5RIaRl7eyVLSzCnpO2BOAZoeObsWf7Di/S85ZqKLTBoEt
         zb5wpD9kIFFS/2atJeKvU6VaVWp18Dac0S4xG92k=
Date:   Wed, 22 May 2019 11:19:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] mm/vmap: get rid of one single unlink_va() when
 merge
Message-Id: <20190522111911.963fbb4950e051a35e92887c@linux-foundation.org>
In-Reply-To: <20190522150939.24605-3-urezki@gmail.com>
References: <20190522150939.24605-1-urezki@gmail.com>
        <20190522150939.24605-3-urezki@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 17:09:38 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> It does not make sense to try to "unlink" the node that is
> definitely not linked with a list nor tree. On the first
> merge step VA just points to the previously disconnected
> busy area.
> 
> On the second step, check if the node has been merged and do
> "unlink" if so, because now it points to an object that must
> be linked.

Again, what is the motivation for this change?  Seems to be a bit of a
code/logic cleanup, no significant runtime effect?

