Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1653FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D4920843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QmfZnkAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfDWF5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:57:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43802 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDWF5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:57:13 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190423055710epoutp02e10832f851d084811c328ee91028990e~YBN-meFHJ1654116541epoutp02C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:57:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190423055710epoutp02e10832f851d084811c328ee91028990e~YBN-meFHJ1654116541epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555999030;
        bh=unokxFsYm12DLWacHbDvzx0rtQCsvpjHpiIIu4fRcI0=;
        h=To:Cc:From:Subject:Date:References:From;
        b=QmfZnkAiM01hKkojR+WdlUcUs7I4iLEMDJ1UrsiZs/jIyAWwk6Wt/dYwOWtSg4Gut
         4CwRYiom7hPe+uGmz+0Klz/IKwYcXF311P07fYWkf9odgHal4ZZ/FhR49XNTOMUpmd
         ijMsyPbCKEtj09L/+OZW5K00H3jjPZ72dm4b2ulQ=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190423055707epcas1p496debf81b663c41ef6996b07ed5f8d03~YBN8Cpe9A2031920319epcas1p4_;
        Tue, 23 Apr 2019 05:57:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.ED.04257.139AEBC5; Tue, 23 Apr 2019 14:57:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190423055704epcas1p3698d02b077f2e75da943525437363840~YBN50tLCU0554805548epcas1p3B;
        Tue, 23 Apr 2019 05:57:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190423055704epsmtrp14d9e7abe230736902663a6dcdf24da14~YBN5y4hrE2983229832epsmtrp1R;
        Tue, 23 Apr 2019 05:57:04 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-b7-5cbea93149fc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.DA.03662.039AEBC5; Tue, 23 Apr 2019 14:57:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190423055704epsmtip1e5c1151ea335ff8326e61f676d1f0960~YBN5prrQ30308403084epsmtip1d;
        Tue, 23 Apr 2019 05:57:04 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.2
Organization: Samsung Electronics
Message-ID: <b3ff314f-194a-a8e1-b4f9-ef281cd9e577@samsung.com>
Date:   Tue, 23 Apr 2019 14:58:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTnc3fXq3Tra/k4CdW6EaTh3HWubvlAUmyZghBEhGY3vW7iXuxu
        kgWRaQ/FzAi1zEo0KcUwzF6ijaYlWUhgomXRSqGSHtDUpAe07Rr53++c8/t9v3POdyiZopaM
        oArNdsFm5o0MGUzc6Y9URbNtD7LV391B3NnxFwQ3NvNBzpW1dJLcSE8jyU2UXieT5bqu9gpS
        57zUEair7m5HOk/X6ixib1GCQeDzBZtSMOdZ8gvN+kRm567clFztJjUbzW7hNjNKM28SEpnU
        jKzotEKj15dRFvNGhzeVxYsiE5OUYLM47ILSYBHtiYxgzTdat1hVIm8SHWa9Ks9i2sqq1bFa
        L3F/kaG3vh5ZP4QcdD+lj6J3uBIFUYDjoO7rD1SJgikFvodg9stPuRR8RzA4NyOTgjkE/WXl
        Af8k8zWzpA8rcB8CjytZIn1DMD434ieF4A3w6dErwleQ4c8IHngq5L4CiaPA+XHcr17hJZUP
        1xI+vAyvhdH5SW8jFEXjJGipL/ClCbwejr0eQz4civfA28c3/c/QeDk8uTDll8pwOLyauhIg
        4TVw90ujv2vAAyRcq6pa6DoVLk70yiW8AqYHuwMlHAGfzpxYwIeh7ckAKYlPIeh2Pl8QaMDZ
        ei7A15wMR0JnT4xkthS+zlbJfWnANJw6oZDY62DE/WbBdiW0nKwgJayDjitTgdLicqDvoYeo
        QcqGReM0LBqnYdE4Df+NmxDRjsIEq2jSCyJrjVv82V3If5JR3D3UO5zhQphCzBK6aaIvWyHn
        i8USkwsBJWNC6J8FvdkKOp8vOSTYLLk2h1EQXUjr3fZZWURonsV74GZ7LquN1Wg0XBy7Scuy
        TDjdmZySrcB63i4UCYJVsP3TBVBBEUfR9vODtNrwa7dLX1KcWi2Y1CNXJ1Vhqw4cPl6TE1yr
        ed0ctOzIkKo5bG3L0sDIh9WP92e2tu04UvqsaKhuOKnsjtt+/7f+dvO20T+/Tk/jtBB3zs5b
        528UzkZlvkyf9jjn2OnquvgN0fvm3zttG3u4ibTy+LEZR0x6h7stoWPocvpNhhANPBsls4n8
        X6kJLOaoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSnK7Byn0xBjdXq1tMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GXumT2cseC5S8eA0bwPjQ4EuRk4OCQETiR8TvrKB2EICuxklljRIQsQlJaZdPMrcxcgBZAtL
        HD5c3MXIBVTyllFi7bppLCA1IgIaEi+P3mIBSTALvGGU6F+zhR0kwSagJbH/xQ2wocJARS3n
        poI18AsoSlz98ZgRZCivgJ3E4ulpIGEWAVWJpjvXGUFsUYEIiTPvV4CV8woISpyc+QTMZhZQ
        l/gz7xIzhC0ucevJfCYIW15i+9s5zBMYBWchaZmFpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiww
        ykst1ytOzC0uzUvXS87P3cQIDn0trR2MJ07EH2IU4GBU4uFdcHtvjBBrYllxZe4hRgkOZiUR
        3l9pe2KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MJbW
        W+6QWX/jf53ireWyBaumum/7ypKnvHrp59XaSjt+9IqeNC3eJuK4zdkt35TPV7/e/cbUhzv0
        OlgWZNfv3dsdzHZ6IXf2xeQOwYYGo80c5eq2z+MU0/RiF71kOf/q/D729RM/ft39aL4a5+aT
        3sd2NlgX/lDyZ5r0vuOznnbE7U1/L160/67EUpyRaKjFXFScCAAXblbveQIAAA==
X-CMS-MailID: 20190423055704epcas1p3698d02b077f2e75da943525437363840
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190423055704epcas1p3698d02b077f2e75da943525437363840
References: <CGME20190423055704epcas1p3698d02b077f2e75da943525437363840@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.2. I add detailed description of
this pull request on below. Please pull extcon with following updates.

[Detailed description for this pull request]
1. Add new extcon-intel-mrfld.c extcon provider driver
- On Intel Merrifield the Basin Cove PMIC provides a feature to detect
the USB connection type. This driver utilizes the feature in order
to support the USB dual role detection.

2. Update the extcon provider drivers
- For extcon-intel-cht-wc.c, make charger detection co-existed
  with OTG host mode and enable external charger.
- For intel extcon driver, add common header file (extcon-intel.h)
  in order to remove the duplicate definitions.
- For extcon-arizonal.c, disable microphone detection on driver removal.

3.
- Edit comment of extcon_unregister_notifer() to fix a build warning
- Add CONFIG_ACPI dependency to Kconfig to fix a build error for extcon-axp.c

Best Regards,
Chanwoo Choi


The following changes since commit 86baf800de84eb89615c138d368b14bff5ee7d8a:

  extcon: ptn5150: fix COMPILE_TEST dependencies (2019-04-05 10:08:37 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.2

for you to fetch changes up to 00053de52231117ddc154042549f2256183ffb86:

  extcon: arizona: Disable mic detect if running when driver is removed (2019-04-12 09:38:40 +0900)

----------------------------------------------------------------
Andy Shevchenko (2):
      extcon: intel: Split out some definitions to a common header
      extcon: mrfld: Introduce extcon driver for Basin Cove PMIC

Charles Keepax (1):
      extcon: arizona: Disable mic detect if running when driver is removed

Valdis Kletnieks (1):
      extcon: Fix build warning for extcon_unregister_notifier comment

Yauhen Kharuzhy (2):
      extcon: intel-cht-wc: Make charger detection co-existed with OTG host mode
      extcon: intel-cht-wc: Enable external charger

YueHaibing (1):
      extcon: axp288: Add a depends on ACPI to the Kconfig entry

 drivers/extcon/Kconfig               |   9 +-
 drivers/extcon/Makefile              |   1 +
 drivers/extcon/devres.c              |   2 +-
 drivers/extcon/extcon-arizona.c      |  10 ++
 drivers/extcon/extcon-intel-cht-wc.c |  81 ++++++++--
 drivers/extcon/extcon-intel-mrfld.c  | 284 +++++++++++++++++++++++++++++++++++
 drivers/extcon/extcon-intel.h        |  20 +++
 7 files changed, 389 insertions(+), 18 deletions(-)
 create mode 100644 drivers/extcon/extcon-intel-mrfld.c
 create mode 100644 drivers/extcon/extcon-intel.h
