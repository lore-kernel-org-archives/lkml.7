Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36EE20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CDA7M4rX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfCZPab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:30:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37692 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfCZPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:30:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so11148605edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwlUJu9dKmrwda2u436urcIe7/q2Yk8NXJhgahmqboY=;
        b=CDA7M4rXpKNhjNw3fG77CDOtcw/FJp463Eb8gFbB5yzcybcSjofek0IiHpMUvWa6Ee
         zVhSSsMfnXAExxPoWAGyPoxWnE++NQF7jsl6nn7s+K/MiaIXy0ux1wKA65dE5fI1rf/I
         m4MIQvDsoEZ+QmrE0DOcOliih4pPgFXgmE2otv++20egQJFDFUhnbSGM6iqgI7nWtv+r
         xXO1HDEWDf9n53DioE21PDBrw206+mOlCVLjcIMbrRJEZ1IIvSkqZkfjLWPMcX01dH8t
         brn52UOkVu+FnYazpWGVDeWuo+V3Yezt9luR9Np7k9KPZDa78i0QNIo5QITIbMohyCha
         4Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwlUJu9dKmrwda2u436urcIe7/q2Yk8NXJhgahmqboY=;
        b=lTCAuNt56FyhxqyLIDiU67F9X76HeozzWnfaEx8haT5rpWBY2Xc6215pNeSgnr+Oao
         wWG/8hAp7bEVIsh7TWe9nIiC7SIc8x1UGh/CDl3acYuGalhS/i4oUPzB5QqUWOV9p7Lt
         9SOSizBjkny6ET2wv8IpSc2ZInJLUcWNaoV4gCWBYoewAzzZmM/Et00UEcoYFOpbxmmX
         45mJGkY2hc24iNkVcsInb/eM7PfYgeSUuZhHGOI2+lqybcG3SvBZKfJF0qWYn0j6IfGZ
         9Qo2j5tau2qvkOW1+hsh3PdjSMNcrkmv7QJXig25mJqaVsrdBXH+Q93qOzHlZcX2zxKz
         pLkg==
X-Gm-Message-State: APjAAAUebRuKG/qCTVIKBIr2X0tnnCVOrJr2lI59XT2CmDm8w9es+LDW
        8QFpnHKp7iIG9NmZ3esPmvf6N5+OX1VEKA==
X-Google-Smtp-Source: APXvYqz/epaAkZ+8JB5+y/0N1I7GU3iHFDaNgVLHGzUxMwM6P75CsUYbe3jyKTjAIqdS5COqlgR62g==
X-Received: by 2002:a05:6402:709:: with SMTP id w9mr21264924edx.14.1553614228179;
        Tue, 26 Mar 2019 08:30:28 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b2sm5310830eda.36.2019.03.26.08.30.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 08:30:27 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC 0/4] net/fib: Speed up trie rebalancing for full view
Date:   Tue, 26 Mar 2019 15:30:21 +0000
Message-Id: <20190326153026.24493-1-dima@arista.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During moving from 3.18 stable kernel to 4.9 on the switches, rebasing
local -specific patches and stuff, it was found that BGP benchmarks for
full view have started to hit the soft lockup detector by holding rtnl
mutex for a couple of seconds on routes changes.

I've found that the hard-coded MAX_WORK doesn't limit the amount of
pending rebalancing work anymore. So that any route adding/removal may
cause massive rebalancing of the trie. And making the hit even worse,
tnodes are freed by RCU with a call to synchronise_rcu() every 512Kb.
That is way too small and even on 2-cores switches is painfully
noticable.

To address those problems, I've introduced sysctl knob to limit the
amount of rebalancing work (by default unlimited as is de facto now).
I've moved synchronise_rcu() into a new shrinker to actually release
memory in OOM.. I believe non-visible to userspace shrinker is better
than a new sysctl knob for the limit (or any hard-coded value).
Though, not sure how sane the result is.
So, I send it as RFC, having qualms that it's not ready for inclusion
as-is yet.

I've looked further into the origin of problems here and was thinking if
it make sense to do the following (rough plan):
1. Introduce a new flag RTNL_FLAG_DUMP_UNLOCKED to dump fib trie without
   rtnl lock. I'm a bit out of context, so probably I miss some obvious
   reasons why lock needs to be held at this point.
2. Add a new fib_lock mutex for updating a trie. I'm not really sure
   that we can always release rtnl for updates, so probably there should
   be a strict locking order: rtnl_lock (when needed) => fib_lock.
3. Correct current documentation, that mentions fib_lock as rwsem.
4. ??

I did some experiments on the plan above, but decided to send this RFC
to get opinions of people who understand more. Maybe, my plan is
nonsense and it's not worth invest amount of time it requires.

I've also looked into changes between v3.18...v4.9, and found the
following patches set: https://www.spinics.net/lists/netdev/msg309586.html
While it has impressive results on lookups, it seems to be the reason of
the regression on the big scale: one of the patches has 5 times penalty
to remove a route on a big scale, another adds 10 times penalty by
calling synchronise_rcu() more frequently (I've marked them by Fixes tag
in the patches).

[I was very lavish on Cc list, please ping me in private if you don't
want to be copied on the next version]

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: David Ahern <dsahern@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Ido Schimmel <idosch@mellanox.com>
Cc: netdev@vger.kernel.org

Thanks,
        Dmitry

Dmitry Safonov (4):
  net/ipv4/fib: Remove run-time check in tnode_alloc()
  net/fib: Provide fib_balance_budget sysctl
  net/fib: Check budget before should_{inflate,halve}()
  net/ipv4/fib: Don't synchronise_rcu() every 512Kb

 Documentation/networking/ip-sysctl.txt |   6 ++
 include/net/ip.h                       |   1 +
 net/ipv4/fib_trie.c                    | 121 +++++++++++++++----------
 net/ipv4/sysctl_net_ipv4.c             |   7 ++
 4 files changed, 87 insertions(+), 48 deletions(-)

-- 
2.21.0

