Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD929C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B044B27B33
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBfEUGlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFCEGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 00:06:21 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55736 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfFCEGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:06:21 -0400
Received: by mail-it1-f196.google.com with SMTP id i21so5404484ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 21:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZoNkUUHxuKOqMH8v2MH2iQcIXpbAzswDO7twwJlvKc=;
        b=eBfEUGlKHScAMQSLXmTl3+n687q0/LnulNE1jATXybFjerw9z2AUD1P3CHgDM8Ztem
         3UCv5c+jMQLH0zNpKIWIisVM0NjALb1RtUXdtXHN8Q80a7bAKkwjySIKYwpSeSGHHiaj
         pS/w+Ev0YyESB0ILA0nRq132uESIQG70eFYI/Mn7whlXyaw21XKWQhXB+MSGxBoU71bo
         m4Wlwlhs6Q/H5ExEWdseICg3hnyRiTNGp3940lqNX576cyLs2kRQihvj9chEMwZgZWrP
         PzMz5kYN4kqu9QNU8IvOIRtG31+Pc6e8bQs2gwl16PeEEfEKmcNJjFBZ04xThlIghkB3
         vcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZoNkUUHxuKOqMH8v2MH2iQcIXpbAzswDO7twwJlvKc=;
        b=Yp5ovQzI2ZQEWo1gnC23wLgN6sgqWxcaABEWDlZbhtl1M/G54elGZBzlAF5+f4mUQb
         KFiqH33vLq9zwhWpAsjfARKbb6m1rhPuA6G3Szi5qASV2HYalf3pykDnnORXC7ns1iYp
         d1yErv18y2wT7RWnGyeWiSNydXRuCpUwPJEoIbI/Wuat5paDrXT4duzvdeWPKUwLmORE
         MxKIhRaqD0DgVifDpXGXUm7FiXhnUNV238RFilcXRjd5bIPOD5tHfd/Q/N+qHP6jkcEJ
         em64YVUYZ3TzR7CK6nrrDjTggljJYajRTV2HAU0ujkazRaj0teJ50tMDozevjIN42FrU
         VQAw==
X-Gm-Message-State: APjAAAVju3XpPG0xiwBDKcfZhGcWDyrhfmq3M0Zv1j+XqX3VYGCQ2Pku
        Vd2Z0Pu8Qamf1neAIIusJm2kHpVd0L6iiHeDIA==
X-Google-Smtp-Source: APXvYqwGBdGiZKLcHhZGWJV3HcFD6Wn6fo+ECEMCQ4j5U5lz0Mxw2HCcEUc2RuGroT1Z9lqrPptDVKl/vohDHgsU+dQ=
X-Received: by 2002:a24:7cd8:: with SMTP id a207mr6519668itd.68.1559534780376;
 Sun, 02 Jun 2019 21:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
 <20190530214726.GA14000@iweiny-DESK2.sc.intel.com> <1497636a-8658-d3ff-f7cd-05230fdead19@nvidia.com>
 <CAFgQCTtVcmLUdua_nFwif_TbzeX5wp31GfTpL6CWmXXviYYLyw@mail.gmail.com> <d5dde9e8-3628-850e-f2b2-73c08098a094@nvidia.com>
In-Reply-To: <d5dde9e8-3628-850e-f2b2-73c08098a094@nvidia.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 3 Jun 2019 12:06:08 +0800
Message-ID: <CAFgQCTuYBdEvLpUa3-Msu8fJe55zr0_7QbQA3c0LZdgRV+zi_w@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 1, 2019 at 1:06 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 5/31/19 4:05 AM, Pingfan Liu wrote:
> > On Fri, May 31, 2019 at 7:21 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >> On 5/30/19 2:47 PM, Ira Weiny wrote:
> >>> On Thu, May 30, 2019 at 06:54:04AM +0800, Pingfan Liu wrote:
> >> [...]
> >> Rather lightly tested...I've compile-tested with CONFIG_CMA and !CONFIG_CMA,
> >> and boot tested with CONFIG_CMA, but could use a second set of eyes on whether
> >> I've added any off-by-one errors, or worse. :)
> >>
> > Do you mind I send V2 based on your above patch? Anyway, it is a simple bug fix.
> >
>
> Sure, that's why I sent it. :)  Note that Ira also recommended splitting the
> "nr --> nr_pinned" renaming into a separate patch.
>
Thanks for your kind help. I will split out nr_pinned to a separate patch.

Regards,
  Pingfan
