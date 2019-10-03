Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA37C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A121520700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7rKLSrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfJCOqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:46:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45024 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfJCOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:46:19 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so6059525iol.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdbwXuh5bV4qEcKvgZf01HKoOU3JMuTQzHSwqy4Er+0=;
        b=e7rKLSrBU31at0uyKHw4kyJZiHmcMTUe49QEUNESNUa9syxwp7qu4QKioB50Y7wCq8
         e5KlDYUq4dpgJ5kLM3dl/hfh2fX3F1j4aboffPUX7GAPW5zl92o09lYa891tzm2BpX4I
         yEdnK53WgNclgiJsvIDzGw4ENp33KQmOuvIYv/sHKTdZMIcjpIwFEVFTLEqZ6P6SDMGa
         w+xxvKyISxBiP1u/gKUnZNfqKHtm59VHZyTJymIAuL3jEJToUpr6dgh8WBjN9BlPLixL
         uo6ymwGL1x3mZ5xz6xA6bT2ZKN+Vh40je10c1uE2aD9aP0x4mJQ3luKQO48VbvmM+igE
         0PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdbwXuh5bV4qEcKvgZf01HKoOU3JMuTQzHSwqy4Er+0=;
        b=gw76W3gKp3Vjqr21wQZomsObfsbSEwRsyIMPQT0wSDIcmzEPiHtCC/iA7NpEpOy0T9
         DVrtW6ccN/omB5nbYTT/kw3Eti2d17OCmUN0OOXQpERBCmYtzrAEuVbbcrZhHSCUCLix
         pgDtJAGDYmzNSh4yQI/+pRUhhBtpXjjFNGtkeuoOKZtFzT5OBv/4MRW5FyKn5pLJRjjR
         vMnTFZonmjCjjMEz4L+AKThBg7BwD09xjZho/48/+rZ95TrElGuAprRBjek7/6RwgOQX
         Srko/X7duaiiHzJLaynk4E0iWOF4/wlO7UqDWZre2u7IxihN46ZURhGYn0B22HZlcYBI
         yKkw==
X-Gm-Message-State: APjAAAWfSXLcw7pU1zblttuLa2jqwJKET38UtFg8CcmLnwjEUUyHh+j/
        mNP5CY8mZjK6/cFbop3LN760zY+Qq1m6tr5KymfWMA==
X-Google-Smtp-Source: APXvYqxLMMgyZmfknk/IaEbgrSuiiQdukVSe/Iyrfs/A49rS7Vf3MxtQ6d9wEfSV7Z7KPhphxtCUN0yer77GhWPg8DM=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72mr8544912iod.43.1570113978710;
 Thu, 03 Oct 2019 07:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5D2uzR6Sz1QnX3G-Ce_juxU-0PO_vBZX+nR1mpQB8s8-w@mail.gmail.com>
 <CAHCN7xJ32BYZu-DVTVLSzv222U50JDb8F0A_tLDERbb8kPdRxg@mail.gmail.com>
 <20190926160433.GD32311@linux.ibm.com> <CAHCN7xL1sFXDhKUpj04d3eDZNgLA1yGAOqwEeCxedy1Qm-JOfQ@mail.gmail.com>
 <20190928073331.GA5269@linux.ibm.com> <CAHCN7xJEvS2Si=M+BYtz+kY0M4NxmqDjiX9Nwq6_3GGBh3yg=w@mail.gmail.com>
 <CAHCN7xKLhWw4P9-sZKXQcfSfh2r3J_+rLxuxACW0UVgimCzyVw@mail.gmail.com>
 <20191002073605.GA30433@linux.ibm.com> <CAHCN7xL1MkJh44N3W_1+08DHmX__SqnfH6dqUzYzr2Wpg0kQyQ@mail.gmail.com>
 <20191003053451.GA23397@linux.ibm.com> <20191003084914.GV25745@shell.armlinux.org.uk>
In-Reply-To: <20191003084914.GV25745@shell.armlinux.org.uk>
From:   Chris Healy <cphealy@gmail.com>
Date:   Thu, 3 Oct 2019 07:46:06 -0700
Message-ID: <CAFXsbZrLkjsda8oM4SG6LOpfu7a=vwJ7eGM-FL8dzCKb0yzy5w@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Refine memblock API
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The iMX6 does not have MMUv2 hardware, it has MMUv1.  With MMUv1
> hardware requires command buffers within the first 2GiB of physical
> RAM.
>
I thought that the i.MX6q has the MMUv1 and GC2000 GPU while the
i.MX6qp has the MMUv2 and GC3000?  Meaning the i.MX6 has both MMUv1
and MMUv2 depending on which i.MX6 part we are talking about.
