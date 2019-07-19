Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FEC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D5A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfGSNPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:15:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37486 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGSNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:15:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so30866341qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJudaL79bW4omgAyQw960J8nLutDsvWcYRNzSIrImJk=;
        b=jCoqJNGJCWA+3P02O6zQLsWDtnumjqG1zR0hjSK/TPjPu35UAkb68o+BeodA/UKhXd
         9va+mA6bF+fgBBoOOVDoZPhv6TSBOqEbmPRabjpAjKkmNWjnHMzdzL/9T67k6BHC831l
         yZ8oAqsiu6pGL3G4+46yHm6lgxA8ixzS2PQ98Dv5hvjJWewdj7xAhcmicghszTg0s6xX
         zHO8i2KnKWrlhXe1n3OyzDYKEuUZyNODxJWOH5RweP28Lb9EPCE1QAQ+Wm2AZpuwQisQ
         qBmDT31TfIYgkSNP2kPtOwMjuQAovfr+SFrWK5Ghkp+gOjvhCIyQxOFDJGHDQgiiMv/F
         Q0FA==
X-Gm-Message-State: APjAAAVSMvU95isPt6nijyn0VczkuDFigUCo1Armx7Ipaze4fX26uxri
        +ZVEPMqyz+7TDXz2PuVfsTB83ly0LhWeXLpAgig=
X-Google-Smtp-Source: APXvYqzq39XuG4rtK+tyHE29oYxqImfovUD05fjkHiSfoGve5xyEVl+xDVf5xAeDYc0RTG70QnNeiTFYppx0Fl08CGk=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr37177378qtf.204.1563542139401;
 Fri, 19 Jul 2019 06:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190719113139.4005262-1-arnd@arndb.de> <CAK7LNAS49O=v8tJe+NauzsexVeg5hWNzFMFuWbCJbqc_qRv3dw@mail.gmail.com>
In-Reply-To: <CAK7LNAS49O=v8tJe+NauzsexVeg5hWNzFMFuWbCJbqc_qRv3dw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jul 2019 15:15:23 +0200
Message-ID: <CAK8P3a28026u1_x7K3kVsucUq47vL7n4_Q8dNeCNyzLpeZ9q8Q@mail.gmail.com>
Subject: Re: [PATCH] [v2] blkdev: always export SECTOR_SHIFT
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 2:48 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd,
>
> On Fri, Jul 19, 2019 at 8:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > When CONFIG_BLOCK is disabled, SECTOR_SHIFT is unknown, and this leads
> > to a failure in the testing infrastructure added from commit c93a0368aaa2
> > ("kbuild: do not create wrappers for header-test-y"):
>
> I think this should be
>
> commit 43c78d88036e ("kbuild: compile-test kernel headers to ensure
> they are self-contained")

Ok, fixing that in the resend without the #ifndef.

       Arnd
