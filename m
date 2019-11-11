Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DAEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813052173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k4eOYsri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKKVdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:33:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40425 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKVdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:33:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so15414861ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkuJdAUqLhO37Xog7hFtb+aT8vazqfXgcjtA7SyhWEM=;
        b=k4eOYsri0w6XOlZCdf7P084yo6O7L1TJstF6Pu+hSlk7vW3lwXpd2MzO0Ilq2GKM9G
         875XCJMh8bIDrXJyWLgAyisOk8QUDFGc+8VNRGP2WbGsPZ1JMy4JohvrVaFO02oAn+cG
         GT84K4jMd2C/Toq2BlvzMC3eGYdlzGljIb8UTxWPVbTtMANq/Re6Rd43fxVq5JnuhBX4
         1GKpNuxprveZ+p5cNgvazNJl9pJawzxbeMl5ugX7ZTx+ZI7h5/1jJHNumbzTKcln1oGV
         0dzztyfuHQHOlrRrPQqvUBcZw3rljLp4z4V2sHehPmt670i8GGWzYnYjVVmwqbF9k7MN
         nnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkuJdAUqLhO37Xog7hFtb+aT8vazqfXgcjtA7SyhWEM=;
        b=Ae/frqJnfFRS8/ggKIUkCwFSZraps/C+dkukIAPk8Md16RtagXBdv5TjQq1F1Fh70l
         yKQWi1AhKFgEjOlEUiBGa7B+py+2BevBxulM/Um7XmURNCZEWoj/Of9IhWYCjI5wxKYh
         B5pHsJ8ymHMNRMW6s3+8k/9JAAkDpMYVofQMtNZQHoMGQSl+56frZEDC6bkAa+C1YxFK
         Zan10s3aDhgBomA/K9UO8c1kR1nhiAGPMoMxQxNrtbOYwWKo5xE450kP8ZRuACDyfVYh
         LmGzeJbB3uaXcnD3SCijYXYvj9Fp9PuKseSfzHNErvvfY/YQBcyp5QbteNUgNgfDX7xb
         dw/A==
X-Gm-Message-State: APjAAAVCKsAVsCe/o9Rv3M/ki7TLnIzE8rJLKkTiEpGWjIyxEfUxqEIt
        MWH7W+zr8xzFeGRGImzTJZAa1AtEPfehW8Z/N4+Uqg==
X-Google-Smtp-Source: APXvYqzatbulSOotOeb73f+mEEd8AbnaVu+WC83YXOlDUc5Ps3ZfCa7y58nNWXYjZgHlfIqIWwGHKGsT3XLrSqRGFdw=
X-Received: by 2002:a05:651c:20a:: with SMTP id y10mr17533980ljn.76.1573508011119;
 Mon, 11 Nov 2019 13:33:31 -0800 (PST)
MIME-Version: 1.0
References: <1573493889-22336-1-git-send-email-alan.mikhak@sifive.com>
 <20191111203743.GA25876@lst.de> <CABEDWGyMrDnuR+AzazHqpiHC9NrHFoVcW5iFREOey04Hv7xLqw@mail.gmail.com>
 <20191111211503.GA26588@lst.de>
In-Reply-To: <20191111211503.GA26588@lst.de>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Mon, 11 Nov 2019 13:33:20 -0800
Message-ID: <CABEDWGzmagoEsCHQkDVEVG=myxNhX97Hm8A0BKdEkLc_7zrZWw@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: endpoint: Add NVMe endpoint function driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-nvme@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 1:15 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 11, 2019 at 01:09:17PM -0800, Alan Mikhak wrote:
> > Thanks Christoph. Let me repeat what I think your comment is saying to me.
> > You prefer all parsing for nvme command received from host over PCIe
> > to be removed from nvme function driver and added to existing fabrics
> > command parsing in nvme target code with new flags introduced to
> > indicate fabrics vs. PCIe.
>
> At least for all the common commands, yes.  For Create / Delete SQ/CQ
> I am not entirely sure how to best implement them yet as there are
> valid arguments for keeping it entirely in the PCIe frontend or for
> having them in common code, and we'll need to figure out which weight
> more heavily.

I will look into moving all common commands to nvme target code.
It might take a bit of time and review for me to figure it out. In the meantime,
please look at the rest of the code even though its structure may not be
desirable for upstream acceptance. These are the type of comments that
I seek.

>
> > Any more thoughts?
>
> I'd love to eventually find time to play with this code.  Do you run
> it on unrelease SiFive hard cores, or is there a bitstream for a common
> FPGA platform available?-

I run it on an internal platform meant for verifying our PCIe endpoint
hardware. I use that platform to develop new functionality to enable,
simplify, and promote the integration of our PCIe endpoints into larger
systems. As far as I know, there is no public bitstream available since
the platform is for internal use.
