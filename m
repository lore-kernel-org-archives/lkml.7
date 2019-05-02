Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BAB206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEBOPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbfEBOPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6FF9AE47;
        Thu,  2 May 2019 14:15:11 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id CA511E0117; Thu,  2 May 2019 16:15:10 +0200 (CEST)
Message-Id: <cover.1556806084.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v2 0/3] netlink: strict attribute checking follow-up
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org
Date:   Thu,  2 May 2019 16:15:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three follow-up patches for recent strict netlink validation series.

Patch 1 fixes dump handling for genetlink families which validate and parse
messages themselves (e.g. because they need different policies for diferent
commands).

Patch 2 sets bad_attr in extack in one place where this was omitted.

Patch 3 adds new NL_VALIDATE_NESTED flags for strict validation to enable
checking that NLA_F_NESTED value in received messages matches expectations
and includes this flag in NL_VALIDATE_STRICT. This would change userspace
visible behavior but the previous switching to NL_VALIDATE_STRICT for new
code is still only in net-next at the moment.

v2: change error messages to mention NLA_F_NESTED explicitly

Michal Kubecek (3):
  genetlink: do not validate dump requests if there is no policy
  netlink: set bad attribute also on maxtype check
  netlink: add validation of NLA_F_NESTED flag

 include/net/netlink.h   | 11 ++++++++++-
 lib/nlattr.c            | 18 +++++++++++++++++-
 net/netlink/genetlink.c | 24 ++++++++++++++----------
 3 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.21.0

