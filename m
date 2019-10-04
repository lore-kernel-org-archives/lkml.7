Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23167C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C2D207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 04:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ftmB/UvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfJDEWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 00:22:01 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:58251 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbfJDEWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 00:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570162921; x=1601698921;
  h=mime-version:from:date:message-id:subject:to;
  bh=Zz/4kUum/4LoqYB7Rvny12tH6aVFfBpG02v+rgY5AYc=;
  b=ftmB/UvQpIdwOuR72S+LoDfIPZDoiVwc+Bs3rc+cBA74ZAg8s1oNa8dV
   PIuM/lzF1JNhuKsvBNtoJfHZzVyC8lhhjOaWDRAe1rblb5YrSFGMhBQuy
   XtM1xpud3BxgiEPw87H1v51kX9cuPSWZRdtnLqBrF3dumDH8gM3pw4ekA
   eNTs1cucw+e3pXkQObt9aIcb8lzButks/r0KJ9BKzaypsxmeCPX6beIn0
   ppxwU5IHL/5wr5k8GDinLBOvTRjLJzNIRvH9IgUeXy4Usr+3GQagZBko+
   VAsCRmzSLflHKWvaMKkM8bQHx0oPmnkAYaFvDNbP+4ij0NaG1vXNN4vSE
   w==;
IronPort-SDR: XBkX8ZpdaAc023avrluDnUXMaT3Y20EYmNWGXbT50+lIC0136jzREmaNl4c1yFd5OOH4ZIYdut
 RNT12D/xLa1uVSauCEZsPYcK/pDghLN9HOL41F4qE0SLTCfdVh3+vfpC16jGOl6fhbMjW1eUd/
 YI7WyP7CoCvhYmOIughyD+khC1XTCmuoVQLFtn3FsdnjdCEbF8ssQY8L0eTmtiYPFcON65vSYc
 S6rJAyH+SsIruPl72EZKJEXvKjFWiC9xQeH4I3JciMX/qkx9QeBZJrnK0x6l+hd4D1SNcu4Acv
 eHQ=
IronPort-PHdr: =?us-ascii?q?9a23=3AAmwN6hVmr76lcwfPn8D8vzCLZGHV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbB2Ft8tkgFKBZ4jH8fUM07OQ7/m7HzFYqs/c+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLtsQanYRuJrsxxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipcCY2+coQPFfIMMulYoYfzpFUAsAWwChW3CePz1jNFnGP60bEm3+?=
 =?us-ascii?q?kjFwzNwQwuH8gJsHTRtNj6NqYSUOG1zKnVyjXIcvBZ2Tfn54jJbxsspvGNXL?=
 =?us-ascii?q?NwccXLyEkjCx/Jg1uLpIz4IzyVzP4BvHaG4Op9TO+ijXMspQJpojW32Msglo?=
 =?us-ascii?q?3EipgWx13E7yl13Yc4KN+iREN6ZdOpFoZbuTuAOItsWMwiRnlluCM9yrIbp5?=
 =?us-ascii?q?G2ZDMKyJE7xx7HbPyHbpSI7grjVOmPJTd4g2poeLeliBaz9Uis0+n8Vsep3F?=
 =?us-ascii?q?pToCpIk93BumoC1xzU7ciHRf998Vm71TmT0ADT7/lIIUEylaXFN54s2qA8mo?=
 =?us-ascii?q?YXvEjZHSL7mF/6gLKXe0gm4OSl6uDqbq3jppCGNo90jg/+Mr4pmsy6Gek5Mg?=
 =?us-ascii?q?kPX2iB9uS9yLHv4UP0Ta5XjvIqiKnVqo7VKtkGpqKhGQ9azp4j6wqjDzehyN?=
 =?us-ascii?q?kYmXgHLFRYeBOIloTpOE/BIOr+Dfihh1Shiylrx//YMb37GJnNLWbMkK3nfb?=
 =?us-ascii?q?lj705Q0g0zzcpQ58EcNrZUG//5U1TttdXeRiU0Mge0zuKvXM5n26sdVHiJD6?=
 =?us-ascii?q?vfN7nd5xvA4uMpPvnJfIo9pjnwMb4m6uTogHt/nkUSOeGt3J0KeDW7E+5gLk?=
 =?us-ascii?q?Gxf3XhmJECHH0Msw54S/blzBWwUT9CenD6ZqM14HlvGoKnHJrFX6imm/qc1z?=
 =?us-ascii?q?39E5FLMCQOIVCBF3j5as2/XPEDIHaZOchnnRQPTv68QJVn2B2z4lzU0b1ie9?=
 =?us-ascii?q?vV6C0FstrR1NF0r7nChxE79GQsVOyA2HvLQm1pyDBbDwQq1bxy9BQugmyI1r?=
 =?us-ascii?q?J11rkBTYRe?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HfAgDGx5Zdh0WnVdFlDoVtM4RMjl6?=
 =?us-ascii?q?FFwGYGAEIAQEBDi8BAYcIIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYV?=
 =?us-ascii?q?AgjopAYNVEXwDDAImAiQSAQUBIgE0gwCCCwWhV4EDPIsmgTKIZgEJDYFIEno?=
 =?us-ascii?q?ojA6CF4Nuc4QogymCWASBNwEBAZUrllIBBgKCERQDjFGIRBuCKpcWLYwSgWy?=
 =?us-ascii?q?ZSg8jgUaBezMaJX8GZ4FPTxAUgWmNcVskkXsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HfAgDGx5Zdh0WnVdFlDoVtM4RMjl6FFwGYGAEIAQEBD?=
 =?us-ascii?q?i8BAYcIIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopAYNVEXwDD?=
 =?us-ascii?q?AImAiQSAQUBIgE0gwCCCwWhV4EDPIsmgTKIZgEJDYFIEnoojA6CF4Nuc4Qog?=
 =?us-ascii?q?ymCWASBNwEBAZUrllIBBgKCERQDjFGIRBuCKpcWLYwSgWyZSg8jgUaBezMaJ?=
 =?us-ascii?q?X8GZ4FPTxAUgWmNcVskkXsBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="80143301"
Received: from mail-lf1-f69.google.com ([209.85.167.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 21:22:00 -0700
Received: by mail-lf1-f69.google.com with SMTP id o9so568727lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 21:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=amG90aSOmtrR07i+DuzkZAUHX9myFv9sjojIkK2vdYg=;
        b=A/MH6PYUXEnPROxNfZfHwc053qZ0IgL7uGSWw8lsJ/wl7p4iMsMxWgVTkfVWykSilX
         fBZDBv2990dMButrvM0vZoK95PiCqBYAeZgWrMGX+iqOdcf/rxJH5ZcLnnHRyMJtq9c7
         7SiAhJuW4Lry4Ue98P6qmbzPuw32CR5+X2HyXn1QauZLcewYhQ/zRwW0sopazF5qoESP
         ZccYBOn8+y8zKe9Ij9Wfe9xTla8Et38ycezlE71aS7xo6rlww/WYRjbyO0Q7BvRPL8E+
         4lTMAG0rMVnl2wfAR2+B81voGR/nY/3snNh/4RRXhS5OkSoReBBIUFDtg+ewhP6Pelhl
         QiHA==
X-Gm-Message-State: APjAAAXOVnlq4eoluC7LC5LQWtSA/P0bajTgKqQLWP77mKf98i+JGiTw
        ivGV0/f68LkmregdDYnDhden0HkpXOFjCxedlboj/2/6DJoVqD70Mq7MokgF/q5QpFEaUI7lz8R
        Y9BxUgSseVyY+ehjUpDcW4RLMGnjOKUob+HOuH+GW0Q==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr8095285ljk.92.1570162917779;
        Thu, 03 Oct 2019 21:21:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCGwPRRiYf1Q/eIA5nDBwCgRpd6pymD6rSMeHLbsHofWwEDUxAhe/APLSwXlX8W/Naztv6mOgh6eqkN86P1gI=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr8095273ljk.92.1570162917489;
 Thu, 03 Oct 2019 21:21:57 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 3 Oct 2019 21:21:44 -0700
Message-ID: <CABvMjLTicqk-ncY18j=UCZhCCugTVkPWKjkWZj9yEccUp3m8XQ@mail.gmail.com>
Subject: Potential uninitialized variables in power: supply: rt5033_battery:
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

drivers/power/supply/rt5033_battery.c:

In function rt5033_battery_get_present(), variable "val" could be
uninitialized if regmap_read() returns -EINVAL. However, "val" is
used to decide the return value, which is potentially unsafe.

Also, we cannot simply return -EINVAL in rt5033_battery_get_present()
because it's not an acceptable return value.

Thanks for your time to check this case.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
