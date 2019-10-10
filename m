Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC621ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8645B206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="aDCBj+lF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfJJAy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:54:28 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:47616 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731751AbfJJAy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570668868; x=1602204868;
  h=mime-version:from:date:message-id:subject:to;
  bh=CvhoDmZeQv6rXDGqQHMAsw6y7CswFv+lDA2qhhTWvao=;
  b=aDCBj+lFbjGUASnGfRjML0/8gcP+1mU5Uzvr7UgIocH1RB7yB505+A6e
   jcN6IEbaH8qLa6WiOqX67GuAMlCx3vHswx/jsfdzjVr8HJpvpN2EgaAEZ
   xVzXrgs8pUc1emJZImkuCpgx7NwB2bIvnX43yfQTlrnTxC4p0oSxpRTYL
   O4ARhuCuCnjFz/Dt1pmx4HykGSwXBTj7mpe4G685T3uIRUFkKPIs9iD76
   SFGMmGryHTR0T668h4ENj4lLMmWT88vpC8f4MBPySZiwujqcQkf/smUAg
   /gV99rGXnXZHnyOhdBR2KDmGM3IiZIu/yb7erqLHgY62BByqRyIjgkc2w
   g==;
IronPort-SDR: y5IXnmO6MdjxkmEdLpT90KS7GP55LYYj2XhzbrkW9o54ILD2/SV2ppe/wKTaO8dmuTcpTw+aL6
 jnle2r/o1aMQY/Kj+wsUbzkUDY4kNgJRikJjzke6ukuFDXUMdmY8sE+K0FlFSLQvnqr0h/KLQo
 +FMD944ytUhzA4g9YUn0Xfq/BfQI83d+riU+WgLNJp/MDyyPw8A/rEfwzVouy2AMeKUUSVWW+/
 HfQSv95S9StgfqMrb6OD7lCbwUYQmIF8+xjRg+wUV7uQa1ztyL6NUim0nIWn26uhINFpyPTl+j
 BNQ=
IronPort-PHdr: =?us-ascii?q?9a23=3ARLWydxUoGQwzmVOa64IUh/Air8DV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCGt8tkgFKBZ4jH8fUM07OQ7/m7HzJaqs3Q+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLt8Qan4RuJ6g1xx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipcCY2+coQPFfIMMulYoYfzpFUAsAWwChW3CePz1jNFnGP60bEm3+?=
 =?us-ascii?q?kjFwzNwQwuH8gJsHTRtNj6NqYSUOG1zKnVyjXIcvBZ2Tfn54jJbxsspvGNXL?=
 =?us-ascii?q?NwccXLyEkjCx/Jg1uLpIz4IzyVzP4BvHaG4Op9TO+ijXMspQJpojW32Msglo?=
 =?us-ascii?q?3EipgWx13E7yl13po5KN6iREJmZdOpEp1dvDyAOYRsWMMtWWRotT4/yr0BpJ?=
 =?us-ascii?q?G0YjAHyI8ixx7Dc/yHdJWI4g77WOaRPzh4gHVldaq6hxmo8EigzvTwVs220F?=
 =?us-ascii?q?pXtyZFnMTAu3QP2hDJ5ciHTfx9/kil2TmRzQzc9uZEIUUsmaraLZ4u3KIwm4?=
 =?us-ascii?q?INvUjfGiL6gkb7ga+Mekk65uSl6P7rbqjiq5KeL4N0jxvxMqUqmsyxG+Q4NQ?=
 =?us-ascii?q?0OUnCb+OW91L3s50z5TKlWgvA4iaTZrYzVJd4BqqGnHgBVz54v6wyjADe+zN?=
 =?us-ascii?q?QYgX4HIUpBeBKGiYjpJl7PLOn7DfihmVSslilkx/TdM73/DZXCMGLDnK3ifb?=
 =?us-ascii?q?lj8U5czhQ8zdRF65JTELEBL6G7Zkikkd3TDhY0N0SI3vz+Fdhhyo5WDWeTH7?=
 =?us-ascii?q?WALa7OrVKg7Os+J+iGfoJTszH4fbxt3OLjlX80nxc3erillc8MYnepEtxlLl?=
 =?us-ascii?q?+fbH6qhc0ORyNCugs4Ufyvg1mBeSBcamz0XK8m4Dw/ToW8AsOLQoGrnazE3y?=
 =?us-ascii?q?qhGJBSTn5JB0rKEnrycYiAHfAWZ2baEM9ggyECHYGgQolpgQOutR7nzaNPJf?=
 =?us-ascii?q?GS5yYC85/vyY4xr8bTmBc95CE8NMOb3CnZRHpzmGwgTCRwwatl50Fx1wHQ/7?=
 =?us-ascii?q?J/hqlpFM5T+vQBYAczNNaI3v56AtGqAlnpY9yTDluqX4P1UnkKUtstzopWMA?=
 =?us-ascii?q?5GENK4g0WGhnLyDg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HdAgD+f55dh8XQVdFmDoIzhBGETY5?=
 =?us-ascii?q?chRcBmB0BCAEBAQ4vAQGHEiM3Bg4CAwkBAQUBAQEBAQUEAQECEAEBAQgNCQg?=
 =?us-ascii?q?phUCCOikBg1URfAMMAiYCJBIBBQEiATSDAIJ4BaRZgQM8iyaBMohjAQkNgUg?=
 =?us-ascii?q?SeiiMDoIXhGGHUoJeBIE5AQEBlS+WVwEGAoIQFAOMUYhFG4IqlxaOLZlPDyO?=
 =?us-ascii?q?BRYF8MxolfwZngU9PEBSBaY1xWySRSwEB?=
X-IPAS-Result: =?us-ascii?q?A2HdAgD+f55dh8XQVdFmDoIzhBGETY5chRcBmB0BCAEBA?=
 =?us-ascii?q?Q4vAQGHEiM3Bg4CAwkBAQUBAQEBAQUEAQECEAEBAQgNCQgphUCCOikBg1URf?=
 =?us-ascii?q?AMMAiYCJBIBBQEiATSDAIJ4BaRZgQM8iyaBMohjAQkNgUgSeiiMDoIXhGGHU?=
 =?us-ascii?q?oJeBIE5AQEBlS+WVwEGAoIQFAOMUYhFG4IqlxaOLZlPDyOBRYF8MxolfwZng?=
 =?us-ascii?q?U9PEBSBaY1xWySRSwEB?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="81815426"
Received: from mail-lj1-f197.google.com ([209.85.208.197])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 17:54:26 -0700
Received: by mail-lj1-f197.google.com with SMTP id j10so678825lja.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X6658J+R/8DLtnXNsIQxFC4BQJ5LRBc5J5W674y5UAg=;
        b=dzwqTsT/zpl7F+UQoKKiRQtWgPuUaVzvnUYdKtSKGchLUWa+GbsnV6nDumUgc920XF
         0BDSo7bHXp2EW/kgCjl0GuXQDEyh2NWOlgiPoZnjHXZKdr9RMwjyqFwcGPpzoUZc9tLo
         c1pD6Hmxl88iaFzmvRR78uLxc4WVi0pQRIrHRLUK2pRVwnQtnNt0OPGAJ7xtwgnkLE/N
         BiMq8poVGV3wzucZbh3QrEdw2ef3OtprJ2x/x0RxJjP9T843j6jj3OaqKuUuCWE2VasZ
         rRiu2a9sUC3KP5a5rTZI6bpWSZ5TQW5rA8tNmpc6GRXJhfwKNPee1CO9xDf/fnJyxzh+
         IxGw==
X-Gm-Message-State: APjAAAU6i7wbyxwgB4JXeAmbjslegE0vIGp+aGW5sZ6bXxhLIrDfJecx
        67/64ZGRH0chevOrvMyJCVh9sDMaI5AlZB1bD8820i4FSo0GA5Tq6SjNa6H7nmmUXPBrcr8xpUI
        OPKHPlUbe19zPyYQgxmzoUwMNlAWtLifdduyry5EG6w==
X-Received: by 2002:a2e:8908:: with SMTP id d8mr4003609lji.197.1570668864408;
        Wed, 09 Oct 2019 17:54:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzY65B7icoEC0DZuTwOEdfQUSKAFR9Xy0P1qnaDyFcUTJ44+DnKOYzHIZB7uhU85EAazKb8dNpcntmO+J0d0eo=
X-Received: by 2002:a2e:8908:: with SMTP id d8mr4003596lji.197.1570668864136;
 Wed, 09 Oct 2019 17:54:24 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 17:55:06 -0700
Message-ID: <CABvMjLSomcm5Yi8b8YNgJGkQkc++qdCS_SQvKfmsV0CfS+GLuA@mail.gmail.com>
Subject: Potential uninitialized variable "reg" in clk: axi-clkgen
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
drivers/clk/clk-axi-clkgen.c:

Inside function axi_clkgen_recalc_rate(), variable "reg" could be
uninitialized if axi_clkgen_mmcm_read() fails. However, "reg" is used
to decide the control flow later in the if statement, which is
potentially unsafe.

The patch for this case is not easy since the error return is not an
acceptable return value for axi_clkgen_recalc_rate().

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
