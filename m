Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4687C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E74B23431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="OzpFioaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfH3W1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:27:23 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:23601 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfH3W1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567204042; x=1598740042;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=+AxKleiBOotn72mRXxY/KudOmnLMJMiIcrvaqwrtHdw=;
  b=OzpFioaXHjOs1ZkOfgehhLN6JksrEiWwHw4FAr5GnMYaegARhvBpoG3L
   96Nvl7QtXZrxM4C/sHmjvQKJnPQWswqJ7G1wVFmvs9wjYWtmv2qVQLLvc
   4XcnLYIwmQr6mSXEY1PscQUoBjGOssX6kfUFvFI9Ho/XZw9eNDRlp2nGz
   3wHZwDiLvKnRFKoasyD+sHLuKxp/+psLpqYaFC+ohNQx4zDfmrzxxHNuP
   kJ73TP+V7K6scPeAfcf33oJbV5bbNUv4FQxHzPOTetin46Oy6oxFQLME6
   o9y8H7fAxY873hkMBbZWjp4FHUIbHD9MR7FxKq8dsmEnwd68t+DXfwGoE
   g==;
IronPort-SDR: SAHogo5alGY6w/WNw6T0bCA49MkQmmBCVIYw67MLI2OLURyjcfWF5pvPcJImrGUc39JbmRo2PF
 OIVf3Mh5MoKgH1UwoMvuT8srEwYfv/ruxPGzglIjWJ8So7gd8huFNlf8/R709LhTakKK19P/PX
 GbBAtUMgbxqI5o+/f8oOFkEuN4A80PwJSjR+vtQjrp/z34FbAWPA7TPdkrXnlhtxVKmiafLkeH
 Bv8Pr7gbxz1ja8x+N7IUyLShMOgafv7dcelaLGJRxlvLMRz95iNIX1vmH5LKLnKgSQeXGGPaH2
 EYo=
IronPort-PHdr: =?us-ascii?q?9a23=3A10fCyhKFckbbzuHm8dmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRLfjxwZ3uMQTl6Ol3ixeRBMOHsqgC0rSL+PixEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCejbb9oMRm7rAXcusYKjYZmN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU81MVSJOH5m8YpMAAOoPP+lWr4fzqVgToxWgGQahH//vxiNSi3PqwaE2z+?=
 =?us-ascii?q?YsHAfb1wIgBdIOt3HUoc33O6cTUOG1zLTIzTLeZPxV2Tfy8onIeQ0mrPCMXL?=
 =?us-ascii?q?NwcdDeyUgzGw/ZgFidspHlMC+P1ugXrWeU8vdgWPuphmU6qA9xuiCiytkwho?=
 =?us-ascii?q?TNnI4YyVDJ+T9kzIs0J9C0Ukx2bcCiHZBNrS+VLZF2TdknQ2xwvSY6zaAJto?=
 =?us-ascii?q?CjcSgRzZQn2wbfa/uac4iU+h7jVPieITN/hH99fbKwnRey8Uy5xu34WMm4zU?=
 =?us-ascii?q?9GriRHn9XSrHwN2BvT6s+ISvt54EitwyqA1wfW6u1cIEA0k7TUK4I5z7Iuip?=
 =?us-ascii?q?YetV7PEyz2lUnskaObd0cp9vKq5uj5ernmo4WTN45wigHwKKQuncm/DPw4Mw?=
 =?us-ascii?q?kPX2iU4+W82KH/8UD3W7hKk+E5krPDvJ/EOMsbu7a1AxVJ3YY79xa/EzCm3c?=
 =?us-ascii?q?wcnXkGKlJFZR2Gg5HqO17QOvD4C+mwg1C3nTd1yPDJIKfhDo/OLnfdirfhe6?=
 =?us-ascii?q?hy60pGxAo019Bf6MEcNrZUBfP4Wkb1/PzfBRw+e1ixw+HsC9JV1Y4EX2+LRK?=
 =?us-ascii?q?iDP/WBn0WP47ceIvuMeYhdijb0KrBx9uzuhH5hwQQ1YKKzm5YbdSbrTbxdP0?=
 =?us-ascii?q?yFbC+00Z86GmAQs197FbSyhQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E8AACKoWldhkinVdFmHgEGBwaBVQc?=
 =?us-ascii?q?LAYNWMyqEIY8MgW0FHZN2hSSBewEIAQEBDi8BAYQ/AoJhIzYHDgIDCAEBBQE?=
 =?us-ascii?q?BAQEBBgQBAQIQAQEBCAsLCCmFQYI6KQGCaAEBAQMSEQRSEAsLAwoCAiYCAiI?=
 =?us-ascii?q?SAQUBHAYTCBqDAIILoWiBAzyLJH8ziG8BCAyBSRJ6KIt4gheBEYMSPodPglg?=
 =?us-ascii?q?EgS4BAQGUVJYJAQYCgg0UjCuILBuYYi2mIg8hgTUBggozGiV/BmeBToJODgk?=
 =?us-ascii?q?Vji0iMI84AQE?=
X-IPAS-Result: =?us-ascii?q?A2E8AACKoWldhkinVdFmHgEGBwaBVQcLAYNWMyqEIY8Mg?=
 =?us-ascii?q?W0FHZN2hSSBewEIAQEBDi8BAYQ/AoJhIzYHDgIDCAEBBQEBAQEBBgQBAQIQA?=
 =?us-ascii?q?QEBCAsLCCmFQYI6KQGCaAEBAQMSEQRSEAsLAwoCAiYCAiISAQUBHAYTCBqDA?=
 =?us-ascii?q?IILoWiBAzyLJH8ziG8BCAyBSRJ6KIt4gheBEYMSPodPglgEgS4BAQGUVJYJA?=
 =?us-ascii?q?QYCgg0UjCuILBuYYi2mIg8hgTUBggozGiV/BmeBToJODgkVji0iMI84AQE?=
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="5435203"
Received: from mail-lf1-f72.google.com ([209.85.167.72])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 15:27:21 -0700
Received: by mail-lf1-f72.google.com with SMTP id y24so1865011lfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLm09boqVLNebbJn0KRM9g9k9tAtM8q9U95oJU1h0L0=;
        b=nsYNggDZWYFRdjvmYKw810pu7CDpC4YZQZDWHIrIsgl8lMDNtzx7PtgL0WEGMLMJ1j
         i2w4ARzFFgwaEuC3ss+Qh8vd6YaJr2XRcK+Hf2I7x9aJjjdl3o9VexHhDxWZU6gvdXSH
         yecth/BiWN2aMU90d7Q3v16Wy6vpa9NlCbmOYBazYDF19zhy29h9tGwYowM08UgcnAe7
         RYAdPmnBNoAVsRzVgOqGn9z5nI37CqEyhUuTNc1d6HdK1Zdpjd9P/O0Q2WubqKS1oqVn
         38Y50z7HTTHe9PFH6tJ+7V3QkD4rqEOwnT9rxC/MfDio1joWHDFomdWYFC28w/h3m08f
         /tCg==
X-Gm-Message-State: APjAAAXoLoSEctA8FuiZAqqdOwY/XsV7pCfLlnyWXym7tJAh/h1QnSYC
        wR/c9YzIm4i44k9/IGuv0JLLKAMvAj5eYXrq/OWZZiPyjWDM9b94yvfvLGVw8NMqgB7DRfvgk1R
        5YB8jZviaoF+0/625kkEn9K7i3zD+jUQvG36Fye5QDw==
X-Received: by 2002:a19:2d19:: with SMTP id k25mr11524771lfj.76.1567204039625;
        Fri, 30 Aug 2019 15:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNwVPvOdN/tveaY5mDrcDGRnQDZr8owb4Bj/v//Ng1I8rWXAU6aT8pAFp3c8BU1Pct5O5eSmP/cI28qOpREA4=
X-Received: by 2002:a19:2d19:: with SMTP id k25mr11524763lfj.76.1567204039450;
 Fri, 30 Aug 2019 15:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190822062210.18649-1-yzhai003@ucr.edu> <20190822070550.GA12785@dhcp22.suse.cz>
 <CABvMjLRCt4gC3GKzBehGppxfyMOb6OGQwW-6Yu_+MbMp5tN3tg@mail.gmail.com> <20190822201200.GP12785@dhcp22.suse.cz>
In-Reply-To: <20190822201200.GP12785@dhcp22.suse.cz>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Fri, 30 Aug 2019 15:27:50 -0700
Message-ID: <CABvMjLRFm5ghgXJYuuNOOSzg01EgE1MazAY7c6HXZaa6wogF8g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: return value of the function
 mem_cgroup_from_css() is not checked
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our tool did not trace back the whole path, so, now we could say it
might happen.

On Thu, Aug 22, 2019 at 1:12 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 22-08-19 13:07:17, Yizhuo Zhai wrote:
> > This will happen if variable "wb->memcg_css" is NULL. This case is reported
> > by our analysis tool.
>
> Does your tool report the particular call path and conditions when that
> happen? Or is it just a "it mignt happen" kinda thing?
>
> > Since the function mem_cgroup_wb_domain() is visible to the global, we
> > cannot control caller's behavior.
>
> I am sorry but I do not understand what is this supposed to mean.
> --
> Michal Hocko
> SUSE Labs



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
