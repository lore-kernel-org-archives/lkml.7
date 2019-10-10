Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE173C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827C220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="do8GURDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfJJFct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:32:49 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:64543 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfJJFct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570685569; x=1602221569;
  h=mime-version:from:date:message-id:subject:to;
  bh=RvB4beOHJ+bh6/+tuaexoTBtxRmUrxcVHhPsG/H7aFw=;
  b=do8GURDFBUaRwtitqWvCsn+sdfpzSuQm4n5MydBsSP/MhekGYz6tRCjN
   aXkf6gjaAC7dzFg7RygpO8N3civa0BX3Ad+Otiyepkx2a8JBlimlqQ7Y8
   SCB4as3K/H549BYmJu6W6vAc1JnQfl5o+RtEMNzRnVyuFb13SuGm+zXPo
   NNXVLadGOip0k6oCsWxpkXi3/t+d8t/KcB5SEzlmTABqzmwbYfdcttnLu
   VL6OxCvyL71byasPCJqVXCXnzjk95uhKsvJ+alUFr/xAcnCfBFZFiO6gO
   Qqob01PEzLG7wNvQH6zdu+3e93G7DEfU3B1+efnM/dBW/EhEX795WIJb8
   A==;
IronPort-SDR: FwGnsVwyqxEooVuyjSBWkN4k4/yzuXX6bIru5XANKmOCjjWW3eDGvT8dVgj1GTTSKjFX2rEPXf
 pQ1vdE2xbQr8Qhmu4xZuRylFvORAscUtdZUWztTbBQHfqaZ22I9DjXv6DFBrbRhyUTgBTwo8rZ
 V9cOSL9jz9EhjM4KjlbvTsS8QdzgTS8cPC+Zi0ZiQcdcNPPnhRirSyezmTcSfvRICeLnQDIayh
 OZG79DKvpvtA/bj7bBRHqPOZduBL91XlWR1EQGawGd2jo0O2lNDnpnujIpKMWmklIK44rYHpNI
 8xo=
IronPort-PHdr: =?us-ascii?q?9a23=3AehiS8B2CXl7CFgnAsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIeLfad9pjvdHbS+e9qxAeQG9mCsLQa0aGH4+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7J/IAu5oQjVtcQdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWG?=
 =?us-ascii?q?FPXNteVzZZD4yzb4UBAekPM/tGoYbhvFYOsQeyCBOwCO/z1jNFhHn71rA63e?=
 =?us-ascii?q?Q7FgHG2RQtENAPsHXVrNX1KaASWv22w6nI1zrDbu5d1DD96YnJchAuu/CMUa?=
 =?us-ascii?q?5sfcff0kQvCh/Kjk+KpYP7IjyVy/0Avm6G5ORjTeKik3Arpx11rzS1xcohip?=
 =?us-ascii?q?PFip8Ux13G7yl0wpo5KNulQ0Bhe9GkCoFftySCOotzRcMtXn9ntT4hyr0DpZ?=
 =?us-ascii?q?67ZC8KyIk7xxLHa/yIbYyI4hX7WeaUOzh4hXZldKu7hxa87ESs0+P8W8uo3F?=
 =?us-ascii?q?pQoSpFld7Mtn8J1xPN8MSIVvx9/kK51TaO0QDc9P1ELFgqmabHL5Mt2L09m5?=
 =?us-ascii?q?oJvUjeHyL7ml/6ga2Kekk8/+in8eXnYrHopp+GMI90jxnzM6Qvm8y/G+s4Mx?=
 =?us-ascii?q?QCU3SV9Omnyb3s4Vf5TK9UgfIrj6nVqIraKtgDpq6lHw9V1Z4u6xK+Dzegzd?=
 =?us-ascii?q?QZkmALLFFbdxKdiYjmJVXOLevmDfewnVusii1nx/PYMb37BJXCMHzDnK3mfb?=
 =?us-ascii?q?Zn5E4PgDY0mPJS4YkcI6ELJ/+7DkbhvtvVJhw0KQq5x6DrC4M5nocfX3+fR6?=
 =?us-ascii?q?6VPYvMvlKSoOEiOe+BYMkSojm5Y/wk4eP+yHw0g1kQeYG30pYNLnO1BPJrJw?=
 =?us-ascii?q?Oee3WoyuUBEHYXuEIHTeXswAmQUT9CenCrd6knoCwwEsSrAZqVAsiGgLGH0z?=
 =?us-ascii?q?amVqZRYG8OXluXFnHnX46fHeoHcmSfLtI3wRIeUr30eo4z1Qyp/D36wrsvev?=
 =?us-ascii?q?vG+iQZ7cq4/MV+/avemQxkpm88NNiUz2zYFzI8pWgPXTJjmfkn+UE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GQAwAXwp5dgEanVdFlDoIzhBGETY5?=
 =?us-ascii?q?bhRcBhniGcYo0AQgBAQEOLwEBhxgjNwYOAgMJAQEFAQEBAQEFBAEBAhABAQk?=
 =?us-ascii?q?NCQgnhUKCOikBg1URfA8CJgIkEgEFASIBNIV4pDGBAzyLJoEyiGUBCQ2BSBJ?=
 =?us-ascii?q?6KIwOgheBEYNQh1KCXgSBOQEBAZUvllcBBgKCEBSMVIhFG4IqAZcVLY4AmU8?=
 =?us-ascii?q?PI4FFgXwzGiV/BmeBT08QFI9aWySRSwEB?=
X-IPAS-Result: =?us-ascii?q?A2GQAwAXwp5dgEanVdFlDoIzhBGETY5bhRcBhniGcYo0A?=
 =?us-ascii?q?QgBAQEOLwEBhxgjNwYOAgMJAQEFAQEBAQEFBAEBAhABAQkNCQgnhUKCOikBg?=
 =?us-ascii?q?1URfA8CJgIkEgEFASIBNIV4pDGBAzyLJoEyiGUBCQ2BSBJ6KIwOgheBEYNQh?=
 =?us-ascii?q?1KCXgSBOQEBAZUvllcBBgKCEBSMVIhFG4IqAZcVLY4AmU8PI4FFgXwzGiV/B?=
 =?us-ascii?q?meBT08QFI9aWySRSwEB?=
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="86473876"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 22:32:46 -0700
Received: by mail-lf1-f70.google.com with SMTP id e1so1068610lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 22:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BKv+zYAxPAe9xy/3rqyjgE0Q508CSlpep/D1x2EiUB4=;
        b=psA9B/Zp2xeR6PJCkjOpv1jEiKcWgJ4R/5hnzDOY3t63E3elrjYitq5lhJ2tRFmHJx
         ZtxUiN5VqYkG3T1JQC4xgoNjU9Ke+iGpj03gCMXBVnto0dj1XcjYZ1DIYWFK6cGTx42C
         dp4ieqZpnu5/1RUHoPuS+b2QJu1Vy4QnV6WpuNm580B+Nj0vGjaqO3nuo6MxSOdloS9V
         /lUsDT082RKzxw+olac7iLwdereoZQAym+LrX2H+7eg5kAX1HU3tjltpK/DbLPTMIdkI
         wPpILA/aijtbYCxsuEl1j7Grmg+7YcvjHmSY/4nMNeMW5hXfqQJJ2/AwXnwibNibAL/V
         OBgw==
X-Gm-Message-State: APjAAAUtGFfxMoogMzPu/QwVVMkk58mn8RG60AYmNEkpRLCCx4n1XgD+
        922+xFm7eummmkgxqLLkti7xEa6wo7JPw4JXLNv1eEzv42q/sTSgNWLACpHxWoMJzY8DXAXnuUf
        gc1BOce6gzes7WLiPi3FVVE3W7xsSFdhJyFLu7WmwZg==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr4878458ljc.97.1570685564167;
        Wed, 09 Oct 2019 22:32:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXtuaVfh6FwAnhgdZW/B5B3OiSHp4oGbk49Vc2sdQ51k/MQiWe6cExDapm9ByzkBtotjY7eq65bQwlL/tHon4=
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr4878448ljc.97.1570685563972;
 Wed, 09 Oct 2019 22:32:43 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 22:32:18 -0700
Message-ID: <CABvMjLS52a75=WBPvG63xywiMTpGZCYikp6DGFQ-fn8wN_62DQ@mail.gmail.com>
Subject: Potential NULL pointer deference inata: sata_rcar
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
In function sata_rcar_bmdma_fill_sg, macro for_each_sg uses sg_next(),
which could return NULL as "sg", however, there's no check before
dereferencing it (in sg_dma_address()), which is potentially unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
