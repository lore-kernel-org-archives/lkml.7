Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F31C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6612B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwZRENip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfEMPBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:01:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47013 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfEMPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:01:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so7336534pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wqVVN3IIgShUqzAShGWEI+byOb6ln1yA8gH7qqjTguw=;
        b=BwZRENipTYdf44NKxuyIB0lt0XfhTgELdsx+5j8XBjRFb4y/gV+ZkXtYj+r8r7aZuE
         8nMs3gaatVq38w7uj5RBuigzmFBSXh0JM0xwYo0aSV259ZAmfyql1d34478aub07/vGx
         GeIFAuf9+TaN6NDBgMLsPYbCWPgBjUwJZc5OWRPXGELo6EgPmnDLk6jOGqtmFIng6+fd
         9vEG5i1/qTvnhqwcerEvL7E5fXKNY4YqvpriP40b0rqNnZ/fkVBHGJMXu89Opfuqus5h
         fPsB+H4DtY/Nz4lMdzuUJojeg2DPdESrd4kx3MqgHADcInwqA9CWyBNPxSe4BKCQ/cDj
         EM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wqVVN3IIgShUqzAShGWEI+byOb6ln1yA8gH7qqjTguw=;
        b=UUTa/P5/dnNXIVJ4RRHwD/Cq6ZiSntI1q94xIVpMfO9j8+Ly4LoMb1+l5CUdbp9wu1
         nMDsZLAij/hcWg8r7TBX7vxrr67fPfhccSmYBCGj2QI38x8FmvO68znZ1wliCj88dUCj
         FhSpIjTYqZqvOcf4wX2QLK+8mr+F+pkFobW374A5QuS/n73MJqCddfs7Pn1D4QBb/nIE
         NiBSwruDnQ2NqgYzdCFNlxVxj8Z8WdUhzKWbvaeZyv5LdFB8DKeugRvadfYwQP0QBhkY
         lP2dbe3Q8F/GiVmhHM8N+KQL4KnrYXZfIIV9lwuufmD1aqqBe0DZeT+ObQSsL1VVvWTV
         5nsw==
X-Gm-Message-State: APjAAAW9vjt+bwpgx34ZeitE3/doiJvcJSAFRqbzWQQz37RCtgYvBE6e
        pSkK0YElxM3QCp1RFUJNT0ubVg8ZknaNIMTz7TQ=
X-Google-Smtp-Source: APXvYqzb1pC6YBP8f3TrWUM/qVw4SAVtN8Iti9N+i3omIf8rlJuWnxt3bcuzdImJEKQIWIiazHiY3NOPOlmGNNbODA8=
X-Received: by 2002:aa7:9214:: with SMTP id 20mr33394163pfo.202.1557759678130;
 Mon, 13 May 2019 08:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com> <20190513135031.GC15318@localhost.localdomain>
In-Reply-To: <20190513135031.GC15318@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 14 May 2019 00:01:07 +0900
Message-ID: <CAC5umyhT1MW_d8wjFj2qBaf1+j0b62yP_OzuGUbnV+_tnpkrEw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
To:     Keith Busch <kbusch@kernel.org>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Busch, Keith" <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "Heitke, Kenneth" <kenneth.heitke@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=8813=E6=97=A5(=E6=9C=88) 22:55 Keith Busch <kbusch@ker=
nel.org>:
>
> On Sun, May 12, 2019 at 08:54:15AM -0700, Akinobu Mita wrote:
> > +static void nvme_coredump_logs(struct nvme_dev *dev)
> > +{
> > +     struct dev_coredumpm_bulk_data *bulk_data;
> > +
> > +     if (!dev->dumps)
> > +             return;
> > +
> > +     bulk_data =3D nvme_coredump_alloc(dev, 1);
> > +     if (!bulk_data)
> > +             return;
> > +
> > +     if (nvme_coredump_telemetry_log(bulk_data, &dev->ctrl))
> > +             dev->num_dumps--;
> > +}
>
> You'll need this function to return the same 'int' value from
> nvme_coredump_telemetry_log. A negative value here means that the
> device didn't produce a response, and that's important to check from
> the reset work since you'll need to abort the reset if that happens.

OK.  Make sense.
