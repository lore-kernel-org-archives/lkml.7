Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5136BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DC72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RXf/SFfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF1BaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:30:20 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45787 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfF1BaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:30:20 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190628013017epoutp0429f98fcca1e93b26f029dfaccff75c5f~sOJzvm6bk2092920929epoutp04K
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:30:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190628013017epoutp0429f98fcca1e93b26f029dfaccff75c5f~sOJzvm6bk2092920929epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561685417;
        bh=ffnQ15nGob+u1jxBjPgSlbpYxPywcFIA5tLlnd806EI=;
        h=To:Cc:From:Subject:Date:References:From;
        b=RXf/SFfjPYjMEqyMBJKYX8xkXSSlqDtX2mA/KL4KAH1dDYI7vliMuaivAl0FVSYpW
         20Kx0ZOiquJAfzjsh/lHFyD2NC3vkMBwpdL2xDek5k618aUQNjKzcsiYscv9crUXIT
         zwwuqIZSG7NjaJP1eShOGo5TKHMmDuZskfojuFkQ=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628013013epcas1p17597943468463b771722d5313fc5513c~sOJwDFxVS2609926099epcas1p1G;
        Fri, 28 Jun 2019 01:30:13 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.D9.04108.F9D651D5; Fri, 28 Jun 2019 10:30:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190628013007epcas1p405af6ef75a8164072459694c2b17385a~sOJqWN6Xa1800218002epcas1p4k;
        Fri, 28 Jun 2019 01:30:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190628013007epsmtrp2635607a45265cad3d2c410064ff63e5e~sOJqVZ5uM2300923009epsmtrp2M;
        Fri, 28 Jun 2019 01:30:07 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-fc-5d156d9f6dca
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.9B.03662.F9D651D5; Fri, 28 Jun 2019 10:30:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190628013007epsmtip158e7267c172cae93daacd4b399efb9cc~sOJqMsUqN2343323433epsmtip1i;
        Fri, 28 Jun 2019 01:30:07 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.3
Organization: Samsung Electronics
Message-ID: <d312e5b6-3faf-ad5e-fc2e-c6f8b09ea9ec@samsung.com>
Date:   Fri, 28 Jun 2019 10:32:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmru6CXNFYgx91FhNvXGGxuP7lOatF
        8+L1bBaXd81hs7jduILNgdVj06pONo/9c9ewe/RtWcXo8XmTXABLVLZNRmpiSmqRQmpecn5K
        Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBaJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xqfHDawFb/gqOruesTUw
        3ubuYuTkkBAwkdj6ZDZ7FyMXh5DADkaJzu55jBDOJ0aJc49PsEI43xgl7p78xwbTcuTFQajE
        XkaJrfe2M0M47xklmh7fB6sSEdCQeHn0FgtIglngDaPEvs+drCAJNgEtif0vboAVCQMVvTp9
        CszmF1CUuPrjMSOIzStgJ3F76x92EJtFQFXi1extTCC2qECExOUtu6BqBCVOznzCAmIzC4hL
        3HoynwnClpfY/nYO2EUSAgfYJDbeaAZKcAA5LhJrlppDvCAs8er4FnYIW0ri87u9UK9VS6w8
        eYQNoreDUWLL/gusEAljif1LJ4PNYRbQlFi/Sx8irCix8/dcRoi9fBLvvvawQqzilehoE4Io
        UZa4/OAuE4QtKbG4vZMNosRDomN+6QRGxVlInpmF5JlZSJ6ZhbB3ASPLKkax1ILi3PTUYsMC
        U+TY3sQITpJaljsYj53zOcQowMGoxMOrsFMkVog1say4MvcQowQHs5IIr+Q5oBBvSmJlVWpR
        fnxRaU5q8SFGU2BYT2SWEk3OBybwvJJ4Q1MjY2NjCxNDM1NDQyVx3njumzFCAumJJanZqakF
        qUUwfUwcnFINjN41mutar7y5G8nn39XLmsInE3Ru0dfko6/P3H4nYcrzNEbQf73g1y2aB2TC
        Mi+UPQ041jpz0odNR3meP88Quci/b22w8XPXJk4x7dmZYW9U+vq+2DD4JebUnulq8r9WvPLr
        h7b5nrN0Nzie23wyt2pZhuH2VrcKHlvhudpTjO54isQyn08xUWIpzkg01GIuKk4EADmnL5mo
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO78XNFYg+0bhC0m3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jE+PG1gL3vBVdHY9Y2tgvM3dxcjJISFgInHkxUHWLkYuDiGB3YwS++atYIRISEpMu3iUuYuR
        A8gWljh8uBii5i2jxLQzJ8FqRAQ0JF4evcUCkmAWeMMo0b9mCztIgk1AS2L/ixtsILYwUNGr
        06fAbH4BRYmrPx6DNfMK2Enc3voHrJ5FQFXi1extTCC2qECERF/bbDaIGkGJkzOfsIDYzALq
        En/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj4CwkLbOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVG
        eanlesWJucWleel6yfm5mxjBEaCltYPxxIn4Q4wCHIxKPLwKO0VihVgTy4orcw8xSnAwK4nw
        Sp4DCvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamBsl2r+
        96nSxkx2m275hSTNRWKNb2ZPcSuaVR0sVus0Z7O1/dz1kh63Ox1UhFef2s5p8//1kr0rraRX
        ilXU88w3VA9fsC0gMEKq8mTImWiD//6N++ZrZEXnJSqLJQRonAwI3OOS5W359Id18HupVYs+
        fHjZ0M1f6/0k0c3+jMmKs6EsXGsu7VFiKc5INNRiLipOBACzWXR+fAIAAA==
X-CMS-MailID: 20190628013007epcas1p405af6ef75a8164072459694c2b17385a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190628013007epcas1p405af6ef75a8164072459694c2b17385a
References: <CGME20190628013007epcas1p405af6ef75a8164072459694c2b17385a@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.3. I add detailed description of
this pull request on below. Please pull extcon with following updates.

[Detailed description for this pull request]
1. Add new extcon-fsa9480 extcon provider driver
- It is extcon provider driver for Fairchild Semiconductor
FSA9480 microUSB switch and accessory detector chip which
detects the kind of external connector like usb, charger,
audio, video and so on.

2.
- Add the exception handling code for extcon-arizona.c
when using the regmap interface.

Best Regards,
Chanwoo Choi


The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.3

for you to fetch changes up to 0937fbb7abeb165ef0ac6a56a3a6f041eca6dbde:

  extcon: fsa9480: Fix Kconfig warning and build errors (2019-06-26 17:27:39 +0900)

----------------------------------------------------------------
Charles Keepax (1):
      extcon: arizona: Correct error handling on regmap_update_bits_check

Randy Dunlap (1):
      extcon: fsa9480: Fix Kconfig warning and build errors

Tomasz Figa (2):
      dt-bindings: extcon: Add support for fsa9480 switch
      extcon: Add fsa9480 extcon driver

 .../devicetree/bindings/extcon/extcon-fsa9480.txt  |  19 +
 drivers/extcon/Kconfig                             |  12 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-arizona.c                    |  33 +-
 drivers/extcon/extcon-fsa9480.c                    | 395 +++++++++++++++++++++
 5 files changed, 447 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
 create mode 100644 drivers/extcon/extcon-fsa9480.c
