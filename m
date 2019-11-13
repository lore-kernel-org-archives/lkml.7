Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD7C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733E5222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="doPKvu1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKMB0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:26:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44262 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKMB0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:26:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id s71so250302oih.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0MB/SSMpogQj4Fcl4IC+pxpUwq0gyFs7A/amSO1m4Y=;
        b=doPKvu1gZNpcuqwOmCORE1idu0dAD0+ZV4ybOrLIR70xlU/Ld+eQ7FHZDb7gjt5NSd
         uISrpZzkm2+LjEtMuDDLkKlB7O2X18chqvg8BtH28z3+X12qZdHaQHtuQushixLAzJg7
         t983ph1Tvk4oDHv2V/w4UkB4XE4huboN+gnSOdLM32WdvXQhALzflaDwdfqPOs4q1FDx
         KHTaYVXq5pc5+JMyRNtd4GCn8D2IdH6SpPmHk2S+B8emEa5gIX6d6TAhG7Nj1WNaSqx/
         ZxFw0h3C4SOkt6WE3U5FxbkudR4vKN1cP2Z3YTQ4vcdCMRuvF/2j35Cwczb+P1sv6s+B
         KzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0MB/SSMpogQj4Fcl4IC+pxpUwq0gyFs7A/amSO1m4Y=;
        b=rSxv3HQ1kBKvkK/wFPJZmvhb0apImdUWWWzfupgigWxYq2DlfL4tFjO43zXucuqmxB
         Z4vqy485de/6RYIuv/FXsOlvIYlFCgQCXZFH2n0ddScbAisMePVf//n6XoJo+K9dN3od
         w+D2JNDuyvwdr8tMqSx73G0o79FenXntnYNRnRmcwsnggPGczaNM6KsSu48kRae+E5wh
         Mn5ZAfqSNJRWZXKmNjnuWKDGrsuENDqgkfdhvE4Pt+32oLMuAT8girkaJ0hYmsNNLHUJ
         /nCxQLuX7tZ//sgv5h1jbrBO8FMUs9NbeiVhm8AI7hUxbXmdGwSqTWgRWisSZ5NHmTDi
         MS0g==
X-Gm-Message-State: APjAAAUbXdFj944qkAPYVoMMgiFR2lcoIO6mF3yKqh398tcwPZy6FDGv
        ZTUIBfVtGs8BO57ylQ+C9VcSsvrCKPW6kRRiMx1uAw==
X-Google-Smtp-Source: APXvYqxe6zvqvkMBezUGqzKAEYSTwQ/sNKuj6ffZfvcWwiO9AOk1SDdrnEGOgdcqBDW/SJNVakQKutXfNYK60w6drc8=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr499780oih.0.1573608378184;
 Tue, 12 Nov 2019 17:26:18 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157309901655.1582359.18126990555058555754.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87h839tpo9.fsf@linux.ibm.com>
In-Reply-To: <87h839tpo9.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Nov 2019 17:26:07 -0800
Message-ID: <CAPcyv4gTRiZuA8A7cDxCZtHJv=LZMjd=tVgq35gbc0K8BUDHsA@mail.gmail.com>
Subject: Re: [PATCH 04/16] libnvdimm: Move nd_numa_attribute_group to device_type
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 1:23 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > A 'struct device_type' instance can carry default attributes for the
> > device. Use this facility to remove the export of
> > nd_numa_attribute_group and put the responsibility on the core rather
> > than leaf implementations to define this attribute.
> >
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
>
> can we also expose target_node in a similar way? This allows application
> to better understand the node locality of the SCM device.

It is already exported for device-dax instances. See
DEVICE_ATTR_RO(target_node) in drivers/dax/bus.c. I did not see a use
case for it to be exported for other nvdimm device types.
