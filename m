Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE77C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2432F2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="e1IXm1t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfECAlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:41:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39205 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfECAlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:41:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id w130so2800483oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SHIb7mMlQkdwyCNw9OmBZQRiEVvms1FbzqlKO0H0jyU=;
        b=e1IXm1t3gKlTz2nFZZhNAzGsgTFDXyOgM3CFnu4chnqlechdZ7feD30cbyHmMI5HHL
         Mow0+iu80TVLHPyMx1LwR9PuBhoBHNdhmDP4ahBt00mnUknZ8tdK5CEfHgeOiftwVL0S
         F5KwPhWFCCeZpNAS0pz0EsQW4O3toomBI0UHHT5HsSM2H9gakq2uQPs8CTymYw5aTArB
         GAUHldWl2nCQQ5HdMNPl5hcpiP+LINUzdOtMtfIPK+9cTWWmQXy3Gd8fS1jVCKi3RMxF
         xmqYUQj3Rn2ZSQ+YTn8wmsjBK0VE8AS4n33Qkh/623T5y/inK3uqJblSvzvsWPFjELMJ
         yjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SHIb7mMlQkdwyCNw9OmBZQRiEVvms1FbzqlKO0H0jyU=;
        b=Z3zJX1OpXp5ebXhufRGBRovZIr7ij+naVSpFQg4ML0GloPMvIY9vE7b1KaD1L0n2Un
         FyH7dkMU933M5GA99CVPW10hoVlUCJ4ss182NF/qbK0N5ncAvrzkgRWa+0gCbJ90dUbu
         J2FacstvFRvkIxkTtL7S1uynPbdl7dy9lp+17gudOf/Alymp+K4UaFxXbPX6kvBtPJ0V
         /fcHQu5oiU2iWBXzcsH//+yn3JLFeBunFnLij69uIRfg0Gi6Ln5VtnLwhuG7bqUHjXnS
         jEtLTArRBzipaLe3m51bP4ymGyd0VgJPSdBnC6TSNrON3FKMN6ajb700MsjasgnxagyM
         VJzg==
X-Gm-Message-State: APjAAAVlUOHJ+1xiIJDrK1N12+hsj9/1fwtF3aXCMTK1rWly7upNNAsK
        uUhJ4r1CAhsLmSnogrLRN8NqhPE4OnV2ZGp2oeFA50geHTdcxw==
X-Google-Smtp-Source: APXvYqyHWUCZG/bYwe3R1gmgamI4fU+xS8/lH0BFReBkq0nRMUCer+rB8GXaCig08T80kfmw9To4vMkmNRhGU8dh5W0=
X-Received: by 2002:aca:47c3:: with SMTP id u186mr4629092oia.105.1556844076989;
 Thu, 02 May 2019 17:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
In-Reply-To: <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 May 2019 17:41:05 -0700
Message-ID: <CAPcyv4g+KNu=upejy7Xm=jWR0cdhygPAdSRbkfFGpJeHFGc4+w@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 7:53 AM Pavel Tatashin <pasha.tatashin@soleen.com> w=
rote:
>
> On Wed, Apr 17, 2019 at 2:52 PM Dan Williams <dan.j.williams@intel.com> w=
rote:
> >
> > Up-level the local section size and mask from kernel/memremap.c to
> > global definitions.  These will be used by the new sub-section hotplug
> > support.
> >
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Should be dropped from this series as it has been replaced by a very
> similar patch in the mainline:
>
> 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
>  mm/memremap: Rename and consolidate SECTION_SIZE

I saw that patch fly by and acked it, but I have not seen it picked up
anywhere. I grabbed latest -linus and -next, but don't see that
commit.

$ git show 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
fatal: bad object 7c697d7fb5cb14ef60e2b687333ba3efb74f73da
