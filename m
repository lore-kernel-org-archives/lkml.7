Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0149ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC1C2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ONissujf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbfJJAfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:35:50 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:55171 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfJJAft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570667749; x=1602203749;
  h=mime-version:from:date:message-id:subject:to;
  bh=nWu3ebWjqXjCvzB4v842JIolrNY8p92IVVNrwebapD4=;
  b=ONissujfcMeMqvgW9vzgAndrQgUr7u2J+0Mt2QKqN+NA8btYr4nzzJzW
   e8BldebK/8kzlOkSFiWV2AEjLhWZhv/sOycfsNFMFqOLn+Th6WMRddL6/
   AD51fx7f8yvt5BCcZ8xaPjfeKS88VEzy6fOeHtXMr9j7lsKWHBvqlPABG
   kOLJ65T2sIoSwXqh1qDElManjqllYQYlA0yJLClEaCjsBrV8YidUVFEEo
   L7w8foXL9lU2jSaho+u6KVfSVa53c9X7xBi4erB3XK5wrek2/uT1etsqF
   YSr3TsnztklhbEuxGQQRyyQqAeiuFXuiNRMBQOqOqAhfqumlL0iz9ANzQ
   w==;
IronPort-SDR: 0MK1gZZ9srlenfXTIouQdW0+l4v44gJjyDCcLaNK0H52yJ+o3EL6mn7pWh4orr0ydm+PQbtbNP
 CF0VO8ltqBgZfckNhOU5GylfvDlsjDIKN59tud9Y01fd5uCrzksCxmhgNLQwOUBy+BnV6/Fo1m
 jwvIqeT1l4HwjkOhBAUUDPet7BGDDRD8JdkQB8KpZNi6aRlUTeRaR6mq/oYIVMLPe76gJ/Fxg/
 /pEvuZm8O5aUURZjAbXSyFPc//sQ9vaAFnqaYQ4FhcPvxbTezsQruXv8jqEofTrN4Il7pIdZdj
 KMw=
IronPort-PHdr: =?us-ascii?q?9a23=3AJcXt8B3l4TKSGTfUsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMSI/ad9pjvdHbS+e9qxAeQG9mCsLQa0aGN7OjJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7J/IAu5oQjftMQdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWG?=
 =?us-ascii?q?FPXNteVzZZD4yzb4UBAekPM/tGoYbhvFYOsQeyCBOwCO/z1jNFhHn71rA63e?=
 =?us-ascii?q?Q7FgHG2RQtENAPsHXVrNX1KaASWv22w6nI1zrDbu5d1DD96YnJchAuu/CMUa?=
 =?us-ascii?q?5sfcff0kQvCh/Kjk+KpYP7IjyVy/0Avm6G5ORjTeKik3Arpx11rzS1xcohip?=
 =?us-ascii?q?PFip8Ux13G7yl0wps5KNulQ0Bhe9GkCoFftySCOotzRcMtXn9ntT4hyr0DpZ?=
 =?us-ascii?q?67ZC8KyIk7xxLHa/yIbYyI4hX7WeaUOzh4hXZldKu7hxa87ESs0+P8W8up3F?=
 =?us-ascii?q?pQoSpFld7Mtn8J1xPN8MSIVvx9/kK51TaO0QDc9P1ELFgqmabHL5Mt2L09m5?=
 =?us-ascii?q?oJvUjeHyL7ml/6ga2Lekk8/+in8eXnYrHopp+GMI90jxnzM6Qvm8y/G+s4Mx?=
 =?us-ascii?q?QCU3SV9Omnyb3s4Vf5TK9UgfIrj6nVqIraKtgDpq6lHw9V1Z4u6xK+Dzegzd?=
 =?us-ascii?q?QZkmALLFFbdxKdiYjmJVXOLevmDfewnVusii1nx/PYMb37BJXCMHzDnK3mfb?=
 =?us-ascii?q?Zn5E4PgDY0mPlb6olPA7cNOvW7aFL0sduQWhZ/IRGxxuHPFNJi25kCVGmPRK?=
 =?us-ascii?q?6FZueamFuF9uspL/OBLKUYvDL6Lflts/fqgG8wn1MHcO+j0J8Tb3a5Nv5hJF?=
 =?us-ascii?q?mdYHyqidAERyNCugs4UfyvkkGJeSBcamz0XK8m4Dw/ToW8AsOLQoGrnazE3y?=
 =?us-ascii?q?qhGJBSTn5JB0rKEnrycYiAHfAWZ2baEM9ggyECHYGgQolpgQOutR7nzaNPJf?=
 =?us-ascii?q?GS5yYC85/vyY4xr8bTmBc95CE8NMOb3CnZRHpzmGwgTCRwwatl50Fx1wHQ/7?=
 =?us-ascii?q?J/hqlpFM5T+vQBYAczNNaI3v56AtGqAlnpY9yTDluqX4P1UnkKUtstzopWMA?=
 =?us-ascii?q?5GENK4g0WGhnLyDg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GYAgB0fJ5dh0enVdFmDoIzhBGETY5?=
 =?us-ascii?q?cgW0FgyUBjWmIOYF7AQgBAQEOLwEBhxIjNQgOAgMJAQEFAQEBAQEFBAEBAhA?=
 =?us-ascii?q?BAQEIDQkIKYVAgjopAYNVEXwDDAImAiQSAQUBIgEaGoMAgnikaIEDPIsmgTK?=
 =?us-ascii?q?IZQEJDYFIEnoojA6CF4Nuc4dSgl4EgTkBAQGVL5ZXAQYCghAUA4xRiEUbgio?=
 =?us-ascii?q?BlxWOLZlPDyOBMQKCDjMaJX8GZ4FPTxAUgWmNcVskkUsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GYAgB0fJ5dh0enVdFmDoIzhBGETY5cgW0FgyUBjWmIO?=
 =?us-ascii?q?YF7AQgBAQEOLwEBhxIjNQgOAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAg?=
 =?us-ascii?q?jopAYNVEXwDDAImAiQSAQUBIgEaGoMAgnikaIEDPIsmgTKIZQEJDYFIEnooj?=
 =?us-ascii?q?A6CF4Nuc4dSgl4EgTkBAQGVL5ZXAQYCghAUA4xRiEUbgioBlxWOLZlPDyOBM?=
 =?us-ascii?q?QKCDjMaJX8GZ4FPTxAUgWmNcVskkUsBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="14101559"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 17:35:48 -0700
Received: by mail-lf1-f71.google.com with SMTP id c7so978872lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G4W3e3qGvtDBybhSHNkiyzwqamwrUZ6xOAFBHkAsOEk=;
        b=OvJWODO7EiB4zemUtqIBSEk9qfPIYa7YLicgAcYsTLIpPeHRh05RHBEUmf3672uKTL
         AT2wjI4XdcLsH3xvDQGUxKezfbmiTMoRzWHFULcEZXi594fde5OsAvsB1LYA90TF5jlR
         venxSOfbsojV5ZjmmTy3fHQ4xV7kmg9jjiRprXwnrjtJFJ2JvsmON02rtzXxQKMLunU1
         G1o54w4rd1kzbrp/pcP7TasajXhcsHTykT9BENjydlCJ2hHmmQc7bhwRJdQ6M4c7rcOX
         O117oXxOtYCZ+9WvIqJ9NfFXJDiI5NnTKAxkYyL0WUZmPbfZriyJMDe5NdY85s2O/d4f
         /44Q==
X-Gm-Message-State: APjAAAWokjM4JeAHrrRuJLQKmGGnr1Vre1AQRiFOIgdzomlAj3arRzGA
        w2KOdZ/1LH2Kx7KBI1sOInxZT2D8BYUREDg28TjJVQYw1XopiSxqKPHKxcMEYo71XbvmCFqw80u
        XQBN4huqB5n5yFoJwat6gQo6TP/LCer/vcX5pzrOMxQ==
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr4006720ljj.104.1570667746628;
        Wed, 09 Oct 2019 17:35:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvF9cWwtovR/T13+tT+9QEtwd/pWMQ6spGIHADyJ6SkZx60DwAP8BAZs9zWtZz8M8Q2/bsxHfBns3rLL9Dquk=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr4006714ljj.104.1570667746390;
 Wed, 09 Oct 2019 17:35:46 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 17:36:28 -0700
Message-ID: <CABvMjLRirOKZvCaknF6isxRPvOgMeij2YZe1ef83EEg0kFnUjg@mail.gmail.com>
Subject: Potential uninitialized variables in rtc: ds1343
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
drivers/rtc/rtc-ds1343.c:
Inside function ds1343_show_glitchfilter(), variable "data" could be
uninitialized if regmap_read() returns -EINVAL. However,"data"
is used later in the if statement, which is potentially unsafe. Patch
for this case is hard since the return value -EINVAL is unacceptable
for ds1343_show_glitchfilter().

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
