Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9C0C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7753E2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfELGwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 02:52:04 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:12990
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfELGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 02:52:04 -0400
X-IronPort-AV: E=Sophos;i="5.60,460,1549926000"; 
   d="scan'208";a="305692769"
Received: from static.kpn.net (HELO hadrien) ([193.173.13.127])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 May 2019 08:52:00 +0200
Date:   Sun, 12 May 2019 08:51:59 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     =?ISO-8859-15?Q?Petr_=A6tetiar?= <ynezz@true.cz>
cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
Subject: drivers/of/of_net.c:64:2-8: ERROR: missing put_device; call
 of_find_device_by_node on line 57, but without a corresponding object release
 within this function. (fwd)
Message-ID: <alpine.DEB.2.21.1905120850400.3167@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1139231484-1557643920=:3167"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1139231484-1557643920=:3167
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hello,

You should drop the reference count on the value allocated with
of_find_device_by_node on line 57.

julia

---------- Forwarded message ----------
Date: Sun, 12 May 2019 10:20:42 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/of/of_net.c:64:2-8: ERROR: missing put_device; call
    of_find_device_by_node on line 57,
    but without a corresponding object release within this function.

CC: kbuild-all@01.org
CC: linux-kernel@vger.kernel.org
TO: "Petr Štetiar" <ynezz@true.cz>
CC: Felix Fietkau <nbd@nbd.name>
CC: John Crispin <john@phrozen.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8148c17b179d8acad190551fe0fb90d8f5193990
commit: d01f449c008a3f41fa44c603e28a7452ab8f8e68 of_net: add NVMEM support to of_get_mac_address
date:   6 days ago
:::::: branch date: 11 hours ago
:::::: commit date: 6 days ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/of/of_net.c:64:2-8: ERROR: missing put_device; call of_find_device_by_node on line 57, but without a corresponding object release within this function.
   drivers/of/of_net.c:68:2-8: ERROR: missing put_device; call of_find_device_by_node on line 57, but without a corresponding object release within this function.
   drivers/of/of_net.c:82:1-7: ERROR: missing put_device; call of_find_device_by_node on line 57, but without a corresponding object release within this function.
   drivers/of/of_net.c:87:1-7: ERROR: missing put_device; call of_find_device_by_node on line 57, but without a corresponding object release within this function.

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d01f449c008a3f41fa44c603e28a7452ab8f8e68
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout d01f449c008a3f41fa44c603e28a7452ab8f8e68
vim +64 drivers/of/of_net.c

3eb46a1da Sergei Shtylyov 2015-03-18  51
d01f449c0 Petr Štetiar    2019-05-03  52  static const void *of_get_mac_addr_nvmem(struct device_node *np)
d01f449c0 Petr Štetiar    2019-05-03  53  {
d01f449c0 Petr Štetiar    2019-05-03  54  	int ret;
d01f449c0 Petr Štetiar    2019-05-03  55  	u8 mac[ETH_ALEN];
d01f449c0 Petr Štetiar    2019-05-03  56  	struct property *pp;
d01f449c0 Petr Štetiar    2019-05-03 @57  	struct platform_device *pdev = of_find_device_by_node(np);
d01f449c0 Petr Štetiar    2019-05-03  58
d01f449c0 Petr Štetiar    2019-05-03  59  	if (!pdev)
d01f449c0 Petr Štetiar    2019-05-03  60  		return ERR_PTR(-ENODEV);
d01f449c0 Petr Štetiar    2019-05-03  61
d01f449c0 Petr Štetiar    2019-05-03  62  	ret = nvmem_get_mac_address(&pdev->dev, &mac);
d01f449c0 Petr Štetiar    2019-05-03  63  	if (ret)
d01f449c0 Petr Štetiar    2019-05-03 @64  		return ERR_PTR(ret);
d01f449c0 Petr Štetiar    2019-05-03  65
d01f449c0 Petr Štetiar    2019-05-03  66  	pp = devm_kzalloc(&pdev->dev, sizeof(*pp), GFP_KERNEL);
d01f449c0 Petr Štetiar    2019-05-03  67  	if (!pp)
d01f449c0 Petr Štetiar    2019-05-03  68  		return ERR_PTR(-ENOMEM);
d01f449c0 Petr Štetiar    2019-05-03  69
d01f449c0 Petr Štetiar    2019-05-03  70  	pp->name = "nvmem-mac-address";
d01f449c0 Petr Štetiar    2019-05-03  71  	pp->length = ETH_ALEN;
d01f449c0 Petr Štetiar    2019-05-03  72  	pp->value = devm_kmemdup(&pdev->dev, mac, ETH_ALEN, GFP_KERNEL);
d01f449c0 Petr Štetiar    2019-05-03  73  	if (!pp->value) {
d01f449c0 Petr Štetiar    2019-05-03  74  		ret = -ENOMEM;
d01f449c0 Petr Štetiar    2019-05-03  75  		goto free;
d01f449c0 Petr Štetiar    2019-05-03  76  	}
d01f449c0 Petr Štetiar    2019-05-03  77
d01f449c0 Petr Štetiar    2019-05-03  78  	ret = of_add_property(np, pp);
d01f449c0 Petr Štetiar    2019-05-03  79  	if (ret)
d01f449c0 Petr Štetiar    2019-05-03  80  		goto free;
d01f449c0 Petr Štetiar    2019-05-03  81
d01f449c0 Petr Štetiar    2019-05-03  82  	return pp->value;
d01f449c0 Petr Štetiar    2019-05-03  83  free:
d01f449c0 Petr Štetiar    2019-05-03  84  	devm_kfree(&pdev->dev, pp->value);
d01f449c0 Petr Štetiar    2019-05-03  85  	devm_kfree(&pdev->dev, pp);
d01f449c0 Petr Štetiar    2019-05-03  86
d01f449c0 Petr Štetiar    2019-05-03  87  	return ERR_PTR(ret);
d01f449c0 Petr Štetiar    2019-05-03  88  }
d01f449c0 Petr Štetiar    2019-05-03  89

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--8323329-1139231484-1557643920=:3167--
