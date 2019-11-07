Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0129F2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="o9DFkbSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbfKGN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:28:01 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:46264 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:28:00 -0500
Received: by mail-lf1-f53.google.com with SMTP id 19so1574835lft.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=otw/LMNaCwhQgMmtphcj9FWjbVudliiaHCPb5fKJ7oY=;
        b=o9DFkbSgfcONILRXfz2vEJwroONNdr/qnLpSEg2Ki5GZW3ZAp2fGK9f8iEMBkObjtI
         A784rbh5Zdb1R3CbMZr2gn4z2+F4iqs/B3zgPUJtzq5xDr2rsTzs+k2Sn49S7kEjjUlI
         /shcDaMltMxTtRhx3q8jtyAcOtl3TZWRlG2dDVXn6SzAuOlSkd6IHy/e2IxX+6lsewtk
         jov5+9zUPw5WgkfEKzByYoRLz2JwIRYBJUYeyTSN9DQ3SvGreYzpHxXGVYARg7/noQBK
         eOmeS9qKO6cjBQy7S4HM2SxsdBG4m1YHEIj1F52RmqHV581u+CqH5vrnFDKq4tIYd3r0
         97pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=otw/LMNaCwhQgMmtphcj9FWjbVudliiaHCPb5fKJ7oY=;
        b=GIMv7/kZ36DiIAq7QjbJHDkvC/uiwk0wlJb+i+hGafxJJ9yxpf9Gf+J6tZE6R9vQtz
         LfSgKkZa1Xm5R76zkcpehq8oY2o37ZyLE2NL2rKHTaA4IO+V+9a3EBwThZoI6nXfXFx+
         YECqzIfvAQa9eEdp1npxxXEzTafiLhARPMVkdB0uXfIP5tqOedMYHvi6c4hx48v45NTi
         PAMC5LVlvVfrKg57DjT4105xhW3azw/wXCyVct8sMXhOzmlN7lUlthxkmm8835Btxchk
         LKAOCDqbQTCnB3GYOEScuhjs8vnbTfRGTexmxZtYkCEo9CedOz76tJs79ms7DxEarwAS
         o/SQ==
X-Gm-Message-State: APjAAAX5gfdEL+z4crGqWZVh9KEKgBAzj8MekLWDfqHxaWQ9mW4E1ziK
        3tVq/P+t402cBcGMHR14b0P4K0BEt/o=
X-Google-Smtp-Source: APXvYqwBOahQPdDfqFrzvyNe/0wXA1CuMAdtA0EO4BM/bJ3R2ViH1fJ6lzXjluZp9R3Joi1oXI7/AQ==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr2456723lfc.153.1573133278543;
        Thu, 07 Nov 2019 05:27:58 -0800 (PST)
Received: from mimer.lan (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id y20sm3151507ljd.99.2019.11.07.05.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:27:57 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 0/6] Add namespace awareness to Netlink methods
Date:   Thu,  7 Nov 2019 14:27:49 +0100
Message-Id: <20191107132755.8517-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed in v3:
- added patch 6 for setting IPv6 address outside current namespace
- address checkpatch warnings
- address comment from Nicolas

Changed in v2:
- address comment from Nicolas
- add accumulated ACK's

Currently, Netlink has partial support for acting outside of the current
namespace.  It appears that the intention was to extend this to all the
methods eventually, but it hasn't been done to date.

With this series RTM_SETLINK, RTM_NEWLINK, RTM_NEWADDR, and RTM_NEWNSID
are extended to respect the selection of the namespace to work in.

/Jonas

Jonas Bonn (6):
  rtnetlink: allow RTM_SETLINK to reference other namespaces
  rtnetlink: skip namespace change if already effect
  rtnetlink: allow RTM_NEWLINK to act upon interfaces in arbitrary
    namespaces
  net: ipv4: allow setting address on interface outside current
    namespace
  net: namespace: allow setting NSIDs outside current namespace
  net: ipv6: allow setting address on interface outside current
    namespace

 net/core/net_namespace.c | 19 ++++++++++
 net/core/rtnetlink.c     | 80 ++++++++++++++++++++++++++++++++++------
 net/ipv4/devinet.c       | 61 ++++++++++++++++++++++--------
 net/ipv6/addrconf.c      | 13 +++++++
 4 files changed, 145 insertions(+), 28 deletions(-)

-- 
2.20.1

