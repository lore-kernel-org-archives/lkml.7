Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2430720862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 11:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwVTs6IT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfJDLT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 07:19:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41051 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfJDLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 07:19:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so6088293ljg.8;
        Fri, 04 Oct 2019 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHbbyBI0YzhubY2xK/Fy9TQHAcFSxAHRDP1G9U6X/5w=;
        b=ZwVTs6ITF1OZARiTDXBR9cv0O8YFIWaIs7/X53l22yjs/AfRrkN7vOR979gY90rnMO
         sI9K0hwQ7BPyKach/dZz40Ew01I7IMRT3lw5XUiG4szb9LGp2dXC8jZRbxQWYpoceOxa
         5/LUYHnITNZ2+adcm8RM+PfJPnn5osUlYxT8Gt7sD/lAK8sKN5gujLYkRfZka+YC/H0h
         jxU0SUFy03+x/+jvAIJJNRin8a+pv1AYdTTdRjIqHRDcweH95bPb8sjI0ikSJZHteAKe
         8TjRnAepz0Ee9ICP6F1zBNFt+M1UfpJhQw+ytV4VIbUYlvvhh3ZIFZC2yU5fac8xtIt5
         4+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHbbyBI0YzhubY2xK/Fy9TQHAcFSxAHRDP1G9U6X/5w=;
        b=HtYXqCLvEkRIX5w6C8jclGDLKYBWlDaERNcu9kAKHOphg5lMFHdPPr2S7KfvmY5wOZ
         zjwvagXKemD/t8R6Dl4pENvr6oeXNo8gwu9zDvfRmkUrNR8U0XOml23NMmleu4ls3wry
         ogEI+tjOrA9hvjRTXZ09PtzZxQc5EnVrKDppOZNNWHbZ0lfMlHK7O8gbPkSFbJqvspqN
         p+kVD1VFf5sP/YrIG4FVSl4VNFrvrA+UVnd/pW/CEApZTeK+yW7+CgCDnhpbKKWlozJD
         3QGUmN1vh3BPs6k2Iuwd3BpajnsTnjxB1TASJ9EmJitof//bklsexW4oWYbKfdkZqlLP
         6zyw==
X-Gm-Message-State: APjAAAVnaEleseJ/NuV2F5amu4qAi3ZGuPAkODWgpScHeHFuSzXtSAQZ
        g1ThTN0sq+vt2+9ojzSMiWwwEe1o3mXoT6Fz8Hg=
X-Google-Smtp-Source: APXvYqwphC/8akT4K4ZZo2FAEqmbhT5NdtBZSEXp3MGpNwS3nRBpRLJLa1fNenXtzAXvqTn8kUIkv9IvCN6TwZ0WAX8=
X-Received: by 2002:a2e:b4c5:: with SMTP id r5mr2937831ljm.54.1570187996088;
 Fri, 04 Oct 2019 04:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com> <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
 <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
 <20191003080028.GK2819@lahna.fi.intel.com> <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
 <20191004075426.GA2819@lahna.fi.intel.com> <CA+CmpXsMkwZhCegGYPYQo2GwN6ROwDYbY3RVZTEeN+FfZ-PbMQ@mail.gmail.com>
 <20191004081951.GD2819@lahna.fi.intel.com>
In-Reply-To: <20191004081951.GD2819@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 4 Oct 2019 14:19:39 +0300
Message-ID: <CA+CmpXvoro+m-NZLguMtDq_r_Og8LAFQgPGosvA+WsjMhi6m1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        nicholas.johnson-opensource@outlook.com.au,
        Lukas Wunner <lukas@wunner.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu,
        Anthony Wong <anthony.wong@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 11:19 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, Oct 04, 2019 at 11:07:34AM +0300, Yehezkel Bernat wrote:
> > > Also if you can get the hw_vendor_id and hw_product_id from the kernel
> > > does that mean you don't need to do the two reads or you still need
> > > those?
> >
> > Are those the chip vendor or the OEM, in case they are different?
>
> Those are the actual USB4 hardware maker values, directly from
> ROUTER_CS_0 (p. 287 in the USB4 spec). This almost certainly differ from
> the OEM values from DROM we currently expose.

Makes sense to me. Userspace can learn the relevant IDs that their NVM format is
known.

>
> > Thinking about it again, I'd guess it shouldn't matter much, if the chip is from
> > Intel, the FW supports NVM upgrade, isn't it?
>
> So the bottom line is that if the kernel thinks the router supports NVM
> upgrade it exposes the nvm_active/nvm_non_active files etc. I think
> fwupd uses this information to display user whether the device can be
> upgraded or not (for example ICL cannot as the NVM is part of BIOS).

Yes, fwupd already takes this into account, but the question here is how to
handle cases that NVM is available but the format isn't known to
userspace (yet).

>
> Exposing hw_vendor_id and hw_product_id may speed up fwupd because it
> does not need to go over the active NVM to figure out whether the new
> image is for the correct controller.

It's not about finding the relevant image for upgrade (which must be searched
for by looking in the DROM vendor/product values), but about the question if the
NVM format is known to userspace and skip the parsing work if it's anyway going
to fail.

So yes, I think exposing vendor ID (and maybe also product ID) can improve the
situation.

Thanks!
