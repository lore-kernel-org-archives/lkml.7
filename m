Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 02:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF0120815
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 02:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UGVdj8ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfHZCvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 22:51:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:31758 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHZCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 22:51:17 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190826025114epoutp034a84c094af1eaad22433998387ecd230~_WUU3xTT61778317783epoutp03M
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:51:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190826025114epoutp034a84c094af1eaad22433998387ecd230~_WUU3xTT61778317783epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566787874;
        bh=nJT9JjNe62VH/W5HebbQtRSJS4FKLArq4z/vc8ZlJBg=;
        h=To:Cc:From:Subject:Date:References:From;
        b=UGVdj8nelSDfHX0/Jy+oTfr1nQ0uSVTrMtC9IDfdvsCMVQuifNqRMXaxNwBp7Lqu3
         VjMNf05ovo9QXHO0kkEqQiIHJa444iBHDnVfwNtYcBISihn/RubAhIGFp4ufz+xZHl
         +u/scBMiOpQ8fCr2oVd3Z7JiT/NEQQ06sJoW2M4Y=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190826025113epcas1p1aa112a82d8551aa1333e258eb8fff5ae~_WUUUJIHF1594315943epcas1p1n;
        Mon, 26 Aug 2019 02:51:13 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46GxMy3pVLzMqYkb; Mon, 26 Aug
        2019 02:51:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.78.04085.E19436D5; Mon, 26 Aug 2019 11:51:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190826025109epcas1p2add5354e4989028cd942b2121447dfd8~_WUQ3kt_62375723757epcas1p2c;
        Mon, 26 Aug 2019 02:51:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190826025109epsmtrp23aafd0a78a21f2747266ceaa1170b030~_WUQyRXst1231212312epsmtrp2A;
        Mon, 26 Aug 2019 02:51:09 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-11-5d63491e56e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.41.03706.D19436D5; Mon, 26 Aug 2019 11:51:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190826025109epsmtip2ddddf4169ac3d33b4b6f4c189d9e0c37~_WUQIKZu41975419754epsmtip2Y;
        Mon, 26 Aug 2019 02:51:09 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.4
Organization: Samsung Electronics
Message-ID: <4c61ce13-69c7-f6ce-ae37-722f370371f4@samsung.com>
Date:   Mon, 26 Aug 2019 11:55:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmvq6cZ3Kswfqt8hYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbcVWfYC04LV6w93sXW
        wLicv4uRk0NCwERi6oPlzF2MXBxCAjsYJX693MIK4XxilHiw7zELhPONUeLg9CNsMC2P531h
        gkjsZZR4OXEiE0hCSOA9o0T3AqBZHBwiApkS71rBapgFVjNK7P9xihmkhk1AS2L/ixtgg4QF
        NCQ+NJ1jAbH5BRQlrv54zAhi8wrYSTw6fh6snkVAVeL07Ytg9aICERKfHhxmhagRlDg58wlY
        L7OAuMStJ/OZIGx5ie1v54D9IyFwgE3ix/cPzBBXu0gsv3WXEcIWlnh1fAs7hC0l8fndXqjP
        qiVWngT5EqS5g1Fiy/4LrBAJY4n9SyczgXzGLKApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ
        4JXoaBOCKFGWuPzgLhOELSmxuL0TapWHxIEpnYwTGBVnIXlnFpJ3ZiF5ZxbC4gWMLKsYxVIL
        inPTU4sNC0yRY3sTIzhNalnuYDx2zucQowAHoxIPr0BuYqwQa2JZcWXuIUYJDmYlEd4cfaAQ
        b0piZVVqUX58UWlOavEhRlNgaE9klhJNzgem8LySeENTI2NjYwsTQzNTQ0Mlcd6FPyxihQTS
        E0tSs1NTC1KLYPqYODilGhhXLFEwEVG+lrg7bt7Dpj2HzI7Kss+QX9pZWxm05P1SaSPJHCVN
        zXWiQdx8G099kKru6HTeMPO8i05LyPM1/1eH5K7l5KgLv5/rzcn0eauZyaxKn8eZa26uv9sQ
        Zp92rmaKzdEXVsfWKT39pNtn/mdZU3jPHx4+IfZOxk8bnx9+MsM5Iv2dyXYlluKMREMt5qLi
        RADL9iCPqQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK6sZ3KswfJDPBYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        xtxVZ9gLTgtXrD3exdbAuJy/i5GTQ0LAROLxvC9MXYxcHEICuxklFh86wgaRkJSYdvEocxcj
        B5AtLHH4cDFEzVtGicvXpzGC1IgIZEpM7NjCCpJgFljNKPF0+S12kASbgJbE/hc3wAYJC2hI
        fGg6xwJi8wsoSlz98RismVfATuLR8fPMIDaLgKrE6dsXwepFBSIkDu+YBVUjKHFy5hOwXmYB
        dYk/8y4xQ9jiEreezGeCsOUltr+dwzyBUXAWkpZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMC
        w7zUcr3ixNzi0rx0veT83E2M4AjQ0tzBeHlJ/CFGAQ5GJR7eHVmJsUKsiWXFlbmHGCU4mJVE
        eHP0gUK8KYmVValF+fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwhjz5
        tHibcWTm/mv2T/YstLQP1+Jy8fBvP5jMFbjjgMtZ9/miPfMWXGZ0FxH0ubY12Xk56/d7nns9
        zkvM170QeWymsITHZY0U1q/WRbd7tZM+BEs1zljdYjr7XNqPd+GzTq8+dtyjR9PL+b2AhuzM
        rM/vZO6z98fdWPD5ewnLquXXDixYveXEJCWW4oxEQy3mouJEAAS+yhZ8AgAA
X-CMS-MailID: 20190826025109epcas1p2add5354e4989028cd942b2121447dfd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190826025109epcas1p2add5354e4989028cd942b2121447dfd8
References: <CGME20190826025109epcas1p2add5354e4989028cd942b2121447dfd8@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.4. I add detailed description of
this pull request on below. Please pull extcon with following updates.


Detailed description for this pull request:
1. Clean up the and fix the minor issue of extcon provider driver
- extcon-arizona/max77843 replace the helper function
  with more correct helper function without operation changes.
- extcon-fsa9480 supports the FSA880 variant by adding the compatible name.
- extcon-arizona updates the dt-binding file for the readability.
- extcon-gpio initializes the interrupt flags according to active-low state.
- Clean up extcon-sm5502/axp288/adc-jack

Best Regards,
Chanwoo Choi


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.4

for you to fetch changes up to a3fc5723397703a56fb6083b3e2f2ac601d1dfe0:

  extcon: adc-jack: Remove dev_err() usage after platform_get_irq() (2019-07-31 09:55:46 +0900)

----------------------------------------------------------------
Andy Shevchenko (3):
      extcon: arizona: Switch to use device_property_count_u32()
      extcon: axp288: Add missed error check
      extcon: axp288: Use for_each_set_bit() in axp288_extcon_log_rsi()

Charles Keepax (1):
      extcon: arizona: Update binding example to use available defines

Linus Walleij (2):
      extcon: fsa9480: Support the FSA880 variant
      extcon: gpio: Request reasonable interrupts

Stephen Boyd (1):
      extcon: adc-jack: Remove dev_err() usage after platform_get_irq()

Vasyl Gomonovych (1):
      extcon: sm5502: Add IRQ_ONESHOT

Wolfram Sang (1):
      extcon: extcon-max77843: convert to i2c_new_dummy_device

 .../devicetree/bindings/extcon/extcon-arizona.txt  |  2 +-
 .../devicetree/bindings/extcon/extcon-fsa9480.txt  |  4 ++-
 drivers/extcon/extcon-adc-jack.c                   |  4 +--
 drivers/extcon/extcon-arizona.c                    |  2 +-
 drivers/extcon/extcon-axp288.c                     | 16 ++++++------
 drivers/extcon/extcon-fsa9480.c                    |  1 +
 drivers/extcon/extcon-gpio.c                       | 29 ++++++++++++++--------
 drivers/extcon/extcon-max77843.c                   |  6 ++---
 drivers/extcon/extcon-sm5502.c                     |  2 +-
 9 files changed, 39 insertions(+), 27 deletions(-)
