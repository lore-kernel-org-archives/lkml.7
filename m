Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19848C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE8C21A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 06:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hJ6RPPBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfKMGOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 01:14:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34549 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfKMGOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 01:14:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id 5so669337otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 22:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8/eBOEFYWm/dQgNr/pNtbBC73p9IYMi5gGkpqo2SI4=;
        b=hJ6RPPBE1NoZf0/QVupYvy9OSDziN9tXHIJgPesa3XQzwUekMxqHmy4ywWzJ7olyYn
         S25aiGORN3SKrmbL/zg3J82nKwwPyIlH7PmQWbCLsU8YVru2546iAwoNbriXDphYCHP3
         MpbJ6zeFfdnFYRNFEWoBo/jpLeE7M5vPyoMOZssjrCd54wlf2SAg74J9p7QSN2Rc3HbZ
         dxBhLBVLxCENTG/wdo2QS9QsWhp6iAHjPsEyxbnLxnN4Zf7etAvI1IsZWkGfHlLFA659
         krN85FOxSocMTjuEy7YL4rUwZsNs9tYal7YQEvS3BOcZKt5J7hBKVU3FLEUJVZFKERpY
         75eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8/eBOEFYWm/dQgNr/pNtbBC73p9IYMi5gGkpqo2SI4=;
        b=M/Iylq7cvZqlBFHKWmxllm/n4oMagQhV0a0lXUVyl2guM3OhKO+cOcqLAYAhSJM9Xz
         eTx8g6EnO6eHG3CKAd38AmF+uW0zCRXgFZIaOb3AB4QyS1dEL/nWGuDr8LnlhWO6L23R
         rDKVj1MrmK+MYWVbsEu5GxW9a/ISWfHS7sX4qnuNjw5BTecIdNYS2nJ+Z6aH8e1zYOFg
         sL33LYWUWZYdRvnzhVKbPZ/dNCrEKk61JPlflFyYLcqQMnZgH45ydjSaCE91JPjJ7bx1
         5VBHj9YQUaAkjEMw+X4sXD3vu/JXko418lRVYunQThahkeCzjxv+85lSD3NClrcHTXJn
         yW7Q==
X-Gm-Message-State: APjAAAXBbkgZg0ZJqUooUACfxmN/CuQlc31P9r7I2ApYlfrOdB2p83ep
        BKgYu9ztdtLtaGYL5OKOfWIHdxtJ8sMe2/SbrBUSCw==
X-Google-Smtp-Source: APXvYqydyDDmkM3Pb1e2pPbf9fbI2BGEVuN/kDhx0lcoQbUla4YO7+zpV4A7M6u65IKIch5dF7aZebIgX7kFjMgndhw=
X-Received: by 2002:a05:6830:1b70:: with SMTP id d16mr1213448ote.71.1573625656497;
 Tue, 12 Nov 2019 22:14:16 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157309901655.1582359.18126990555058555754.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87h839tpo9.fsf@linux.ibm.com> <CAPcyv4gTRiZuA8A7cDxCZtHJv=LZMjd=tVgq35gbc0K8BUDHsA@mail.gmail.com>
 <738e328b-9a9b-b297-8379-f0d72d06c5c9@linux.ibm.com>
In-Reply-To: <738e328b-9a9b-b297-8379-f0d72d06c5c9@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Nov 2019 22:14:04 -0800
Message-ID: <CAPcyv4iB1r7FAYEm_+vtj_BGS1k6Cu_2xG7tH9O601zrk2wNXw@mail.gmail.com>
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

On Tue, Nov 12, 2019 at 10:02 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 11/13/19 6:56 AM, Dan Williams wrote:
> > On Tue, Nov 12, 2019 at 1:23 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >>> A 'struct device_type' instance can carry default attributes for the
> >>> device. Use this facility to remove the export of
> >>> nd_numa_attribute_group and put the responsibility on the core rather
> >>> than leaf implementations to define this attribute.
> >>>
> >>> Cc: Ira Weiny <ira.weiny@intel.com>
> >>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> >>> Cc: Vishal Verma <vishal.l.verma@intel.com>
> >>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>
> >>
> >> can we also expose target_node in a similar way? This allows application
> >> to better understand the node locality of the SCM device.
> >
> > It is already exported for device-dax instances. See
> > DEVICE_ATTR_RO(target_node) in drivers/dax/bus.c. I did not see a use
> > case for it to be exported for other nvdimm device types.
> >
>
> some applications do want to access the fsdax namspace as different
> mount points based on numa affinity. If can differentiate the two
> regions with different target_node and same numa_node, that will help
> them better isolate these mounts.

Can you be more explicit than "some", and what's the impact if the
kernel continues with the status quo and does not export this data?
I'm trying to come up with the justification to include into the
changelog that adds that information.

At least on the pmem platforms I am working with the pmem ranges with
different target nodes also appear on different numa nodes so there is
no incremental benefit for target node there.
