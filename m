Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E3ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02262084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="KIpNObPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfJGUoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:44:32 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:30990 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfJGUoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570481071; x=1602017071;
  h=mime-version:from:date:message-id:subject:to;
  bh=Fn0EXqdG0WTVZZSsQrhenOVDkwng3N7VJA5gexUk7RY=;
  b=KIpNObPwR5Q5IU2HTMeVrzh+WSCiMfYF4335ozQC34l661xGtCLP+Tcz
   DgVp//Ek8glEedbOP3vvK6OrTYbdSdmOHHJpO5UCotD7LgZCgqTcC3Vx1
   puf5pLcM8CR+55/j9HLMzPJ/apavLZ5v13d4d/S4Zt5Pg0w2QzvnFwteX
   +8+XZMHNl1wtJCczeZuhKQfP4T0bYcc7a8F7+L2kbseiormDOYb/Bozva
   bhHMCERj9OWmF29plTmxDjsMSVqR9hbn5MtQTci3t3igb6So4i4A2b1Zi
   P7NsCDn1LIhNmd8zQTnRDeUYtNgkWe2x4AohI5284JxdBrSM/RixSXQM1
   w==;
IronPort-SDR: otX9TAGxVn7ryy6XTB+ThaEqPboUlIQxRvqn3cOnBiq/BTcV4WDl7daFLP/J7usFlwvJfUFzaa
 uTFgWPzL+MshEUF1G4dhKGSLgXxrBf1VSF5dSDEjbqEYdSTmGARjo/oOibuio5p8Fu/6JAzhlC
 nPSYA5gvbSoQhhDEaKQrhbNR8r8vdCbz5UhwVhTXK1x6gitRhkgUbpHFzVgobUL3uXuzZm0Dft
 JSkKTOss/UGRPbaFxBlq4c/p+Z7JfPxrWww7EXsct/qobrGVESiGEL7pRo3H7n3cBAEHPzqk8M
 Ld0=
IronPort-PHdr: =?us-ascii?q?9a23=3Ay4PsrBazavqhdYg2pc7MqZb/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8W4bnLW6fgltlLVR4KTs6sC17ON9f2/EjVbsN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twXcu8sZjYd/JKs8zg?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFKH4GyYJYVD+cZMulWr4fzqVgToxWgGQahH//vxiNSi3PqwaE2z+?=
 =?us-ascii?q?YsHAfb1wIgBdIOt3HUoc33O6cTUOG1zLTIzTLeZPxV2Tfy8onIeQ0mrPCMXL?=
 =?us-ascii?q?NwcdDeyUgzGw/ZgFidspHlMC+P1ugXrWeU8vdgWPuphmU6qA9xuiCiytkwho?=
 =?us-ascii?q?TNnI4YyVDJ+T9kzIs0J9C0Uk92bNqiHZBNrS+VLZF2TdknQ2xwvSY6zaAJto?=
 =?us-ascii?q?CjcSgRzZQn2wbfa/uac4iU+h7jVPieITN/hH99fbKwnRey8Uy5xu34WMm4zU?=
 =?us-ascii?q?9GriREn9TIrHwN2BvT6s+ISvt54EitwyqA1wfW6u1cIEA0k7TUK4I5z7Iuip?=
 =?us-ascii?q?YetV7PEyz2lUnskaObd0cp9vKp5unjernmo4WTN45wigHwKKQuncm/DPw4Mw?=
 =?us-ascii?q?kPX2iU4+W82KH/8UD3W7hKk+E5krPDvJ/EOMsbu7a1AxVJ3YY79xa/EzCm3c?=
 =?us-ascii?q?wcnXkGKlJFZR2Gg5HqO17QOvD4C+mwg1C3nTd1yPDJIKfhDo/OLnfdirfhe6?=
 =?us-ascii?q?hy60pGxAo019Bf6MEcNrZUBP/1EmXrs8PeRks9Pgq+6+XqEtNw0sUZQ23ZRu?=
 =?us-ascii?q?eCPqKXvVKW6+YHOOiJfIsYtjfnLucs/fOoimU23RcZfK+0zd4UZWq+E/BOPU?=
 =?us-ascii?q?qUezzvj80HHGNMuRAxCKTYiFyTTDgbXne7Wepo9DE6GZ+gFK/IXcawi6bH0S?=
 =?us-ascii?q?umSNkeTWBLDF+dDD/TcIOLE6MHcyWULedqiXoZXqLnRoM8g0KArgj/notmPO?=
 =?us-ascii?q?rJ/WUqtZvinIxk9e3alElqrhRpBN7b3m2QGTIn1lgUTiM7ifgs6Xd2zU2OhO?=
 =?us-ascii?q?0h26RV?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HFAgCFoptdh0WnVdFmDoIQhBCETY5?=
 =?us-ascii?q?hhRcBhneFWYEYijQBCAEBAQ4vAQGHHyM3Bg4CAwkBAQUBAQEBAQUEAQECEAE?=
 =?us-ascii?q?BAQgNCQgphUCCOikBg1URfA8CJgIkEgEFASIBNIMAggsFomCBAzyLJoEyiGQ?=
 =?us-ascii?q?BCQ2BSBJ6KIwOgheBEYJkiD2CWASBOAEBAZUsllQBBgKCEBSMVIhEG4IqAZc?=
 =?us-ascii?q?UjiyZSw8jgUWBfDMaJX8GZ4FPTxAUgWmNcVskkhwBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HFAgCFoptdh0WnVdFmDoIQhBCETY5hhRcBhneFWYEYi?=
 =?us-ascii?q?jQBCAEBAQ4vAQGHHyM3Bg4CAwkBAQUBAQEBAQUEAQECEAEBAQgNCQgphUCCO?=
 =?us-ascii?q?ikBg1URfA8CJgIkEgEFASIBNIMAggsFomCBAzyLJoEyiGQBCQ2BSBJ6KIwOg?=
 =?us-ascii?q?heBEYJkiD2CWASBOAEBAZUsllQBBgKCEBSMVIhEG4IqAZcUjiyZSw8jgUWBf?=
 =?us-ascii?q?DMaJX8GZ4FPTxAUgWmNcVskkhwBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="80775912"
Received: from mail-lf1-f69.google.com ([209.85.167.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 13:44:30 -0700
Received: by mail-lf1-f69.google.com with SMTP id c13so1689901lfk.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XoSfNAYjm7qXQtfl7i5O7p/asYCHengmkw3OkX7r4NA=;
        b=txd9x5Zza1+ykPNQshWzPjUOqx6nUTrs1u8wz6AMY3Dpfbv+d/w2iCzgV87PF2KFtP
         ra0ATN4nLix4PAnbmeDgMuzhh9xA9hdII4TSdeRd9toNlCRW553Jc+SqdoGLo4K3RmZS
         P6OU7M3VyXYykE16/4eiNKD/MoJRNahIUhkSFcNMPk4EAeDaXkHzjUOL7zsKf+HLw2bY
         WujGiGe16m6GsgMxqahizvHexjLOG99ahC9Gb5+v/wuw6j/1NoYSXvDT9oMCreKMbqFZ
         UTY7geEsp8u6DvPtQ57liY8Tp4Blv8HjjjBErClOVHhzwcIdtSGhDmNwtg7C+bL918z6
         5kBA==
X-Gm-Message-State: APjAAAUseZ58IlLqeNWfKpmzYZWqd9wsK1Ne2XYyQVVYa89hZVS2uNEl
        WELYye64PLvxeUA4GXIyy7hxw8xKcBQXesSeJBH955PaS3r0op8tEXi64ftf6sGO3xh6/2yJUgx
        ppgjWLMCJ0hczYZB6rB3kWpFom63D8OVen6XXrRV1eA==
X-Received: by 2002:a05:651c:283:: with SMTP id b3mr20090394ljo.25.1570481068902;
        Mon, 07 Oct 2019 13:44:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwzJco/LBaOLn1u551TbYDuUXHkAuJM2nFwIC9yjeT4xnsPz5+8+1cQ/yciTD7OSBul+ZukO4Vvg98wvcko5h0=
X-Received: by 2002:a05:651c:283:: with SMTP id b3mr20090387ljo.25.1570481068718;
 Mon, 07 Oct 2019 13:44:28 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 7 Oct 2019 13:45:11 -0700
Message-ID: <CABvMjLTNw4YNoc66ERZv4NT+2Dm=jMRg9qV45nbnkKyAZ8-y4w@mail.gmail.com>
Subject: Potential NULL pointer deference in SFI
To:     Len Brown <lenb@kernel.org>, sfi-devel@simplefirmware.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

drivers/sfi/sfi_core.c:

Inside function sfi_map_table(), sfi_map_memory() could return NULL,
however, the return value of sfi_map_memory() is not checked and get
used. This could potentially be unsafe.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
