Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877E021734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXZWcd+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfKAVOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:14:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33840 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKAVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:14:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id l202so9360988oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsBFzGseNwFFn5J/7iyUWJn/fmN/VHqMXH3Pl+Ts4n4=;
        b=AXZWcd+yryOPD4PVkEcKBB2NuJvQ7TNtMHwdG/PothZp+16BB1lKXLpleUSlWJUqwV
         bhqy3YgPiKCHz0JXPkanxlqh0v4gh8MA83zZGd2XOurl2G//TSjG0c0E/5Wl7JPRm4jX
         fc3Kd4Os18BKAksnMs+fT1m4/BgTiR/yCP99MNo52SJnA7mWvB/OYl55SRyfeo4PlJN9
         IJs7cTRox+DrOxbJmRzB4HyFMhVJLwrzqmNC5A084jm+NgBPv3GIKU1DpyMlHACHWnGf
         HcBCdHKRhpwGGoV4UK7HTPwSd7j8olhNpcW8orK0RjZxjoJ0ap/qA/fSplc9me5F8LHT
         vk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsBFzGseNwFFn5J/7iyUWJn/fmN/VHqMXH3Pl+Ts4n4=;
        b=FgW2hQ2/VQ778PfE/CcpsULvvxGjAiMTMYE7L/sMeGxBPglji30Xht/hJ354NCKOhB
         RW2X0y2ENZlXo75Sxa2SmO6+uAqU/CbdjfojOTCohyqM4hcTkd9VjHY6nyPnUuIKt2F9
         cuTx6aZujO/+DUYZ8AAI2pA8xmO2xC0n0Ky0JJ1LLL7CcK0p/XGilbr98wbZlUbKPGBo
         jIea+SDJNWdij3hsMJrRjEzl3AZm4ebyz3PMvWgqVo9Novby2Kkyi92xVJNpi9LFnI25
         p9K1rRqCcmlzuaENgnpodz04rujZVDeb0IOjBzvZGAposOc822xBfunSdIFUwZBLxrtD
         it5Q==
X-Gm-Message-State: APjAAAWc8pLjr9Sd6xSy1jJ0jFb5oqFG13+x8Jdpmiw+3PrOljMRHHDq
        EZbbJ6G3CpCGG9Vq4v5hsdrLF5HosrZKDkM72AnuDw==
X-Google-Smtp-Source: APXvYqwgRMsWiGTNh6WOcdU1Aoj9HbAoKkUAOYZP0eoiRwERP3bRkOhMrW6BQVW+CaXUu6pzBCRJw5nvVfmlcFWHy2Y=
X-Received: by 2002:aca:4dcc:: with SMTP id a195mr5936152oib.172.1572642857474;
 Fri, 01 Nov 2019 14:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org> <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck> <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia> <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
 <6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
In-Reply-To: <6994ae35-2b89-2feb-2bcb-cffc5a01963c@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 1 Nov 2019 14:13:41 -0700
Message-ID: <CAGETcx-9M8vvHA2Lykcv0hHWoC2OAw5kfBrjcNJN2CYCwR4eWQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To:     John Garry <john.garry@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 3:28 AM John Garry <john.garry@huawei.com> wrote:
>
> On 31/10/2019 23:34, Saravana Kannan via iommu wrote:
> > I looked into the iommu-map property and it shouldn't be too hard to
> > add support for it. Looks like we can simply hold off on probing the
> > root bridge device till all the iommus in its iommu-map are probed and
> > we should be fine.
> >
> >> I'm also unsure about distro vendors agreeing to a mandatory kernel
> >> parameter (of_devlink). Do you plan to eventually enable it by default?
> >>
> >>> static const struct supplier_bindings of_supplier_bindings[] = {
> >>>          { .parse_prop = parse_clocks, },
> >>>          { .parse_prop = parse_interconnects, },
> >>>          { .parse_prop = parse_regulators, },
> >>> +        { .parse_prop = parse_iommus, },
> >>>          {},
> >>> };
> >>>
> >>> I plan to upstream this pretty soon, but I have other patches in
> >>> flight that touch the same file and I'm waiting for those to get
> >>> accepted. I also want to clean up the code a bit to reduce some
> >>> repetition before I add support for more bindings.
> >> I'm also wondering about ACPI support.
> > I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> > I'd be happy to help anyone who wants to add ACPI support that allows
> > ACPI to add device links.
>
> If possible to add, that may be useful for remedying this:
>
> https://lore.kernel.org/linux-iommu/9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com/

I'm happy that this change might fix that problem, but isn't the
problem reported in that thread more to do with child devices getting
added before the parent probes successfully? That doesn't make sense
to me. Can't the piceport driver not add its child devices before it
probes successfully? Or more specifically, who adds the child devices
of the pcieport before the pcieport itself probes?

Thanks,
Saravana
