Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77506C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4957F206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="AhGntN+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJGUaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:30:20 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:30153 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGUaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570480221; x=1602016221;
  h=mime-version:from:date:message-id:subject:to;
  bh=WZdJ9Jb3KxHxJBtuOx83LGJHR6vLyDJ32s1vBewrsBg=;
  b=AhGntN+ifOjhcgNpLNBKv/p5SX07l4mSh1WkJGF8XctDyOLpXckH/K8e
   PreMGSEVX7AEVloLXyTHxLe8rJtbN0R13TkbjLDyACFIj8lQmgZ+D9uLZ
   GpkNkU3K3Ef63PD7150+PVlRveoelzWlAFhsyPOCC0CH3nko5RwEbIMos
   cPZb/50Lu8Ey1a+CFlkCuZxGM2LvolQ0lhKL5fezXDd8akudV8KxJJJuk
   EsTxdTQKxQgyihrOjuYO2NHYRgXFeDQi9LSxU71TVyy0/ROK0cyRjAhYh
   Zp5+FcLG7Qm5XwRmdfMMjYbjQKUDQx8kgkvSSVJEU7dCensLVwfgLqHFm
   g==;
IronPort-SDR: UlH8kVkuLPrYup5JLTUiyeyx5TZyHwHUFhURdTxKZrN8BeVFw/xPBbuTnJaWEF4NdhrE++aiod
 /1X9dA3rpzpLPfmdJdi5JZGUsPVRhBY/VZgaVWBDkuNSsBAUvazhAtZ/SlXe2+LX0Q/6EqFN75
 M6+QynNZITqYd97sgA/w5VZsGl38D0O/htyIXAWZ7IX+VuP8zeffyoNeYZ6NGMQ885r0Ir0Tgq
 XKPe1h7yQN0ZDFTYSTVG4PRBaod2nulUSGSP8v0iPApu+ukcR26EeW+tynqTbeQguDBC3Ne63a
 x0s=
IronPort-PHdr: =?us-ascii?q?9a23=3AZVLMrBSQG05u4ORPz1i2Tmb41tpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYRON2/xhgRfzUJnB7Loc0qyK6vumBDNLuM3f+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLtsQbg4RuJrs/xx?=
 =?us-ascii?q?bIv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4ihbYUAEvABMP5XoIf9qVUArgawCxewC+701j9EmmX70bEm3+?=
 =?us-ascii?q?g9EwzL2hErEdIUsHTTqdX4LKUdUeG0zanI0DXDaO5d1jT96IfScxAqvPaBXL?=
 =?us-ascii?q?JxcMrR00YvFh/JgkmepIH+IjOayv4Nv3KF4OV9SOKikmgqoBxyrDi33soglJ?=
 =?us-ascii?q?XFi4YPxl3H9Sh12ps5KNy6RUJhYNOpFJ1dvDyAOYRsWMMtWWRotT4/yr0BpJ?=
 =?us-ascii?q?G0YjAHyI8ixx7Dc/yHdJWI4g77WOaRPzh4gHVldaq6hxmo8EigzvTwVs260F?=
 =?us-ascii?q?pXtyZFnNjBu3QX2xzc7ciHTfR9/kO/1jqVyw/T7eRELVg1lardNZEh3qY9mo?=
 =?us-ascii?q?QPvUnHBCP7m0X7gLWLekgl+OWk8eXqb7H+qp+ZLYB0iwX+Mqo0msy4BOQ1Kg?=
 =?us-ascii?q?gPXmmb+eum1b3v4VH1TbtRg/0rjqbZqorWKtoGqa6kGwNVyJos6w6jDze619?=
 =?us-ascii?q?QVhX0HLFNDeBKagInlIlLOL+7iDfe5nVuslCxmx+7JPrL/GJXBNHvDn6n7fb?=
 =?us-ascii?q?Z79UFczBA/zddF55JbWfk9J6e5eEb0uceQI1kbdUSexPr7D9B525JUETaND6?=
 =?us-ascii?q?2TGKfTt0KYoOMlJq+HY4pD/H63DvE/+//oxVx/0WcQYaSzxpYRIjjsG/18P0?=
 =?us-ascii?q?SfJ2LhntobCmoMlg0kRefuhRuJVjsFIz62XqQh9nQgA5mnJZnMS5rrg7Gb2i?=
 =?us-ascii?q?q/WJpMaSQODlGKDGetdIieXfoIQDydL9UnkTEeU7WlDYg72lXmnw/3zbV2M6?=
 =?us-ascii?q?Lv/SsX/cboz99z6MXYjlcv/iYyAsiAhSXFfWF1j34ODwY31aY39V59y0ae17?=
 =?us-ascii?q?FQiOceCNdJof5FT1FpG4TbyrlLCsLyRwWJTNeASR7yU8emCDBpFokZ3tQUJU?=
 =?us-ascii?q?txBoPx3Vj4wyO2DupNxPSwD5su//eZhiCpKg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EVAwDznptdh0WnVdFmDoYghE2OYIU?=
 =?us-ascii?q?XAYZ3hVmBGIMRhyMBCAEBAQ4vAQGHHyM4EwIDCQEBBQEBAQEBBQQBAQIQAQE?=
 =?us-ascii?q?BCA0JCCmFQII6KQGDVRF8DwImAiQSAQUBIgE0gwCCCwWiaIEDPIsmgTKIYAE?=
 =?us-ascii?q?JDYFIEnoojA6CF4ERg1CHUYJYBIE4AQEBlSyWVAEGAoIQFIxUiEQbgioBlxQ?=
 =?us-ascii?q?tjX+ZSw8jgUaBezMaJX8GZ4FPTxAUgWmNcVskkhwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EVAwDznptdh0WnVdFmDoYghE2OYIUXAYZ3hVmBGIMRh?=
 =?us-ascii?q?yMBCAEBAQ4vAQGHHyM4EwIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6K?=
 =?us-ascii?q?QGDVRF8DwImAiQSAQUBIgE0gwCCCwWiaIEDPIsmgTKIYAEJDYFIEnoojA6CF?=
 =?us-ascii?q?4ERg1CHUYJYBIE4AQEBlSyWVAEGAoIQFIxUiEQbgioBlxQtjX+ZSw8jgUaBe?=
 =?us-ascii?q?zMaJX8GZ4FPTxAUgWmNcVskkhwBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="80773091"
Received: from mail-lf1-f69.google.com ([209.85.167.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 13:30:20 -0700
Received: by mail-lf1-f69.google.com with SMTP id c83so1685779lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=55dhnuYmVazkQySeH4LJMqj3qTpKbtoaQ6fsEhqhvMQ=;
        b=RhAcvBX5enRU0OoUoT7dPWjSdMCaqOz6Kng83T3Zj+DOXIYpyfto87Wm3fCOdMhA3d
         Aty2adDat/yMgUn5fwtd0h0oBPwZNIYOBTCEDaYit2j7PLPn034VUpQJJYON0Og8mcS4
         hWE+HBuUsBnZ2GTdf33uUQjBPRCd47d56QGSGt9P0cIkC0SBMOzk0XhlFaJiWMjlbNN3
         Tg8r3x9eagt14dKHAI12LimpqwXn02S8CAKdGB4VbTj/ZlKPBv9HYbGpCiLVj8M9EyPu
         y0Jp3Cbx0U8BkJsI9rqpIMq2q2KdzUSV22pD0SHUT0x2qga18ULfyPdxaWjHfcp/WXkZ
         9wKQ==
X-Gm-Message-State: APjAAAWXCsYHssMJvhc1Zpn/CAuo3/xQ8vEcqP55GYQTs8kyvAmEIggg
        S1uIFxd0+pMESsWYRkmn1rSrF3VZR+WjiC3Zfh/yUayYfBTg1DilIDAaYMwbxYlYTLJyTnXFXwg
        A9uU+yhIeqjqsYu5NYWHb0f3VmE78Zkl/phU10rOMIQ==
X-Received: by 2002:a05:651c:283:: with SMTP id b3mr20056078ljo.25.1570480216576;
        Mon, 07 Oct 2019 13:30:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIiP41LU5FNlyZ0Inupz9ufcy5XrKk05nCT7f8X0nvzNx8eHN+9iP6ewKceRhfBV9vtdcEMIXfJaE/0NI2aEs=
X-Received: by 2002:a05:651c:283:: with SMTP id b3mr20056069ljo.25.1570480216371;
 Mon, 07 Oct 2019 13:30:16 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 13:30:59 -0700
Message-ID: <CABvMjLSoa6WfdmvwCCPgAUtc1ZmQ8+14xrDnz5Q8MrpFstMDsg@mail.gmail.com>
Subject: Potential NULL pointer deference in scsi: scsi_transport_spi
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengyu Song <csong@cs.ucr.edu>,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/scsi/scsi_transport_spi.c:

Inside function store_spi_transport_period(), dev_to_shost()
could return NULL, however, the return value shost is not
checked and get used. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
