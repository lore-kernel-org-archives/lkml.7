Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB35C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F712182B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="l+5kJ6to"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfFZQOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:14:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47063 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:14:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id z23so3062167ote.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XK0CaHJOVcsS/u0euQkBQYUAFEHomal+V6KfwmFuG+U=;
        b=l+5kJ6tokPJ98bH2NME9M/AQ27NvFMKuOsXn1/Bb6bOBzelrSngvtDZJXmVwZKzpKi
         qjSD/BPNZzWpZiBQzbopXZ4t+Owe9yGEnJZxcLTPAlrrPvnYO2K7gCbSAaaiJHFcBp4k
         rxUq8p1DHnLMI0fRDu2WCtVRP/OHmPtRFurCHJX0OhgjoUZQUqGECtXD/hiUSR9PPelH
         MnkCXYqaYmm4WKtHJZYWuY7L6Kj9qhni0KNGsJokbTzfJurnEEHErfJ69HKEvmfEeo+E
         N7IwPwAkdbg4plX6eEOz52RHtcXnuvonc5/m143W02YNIvHsz5xJAtpZFJ8Hrcf91kdm
         NShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XK0CaHJOVcsS/u0euQkBQYUAFEHomal+V6KfwmFuG+U=;
        b=t7yI0Oj1TgYg10prz38mKHpoAPrDXWPlrAwQTrghIG0YvpKzLg1u64jEO8YNha360a
         Wpk4Ek0f2ea4OO9njlevMFaF/u6lPFp6u0f/smb2+DobFqaKSx5XcjtAg7rJSpB19Gqt
         /lgArCfMYYpQVn6wIq43LoYBMUulK+fPphowwIf0PApbxvufouXQnHeRwv0jwlZNBq//
         J8MA+wvdedEtl6n7XP4ZmPMNzU6vtSsP1yIfMZvyA5vN/v0w+myct5F/ezsP0HU11vtI
         +7OaLrmCsIaEFmRaPmt+hT/ndY5TSVXjdNS9D4BzHNfr0XUCupMSBIZWEnGCwHalqXM7
         O/5Q==
X-Gm-Message-State: APjAAAV7PYHnUE2fgJxgXdgwST6xwtyxGDecsjdN5qxUlDwDEkUeoezX
        Avhbu43gVIAtejMlP9pTeyGXbErRh9kEuN3wLVB5Mw==
X-Google-Smtp-Source: APXvYqxlK4A4nPLhfNez6panLCe0oG2uZ68rpjoeO+K9OBDO45YdiJCTPi2DLYKpN0RI7gOpjzzUX8DJkFMKIZ4j7YA=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr1155884otn.71.1561565683159;
 Wed, 26 Jun 2019 09:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz> <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de> <20190625150053.GJ11400@dhcp22.suse.cz>
 <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
 <20190625190038.GK11400@dhcp22.suse.cz> <CAPcyv4hU13v7dSQpF0WTQTxQM3L3UsHMUhsFMVz7i4UGLoM89g@mail.gmail.com>
 <20190626054645.GB17798@dhcp22.suse.cz>
In-Reply-To: <20190626054645.GB17798@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jun 2019 09:14:32 -0700
Message-ID: <CAPcyv4jLK2F2UHqbwp4bCEiB7tL8sVsr775egKMmJvfZG+W+NQ@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:46 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 25-06-19 12:52:18, Dan Williams wrote:
> [...]
> > > Documentation/process/stable-api-nonsense.rst
> >
> > That document has failed to preclude symbol export fights in the past
> > and there is a reasonable argument to try not to retract functionality
> > that had been previously exported regardless of that document.
>
> Can you point me to any specific example where this would be the case
> for the core kernel symbols please?

The most recent example that comes to mind was the thrash around
__kernel_fpu_{begin,end} [1]. I referenced that when debating _GPL
symbol policy with J=C3=A9r=C3=B4me [2].

[1]: https://lore.kernel.org/lkml/20190522100959.GA15390@kroah.com/
[2]: https://lore.kernel.org/lkml/CAPcyv4gb+r=3D=3DriKFXkVZ7gGdnKe62yBmZ7xO=
a4uBBByhnK9Tzg@mail.gmail.com/
