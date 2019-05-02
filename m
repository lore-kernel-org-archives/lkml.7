Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A014BC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE0520652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="E9hwztFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEBOxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:53:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43075 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:53:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so46737edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dKGCEW6XzK5wy4m1GTL2dVQ217lYhqpqlUuT/Q5YrAk=;
        b=E9hwztFAlWAIt12OjHM7LZjhNQKHMm9PKOV4hYhj1sqs93tmAJcAHynyx9o1m/Q62l
         eFO0D2Nb0QO2aKaA6ewG2DLDNbxH6ydmK1i7PRFe8I1cJjnmFkwwDXnCoTEyn7ae78IJ
         PuIEHYIkx6WC6q2K5Yp411ug3cQtrEbF5nb9OzScSTLtlqUPy/RjdLub06YuwK0IkspB
         HN5wBjdS0eRi95e8Gd4DiAmo5jvXp4qbwOTz6Y+cESSb4O/49jHWtaKVKs95txPsgK4x
         qhClgbyewxA1wLSADBtMzY4mgzy1iwa9Q+OfBjDBgQGOKG83eaT9rV8Isd6AuZhV3iQ5
         Z/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dKGCEW6XzK5wy4m1GTL2dVQ217lYhqpqlUuT/Q5YrAk=;
        b=sqRAkzSfxKQLYRDataIjp+7RXBFIMt8z1a3CgGUyHWx2OjTaqCxGcwWRB0UStG6uX4
         B9Yadf25BEXL8Xi9etao41SdAW+2qIXhizgvl4m1LZkkwlOQeg9QHWTUsATp/LxalFMd
         JMhewOIF2MTugNaaL9ydkM3NHGfo4DOfp/Pz1/8iXZibNFI+hoWhDFmu2ZI3FYhjI0DC
         wn8h2CNoc8RADClGtmJFv4NypYlbSvsBY0blBtkwnhKqFu1Jbs8kpH1rmFSSgA538lWR
         3DxhVSWEU3V/yyShXitw/BLAF30u1ZQMnu0cph/uH+rh2MgFhe6mojr7qf04eMQehote
         jvGA==
X-Gm-Message-State: APjAAAX1jFQz3ajRGYzaDiKRhSVUaApLgdY121LABdT6gJkmdsa8V/oZ
        Lw7aQeIXnwLacvtRDbQmjnFcAG+WxpzrkgtOcWSWLQ==
X-Google-Smtp-Source: APXvYqzG/pNwhK7Fv/OkZD+XGOAYkZEawBV2i/ZKUmVW/4byaSLkD4xJCAfKtzfrtZdWNgqALb1vdspOkKWJ8CrwwzA=
X-Received: by 2002:a50:b513:: with SMTP id y19mr2992384edd.100.1556808799112;
 Thu, 02 May 2019 07:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 10:53:08 -0400
Message-ID: <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:52 PM Dan Williams <dan.j.williams@intel.com> wro=
te:
>
> Up-level the local section size and mask from kernel/memremap.c to
> global definitions.  These will be used by the new sub-section hotplug
> support.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Should be dropped from this series as it has been replaced by a very
similar patch in the mainline:

7c697d7fb5cb14ef60e2b687333ba3efb74f73da
 mm/memremap: Rename and consolidate SECTION_SIZE
