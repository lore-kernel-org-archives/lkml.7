Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FEC20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1TN3qDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCRJMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:12:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46787 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCRJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:12:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id z25so16974412qti.13;
        Mon, 18 Mar 2019 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diO+Z0qGxDJJ0ZBpJXZgKUdDIvyDhO7CNExrst4Lzyg=;
        b=g1TN3qDM36M0kqJBNPz4ikuEC7xZmPHi41gHUksKa7/+NGdXmU/1QPRi1g/zajGu9O
         PvJ2NgJtgC4hG450ZapRptvS3k7pKDMPtGdLyo/srfjrNsG1cklZx/Ct8JzcsEphvw4W
         qvO6Mrs1HEOiTAtv0lYmXvBM8XEtIpZcjUqUWPCb/Htu3WKbMfNXPom0tpq5693I5DIW
         BLbeef3ddLetZe53Y/TVRukcNIt4Y2yOOlM2sSVLGudFTEL7s1zoeJq0iHnrBMCQWv0p
         7XUuJTwctq+Xsbkm7eKoQrmkmBd4au2fMMZMGNFrKeH8vU95cJ3tPeshYWrylQ807WmM
         BiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diO+Z0qGxDJJ0ZBpJXZgKUdDIvyDhO7CNExrst4Lzyg=;
        b=hL1xeBJDZH2kQQO2s9WSGfQcsanICFkZRy8zVN9dIL+HLLcn3OH9/39BcPBdzdCx8r
         xwEKhXR2nKoEuLhCtTGcEWbe51lZe4KrRDEfOQUv4hSE66nPVfCIrCBh2ghKeNb04h2C
         83kNVCGAMfN4ElrMrZmN8q5JYLJCG1NRiGBIKzZsnWWvdlYVHsGFB5kEuprPumBMMOX4
         UDLSkdSUVAIYEewN6uznO2p66ngnWj2Dg+H89qKflqlbJ6ht39qgLtl96HdSYQiJ4buU
         vYMy0p6ys9vsE8ioJGbBYzttpHs+iPr00j39JmYdgjdLWDuRQ4DH1+iL3qjD9eE2pm3B
         qTKQ==
X-Gm-Message-State: APjAAAVAu/DHvRGEOyDdTlHYoYxcrTm6TGrne/LTLTno3DaVvHoiXG+I
        eveCi2T8Qcohu5qDua2yZtLZvcWGCglHJ0iyYR4=
X-Google-Smtp-Source: APXvYqyOiiFFBljlO+W/PCpQqlX56BWBbv/daJRXBdw5QyNZxt6BWq5FsQtVCw7WuUqCDriYnFe4KpcIlJP5rs6kmKM=
X-Received: by 2002:a0c:ac98:: with SMTP id m24mr11873734qvc.3.1552900369897;
 Mon, 18 Mar 2019 02:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190312142019.30936-1-lhenriques@suse.com> <20190312142019.30936-3-lhenriques@suse.com>
 <CAAM7YAmMBv1Z4Etp5yf9K=RqpTNF0kJ3tsiAysfs_wv9mdNG8w@mail.gmail.com> <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
In-Reply-To: <CAJ4mKGZ3a9xq4HkR3JQ0yRyBCh1acm0YEz14OBUK+bQFzbVEDg@mail.gmail.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Mon, 18 Mar 2019 17:12:39 +0800
Message-ID: <CAAM7YAmt+OS8=ycPrtLLe_FqeD2F_szdkShNAPA49FOPoJd+Gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ceph: quota: fix quota subdir mounts
To:     Gregory Farnum <gfarnum@redhat.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>,
        Luis Henriques <lhenriques@suse.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hendrik Peyerl <hpeyerl@plusline.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 5:06 PM Gregory Farnum <gfarnum@redhat.com> wrote:
>
> On Mon, Mar 18, 2019 at 2:32 PM Yan, Zheng <ukernel@gmail.com> wrote:
> > After reading the code carefully. I feel a little uncomfortable with
> > the "lookup_ino" in get_quota_realm.  how about populating directories
> > above the 'mount subdir' during mounting (similar to cifs_get_root ).
>
> Isn't that going to be a problem for any clients which have restricted
> filesystem access permissions? They may not be able to see all the
> directories above their mount point.
> -Greg

using lookup_ino to get inode above the "mount subdir" has the same problem
