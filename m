Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FEAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D5E2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfGXWpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:45:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53064 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbfGXWpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:45:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 25F0A1543C8CB;
        Wed, 24 Jul 2019 15:45:35 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:45:34 -0700 (PDT)
Message-Id: <20190724.154534.1347804220870523293.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     pshelar@ovn.org, xiangxia.m.yue@gmail.com, johannes.berg@intel.com,
        kjlu@umn.edu, netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ovs: datapath: hide clang frame-overflow warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190722150018.1156794-1-arnd@arndb.de>
References: <20190722150018.1156794-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 15:45:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Jul 2019 17:00:01 +0200

> Some functions in the datapath code are factored out so that each
> one has a stack frame smaller than 1024 bytes with gcc. However,
> when compiling with clang, the functions are inlined more aggressively
> and combined again so we get
> 
> net/openvswitch/datapath.c:1124:12: error: stack frame size of 1528 bytes in function 'ovs_flow_cmd_set' [-Werror,-Wframe-larger-than=]
> 
> Marking both get_flow_actions() and ovs_nla_init_match_and_action()
> as 'noinline_for_stack' gives us the same behavior that we see with
> gcc, and no warning. Note that this does not mean we actually use
> less stack, as the functions call each other, and we still get
> three copies of the large 'struct sw_flow_key' type on the stack.
> 
> The comment tells us that this was previously considered safe,
> presumably since the netlink parsing functions are called with
> a known backchain that does not also use a lot of stack space.
> 
> Fixes: 9cc9a5cb176c ("datapath: Avoid using stack larger than 1024.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
