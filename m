Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A9C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671852085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557847209;
	bh=xQanGgKgajbHtyLgJhLsCWkGAN1PdRL7As5ataJeHr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TcCTPw+rlVt3ExF2orK6X0uo73guzLgLHv0vYa1A4Zpb6JltqcXJ25iqNA0iRBlLI
	 dTSkAeNvKXmkzLfgNLHRWWndtoeKVSHmdtou7gJqZ4DYyKlpLpBD9z/8m14l7ksdJt
	 663wuYWagT25inONuDYV6d87XeLAzJWlnwkc96dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENPUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfENPUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:20:07 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771372166E
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557847205;
        bh=xQanGgKgajbHtyLgJhLsCWkGAN1PdRL7As5ataJeHr8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MllZpyCT0BM/1JzBLxYHNTJoWfcB2/SEoCw4IV8RrlHyrb4V9+fS3wxWA9Llt18ZF
         TUi2m5qWnOXlTfBvBVhy2kNZux5UdUx0eu1WqO26J0L0LpERMgiYFEjRig7XYym/oB
         ZYgWO1/ePmHcBpJHJTqtaV5xcmvSsgTK5PVDtsqk=
Received: by mail-wr1-f47.google.com with SMTP id d12so19649116wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 08:20:05 -0700 (PDT)
X-Gm-Message-State: APjAAAV+lHafBdtEzeqnRH017L/7ubHksRYaemNbK2pJlF2Rrd7+9Rd8
        dTvyoVYzT/dowIal7LjlRd/iwEJe8kHFYZid6IJvRg==
X-Google-Smtp-Source: APXvYqwELjaWm3pDhSAXXkdctielWFjoEeoi62C+ui9DnTaRhS+mhM5kpFFLL672+S8yqjttQBVqPkUrTRqBFHVIKUM=
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr22930401wro.330.1557847204088;
 Tue, 14 May 2019 08:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan> <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net> <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
In-Reply-To: <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 May 2019 08:19:52 -0700
X-Gmail-Original-Message-ID: <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
Message-ID: <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Rob Landley <rob@landley.net>,
        Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 5:47 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> On 5/13/2019 11:07 AM, Rob Landley wrote:
> >
> >
> > On 5/13/19 2:49 AM, Roberto Sassu wrote:
> >> On 5/12/2019 9:43 PM, Arvind Sankar wrote:
> >>> On Sun, May 12, 2019 at 05:05:48PM +0000, Rob Landley wrote:
> >>>> On 5/12/19 7:52 AM, Mimi Zohar wrote:
> >>>>> On Sun, 2019-05-12 at 11:17 +0200, Dominik Brodowski wrote:
> >>>>>> On Thu, May 09, 2019 at 01:24:17PM +0200, Roberto Sassu wrote:
> >>>>>>> This proposal consists in marshaling pathnames and xattrs in a file called
> >>>>>>> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> >>>>>>> been extracted.
> >>>>>>
> >>>>>> Couldn't this parsing of the .xattr-list file and the setting of the xattrs
> >>>>>> be done equivalently by the initramfs' /init? Why is kernel involvement
> >>>>>> actually required here?
> >>>>>
> >>>>> It's too late.  The /init itself should be signed and verified.
> >>>>
> >>>> If the initramfs cpio.gz image was signed and verified by the extractor, how is
> >>>> the init in it _not_ verified?
> >>>>
> >>>> Ro
> >>>
> >>> Wouldn't the below work even before enforcing signatures on external
> >>> initramfs:
> >>> 1. Create an embedded initramfs with an /init that does the xattr
> >>> parsing/setting. This will be verified as part of the kernel image
> >>> signature, so no new code required.
> >>> 2. Add a config option/boot parameter to panic the kernel if an external
> >>> initramfs attempts to overwrite anything in the embedded initramfs. This
> >>> prevents overwriting the embedded /init even if the external initramfs
> >>> is unverified.
> >>
> >> Unfortunately, it wouldn't work. IMA is already initialized and it would
> >> verify /init in the embedded initial ram disk.
> >
> > So you made broken infrastructure that's causing you problems. Sounds unfortunate.
>
> The idea is to be able to verify anything that is accessed, as soon as
> rootfs is available, without distinction between embedded or external
> initial ram disk.
>
> Also, requiring an embedded initramfs for xattrs would be an issue for
> systems that use it for other purposes.
>
>
> >> The only reason why
> >> opening .xattr-list works is that IMA is not yet initialized
> >> (late_initcall vs rootfs_initcall).
> >
> > Launching init before enabling ima is bad because... you didn't think of it?
>
> No, because /init can potentially compromise the integrity of the
> system.

I think Rob is right here.  If /init was statically built into the
kernel image, it has no more ability to compromise the kernel than
anything else in the kernel.  What's the problem here?
