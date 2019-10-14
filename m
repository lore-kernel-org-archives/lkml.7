Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A94C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8370C2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Zr/BdkyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfJNDz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 23:55:58 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:27644 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbfJNDz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 23:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1571025358; x=1602561358;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=pOn1r0uMbFxPbRmdPlkJRD5BpRWveMVLcjOhf0EWA0w=;
  b=Zr/BdkyZL4wgmoH6z7Aulw0LNXuszEuueXMhaDd6sCZ91AuNEuR6hD+d
   eVZwkYsLRE9GHONv/aBbFE0lz89dqtApGKKa3v5gJEMo10cKfcj03gX6/
   uQRxVOMXbzMi/i/N9apEzjzuL6n4Gtc8h/ztihiizVn77K/jvCgiGOcR/
   SJ/ADokFpSlO2y/JOKfHemeBeV8bRXhlVdFWrFTiH1VOFBTHWdyDUsWi9
   10PuDC7XdQN49H6tQ4JvuZ8lGAqjlCR9aY7pBujtmRn+nQFfEzbAXFN73
   NSfEhIGRo5OSSgaCCvvayuamUpajFCyq6uv3W6xktfR/7ono5QbNUFJ6m
   A==;
IronPort-SDR: J4MdPp7ynyysT8SeG5/SUUfxtVN6F5xa0/N+4NaJTVMG1XYlQlAMdH0MmI7X0Ft8UhN1yUV1fY
 VdnWOtvqYCQwK0eVXgBDc8Lk/V3U3xEnlZr11/L4mUA/lAgme5zzoim+cdlgQ4uYhdwy/xWK6N
 BT6O56Z9tJ9AebPrh094cqom2RGDdMm6FEBybXwc9yf+Y3kulb11GRonfhJ6JGDEUJqmDHeNUg
 9q6pPFDGgVIBkWf9famD0vF3go1PfYZXEDnzoxoYa6FXPU1p4ogvKXgY/JOphaCpbikSFxz/iV
 /9s=
IronPort-PHdr: =?us-ascii?q?9a23=3AdvOCxBIj7ZbAyz6fUtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRLfXxwZ3uMQTl6Ol3ixeRBMOHsqkC1LKd7P6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalwIRmqognctMgbipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3?=
 =?us-ascii?q?dKUMRMWCxbGo6zYIUPAOgBM+hWrIfzukUAogelCAmwGO/i0CNEimPq0aA41e?=
 =?us-ascii?q?kqDAHI3BYnH9ILqHnbrtT1NaYSUeCoy6nD0DbMb/NM1jf89YPFdRAgoPCMXb?=
 =?us-ascii?q?1qcMrd1VUjGg3eg1WNtYPlJSmZ2foQvGiG9udtU/+khW0/qwxpvDSj2sMhhp?=
 =?us-ascii?q?PKi48V0FzI6zl1zYUvKdGlTEN2ZdipG4ZKuS6ALYt5WMYiTnltuCY917IJp4?=
 =?us-ascii?q?a2fDMPyJQ73x7fbOGHc5SQ7hLjSumRJTB4iWpgeL2lhhay9VGsyun+VsWpyV?=
 =?us-ascii?q?pKoDdJn93Iu3wX2BzT7c+HSvR5/ki/wzqAywfT6uRcLUA1k6rUNYIhz6Yump?=
 =?us-ascii?q?YPtUnPBCz7lUXsgKOIakkp+fKk5/njb7jivpOcMpV7igD6MqQggMy/BuE4Px?=
 =?us-ascii?q?AOXmma+eSzzrzj8VHlTLhElfA2j7XWsIrAKcsFu6G5HhdZ0pw/5BanEzemzN?=
 =?us-ascii?q?MYkGEDLFJEfhKHkofoN0jNIP/mF/e/hUqjkDNwyvDYMb3uHI/NImLAkLj/Z7?=
 =?us-ascii?q?Z97VBTyA4pwdBY/ZJUBeJJHPWmYUL7vcfEDxY/eza5wu3nBdE1gpgEVEqMD7?=
 =?us-ascii?q?WfPaeUtkWHsLEBOe6JMb4UqjbgLLAX5/fvxSsoi18UfPHxhrMKY2r+E/h7dR?=
 =?us-ascii?q?bKKUHwi8sMRD9Z9jE1S/bn3RjbCWZe?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EGAgBS8aNdh8fQVdFmHgELHIFwC4N?=
 =?us-ascii?q?fMyqEJI5ggg+ZLIF7AQgBAQEOLwEBhEACgl8kNAkOAgMJAQEFAQEBAQEFBAE?=
 =?us-ascii?q?BAhABAQEIDQkIKYVAgjopAYM9AQEBAxIRVhALCwMKAgImAgIiEgEFARwGEyK?=
 =?us-ascii?q?DAIJ4pB2BAzyLJoEyiGIBCQ2BSBJ6KIwOgheDbjU+hCiDKoJeBIE5AQEBlS+?=
 =?us-ascii?q?WVwEGAoIQFIxUiEUbmUAtjBSbPA8jgS+CEjMaJX8GZ4FOUBAUgWmOTCQwkSg?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EGAgBS8aNdh8fQVdFmHgELHIFwC4NfMyqEJI5ggg+ZL?=
 =?us-ascii?q?IF7AQgBAQEOLwEBhEACgl8kNAkOAgMJAQEFAQEBAQEFBAEBAhABAQEIDQkIK?=
 =?us-ascii?q?YVAgjopAYM9AQEBAxIRVhALCwMKAgImAgIiEgEFARwGEyKDAIJ4pB2BAzyLJ?=
 =?us-ascii?q?oEyiGIBCQ2BSBJ6KIwOgheDbjU+hCiDKoJeBIE5AQEBlS+WVwEGAoIQFIxUi?=
 =?us-ascii?q?EUbmUAtjBSbPA8jgS+CEjMaJX8GZ4FOUBAUgWmOTCQwkSgBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; 
   d="scan'208";a="87238372"
Received: from mail-lj1-f199.google.com ([209.85.208.199])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2019 20:55:55 -0700
Received: by mail-lj1-f199.google.com with SMTP id h19so3039810ljc.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 20:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2KVWmKIsjNyLmGyKFy55mcaTZ+9zn5g8XpBLCOjHvI=;
        b=fIQjmX0mgg9wF/MqwZnL6IFtCd2BSwL4zvFL6Es4eY6e9AAdbfvhIPSAMLCDdEGFgI
         1NRAcsyMwC6g3ipHLctTQx5e6IY5P0x76U7/ur3rPvPy9DeWgFqh39Sg2ZDXt16F5uLg
         5rP35pQyd+Uca1hYcCwOt5KZcL4gSixV4tBsAnQ+H/EZ7t9IAZe2A43zAdDlPt/Ogi37
         oaLFjllReT4FpnmIc3uo0uoIHAFkQO8KDTojlyN7YWmaxndda/p0kJixx0fGRXU5/RFf
         eJcbsO3SNvIM42XKwktNkqYvCoyp0FMllcZTx0ktg5NaL+DzUBU0QZwBtNmAWu/iUOEP
         byiQ==
X-Gm-Message-State: APjAAAWFb6fVm/iwau3OmjYUmc0xI7fwoK9/9T4XcpQvyeHtVdN8+XLO
        fe+KstNVNUkjxAWxhZsUczfHi4LOjtoZCQECwwNZPDJpoFFQnUjvfuU/0YWbjt/mSY2Cxad4OMC
        hDvyibC6Ds4KFHKMUcWYmN5v4afuUpb+0EVlk6WcA2Q==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr16909122ljj.181.1571025352260;
        Sun, 13 Oct 2019 20:55:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqrE2yq/Vp75dQaJ47s/jCqRxd5GyxvhCgPQQ3aM9LvDtLLobNElr9bUoPbGK6Dqt6B7LnlW91qurjhvouo9U=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr16909116ljj.181.1571025352056;
 Sun, 13 Oct 2019 20:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABvMjLTicqk-ncY18j=UCZhCCugTVkPWKjkWZj9yEccUp3m8XQ@mail.gmail.com>
 <20191014031238.fqiytckizbrwntci@earth.universe>
In-Reply-To: <20191014031238.fqiytckizbrwntci@earth.universe>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sun, 13 Oct 2019 20:55:40 -0700
Message-ID: <CABvMjLTc8BasrnsOtRvj5zcUiyc6Qj3+sxH2Ox704qRT2GWwmA@mail.gmail.com>
Subject: Re: Potential uninitialized variables in power: supply: rt5033_battery:
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian:

Thanks for your explanation and I will send the patch accordingly.

On Sun, Oct 13, 2019 at 8:12 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Thu, Oct 03, 2019 at 09:21:44PM -0700, Yizhuo Zhai wrote:
> > drivers/power/supply/rt5033_battery.c:
> >
> > In function rt5033_battery_get_present(), variable "val" could be
> > uninitialized if regmap_read() returns -EINVAL. However, "val" is
> > used to decide the return value, which is potentially unsafe.
> >
> > Also, we cannot simply return -EINVAL in rt5033_battery_get_present()
> > because it's not an acceptable return value.
> >
> > Thanks for your time to check this case.
>
> Should be fine to just return false when regmap_read() fails.
> Will you prepare a patch for that?
>
> Thanks,
>
> -- Sebastian



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
