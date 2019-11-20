Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B588C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180D420730
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MvfaECl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfKTR3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:29:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:54919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfKTR3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574270980;
        bh=UgR+It/V76InOK/x1+lwTWYHXazvddsP+10rGEOIdKk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MvfaECl6h0GDrTR83f7/Kepvd8cctinC6BT0qgdR0uBUn3EJdMhWAMgTj1h/1JQHQ
         BiuK4LTXik+xCO5+d+0ga/7o11N3kW6427HdU90stKh7MRw10WxpfVm3DVrILlCPY9
         o+gv33+wLFTKqptPoTpiB0imFLwMO3+jzqj6wtXc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.139]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7i8O-1hleY22aIM-014hqS; Wed, 20 Nov 2019 18:29:40 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH net 0/2] net: qca_spi: Fix receive and reset issues
Date:   Wed, 20 Nov 2019 18:29:11 +0100
Message-Id: <1574270953-4119-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:WU4xQdVJW206/BXl+fhWMXB7873LLAbAsvwYVH9GKFdSLzFUYxr
 XKpwU0xVSZ6cfs5zkNZ3xpO58q9z+0UI85Jn1rRP3lvC7HPrxp2s7n97Xj5fHAWV2UGe52g
 L3rPLTTnnr9pSTXQytmkTOdKjYMXnQZ04hjR0a1AF8swPplAQ2StnrqANWOlC5H+9cxlj49
 xejB8DH20MAb1SUwvSiRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J5PzE8RA9KQ=:f1Ao3dKro55lWTMHpZwLfz
 eA0isuIpTY3t1t5uTXn5kfmQhgZHV+FnEI+Uh9KWj48O4i87cOSbNUwZ/9hcPEuKlHLdLkOEb
 zF5aGKnk+eWC8YKBiwu9rhvgfzXxSIZ0qnNkjDQvcC4iSLoNwWVFePx6sToDd9HNsXaeQPt7A
 eG25WC/7HLZlICvZ40tgOT/iCtlCZNA0sAIARHiCh3co6vzpLsngD2BsNvwCFy/DqyuDTgB0N
 7aFWeIPns2+Cd68wlSwSwJpBUzYxBwOmKaD4qoPt5atH0bx0RfM//zNfm/dqfMXla7Jd6xoXT
 OwizJZBVL0z1MfAxH5vLa1Xn8r5VEMLzYZ3gD4Pr7/7M4zwOfjwQWTmi9650/Hiwh8NuFa8sD
 kbqj9wZg65lDTPCZLCCg8+RWD01/mLroIJWXKKchBebex4jhtmBondEcBYBKCXico8s4qoguL
 fKnmFJC7FMOUUN2lJ/UOZGMQnPwJLi7Kud/wTopLg/aWUCoD6rL+n67D3WWpUP0Q6yY5EPcCH
 9aH5j9c3KW22AxiK4EnFPZOm/aoDTt7JDxEl86xgodlTUvi6gFr5+lMK3Z5v6kyDEb0X8IAOr
 atl/4V6NXnTKPqp5/OCOVciYatBIWs0BKnYQfLorecwpRLJEjyqmdtWoasVX//OdBvRi0l2OV
 Ox164Un9WpQYy7aV9SWesy/bvSwCz+6A39sykI1PDlhPISDf8n7oBMBLnLIoIhSxhWnI6ZElq
 0mg7ILYUpAxCsSMwRDkMR5MNgxhp8ShNudH3YwhDmsdB1b/lZwc0eTUWONp/KVparKemDZfef
 0GGnkqsnK/yHzlGRyOZ3AOrU+S9zCYosGbQruXwQjTXMFekC1JO7u9s+rXDQ2Uuo9aw95Fjnu
 zAmi27hqEz9tLmYm3SyU6fzQ77bLlzlfGvaaslsU3moDz5aVHa5F/oN8HAEn482fy6N2gJSt8
 NFXisHpn0RSWOUExA0zC5uo/QYQ8HcNxhnUjuC7/l4l9AWFJ6JVr4WvuZTofa2lXRrVusO5Tg
 vxcQQ57JpaE/oPuSFiIPRDCzFvCMvl/r4QpxybFVln59oR4e+J0QkDFP1Xpkp7l2Mm/R5xf2S
 KoTYytJAiYwiXfyiFF6Vcv44VWv7ZI31sH1RVHJHgzOQhTTyWIa5J8rEhU2N3+xNuhps4lJIV
 HGgjEiMebfKnXLtSoG+eh0NegXg6xXrDpnsGSu+FbhRDqELBG5GxAQMGr9iAuJhqKx8L7ng3c
 2eUT1PCDsNhGsXPPRvlmUWccz2I1vHTfMr375KQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series fixes two major issues in the SPI driver for the
QCA700x.

It has been tested on a Charge Control C 300 (NXP i.MX6ULL +
2x QCA7000).

Michael Heimpold (1):
  net: qca_spi: fix receive buffer size check

Stefan Wahren (1):
  net: qca_spi: Move reset_count to struct qcaspi

 drivers/net/ethernet/qualcomm/qca_spi.c | 11 +++++------
 drivers/net/ethernet/qualcomm/qca_spi.h |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

=2D-
2.7.4

