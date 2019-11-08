Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037F0FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD450206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FRfas5SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfKHDao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:30:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40439 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfKHDao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:30:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id 22so4041759oip.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 19:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtB37+Q8xvWyEYnhovPvzQrhxqS2lBLxSLUijnwj9JI=;
        b=FRfas5SPxBMSC4DVisx8MORabFwIgq5lwySDwgKd1CXjN2fmnInTfTzfd/12Zf4kwd
         7s723mPTXcsbd4eONjrHEs1ExgPXRwpD2so5jW/aA0M1j/Mdd21FWzvKz0NNmR8g45UJ
         TSQvt/gLwuJ6jvkLvIFFG99T33Yk9Cuk+48m9VmhXMIrFyIZ5Bs2VqKW3s5qR18L4Zss
         vtb2BBZfNNSJTS8qKcpJnHqR4TdOcX/rVLqIsKfr3LD0e2zcHemW+nGkBXnGKpTnunJz
         GhcE+cPH7t8F31zni88ZgcGawamvuyZxMQMOgqg9KFlYwMrlRm/u/3PmtnsGgfNQZAV+
         TqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtB37+Q8xvWyEYnhovPvzQrhxqS2lBLxSLUijnwj9JI=;
        b=Kz7msFpPA15GS28QN7bnQ38YW1LHWt0JcTmMDd6CxwHFLc1CsGZ6/dN5BsEbybMYLw
         zICgZLwQej2rr4f6HW+YZF80S237CWvRMH5eig/RQBK6fHNCqSWhZ5u45Dtk+QgGfLy9
         NtiaEvDpaCDi/y5yaJUSyaK+YWJbghNb9E+YWp9IFwGbQ8/oFShszq33h9NRnddK54I8
         HH+TniwdYosUINOYODRMRd+Ft/44UcOtHRTCWOdrkjEGFwqd+P11NadTalyvVBeOXLCr
         XFY6vslSmgz0QuxKAFI3n1MrU+R8Yv6HqnwEo9mV2EzZY4TGD5YXEtZiC80L4y2uQFLV
         xp3w==
X-Gm-Message-State: APjAAAXDmBu0V+b4ucGN5EoHUDG8ruMY5Cm4gX8Jdm3hZnyKdoZnI8SW
        lBG01X1BCDWzseNSVE7ljgMTRJEJJVRAY/FxVxlX5A==
X-Google-Smtp-Source: APXvYqzkdkYe4VeO2i7N7ZYvtM3Hm00GKsbQ7o4949RHdq20XH0TD40W5eXI5rdUew808QiCN7vktLt6WHrVYh8m+0A=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr6733699oia.70.1573183843511;
 Thu, 07 Nov 2019 19:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20191030041358.14450-1-ruansy.fnst@cn.fujitsu.com> <e33532a2-a9e5-1578-bdd8-a83d4710a151@cn.fujitsu.com>
In-Reply-To: <e33532a2-a9e5-1578-bdd8-a83d4710a151@cn.fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Nov 2019 19:30:32 -0800
Message-ID: <CAPcyv4ivOgMNdvWTtpXw2aaR0o7MEQZ=cDiy=_P9qhVb3QVWdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] xfs: reflink & dedupe for fsdax (read/write path).
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        david <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gujx@cn.fujitsu.com, qi.fuli@fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 7:11 PM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
>
> Hi Darrick, Dave,
>
> Do you have any comment on this?

Christoph pointed out at ALPSS that this problem has significant
overlap with the shared page-cache for reflink problem. So I think we
need to solve that first and then circle back to dax reflink support.
I'm starting to take a look at that.
