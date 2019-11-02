Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4BBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BDF208CB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekUsmwbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfKBAMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:12:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727806AbfKBAMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572653534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3a8267M+RHJNRr07VE5ml30G5v7tWW7jIUnKYNL4CMo=;
        b=ekUsmwbKf6jrFZ/2TM+ZxaxFyAIm+fQ9bClpQI7RZ2sGpbZNtNeS5/HHrHtbMJZSLacqma
        iAPvcnO/z0Kvf4PsVhZNi1fRypScuBdxpB4XNHA2qDi82YufZufXOvc7wxpop4y/giSMAV
        n6DXhfWyLPPA1Zv8Blqq4u8QpOJJhHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-kKyKaigINz67XtZJy_eMew-1; Fri, 01 Nov 2019 20:12:11 -0400
Received: by mail-wm1-f71.google.com with SMTP id b10so4859315wmh.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VX6BMhZnxFI/3YJV1VoE+a6y4VVLv+nOV4fd/3YTNIk=;
        b=DnFsW9KT84lWKz5OUOuJqlycgZKhRYrXd6lujVh72epP5082lPIdA95HgOsolAXAIN
         0XNgrBinP7FIdByyHEAvZOJh3mZEfryRdK4I4ApGt8OaoOgdsfOJfMXB1yQQvf+1EfK/
         JaBqKVAlosDJ0Jbwxcs2UVWl3c9Xr/J8nVKl2YZbW0mcqTx0ncILwkAKFvv35jlnaDIa
         J+eL5JJzg3bj5a8vozjCG+hWb6ZDaxn8rMOpT3TvEkiY75DaxB2xB3B8fN+GzVACf6ua
         q+ScIRy2rXTAFz9/jObvX9IwUrm1CweQKwjbxktMj2PNDvj8D0D2XaHKoMbyeyPiK6/u
         SkMg==
X-Gm-Message-State: APjAAAXy4zIdyZhCG5KGip54cHZF/b6JYHH1H1vJDI+91PiUUE4M4gpm
        hKuQ5KmGJ1SYM6sTPx3Uo4+M96c90GYGgQ0IL0fSXVeIfoCsF3GinWz2ZShjKWjN4/Pv+RDQZ5j
        /tI5QQaPlz1sfsDF/3NMDpi7P
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr12489849wme.152.1572653530238;
        Fri, 01 Nov 2019 17:12:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4oLNGypYFr8/Qg3GXixLBynH2wHCRqp7hWXE77wgSMGttnht7B+mbeCcRpbJfTfqxa6l+UQ==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr12489834wme.152.1572653530002;
        Fri, 01 Nov 2019 17:12:10 -0700 (PDT)
Received: from raver.teknoraver.net (net-109-115-41-234.cust.vodafonedsl.it. [109.115.41.234])
        by smtp.gmail.com with ESMTPSA id a16sm13654781wmd.11.2019.11.01.17.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:12:09 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] icmp: move duplicate code in helper functions
Date:   Sat,  2 Nov 2019 01:12:02 +0100
Message-Id: <20191102001204.83883-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: kKyKaigINz67XtZJy_eMew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some duplicate code by moving it in two helper functions.
First patch adds the helpers, the second one uses it.

Matteo Croce (2):
  icmp: add helpers to recognize ICMP error packets
  icmp: remove duplicate code

 include/linux/icmp.h                    | 15 +++++++++++++++
 include/linux/icmpv6.h                  | 14 ++++++++++++++
 net/ipv4/netfilter/nf_socket_ipv4.c     | 10 +---------
 net/ipv4/route.c                        |  5 +----
 net/ipv6/route.c                        |  5 +----
 net/netfilter/nf_conntrack_proto_icmp.c |  6 +-----
 net/netfilter/xt_HMARK.c                |  6 +-----
 net/sched/act_nat.c                     |  4 +---
 8 files changed, 35 insertions(+), 30 deletions(-)

--=20
2.23.0

