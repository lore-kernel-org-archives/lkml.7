Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4639FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165922071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq4wgxhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfKZOKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:10:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35403 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKZOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:10:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id n4so21543462qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtZkdml7U6qj2jxVG0aJfMPhl8Pc8rIq3csWsA0rzgQ=;
        b=rq4wgxhyGph7sMBYDEYoIFwxMRzv9XdXXTVxbaJBLaAFOGnCuIXHI+W4F1pJ8Q28ff
         lX50oIWJuUpCB4JX+WjfvnD/bke0OdsN+c6yGjNE3zw4MYkJFKz1dKmfPbsCxBInR+T6
         yDFl7010NbDnqlR/JTo3tqNLnqStfAEB47hVmOsG+uGKb2l8oXonsRYZl/gHxpREC1cw
         EPP8gQskJB2D+IlXtqC60v3Nxwbp459YQCSu1XeSP5H4K5K5B0GNrZwRD0t3qbo1ilXV
         guSzjHfClGo0KgQ3vStfTvG82+E8i1dSn34agTtYdmR65iO1cS2pNLMuEHclMvSMBZfR
         Y/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtZkdml7U6qj2jxVG0aJfMPhl8Pc8rIq3csWsA0rzgQ=;
        b=TtkBtvU6DBi99Dh72TVSOgCA1e9irq/qvTrDBAXH8viK610YvLPMTc/txnnrQMHzUv
         6WPRFLkR2I/J2INoOsO6TssxaPAqGfp5Ox4Cr2spqcvt+6p0JdJc1GwzXULDG7s69Cux
         z6LDgcOjvtlB7zF9SFDsC17XE43ZK1ThI0TsbHFjac/tM1qwUtyLEHz4zw2rmtmC2Fsb
         kuQfpnR6G18iKtMT/IvIQtM6r3Mld1rHzSpOHiAGSTlcv6F/4tht2P705nt95jcs9ABL
         X4xArCKYLAvIX6HsUXzZp2kmt10DJaSgjgFTSMgQeyXPZU7R/jEUgy6E99/EIT3qVgxy
         Snqw==
X-Gm-Message-State: APjAAAU0Vn2botZGBmMuxv3yzozTqYU3ju75yQmMsfRGwRMmr99J4NEm
        seC/W3fUQZ0JTrcNpT+6m1hkTU2mjR/uUNi82no=
X-Google-Smtp-Source: APXvYqzOrJdvvaM25hHIRi2TGSLvSpPFpJq4poExivCZHlAX3I639X3QB/w2UwsbUIUf9Mu8aT8+ulVlS6cNpips5Mw=
X-Received: by 2002:ac8:1b41:: with SMTP id p1mr26799235qtk.353.1574777396781;
 Tue, 26 Nov 2019 06:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20191125142018.GA21373@haolee.github.io> <cf85d546-3b6c-e172-3624-0e40e0f7699c@arm.com>
In-Reply-To: <cf85d546-3b6c-e172-3624-0e40e0f7699c@arm.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Tue, 26 Nov 2019 22:09:43 +0800
Message-ID: <CA+PpKPkecQmqZya_iHP9bMvfrz-mYEP0bazAtWj1YbE-uTfCOg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix comments related to node reclaim
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 at 17:42, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 11/25/2019 07:50 PM, Hao Lee wrote:
> > --- a/include/uapi/linux/capability.h
> > +++ b/include/uapi/linux/capability.h
> > @@ -273,7 +273,7 @@ struct vfs_ns_cap_data {
> >  /* Allow enabling/disabling tagged queuing on SCSI controllers and sending
> >     arbitrary SCSI commands */
> >  /* Allow setting encryption key on loopback filesystem */
> > -/* Allow setting zone reclaim policy */
> > +/* Allow setting node reclaim policy */
>
> Does this point to the capability for accessing vm.zone_reclaim_mode = 0
> sysctl knob ? In that case we should not be changing the name here as the
> interface still retains the original name 'zone_reclaim_mode'.

Yes. This comment should be consistent with sysctl documentation and
interface. Thanks for your correction!
