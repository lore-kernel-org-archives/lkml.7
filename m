Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8FCC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB4220B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vp6g94SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0QG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:06:29 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47067 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0QG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:06:29 -0400
Received: by mail-oi1-f196.google.com with SMTP id 65so1947951oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWIMvxomigHpjWeHK43P8bQp7hskbPyoEW4qUC++xwQ=;
        b=vp6g94SZAEhogB8+kASBrS83edW6InCqKko2xuhZZT36olRb9uNCLMVjLyfI6OQkYT
         8otOEjJ/wDda0iFu+AgKq5gR4ZQdNDsgl1cId5NnnL1iJ/GvZXT6HuisMcGOClqUlIDC
         FjGSCO8bQLXY3sOuHvTq/VDGJlZgYzKRP7eKLh/seOIB2ogk0e13lnG4EjwF37n71ps/
         zar5oshbh8IZ1AxD5brAYSbwVO6BQCN0DWQqcd2Fb8iQvPW8X62BL2WBnTS1MxzZQhxg
         ei8ENh0k8ProSrH8xiIDZSOUsBqFhCE5qcGcZDbva8PLP4urG/BUAIMh00/WAaoWm7Us
         XyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWIMvxomigHpjWeHK43P8bQp7hskbPyoEW4qUC++xwQ=;
        b=pPJhUCXhC0YrAVCY986xlfrZg8svfyK6rt5oi8BxMwqS7Zb8A0z6ZnsanLoAxhZT+Q
         U2MRHMbQ2U/9e9Glel1Ohd+6Sx1zrTAOi8zBe70B04plpZL3txgIJEacdEZIRO7ytGif
         bT4Z+5t/3/KBVm1Kep2d0AWHV7L55iZrkGrN3EogYtlBJgBsaWN0iCXoz1gttC7LVfij
         Zd2AyOCwMFCdjolNQ8BQBSDQB9xcUs2Jb6uIN4QxRFlc6B7oX7VErUwUtgpegzX7HbXf
         5D3gYsyJIzaAAoE1WNxTqNatCOcOJ3YAv77NnooOVb8T3+BJy0pQyfdff0Ja8PWZH+2l
         h/WA==
X-Gm-Message-State: APjAAAVFAWndB/XoWk+NDV6WsEfyifd2cPzt5mP/sRh80muu2/wU/6NF
        7Vxl4pik6rB41AKJASZhd3A8qixsIXufielK0a8TLw==
X-Google-Smtp-Source: APXvYqxTBH4M/fPCrgDrZ+VdGZm5oRMIwhu+eQ9E/gvhgkhPtescyRRgvt8+s9jNs39vk0crvfXTrVskZyRmmvNYxVA=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr2695751oii.0.1561651588356;
 Thu, 27 Jun 2019 09:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
In-Reply-To: <20190627123415.GA4286@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jun 2019 09:06:17 -0700
Message-ID: <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 5:34 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jun 26, 2019 at 05:15:45PM -0700, Dan Williams wrote:
> > Ever since the conversion of DAX to the Xarray a RocksDB benchmark has
> > been encountering intermittent lockups. The backtraces always include
> > the filesystem-DAX PMD path, multi-order entries have been a source of
> > bugs in the past, and disabling the PMD path allows a test that fails in
> > minutes to run for an hour.
>
> On May 4th, I asked you:
>
> Since this is provoked by a fatal signal, it must have something to do
> with a killable or interruptible sleep.  There's only one of those in the
> DAX code; fatal_signal_pending() in dax_iomap_actor().  Does rocksdb do
> I/O with write() or through a writable mmap()?  I'd like to know before
> I chase too far down this fault tree analysis.

RocksDB in this case is using write() for writes and mmap() for reads.
