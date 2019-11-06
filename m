Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE3C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE022084C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="Lpn0EaXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfKFFja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:39:30 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39589 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfKFFj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:39:29 -0500
Received: by mail-lf1-f48.google.com with SMTP id 195so16982519lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 21:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHIf5mDgZLljmFUkOq24Gp9TCbOM9O3cWPqt9cOVGZ8=;
        b=Lpn0EaXP7QQ2PPid317+Zmtpz4I05Prd/oE0N7JbiAUP02AFeP7k0qv11Kb/1/zF9X
         tM9vBjnczPDzcydBssC0xmyStZ1Ru0ZPkFVDdYwQEFjBWpjsmF1N57OGiRbYQhASQeXJ
         Zkp2HV99KLf59yquoHDT4Z9zSoIRvCi+OYAOisLwNV94PKYgkVpqcHxhUY0FCiaybkD8
         6MKTzl7w00KErFvhGVKXU3bNq9cSyQkQ4ElAj1Y58mAfpdN1sQbe8kL4s64j10zB7f1x
         UtnDg2qzKgx1bMtX0UY/DvoRUt5rUeg7mKyEzRfPIrFTp23Evt6YIQOe0oNBfGcNIX6R
         HE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHIf5mDgZLljmFUkOq24Gp9TCbOM9O3cWPqt9cOVGZ8=;
        b=jkNkbCsnofGKFFZdBU4bwxG3eBAQjJYgY+bnrhko9lrhm+q+VODF3/sJI25QDNL/at
         b+bbw8TQx5/TNqbMB324A+Wl8NZWI1dIsCIuj1KRS0gxXKO0jwHY99SF7CxvuYaxi1KG
         zzz0/QnH85k46mGMn7iIDH9AFQ8qZVW/2nVa14Hac4X9AwvfjrsGQkFZ9srTWsPWmVCB
         GRiJ7SsNde4Ta0cgkj1PcIFgPpL71yTsui+B1QsjWSXCcK/0PK2oHHzqLt+K2FbEY7yn
         6c5jlBNupaob0tTVOhjvmGvnusKtrR/4s61oVNB4uWL5/gV1+DniE1crcv5SePIzO1NP
         Ql6g==
X-Gm-Message-State: APjAAAUCO8d6AoFzqTIRq2QASPnkchuMUS7q/vxnp732hWRkLaHCPkZ5
        /pxMfs5l6ozX5XbojRVfkpJjPw==
X-Google-Smtp-Source: APXvYqw9LhBoyZ+T7F0ttWVowqdJU54xLZJ1xtS3yNseyOPCBT0Vl/GT/5OZF2Jqps3IA8wel5FbyA==
X-Received: by 2002:ac2:44a9:: with SMTP id c9mr6517246lfm.26.1573018767595;
        Tue, 05 Nov 2019 21:39:27 -0800 (PST)
Received: from mimer.lan (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id c22sm754737ljk.43.2019.11.05.21.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 21:39:26 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 0/5] Add namespace awareness to Netlink methods
Date:   Wed,  6 Nov 2019 06:39:18 +0100
Message-Id: <20191106053923.10414-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed in v2:
- address comment from Nicolas
- add accumulated ACK's

Currently, Netlink has partial support for acting outside of the current
namespace.  It appears that the intention was to extend this to all the
methods eventually, but it hasn't been done to date.

With this series RTM_SETLINK, RTM_NEWLINK, RTM_NEWADDR, and RTM_NEWNSID
are extended to respect the selection of the namespace to work in.

/Jonas

Jonas Bonn (5):
  rtnetlink: allow RTM_SETLINK to reference other namespaces
  rtnetlink: skip namespace change if already effect
  rtnetlink: allow RTM_NEWLINK to act upon interfaces in arbitrary
    namespaces
  net: ipv4: allow setting address on interface outside current
    namespace
  net: namespace: allow setting NSIDs outside current namespace

 net/core/net_namespace.c | 19 ++++++++++
 net/core/rtnetlink.c     | 79 ++++++++++++++++++++++++++++++++++------
 net/ipv4/devinet.c       | 58 +++++++++++++++++++++--------
 3 files changed, 129 insertions(+), 27 deletions(-)

-- 
2.20.1

