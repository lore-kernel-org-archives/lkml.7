Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D0CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C887D2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sTwfKZMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfFNROT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:14:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34461 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:14:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so3364588otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DOR0lfku3yUBhnRNWEqeIw9f7cV+CNTtUVXtGntF+g=;
        b=sTwfKZMStgwHohmnokMWPy+VfqEaV8lW2lueb7v8fb896+Vc0aKVzpBH0A2lEJlw6q
         oALCiHx77zWRNARo52nz8z+FNUxgUwVgBG+v1ofG044GSZOat+JTG9E2WNwyxxib8AG2
         gpjqossClsMvuhpes7lVdiSsvyVheT+RRZNuZS9QKm7gxXA0LXlU62z/ZeDVSIkaSKLG
         q2xdj1lK+22SHsQoDVfk25zVhm3/u/GXGDlHpOQpCSDX6j/uZMH4LMgtT9/w9S6/Uurk
         O8qQF4zoQsEqPbLE2I2goSlCiHkrB1+UDrJXIaIzjBrMd5fRfGm+SSdXADa62AeNqAyv
         0hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DOR0lfku3yUBhnRNWEqeIw9f7cV+CNTtUVXtGntF+g=;
        b=bEcuKN49m6UdqvwlYrfgYNEftLbWF/dJCmRymzxOvVRNLGDc2k7mVtjAwRZ7XqGEWF
         uOe5mnRx0rQqPgRuWkpF11e3MBzpjWXrvVu3ITvKjeocF4hHH2AgM9/9yN/dvTfXlw74
         pCsSfnUBqqP6aYVrQHzPjiQzWUkhcixZcHjWhpXW/eHwb+qBCtNvfTYMl2tt77tbX8pw
         SVglejE8D9wvLO+J5F8SYJtMgL+YYdjpGn8zIkc72lhDl0xiFu6DRpy8jMTOU1AEsTnD
         6wP2cVjM5a7YcBfz3Rq0e7I/3iNVgvIr5Hgzoph3KrAx87ML7+Gvy/qyU7oAjewT8DgU
         CUMw==
X-Gm-Message-State: APjAAAU01YH/GCLwm4lC4NjXuDOX/9cD5ohGdo2zDwMB/bf892CHWwnn
        hbpbaf7rfUcIPtjBM/xyYQqFHmD3kggBmN908aPwgg==
X-Google-Smtp-Source: APXvYqxVUrlRlBzkiByeoyFdu4dQhtacOwZjB+QoHRf7avUupN3JCPic2FiiSx+ZwD9EBq9qIkKVUnOWHfb//Vf+hT8=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr5283755otk.363.1560532457937;
 Fri, 14 Jun 2019 10:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
 <20190614153535.GA9900@linux> <c3f2c05d-e42f-c942-1385-664f646ddd33@linux.ibm.com>
 <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com>
 <24fcb721-5d50-2c34-f44b-69281c8dd760@linux.ibm.com> <CAPcyv4ixq6aRQLdiMAUzQ-eDoA-hGbJQ6+_-K-nZzhXX70m1+g@mail.gmail.com>
 <16108dac-a4ca-aa87-e3b0-a79aebdcfafd@linux.ibm.com> <x49ef3wytzz.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49ef3wytzz.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Jun 2019 10:14:06 -0700
Message-ID: <CAPcyv4iADcyPP4su4tMnyMp8_uiBu8BYCSOjOgck8hE0ZPzLmg@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:09 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
> > On 6/14/19 10:06 PM, Dan Williams wrote:
> >> On Fri, Jun 14, 2019 at 9:26 AM Aneesh Kumar K.V
> >> <aneesh.kumar@linux.ibm.com> wrote:
> >
> >>> Why not let the arch
> >>> arch decide the SUBSECTION_SHIFT and default to one subsection per
> >>> section if arch is not enabled to work with subsection.
> >>
> >> Because that keeps the implementation from ever reaching a point where
> >> a namespace might be able to be moved from one arch to another. If we
> >> can squash these arch differences then we can have a common tool to
> >> initialize namespaces outside of the kernel. The one wrinkle is
> >> device-dax that wants to enforce the mapping size,
> >
> > The fsdax have a much bigger issue right? The file system block size
> > is the same as PAGE_SIZE and we can't make it portable across archs
> > that support different PAGE_SIZE?
>
> File system blocks are not tied to page size.  They can't be *bigger*
> than the page size currently, but they can be smaller.
>
> Still, I don't see that as an arugment against trying to make the
> namespaces work across architectures.  Consider a user who only has
> sector mode namespaces.  We'd like that to work if at all possible.

Even with fsdax namespaces I don't see the concern. Yes, DAX might be
disabled if the filesystem on the namespace has a block size that is
smaller than the current system PAGE_SIZE, but the filesystem will
still work. I.e. it's fine to put a 512 byte block size filesystem on
a system that has a 4K PAGE_SIZE, you only lose DAX operations, not
your data access.
