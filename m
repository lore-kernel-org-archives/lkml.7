Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC569C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F452196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="qBrRgErI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfJKFcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:32:00 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:15598 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfJKFb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570771919; x=1602307919;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=yJ5YGvrPcyRX5zC7jVyQFboOGLnco0MT2oGaJMlgWhA=;
  b=qBrRgErI8DPP+WjNrOCK67oD3e0zxSaVh/oxb1wSX7VgTW42K7JqXUUj
   TUIMIlKD9pHErQu2y07Bd3YnVOqbIT/ZMR+bz1meXe3hrVMVt5ajitGYi
   k3rYqD69OQlpSV2d251YQdpGqMyD7baisNiulDSnxUmUvWbxrsLkByN66
   fFid1qe/z4gjPXN9filAaA4v/9/hvPo+Qk14e0y4BfhCtukKNV3F3pl+U
   QEKUbh/AUoca0jySTjoh2usnlSuxlJ+Rqkq4YHNeZKcsVrZHAdknCRjW6
   FV0HP1zHNwzbXVOhW5KdxL3C6757YUsad1Hyq+ruhXuLsc0qCnUUVntjk
   Q==;
IronPort-SDR: pRaU1Cw/GqJrhGsgYxNyaQfngDOMhmJQ8tAHAsxXzWq2CrkmW84W8YZZIbgVxOtzzAluTJRHf9
 wCrX4I9UB2YY+B6L2RIdnp08DpB9rFeANUG3Ee+9msH8WXLsYazgMijrhdAaz0+GgKjGm6h0sl
 kkB5s4zcTMj5IIfA7LMHZ/LRGsxQtuyxZgSdI0/XVY5sp72TlrnKRFLdap+8lasl9xuiusN4PU
 nPv4ESLX/S4exZie2xsXF00tDATLuu8qnjrrp+0wpjJW8a0VQbd++Hxp1FrRsj9FlaMzsjcDYd
 1XY=
IronPort-PHdr: =?us-ascii?q?9a23=3AAv4DhBVuUWP6HgERsjnwtOG1AM/V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxyFt8tkgFKBZ4jH8fUM07OQ7/m7HzJcqsfc+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLt8QbjoRuJ6Ixxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipcCY2+coQPFfIMMulWr4b/p1UAoxiwCxSyCuzz0TJImmP60Lcm3+?=
 =?us-ascii?q?g9DQ3L3gotFM8OvnTOq9X1Mb8fXuK0zKjJzTXDcvRW0ir+54jIaB8hoOyHUL?=
 =?us-ascii?q?VwcMvQyUkgDQLFgkmMpYHrJD6Vy/gCs3KB4+V+SO2vlncqpgdsqTas3schkp?=
 =?us-ascii?q?fFip4Rx1ze9ih0wJw5KcOkREN4e9KoDodcuz2cOoBrWM0tWXtotzw/yrAevJ?=
 =?us-ascii?q?67ezUFx4o/yh7EbvyHb5CI4hX+VOaNOTt4hGxqeLa4hxuq9Eiv0Oz8Vs2t3F?=
 =?us-ascii?q?ZOrCpJj8DAtn4T2xDP9sSLUPR9/kCm2TaA0wDc9PtILlwzlareM5Ihw7gwmY?=
 =?us-ascii?q?QPsUnbACP6hEH7gLWVe0gk4OSk9fjrb7b8qpOCK4N4lhnyMqE0lcy+BeQ4PB?=
 =?us-ascii?q?IOX2+e+emk1Lzi/E35T69LjvEqjqXUvovXJdkHqa6jGQNazJss6wunAze8zN?=
 =?us-ascii?q?sYhWUHLE5CeB+fi4jpOlfOIO33DPumgFSjji1rx/bYMb3lGZjNMHfDn6n7fb?=
 =?us-ascii?q?pn6E5T1hAzzdZB6JJQEL0BJ+jzWkCi/ODfWzIjMgf87/viAcdwystKVHiOCe?=
 =?us-ascii?q?mVLabbo1KUzu0qKuiIIoQSvWCuBeIi4qvfjG05hFhVT6mg3NNDeWK4F/U+ex?=
 =?us-ascii?q?6xfHH2xNoNDDFZ7UIFUOX2hQjaAnZobHGoUvd5v2ljBQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HSAwCdEqBdf8jQVdFlHgELHIYMKoQ?=
 =?us-ascii?q?jjl6CD4lpj1WBZwEIAQEBDi8BAYRAAoJdIzgTAgMJAQEFAQEBAQEFBAEBAhA?=
 =?us-ascii?q?BAQkLCwgnhUKCOikBgz0BAQEDEhFWEAsLDQICJgICIQESAQUBHAYTIoVHAy6?=
 =?us-ascii?q?lC4EDPIsmgTKIEg1MAQkNgUgSeiiMDoIXgRGCZC4+ghqBdwESAYMtgl4EgTk?=
 =?us-ascii?q?BAQGLN4l4lhdAAQYCghAUjFSEPYQIG5lAmF2PHw8jgUaBCnEzGiV/BmeBTlA?=
 =?us-ascii?q?QFJA1JDCOMYJFAQE?=
X-IPAS-Result: =?us-ascii?q?A2HSAwCdEqBdf8jQVdFlHgELHIYMKoQjjl6CD4lpj1WBZ?=
 =?us-ascii?q?wEIAQEBDi8BAYRAAoJdIzgTAgMJAQEFAQEBAQEFBAEBAhABAQkLCwgnhUKCO?=
 =?us-ascii?q?ikBgz0BAQEDEhFWEAsLDQICJgICIQESAQUBHAYTIoVHAy6lC4EDPIsmgTKIE?=
 =?us-ascii?q?g1MAQkNgUgSeiiMDoIXgRGCZC4+ghqBdwESAYMtgl4EgTkBAQGLN4l4lhdAA?=
 =?us-ascii?q?QYCghAUjFSEPYQIG5lAmF2PHw8jgUaBCnEzGiV/BmeBTlAQFJA1JDCOMYJFA?=
 =?us-ascii?q?QE?=
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="13695694"
Received: from mail-lj1-f200.google.com ([209.85.208.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2019 22:31:58 -0700
Received: by mail-lj1-f200.google.com with SMTP id j10so1493328lja.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tv2M3bVEOwTFf6PpVjYYQE3JCPAHcwi1kAhVSyKoUk8=;
        b=bLp5B4nzfMgAymOsBXF7kTA4Fo89bUFpUHKw8mYdgejYKvx0YpJZh6VzunShKp3kxN
         LtP8kXeOdU8sPUCEgr36Pz1OyiBsb14gRt512f2WSbKp3pEK+12CmQ6oVwwxkGi8ezc2
         zwuHeyrsRFiL97g6vQoVxqmUj+A+Im8N5MZ2K43SxIzhyn8pIZm28OCB2vwiCiqiNRmt
         0DBAQsSF63SF9gxkfVdperWzc04/TkZDVdolZYC3g2kj3OtM2rp8M4gv6VPc94uxyUOT
         EuGHU6DJJiGTIL/ZUdfni8kmIQUB9qQghb6QiXti3Ui7Pb/EwUFu8NYnMaVygrSW4fKC
         M/Lw==
X-Gm-Message-State: APjAAAUyWrrBS84rub0B8U2g8XBOl15FosDRG5RogPG77U83BsRH0Y5O
        aNRoCnlFaJ7fJ+7LoV7oPNbl+Can+g2uJsLXAaJBLRypMSPyddPNJVKDKuALs6KSyYlWzj/sV2Y
        p5K8MWYMBsamrUy5MOSMbyxRw2e4oKEBubtsppBC9+Q==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr8212620ljj.181.1570771916643;
        Thu, 10 Oct 2019 22:31:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHP44PVHjs0kFISU2ps2cAigGwbjhhimKB33YZ1L/BeZfqzW5I3WsJw/QcMLDk/A8RKn0EguzvxM0b+UUoSQQ=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr8212613ljj.181.1570771916412;
 Thu, 10 Oct 2019 22:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
 <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
In-Reply-To: <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 10 Oct 2019 22:31:28 -0700
Message-ID: <CABvMjLTrGprdgFTP-+2XC_p+vE+tVWeYvyuLGkKj1dY7KR+JDg@mail.gmail.com>
Subject: Re: Potential NULL pointer deference in spi
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric:

My apologies for bothering, we got those report via static analysis
and haven't got a good method to verify the path to trigger them.
Therefore I sent those email to you maintainers first since you
know much better about the details. Sorry again for your time and
I take your suggestions.

On Wed, Oct 9, 2019 at 10:48 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 10/9/19 10:37 PM, Yizhuo Zhai wrote:
> > Hi All:
> >
> > drivers/spi/spi.c:
> >
> > The function to_spi_device() could return NULL, but some callers
> > in this file does not check the return value while directly dereference
> > it, which seems potentially unsafe.
> >
> > Such callers include spidev_release(),  spi_dev_check(),
> > driver_override_store(), etc.
> >
> >
>
>
> Many of your reports are completely bogus.
>
> I suggest you spend more time before sending such emails to very large audience
> and risk being ignored at some point.
>
> Thanks.



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
