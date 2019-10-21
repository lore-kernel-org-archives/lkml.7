Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6E32084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNA+lusW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfJUUJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:09:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42211 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730104AbfJUUJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571688595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GRr4vvR8SMLlGLaQHrzXZBP/1GJnG/hY1lt52vVZ3iU=;
        b=HNA+lusWzSNyDPsvdMdhutZeRQpA2g3INz4jDYerCmJm3OAE9Cx3K6tu1kGd2WwSICAcnL
        DAkL/RKZgNA/YOsld7hKMSEn1ZI1O2TWQd3W1morQ7yN36WlGYsO+QvfQKP1WEpWlXjqmU
        CzyTgeABKotVYuHhZdS5KazSndwPdyg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-4-B2IW-aN7CnmlOZGX--cg-1; Mon, 21 Oct 2019 16:09:54 -0400
Received: by mail-wr1-f69.google.com with SMTP id v8so6999289wrt.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hTnU2SL18HXqwrFfPhOqj3zVzoYeINRKnKQ1LCV8o0=;
        b=Zfuo4oBMh0Q7W01F0ssbhtOscp5Yuc2wkmKfw9uYoC+BdcjNSwPRWgTNJnwH2wjSfn
         WUfPzuCRzwt522RYuVsvK8KJ5MhwrzZc4O3aAJI8nANvtf2VE94EJPzpbhzf9sS0qY73
         6wCPUpsuePteYJZNMmQj5rm52+ijYSRcoxBq40CqNZBprQjAGHPgngyaNLRInTRX9hkm
         gFfz0MGypXPpPSsWFm0RZpJ9oTXu30VjolxsAf5kVfyC4Xh7iK6Zxwd7pcZe+Lz5pZU9
         GDIoTW3PEeezQnbRy5psAWUMcDv22MkLac/90krbShc/t4PlmSpjvDHBkTqI1ltGqQ1Y
         ob8Q==
X-Gm-Message-State: APjAAAUHnzrAWonSblCasbtjTIfECwkF8JpzwUiJ/faNpxO5/QSc0oN6
        eyhmygKhvmud7+d4rF5vFWaWjKGRj7kkp9zLZe4KxP6Djf+EwSb7CEXuBcyoXHfCQ2PJ170OLxq
        u6gOOw/lKlUYH/CcNiptAHNh7
X-Received: by 2002:a5d:5609:: with SMTP id l9mr55401wrv.113.1571688592859;
        Mon, 21 Oct 2019 13:09:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfmZR8HzPKtuiCjhCoyN0qzOEXt2OB3PSphHLqsNZCKo7B/TomBYT5P/XX6wfn6KR6i/zXPQ==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr55381wrv.113.1571688592582;
        Mon, 21 Oct 2019 13:09:52 -0700 (PDT)
Received: from turbo.teknoraver.net (net-109-115-41-234.cust.vodafonedsl.it. [109.115.41.234])
        by smtp.gmail.com with ESMTPSA id l18sm20701933wrn.48.2019.10.21.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:09:51 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller " <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] ICMP flow improvements
Date:   Mon, 21 Oct 2019 22:09:44 +0200
Message-Id: <20191021200948.23775-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: 4-B2IW-aN7CnmlOZGX--cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves the flow inspector handling of ICMP packets:
The first two patches just add some comments in the code which would have s=
aved
me a few minutes of time, and refactor a piece of code.
The third one adds to the flow inspector the capability to extract the
Identifier field, if present, so echo requests and replies are classified
as part of the same flow.
The fourth patch uses the function introduced earlier to the bonding driver=
,
so echo replies can be balanced across bonding slaves.

Matteo Croce (4):
  flow_dissector: add meaningful comments
  flow_dissector: skip the ICMP dissector for non ICMP packets
  flow_dissector: extract more ICMP information
  bonding: balance ICMP echoes in layer3+4 mode

 drivers/net/bonding/bond_main.c | 22 ++++++--
 include/net/flow_dissector.h    | 11 +++-
 net/core/flow_dissector.c       | 98 +++++++++++++++++++++++----------
 3 files changed, 95 insertions(+), 36 deletions(-)

--=20
2.21.0

