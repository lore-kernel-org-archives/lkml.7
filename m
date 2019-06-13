Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC65CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8165F215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NM3YEaN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392762AbfFMQly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:41:54 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39715 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbfFMQlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:41:50 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c62331ad
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=+xsFDwonOouL/xgaMNdYF45q7mU=; b=NM3YEa
        N0QYc2oN1LtaLfVCe+WHduQXzS39cMKx8ThxIeAOMqKPvlX2u430mNgg7LAIFnw/
        X/p/fvxQjv8fKnxGKu8WXHuWCNtBkzGeoZ4UMWvU6zX9t4LQzhs0apOCkyZaFYNJ
        pfWCcBoWtQtmuapq5As6KNfo0MyNRpPjMUwk1NaX7EX82egjzc9C/agLTxr+8T80
        CDBwXs+nqqr6C7xWTvECDZSYuMGDUzRcVzWCrI8pvC1gvIFdSyz4S0EGrDHkW7I9
        pD2Je2OMHzjPWxb6m/zzuIAIaP3i9dl8WsksXhSe65g4RyZyOo+nZHq9ghrqBYY+
        pFl7KgJV+WYAC/Mw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 622bf7b9 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 16:09:25 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id w7so14932173oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:41:49 -0700 (PDT)
X-Gm-Message-State: APjAAAWUgqxcM6/mKyEheDka6SpzKOuBiSPtE1zWss4G3A91M9/PeBRT
        CyNARj+paWSqNQDMJK8qzvo29V+XvSgf1nG1v4M=
X-Google-Smtp-Source: APXvYqzSxyWLIGJ5pdEVhCNp9dFzZ+7fDyo26Zj7jyFURW0wR51EC2Zm7ycoNPwlAfTQUEX2EyHA+B6L1bkdzIIwdUE=
X-Received: by 2002:aca:3a0a:: with SMTP id h10mr3676675oia.52.1560444108355;
 Thu, 13 Jun 2019 09:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
 <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
 <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
 <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
 <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de> <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com>
In-Reply-To: <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Jun 2019 18:41:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9oNr9VUiDqRHsrSg+oFmsoJfTv3yGTzjDsokUX7ZYv0JQ@mail.gmail.com>
Message-ID: <CAHmME9oNr9VUiDqRHsrSg+oFmsoJfTv3yGTzjDsokUX7ZYv0JQ@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or in case that's not clear enough:

int __init mod_init(void)
{
  u64 j1 = 0, j2, k1 = 0, k2, l1 = 0, l2;
  for (;;) {
    j2 = jiffies64_to_nsecs(get_jiffies_64());
    k2 = ktime_get_coarse_boottime();
    l2 = local_clock();
    pr_err("%llu %llu %llu\n", j2 - j1, k2 - k1, l2 - l1);
    j1 = j2;
    k1 = k2;
    l1 = l2;
    msleep(200);
  }
  return 0;
}

[    0.289469] wireguard: 17179569424000000 18446744073155127569 289468886
[    0.495002] wireguard: 208000000 1000000000 205528400
[    0.702857] wireguard: 208000000 0 207855129
[    0.910836] wireguard: 208000000 0 207979087
[    1.118871] wireguard: 208000000 0 208034819
[    1.326964] wireguard: 208000000 0 208093122
[    1.534941] wireguard: 208000000 1000000000 207976614
[    1.742868] wireguard: 208000000 0 207927167
[    1.950877] wireguard: 208000000 0 208009538
[    2.158865] wireguard: 208000000 0 207987922
[    2.367012] wireguard: 208000000 0 208146016
[    2.574931] wireguard: 208000000 1000000000 207918184
[    2.782871] wireguard: 208000000 0 207939645
[    2.991017] wireguard: 208000000 0 208148426
[    3.198943] wireguard: 208000000 0 207925281
[    3.406959] wireguard: 208000000 0 208014262
[    3.614892] wireguard: 208000000 1000000000 207934524
[    3.822869] wireguard: 208000000 0 207976970
[    4.030994] wireguard: 208000000 0 208125835
[    4.238792] wireguard: 208000000 0 207800186
[    4.446853] wireguard: 208000000 0 208056350
[    4.654978] wireguard: 208000000 1000000000 208126753
[    4.862801] wireguard: 208000000 0 207822955
[    5.070999] wireguard: 208000000 0 208198517
[    5.278818] wireguard: 208000000 0 207820902
[    5.486879] wireguard: 208000000 1000000000 208059285
[    5.694959] wireguard: 208000000 0 208066514
[    5.903011] wireguard: 208000000 0 208065258
[    6.111015] wireguard: 208000000 0 208004056
[    6.318856] wireguard: 208000000 0 207841271
