Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340C1C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C3727B34
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmVKplRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfFCEFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 00:05:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41756 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfFCEFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:05:23 -0400
Received: by mail-io1-f67.google.com with SMTP id w25so13126619ioc.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 21:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSsDlepu/Gv2h+jW37zv087KL7ej7kJEQqTYULWSEk0=;
        b=RmVKplReHg0sL2j2EUBICn8EXrzONwvrUn2mMxUBdCYefsBuBJKkosK4yAGfCiGUcx
         9aHC80EcMn0EeE3jSkwaIPZsxZg4dPeStRsG1pYO3VB7iM/nnwdfl3Zl0YtR8pnEMvO5
         X5uGwpChIw8jwNCQP8KOaV5bkWiOb7tPNiq5Y/l+ANODYt62XJbL5Wb2C9YU2ZlLL94L
         jWj/p4FoYnq75s2xSMMcAvVRw9X3UdxaDw2iojoAm9Lmahc3mgvn9qTOLXRl0ClqLgkG
         posT3/22lEQqVXi13RGA4YzRiswNmBNj9bVK50RNQbAxKL1Dpp1FkTYuFn2/pHxdNXzy
         4Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSsDlepu/Gv2h+jW37zv087KL7ej7kJEQqTYULWSEk0=;
        b=IazpGLzac14mxOtfBXb7dI/nDMQ6ILwrJX2FUGzk4Dt+hI6odC9DEKMoudxX04y49X
         po1ItWiEk89zkirX/fUQiIvRfBilXltD9R1xI8ayFW5SFMYYk5KIiRRABwhEHMTNPbz7
         yJMfL47Jhl5t3OoKjqsghaXKjNpKdoUru/Rau6E9hiK3zc5iDUH/hPhi07s+exvFhil8
         IFblUdURSochh5Ioiex5W4s8+GdDdtLKVWNxoQa8meOPFmuZBk+iihMuklviJWiLta0x
         ddIon+8akaMJaY3FdDWHo804RjDtHeY+ZGo5FAe9BDMJ6RynoTa5IZO90DG8TKil+koU
         NiJw==
X-Gm-Message-State: APjAAAUb09VUt0EuzmovsXb+taBVe3zopkV8+6uYd3XfuWoNhAcP1qBQ
        /qw2jSB4kJPu0qbBpH+VzVPxzcY0pHrAXdAVjG27
X-Google-Smtp-Source: APXvYqxmU/Kryj20Rs1ffPcWzCCAZzKVb0we2q0TWbrrO4z5swArh/gIW5kqLqMWArYz4SlyKxpfhGgArRMXe0deVpo=
X-Received: by 2002:a5e:d70c:: with SMTP id v12mr13169113iom.12.1559534722712;
 Sun, 02 Jun 2019 21:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
 <20190530214726.GA14000@iweiny-DESK2.sc.intel.com> <1497636a-8658-d3ff-f7cd-05230fdead19@nvidia.com>
 <CAFgQCTtVcmLUdua_nFwif_TbzeX5wp31GfTpL6CWmXXviYYLyw@mail.gmail.com> <20190531171336.GA30649@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190531171336.GA30649@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 3 Jun 2019 12:05:11 +0800
Message-ID: <CAFgQCTsWN6g__pF71qo1VAviT+98LEX6d9WLx2Lk7QktcciPqA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
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

On Sat, Jun 1, 2019 at 1:12 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, May 31, 2019 at 07:05:27PM +0800, Pingfan Liu wrote:
> > On Fri, May 31, 2019 at 7:21 AM John Hubbard <jhubbard@nvidia.com> wrote:
> > >
> > >
> > > Rather lightly tested...I've compile-tested with CONFIG_CMA and !CONFIG_CMA,
> > > and boot tested with CONFIG_CMA, but could use a second set of eyes on whether
> > > I've added any off-by-one errors, or worse. :)
> > >
> > Do you mind I send V2 based on your above patch? Anyway, it is a simple bug fix.
>
> FWIW please split out the nr_pinned change to a separate patch.
>
OK.

Thanks,
  Pingfan
