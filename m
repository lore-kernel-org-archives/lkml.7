Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127AFCA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA13820869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="wlQlXCYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfKEILV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:11:21 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46025 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388074AbfKEILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:11:20 -0500
Received: by mail-lf1-f45.google.com with SMTP id v8so14336175lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 00:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xSFE4g0gY9czO8TwiEEGqsWaa81e8Ul+cCq6vuH+IA=;
        b=wlQlXCYO+/9EbApNjgMhjYp9wpSy75ZPuYAWB8VKQKBX7ARXR1OVtM58CSWg0CoQU5
         zxlf1du+2ubetE4QzVTTqJ7rA/hEW3tfRgbKNqUUphn7sxwvWKN+FW0yjcoW/ci4YsmL
         y3c7LU5tFYjt4UjzxyjTIJ+W2aWft+eBoQDUHYtlLeT1RppLXPiK/61eaI1IglOOh/IN
         KJefgymntKFYJZbccwXqXePOjo9Rh1XXv11BDb9QKGDMTFeaG/cbIjVnh3A7O152LqcG
         Abgha4kFeUQPqGC9aT6lKJyAw82Op9hjBwJbHV4D51QkLnjJLpyCFPykLSAfGupH7fZT
         v5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xSFE4g0gY9czO8TwiEEGqsWaa81e8Ul+cCq6vuH+IA=;
        b=LS+WvZ2hjCC+C4f3t4EOE1TnwIHF9/nxQdRJvdrYVhqY7LR/xDbHkLie5sEfX5SN2l
         k/D/Bd2n4ePKYPQYHbhbDF+K8dNTrKHmbtvxRX4tBBGr18JfuHH2BMD6wp4qbSY24sc4
         9M8BzWr+OWvLIT4zdRy7oCi1XDTjCwP+yQ/pQepnHHibp7kwasZTMU6GfnQJ8LWmIsK1
         60d5T3GV/ttrUriOcbQi8mGOhCaeOIKamfHKdbIsd2fluwz6fkLJ3R0luq1oJe7GLPhv
         0J3QU0Ff70kpYSdBGY8mkunCw9CUIpaEd6f7FmfxtEQ9PCCPdaDvtFJXdHEsgsVMqxuj
         E/1g==
X-Gm-Message-State: APjAAAWPnsgLTPk0Rlk9ye4ozws/t2SX7ihASeABoMBWmCRXkVZA7dHd
        edn4OvYG2TjckBqRlpQjdrJHUji5LwM=
X-Google-Smtp-Source: APXvYqy0cgx16CNi5YxZgqZqXkti4pby1AXyKJj0oZxklimaDslnxqWQgKMKxBaqMNz/fUaPppPd2Q==
X-Received: by 2002:a19:6a03:: with SMTP id u3mr17885682lfu.190.1572941478028;
        Tue, 05 Nov 2019 00:11:18 -0800 (PST)
Received: from mimer.lulea.netrounds.lan ([195.22.87.57])
        by smtp.gmail.com with ESMTPSA id m7sm7275986lfp.22.2019.11.05.00.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 00:11:17 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 0/5] Add namespace awareness to Netlink methods
Date:   Tue,  5 Nov 2019 09:11:07 +0100
Message-Id: <20191105081112.16656-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 net/ipv4/devinet.c       | 56 ++++++++++++++++++++--------
 3 files changed, 127 insertions(+), 27 deletions(-)

-- 
2.20.1

