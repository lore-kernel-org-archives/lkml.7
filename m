Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A210C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBF920702
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FCmdsICW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKMVL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:11:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40020 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:11:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so2921468otq.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VMOtDktK5nRZtvkNQ1ABpB+ui18anwf6LEg99H2kEls=;
        b=FCmdsICWDz7CiyQdNCqoFbVHGJm/vIUdM11of8QtCdEqO7kTxrmAzgtKeqkUeUm4PG
         8uarwrA7BmME+wfycpyXsjrlY0OfLFDjcp8db0KZVB1KPHsE3eaHzwerC/qPVbP5olIT
         BWOdSHrdGYBGqY6o1SWe7pGROzLjpICRv+F228I4+OxXBo1Ao3yFFOy8gdsMD9RgakZX
         w9X8/kT7zMm5mfn8BOLLEhoQiymp+SwxusRI/kp4S/eSbFHrA3Hvxnfw/pv9OJ3maDKU
         klD3Y8Gx3qNKvg+NG+WblD9vg3DYLW9rYjq1OZ3woFdcGRDFVLLlvezA5YmD5IzQljUk
         E+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VMOtDktK5nRZtvkNQ1ABpB+ui18anwf6LEg99H2kEls=;
        b=l/0KUMLqAAlBBRKlD8f1YbEM/qjAIdJzvVlB/cpJxrgNYWtxT0R4/cM3wVqVgALpeh
         wRM/KrSKtNsNRNWvK6LjquWccUWmklNCOQQy/gdf01JZkHiUFxvSMMAHhhp0cT6D6eEn
         v1983smPMk/uUjZYUF2lOvkl1uFAcTvq4R3MgZdb3VjCxZ1Ef2YVNJugFFcDpRTJgBpS
         q8vWCH5AJeULjcqqjwt7tJJ4nqoKSJzFbAn5GEWMIkCB25RLsOR7yEsXWuwwTXwZ7W9N
         guotKR6QXQgAaULkg8btXTK9P47WkgUR1I2Q13bcGUvn9tLCgzcYur5AXXntAshH9m8h
         9/kA==
X-Gm-Message-State: APjAAAWAevTK1y70ACfTp3cc+HeX9tyCB0SSMHlWYCDnaulmH8pPZ3+U
        KRRMEccDIzgsfWyyYDHwVzzvGqzVQwhZJDloMmG8NK1mpc4=
X-Google-Smtp-Source: APXvYqxSKeojpYQlGp84/x8qspq7fqr/e6I8/BHRNkdeEoelyfRcWNtBcKSzleojEZUw8yIj1FjB/HAbRbhRsY6TSDY=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr4554871oti.207.1573679517249;
 Wed, 13 Nov 2019 13:11:57 -0800 (PST)
MIME-Version: 1.0
References: <7B45B9B3-0947-459A-B4FD-9F6CB2F9EF3A@redhat.com> <28CEC8B8-AC6A-4A13-B5A4-C47DB64B45E6@redhat.com>
In-Reply-To: <28CEC8B8-AC6A-4A13-B5A4-C47DB64B45E6@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Nov 2019 13:11:46 -0800
Message-ID: <CAPcyv4gpN8kbh1i6jCDdC2OP41G3C2+7YD4rYz-3HaD_pufvyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
To:     David Hildenbrand <david@redhat.com>
Cc:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:40 PM David Hildenbrand <david@redhat.com> wrote=
:
[..]
> >>>> I'm still struggling to understand the motivation of distinguishing
> >>>> "active" as something distinct from "online". As long as the "online=
"
> >>>> granularity is improved from sections down to subsections then most
> >>>> code paths are good to go. The others can use get_devpagemap() to
> >>>> check for ZONE_DEVICE in a race free manner as they currently do.
> >>>
> >>> I thought we wanted to unify access if we don=E2=80=99t really care a=
bout the zone as in most pfn walkers - E.g., for zone shrinking.
> >>
> >> Agree, when the zone does not matter, which is most cases, then
> >> pfn_online() and pfn_valid() are sufficient.
>
> Oh, and just to clarify why I proposed pfn_active(): The issue right now =
is that a PFN that is valid but not online could be offline memory (memmap =
not initialized) or ZONE_DEVICE. That=E2=80=98s why I wanted to have a way =
to detect if a memmap was initialized, independent of the zone. That=E2=80=
=98s important for generic PFN walkers.

That's what I was debating with Toshiki [1], whether there is a real
example of needing to distinguish ZONE_DEVICE from offline memory in a
pfn walker. The proposed use case in this patch set of being able to
set hwpoison on ZONE_DEVICE pages does not seem like a good idea to
me. My suspicion is that this is a common theme and others are looking
to do these types page manipulations that only make sense for online
memory. If that is the case then treating ZONE_DEVICE as offline seems
the right direction.

[1]: https://lore.kernel.org/linux-mm/CAPcyv4joVDwiL21PPyJ7E_mMFR2SL3QTi09V=
Mtfxb_W+-1p8vQ@mail.gmail.com/
