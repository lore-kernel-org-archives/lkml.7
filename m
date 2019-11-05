Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8894CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02652053B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UJgROrTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfKEE4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 23:56:04 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35713 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKEE4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:56:04 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191105045559epoutp01c000093561afebdfb89cfe83546946f7~UK0hApMaN3218332183epoutp01V
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 04:55:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191105045559epoutp01c000093561afebdfb89cfe83546946f7~UK0hApMaN3218332183epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572929759;
        bh=Ytjp7wk0UhlcXLv1udNAWJDob+wMlvoJ1O86UtYOlYM=;
        h=To:Cc:From:Subject:Date:References:From;
        b=UJgROrTF0VT4NC57Mz9vGpLpZfTyW4wwQbGxfQrKYHopwmzEvnQA+3heFazTMVV5t
         feyIpG/r/PhiEpcXzIGYoj6+WMhsaclDWfdii7NH8mMrtjWhXt+83ZfJ/3a1IUTiSi
         RQS0hRxC6NyO5eFkr5CsSx5OiUd7riSw7vbprPx0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191105045558epcas1p4bca547e7d03b44fdabb802313e48e958~UK0gg2BuP1859818598epcas1p4B;
        Tue,  5 Nov 2019 04:55:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 476cn73KW8zMqYkm; Tue,  5 Nov
        2019 04:55:55 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.D1.04224.AD001CD5; Tue,  5 Nov 2019 13:55:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191105045553epcas1p3aeb81b122b12c40e93bc5768272e2ce1~UK0bYsViC1338813388epcas1p3C;
        Tue,  5 Nov 2019 04:55:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191105045553epsmtrp26c9ede3a644a5120d18d11c43779bd06~UK0bX3-tH2539125391epsmtrp2L;
        Tue,  5 Nov 2019 04:55:53 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-b3-5dc100da0de0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.72.25663.9D001CD5; Tue,  5 Nov 2019 13:55:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191105045552epsmtip10f519e0f560466763330aa804a1ee756~UK0bP2Oib2329523295epsmtip1X;
        Tue,  5 Nov 2019 04:55:52 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL v2] extcon-next for v5.5
Organization: Samsung Electronics
Message-ID: <ff758fcb-8ff9-4e87-9ee8-0247dcf686c1@samsung.com>
Date:   Tue, 5 Nov 2019 14:01:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3u9XsXZdZYdh6Reo9LQdtXpDLWiklX+IYQQ4bDrdtnEvdid
        0irIYeUrwh5EStLTR/ZQlqhpMp1FWFGZSekIBjXoaaVYUlBtu0r+951zvu/3nXN+h8Qkpwkp
        WWq0chYjq6eJULxnJFGWPLVsWCWbPR2iOPX6Ja6outpJKMb7LxAKt72d2IIrHR21hNLZfDNY
        ebK7AylnHasL8H1l2TqO1XCWOM6oNmlKjdocevee4m3F8gwZk8xkKTLpOCNr4HLo7fkFyXml
        ep8lHVfB6st9qQKW5+mNudkWU7mVi9OZeGsOzZk1enOWOYVnDXy5UZuiNhk2MTJZqtxH3F+m
        83jacLNdfODR/AxWicZC61AICVQ63Om5FVyHQkkJ1Ydg+mwnLgQzCCobry0EPxAcP/oKLUqc
        33uDhMIgApf9p0gIviI4NtAq8rNWUOvhw4OpgByjuhF8+tyH+wsElQTO968JP46kNsDk32+Y
        Hy+n4mFi/m3AQkzlgnPCG+Dg1BroGGv15UlyJbUXHs+xAiUCRhvfBZ7EqFUw9e6iSMCx0Pvl
        Aub3BeoeASMDzYTQ9nZw1DUECTgSPj7sDhawFGanBxc4h+D66H1CENcg6HY+XxCkgbPljMjf
        BEYlQmf/RiEdD3d/NyPBOBym504E+SlAiaHmuESgJMC4541IwNFwtbp2wUoJbu9d1IDim5aM
        07RknKYl4zT9N76E8A4UxZl5g5bjGXP60u92oMA9Jin60L2n+S5EkYgOE3+rHlJJgtgK3mZw
        ISAxeoV47PygSiLWsLaDnMVUbCnXc7wLyX3LPoVJV6pNvus2WosZeWpaWpoincmQMwy9Sry1
        rUUlobSslSvjODNnWdSJyBBpJWKG6q3znWZ2c2yqTe0eTSl5MRj+uMz+KFjraGkvqjqiczfa
        7TFtRV2H147V10XueNLq+NNeTRSqUL36oe1GjLeQaz6WZbt96Lc3I2/4ctcV19tz0aHumoJ1
        k1FPLw8PV4T1T8zUi0pUA65dmTs941J+iz4+4ddow7OISJVnXkPjvI5lkjALz/4DKvedLqUD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO5NhoOxBrsOs1pMvHGFxaJ58Xo2
        i8u75rBZ3G5cwebA4rFpVSebx/65a9g9+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+PBg+Us
        BY28Fad+fGJuYLzI1cXIySEhYCKx/+N21i5GLg4hgd2MElcunWGDSEhKTLt4lLmLkQPIFpY4
        fLgYouYto8T2zyfBakQENCReHr3FApJgFtjCKNE2aSYTSIJNQEti/4sbYEXCAtoSN/9/YAax
        +QUUJa7+eMwIYvMK2Ensv/oUrIZFQEVi1cVlYHFRgQiJ59tvQNUISpyc+YQFxGYWUJf4M+8S
        M4QtLnHryXwmCFteYvvbOcwTGAVnIWmZhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECA57La0djCdOxB9iFOBgVOLh/dB+IFaINbGsuDL3EKMEB7OSCO/FGXtj
        hXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTCmvpipflCz
        vDnR/tQJSe5w6/64uj61ojzdRfZBik1H66rW8dRXG54OZFc76m411bL/5FfOu0+lX+qsVSx8
        q9vyREmT9WHA+ffXu9OS5+9uSL808RQ705bbE9qqX8lH3Nu26ce8M4Ktdm9ubq6481I1nV30
        OeOSG3WSlvLVm9cqlblkH8tgmqfEUpyRaKjFXFScCAB4FiZPdwIAAA==
X-CMS-MailID: 20191105045553epcas1p3aeb81b122b12c40e93bc5768272e2ce1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191105045553epcas1p3aeb81b122b12c40e93bc5768272e2ce1
References: <CGME20191105045553epcas1p3aeb81b122b12c40e93bc5768272e2ce1@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.5. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Detailed description for this pull request:
1. Clean up the and fix the minor issue of extcon provider driver
- extcon-intel-cht-wc don't reset the USB data connection at probe time
  in order to prevent the removing all devices from bus.
- extcon-sm5502 reset the registers at proble time in order to
  prevent the some stuck state. And remove the redundant variable
  initialization.

Changes from v2 as following:
- add the missed patch title of this pull request

Best Regards,
Chanwoo Choi

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.5

for you to fetch changes up to ddd1bbbae486ff5913c8fc72c853dcea60713236:

  extcon: sm5502: remove redundant assignment to variable cable_type (2019-10-31 13:47:42 +0900)

----------------------------------------------------------------
Colin Ian King (1):
      extcon: sm5502: remove redundant assignment to variable cable_type

Stephan Gerhold (1):
      extcon: sm5502: Reset registers during initialization

Yauhen Kharuzhy (1):
      extcon-intel-cht-wc: Don't reset USB data connection at probe

 drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
 drivers/extcon/extcon-sm5502.c       |  6 +++++-
 drivers/extcon/extcon-sm5502.h       |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)
