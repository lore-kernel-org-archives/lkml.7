Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A9C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C817E21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576169407;
	bh=eaCUUCpdZ+9jexLrCcFGczPuBpNoGYYZMgq+3l/E9xQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b/hbzt0xoa+obWYh0wqSaE0kMidhF6yB3m2sqIeu0Dzi21Iirte00xBAypILUTEO3
	 WbNEhpMqXCC7q9EGmgu6RpAMi49IFP5Snn3DWsAQmW5qvbMKOPZZQJKyi1VbsUnR6s
	 H14q88Hn8h+EvwfDiuNKLqQQsI+YRo2cAaLqXEqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfLLQuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:50:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45242 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfLLQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:50:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so2613954otp.12;
        Thu, 12 Dec 2019 08:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaCUUCpdZ+9jexLrCcFGczPuBpNoGYYZMgq+3l/E9xQ=;
        b=i4l9Lk0XVMNukyGJcxO7E0U5Q9Jv98x4y7i8eTujCwGCKMtQ/r8aM1lwp8gOG7IUc3
         T1+u61IvdwZ2SdS+jFeptIyp8LHhd9jvUnrVEfj+2uFUKQhgRb70WGwDZRX51W9lFuPA
         7jwcOgKs/Of0r3O2+CDY5lahzGwVEcPuQwOoiPGO5lefsZqWWDpeJNCJg5QFDVQ+4k7J
         fGa6O+SqEAfW64cJMren2nU9bWVHDbVDuRqtWp9F1ZqldqLqKTjin0ouZkl/Nafwyy2x
         poBOb0FXrJs3XAjOL643wf1w7XqmXrO6kWjqFKQjT06xjI00Uga+0kKGoRSOXVu1aub0
         Xg2Q==
X-Gm-Message-State: APjAAAXIokBEml44bvZJqq0NFq7PHwlTqqZ0jNDFuO6fu7NYWbGerJz8
        83woFNOCUsb8xpQXwaoGnBMnT96xL2veXmAvBuyJaA==
X-Google-Smtp-Source: APXvYqy8SxGzaYOvMgcZc8OPw5g1ZlMhu7aM6woCRSkpZ1ycT5QV3+ZW9Xg6QZLm8CbRVZuD0AEdYw/DWJoG5fIDvYQ=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr8617620oto.167.1576169405609;
 Thu, 12 Dec 2019 08:50:05 -0800 (PST)
MIME-Version: 1.0
References: <2691942.bH9KnLg61H@kreacher> <AM0PR04MB44814D98FDF152FB6D186B13885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44814D98FDF152FB6D186B13885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Dec 2019 17:49:54 +0100
Message-ID: <CAJZ5v0j7khsPq_Gye8vutmK8_=z1ZUCfZ4t1ENtmOdVR4qWQeg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU offline
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 2:53 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU
> > offline
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The scheduler code calling cpufreq_update_util() may run during CPU offline
> > on the target CPU after the IRQ work lists have been flushed for it, so the
> > target CPU should be prevented from running code that may queue up an IRQ
> > work item on it at that point.
> >
> > Unfortunately, that may not be the case if dvfs_possible_from_any_cpu is set
> > for at least one cpufreq policy in the system, because that allows the CPU
> > going offline to run the utilization update callback of the cpufreq governor on
> > behalf of another (online) CPU in some cases.
> >
> > If that happens, the cpufreq governor callback may queue up an IRQ work on
> > the CPU running it, which is going offline, and the IRQ work will not be flushed
>
> "will" -> "might"

Well, I'm not sure, but OK.
