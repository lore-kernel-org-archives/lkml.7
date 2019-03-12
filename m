Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B255C10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C9D2148D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tjGdxu/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCLAaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:30:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43108 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfCLAaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:30:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id i8so631616oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96Eychx0pVXg5tC/lmw3nK92/kMpZpAcq39GwifwZoI=;
        b=tjGdxu/bVPVh9Ua5UQ8YtA22eqApz6aIzFPfYx/7CDlBMSMlZHU0eHNZdkYmi1qjsS
         OmHTQI2f2eb5YiKYmgKeN4CALQM8TaBXKfhHPZtA8LlA+Wl4IaWsIyyoHe4RKeXN7JyK
         2oqiCUcYuzjD19Oz1vcxDOEwP0keO3Js0AntCZkGr7o3wJubBd7j754AQ+BahUJ7weyW
         VnQqxBLf8Pc9NU6+/3PfC/AMuqlQ4wQ3rdM2pF8OGCN3nhQ1++j3cDp98NsucCoxQeyc
         omm/sgZP15MkyeSNXf1CWIYFvXT//dFW7uamAA9EMQFBEQuF8Kiv3pSRBCXxmG/SLHfO
         FDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96Eychx0pVXg5tC/lmw3nK92/kMpZpAcq39GwifwZoI=;
        b=pNcllbfhl36d23IB28Ggc6iPn/neShXJZMClgrbffc3PqynxUyoatbpFLHKey8F+ud
         GUphH/X9ArbGSto1wLfYGlnKk8I+JWRJT69hAJA7EMR6ilLw/QzEc2jVRDlWbjM2Mlwv
         6bDFbYBlVF7Qp94D8spJKn2KTINFLf1s1PWEJ2uZF1sCGZ0GLDA1SPSXRT/bdqjTCK9T
         tjk/CvnOuPXpMO8fuocTPLzqzuOrqmTqZXqM+812D2bWVFzxUitufAmZMpz3Ajn7OI2t
         zo08YGZx1HuwvMVksRL+qFCtzGrMUSzin+d9aWAa1qWP+ATnvP3hITPF3t99dSri9siu
         ZCJg==
X-Gm-Message-State: APjAAAX8DNySVaLNt1ElE/e/EtDjK7ndbphD21JJxcLWybpWsEdIu/C9
        HciHt5ud38lV2gYE2UXu7SZPE7alvutUFHfM6nysMw==
X-Google-Smtp-Source: APXvYqwlMK4Ji22rFS+MBGh9COVQcs3fw5qaMUPzkLdofXvv/AYErEbzrXXcIHwPq5L/VyLOpy4O8NJyIgC70phvAJ0=
X-Received: by 2002:aca:3906:: with SMTP id g6mr10168oia.149.1552350611637;
 Mon, 11 Mar 2019 17:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
 <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
 <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
 <CAPcyv4hMZMuSEtUkKqL067f4cWPGivzn9mCtv3gZsJG2qUOYvg@mail.gmail.com> <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Mar 2019 17:30:00 -0700
Message-ID: <CAPcyv4hjfOjLU8x366eDy57FV-=6Xb5sdCr7u-+r8OZe2RwMHA@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 5:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 11, 2019 at 8:37 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Another feature the userspace tooling can support for the PMEM as RAM
> > case is the ability to complete an Address Range Scrub of the range
> > before it is added to the core-mm. I.e at least ensure that previously
> > encountered poison is eliminated.
>
> Ok, so this at least makes sense as an argument to me.
>
> In the "PMEM as filesystem" part, the errors have long-term history,
> while in "PMEM as RAM" the memory may be physically the same thing,
> but it doesn't have the history and as such may not be prone to
> long-term errors the same way.
>
> So that validly argues that yes, when used as RAM, the likelihood for
> errors is much lower because they don't accumulate the same way.
>
> > The driver can also publish an
> > attribute to indicate when rep; mov is recoverable, and gate the
> > hotplug policy on the result. In my opinion a positive indicator of
> > the cpu's ability to recover rep; mov exceptions is a gap that needs
> > addressing.
>
> Is there some way to say "don't raise MC for this region"? Or at least
> limit it to a nonfatal one?

I wish, but no. The poison consumption always raises the MC then it's
whether MCI_STATUS_PCC (processor context corrupt) is set as to
whether the cpu indicates it is safe to proceed. There's no way to
indicate, "never set MCI_STATUS_PCC", or silence the exception.
