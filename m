Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156A0CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00792087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIwIy3Wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbfJ2NvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:51:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26859 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388802AbfJ2NvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572357064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Ptrz2Yswaus+WKDG/vA8NkrbE6i0FJ85P0xohydacQ=;
        b=bIwIy3WfalptrpmuhKEZawE1vJtp29PhYBB11AAHS1GoRejlawbrKM737MAe1OlQDUDfXz
        DMnkJz89lW7aJeozM5JYqgKS0/u7BPrMxJiuBbTsgvJyw34nCZ2lmGe+XsfKECgSIPZkdX
        LADtV05ZiuC6nhFr/4s0bZJ6ahNXuyQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-gah7qXDgP22w51ewU25bFw-1; Tue, 29 Oct 2019 09:51:00 -0400
Received: by mail-wm1-f72.google.com with SMTP id f2so882629wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlvxO01Z2Ul860RxIp3leF/YeqCFOTpWgj3ZwcjunwQ=;
        b=rnDbw+ipZxGCrh7zXPrkADlJq9b1kG85kshEoAkJDMx3Oh/ruoJ6yjkhVipTqiiWBQ
         OoBjxOqajSr+zcuOW04N5Jdpjl7kiZpgDuCltgKpAYVJnKnmtpKKedWptJoLus7HPAIT
         ykMpbMAeOzr6oRfD5OXCJPN1krVoM6CN41H0edlxp0iO4n1t0uQWM//IvUzuuPtgFjD4
         c5Mo0qyUeEZGQz3/T1wzjkliHym4K2dwkWfoCDstgXgz5UwO9c/ep7hWSON0LqW7TeXl
         6M1sm7n0mA7J4DcsWgubRMUxpuhR11Oq2+DRHr8RHi2dRgU2DaizXlpr4US3toXeeAaz
         C0rA==
X-Gm-Message-State: APjAAAUdMr9M+TLyhmzGt/h8GL7SgfHxCgS5cxS8wC7YLMeRQV26GBmU
        8Xfd+zh0yRBzkGRm0vnvDfPiUm2xG5xGeP4FeB1GRuFWeq9omrf5PlYCYYAJr/cSbIVKQVSfhvS
        WSQAsNSRTa1JhulSH+kkbOIon
X-Received: by 2002:a5d:4606:: with SMTP id t6mr19071451wrq.173.1572357059286;
        Tue, 29 Oct 2019 06:50:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxiNpbtiXQVaQtMbJhepi411mWyeAD9dyQuax48oQX25AnmundSwJpn6ZhYZJEjeyZL5wFNuA==
X-Received: by 2002:a5d:4606:: with SMTP id t6mr19071429wrq.173.1572357059102;
        Tue, 29 Oct 2019 06:50:59 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 189sm2556920wmc.7.2019.10.29.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:50:58 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/4] ICMP flow improvements
Date:   Tue, 29 Oct 2019 14:50:49 +0100
Message-Id: <20191029135053.10055-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: gah7qXDgP22w51ewU25bFw-1
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

v1 -> v2:
 - remove unused struct members
 - add an helper to check for the Id field
 - use a local flow_dissector_key in the bonding to avoid
   changing behaviour of the flow dissector

Matteo Croce (4):
  flow_dissector: add meaningful comments
  flow_dissector: skip the ICMP dissector for non ICMP packets
  flow_dissector: extract more ICMP information
  bonding: balance ICMP echoes in layer3+4 mode

 drivers/net/bonding/bond_main.c |  77 ++++++++++++++++++++---
 include/net/flow_dissector.h    |  20 +++---
 net/core/flow_dissector.c       | 108 +++++++++++++++++++++++---------
 3 files changed, 160 insertions(+), 45 deletions(-)

--=20
2.21.0

