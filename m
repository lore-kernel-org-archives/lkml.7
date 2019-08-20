Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5860FC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E33F216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 04:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="haCfRM1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfHTEik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 00:38:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32887 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTEik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:38:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id q10so3114633oij.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTsJc2XB2ULhT5btNfz5YqFDZzAMX4YrlKJzpdakKHA=;
        b=haCfRM1mdP3nfX7azXTUWTkX4VYJbjwY4jc+E3ak3zb/Q1+VOGqLgRgEbsy3pyWICB
         zvAYiCgBRK+8dAkVv4krDHbFmnRdtaPjhz4cpLHCAE65/wVsfPUFMFMcixGZheTPXPms
         aafV2W8tyjSi4gBburO/Opb1eLDzEo0j/90LUSBXS17sLm1C/53R+92S1YUt8vUBzN+/
         U4+YUiQZEu4DVvSOKNCDAYmdydy1ywzQLQF1LZnqZ2ysxAuQMGigKwXhAw4JExvC1809
         LC3e0idPYuahq4WIZQeLES2Pzu3+u4NlHkHZDkmoTlbB8qQQWmc7sgdaCXV41prJKu5+
         po5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTsJc2XB2ULhT5btNfz5YqFDZzAMX4YrlKJzpdakKHA=;
        b=GCio/8CRU990Y1DvVTnVRBgptliIOPd9Ql8S68G9Q9Gesw2PLJNcTQxUO78lFW1uno
         X3uC6L2sEXdhJttDZnFDPolvEPsmQ/92t8DqiXiudSL7MBKQGhO2v739hK8dTozyDhlm
         /Z6bLvKTgST76ys4ox3p67g3svaZ2R99VIv4cO4+f3nGknTCNdMDrixvFogzJaiK5fPe
         oOhRm8Ro3XljQkYj0kbJPaqaXwc3+Qw0Vm7AZsa1n0nxHdsmSdiiWBtu1IsOregpAbtF
         7bJaAXH7ftb10oiyGoOoQc8Ycu3JN9bXKe2c/3++ilsRQ7syfi1ngoeM945MrbygKH3r
         3QZg==
X-Gm-Message-State: APjAAAW7HoQCG7xuGWo9l6nQAkbvPpGeValtBtZA+9PSmxnqCLGjLqc3
        yKKj3VJsIEzpwcGUKb2TeKPJn3Q4pqiS8CmnYOp37g==
X-Google-Smtp-Source: APXvYqwNAdmv8U/MMocqDHerUy4sI8jbpH839Mf4eiVmaYDc08GdXYIAOnJ1qD656K+Q7iTrImqncBEbLElGaGG5fV0=
X-Received: by 2002:a05:6808:914:: with SMTP id w20mr15019903oih.73.1566275919132;
 Mon, 19 Aug 2019 21:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de> <20190818090557.17853-2-hch@lst.de>
 <CAPcyv4iaNtmvU5e8_8SV9XsmVCfnv8e7_YfMi46LfOF4W155zg@mail.gmail.com> <20190820022619.GA23225@lst.de>
In-Reply-To: <20190820022619.GA23225@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Aug 2019 21:38:25 -0700
Message-ID: <CAPcyv4hUC5ReY9v=Lt0M=jPtg3V05suOgt4fVdT4niO_k4hN8Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 7:26 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 19, 2019 at 06:28:30PM -0700, Dan Williams wrote:
> >
> > Previously we would loudly crash if someone passed NULL to
> > devm_request_free_mem_region(), but now it will silently work and the
> > result will leak. Perhaps this wants a:
>
> We'd still instantly crash due to the dev_name dereference, right?

Whoops, yes.
