Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9D220661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX0cFOw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCHS65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:58:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40282 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:58:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so13168375wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VulST1/2AMXIDB7yMcUjh2dvUsL5AGBI9fAMWmbuHw=;
        b=OX0cFOw+fN7wsU4MJ+XsGTmmvEisABWGmpimqwqDYufuu+CVkJjMUhIavCGCeeRydO
         yGrp4ATAlUCyxhcLJ3jtNGbF0NVEbyjVfhD2KOdnGWTp29iM//nYAFmOCK0NTX8ZrcLs
         0RRl5eGWPnxw7W5YRRLrYNtNPCITwP26EAu+2oQGxiL77eyT0FjEsPWK4yvJZxw+s8mx
         3l6KP/50KM/v/OBtbRkxSmYR+aLUO3LUHbLpP8BTvPdvUGr8QU6uHv7SzmBxlKcZ5Gmp
         RvqAqw02ZqxmkXZ7j4kwozmUOR6fx9t4ijO43nOWArHzDsQqToe5kgxZUPvEMFEZpetM
         Y3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VulST1/2AMXIDB7yMcUjh2dvUsL5AGBI9fAMWmbuHw=;
        b=kY2WuFMJBFRd0DeHqnQrE5yAhT3rK3s5RKDG9ZtGD0kwoAXbs4qpjxJqyMFk9ByU5S
         mQXdBvHpQpTC7FxSB5+B8+nu6X05XwMz9DLyndpZ2UVNkPIsbDmkEB7hNe6LVyFTq3Z8
         PMykRdEJI08ctvfu8jiYjr/ql3JOqfFzU9uvOjjnn5eiTTFa2GSWLosLb5OgwOBKSpDr
         SJ6/aTxCodgMYHPblgKWURTf8EqFTUD/FW3BYGh1CZ0ge8je5qxB167p2FcqxOzZEnDR
         qz0lUYnMUZ62VnHD47c4dHJbIrz7uxnyeR7OqjghBIkWban7s57nwO53RefggfPixNsq
         zGkg==
X-Gm-Message-State: APjAAAUqVHKMxb6QhVHuuY4AlLcihrS3I6jj+6TLhezt4WFk84ZrtFWR
        TdVHNdC5RruSDIPJlZ6qv3zQR8H8s9OTe+fFzY0=
X-Google-Smtp-Source: APXvYqzcWVb/aagPDEJZxcFDYeZGBpDtHZqjfb1iu9r6CyYAuF+HMz3kRTfj8Vxj33V/5aD/B+i/cbGA9Zl8cIW5Z/Q=
X-Received: by 2002:a1c:d18a:: with SMTP id i132mr10057844wmg.27.1552071535005;
 Fri, 08 Mar 2019 10:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20190207001312.13672-1-andrew.smirnov@gmail.com> <20190308132355.GA18218@lst.de>
In-Reply-To: <20190308132355.GA18218@lst.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 8 Mar 2019 10:58:43 -0800
Message-ID: <CAHQ1cqGxkz3F+taV5PUCkK7ayqU4QsmxOjr6-TUEgh7c38xg2Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: Share code between nvme_wait_ready() and nvme_shutdown_ctrl()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 5:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 06, 2019 at 04:13:12PM -0800, Andrey Smirnov wrote:
> > Code polling NVME_CSTS_SHST_CMPLT in nvme_shutdown_ctrl() is very
> > similar to polling loop in nvme_wait_ready(). Move shared polling loop
> > code into __nvme_wait_ready() and re-implement both
> > nvme_shutdown_ctrl() and nvme_wait_ready() on top of it to avoid code
> > repetition.
>
> Is there any deeper reason why we would want this?  It only saves
> 6 lines of code, but makes the functions much harder to read.

No, there's no deeper reason.

Thanks,
Andrey Smirnov
