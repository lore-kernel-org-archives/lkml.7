Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD6C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F56620869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lQ5hlKkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfDTQei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:34:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45142 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:34:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id y84so5875275oia.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2nkNuARp9X01dKfEBOtMwOp996ppluuGSD9cN/HBKF0=;
        b=lQ5hlKknHgUdIgtdCdSW+BlZNAFfLwu4hWsS9k88Ag24YEMBmAwCWE3/CkQVyeYzeg
         3DBa/mRqMobf0jbS4KDLFQpX2/bLaOPnc0J0DAzpIxxqngPpoOFIZcZ1Ig2O2j1EO3wf
         GAun3ArtW1LScidQo9nzjwulZ5rXl5sF8L72MNAsiCJCkFtoO5KK4A8jdV4ivGcF97H+
         I44a7FkspL8ec+mXvswIjUGz6vQ1DsIc+M8DgUzXLsv2YU7wNEYsP/zx7o4x1/zNh3AH
         Tv/+hv9FI06FU/1rSvaLo8VX4p/Z2DHQwjQ2PjY8ERIoNlVwd9PcVwuwgdbAyuDsq3tt
         oQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nkNuARp9X01dKfEBOtMwOp996ppluuGSD9cN/HBKF0=;
        b=nNHQBlImLzij2UifN/YclQBl0h99GIhQtp0FQlFCqQqXNHfg9zjnxxQ/06ZI6CDfgY
         gbSJG1AaMOIgkLwrnmab8qz390m7VEyoiXXbA3SkZeGqb5y/8VCXFwun8iUK5fn+d9w5
         CkzqEmpw9ADOUiEaqlaLG0QfwvDxnnUeFJmmHionBi2YsQtvMjasF+0MfpX3ukk33ReP
         bdGZpb5JLvPekRda/njMkLQrQ/Vl+SeoFRf4eRNlLY9tK5Ll00iq+q8RcrDfozeJ6GL7
         TnSIL+sps2yCjk2JtupgddA4m2MzZPBxOroHIlzNy9maCl7Mls6P2m9xvh9NeuS3FNFg
         1W3w==
X-Gm-Message-State: APjAAAXhmnhyIbKva1BRPHyLs8MAmADyNBb7r7gw9bErm3ExTJCAbELD
        3Y9QU7eQu1qZNpkXYARwZ+bSPvQB1SpAuZ91QiVhpA==
X-Google-Smtp-Source: APXvYqwPxWJkMWqyvsgPZQqhL3+W5zzE3UErLcb18t7ERNXhzlO8we8FPAnQV+jOk6LI1G7NFpMMK/IvtwiYI/3C0cA=
X-Received: by 2002:aca:d513:: with SMTP id m19mr5252902oig.73.1555778077724;
 Sat, 20 Apr 2019 09:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com>
In-Reply-To: <20190420153148.21548-1-pasha.tatashin@soleen.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Apr 2019 09:34:26 -0700
Message-ID: <CAPcyv4h73gUwntDYx012qcyMYCmzZDU3HOvKcW5DRkO-GoTc+w@mail.gmail.com>
Subject: Re: [v1 0/2] "Hotremove" persistent memory
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 8:32 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Recently, adding a persistent memory to be used like a regular RAM was
> added to Linux. This work extends this functionality to also allow hot
> removing persistent memory.
>
> We (Microsoft) have a very important use case for this functionality.
>
> The requirement is for physical machines with small amount of RAM (~8G)
> to be able to reboot in a very short period of time (<1s). Yet, there is
> a userland state that is expensive to recreate (~2G).
>
> The solution is to boot machines with 2G preserved for persistent
> memory.

Makes sense, but I have some questions about the details.

>
> Copy the state, and hotadd the persistent memory so machine still has all
> 8G for runtime. Before reboot, hotremove device-dax 2G, copy the memory
> that is needed to be preserved to pmem0 device, and reboot.
>
> The series of operations look like this:
>
>         1. After boot restore /dev/pmem0 to boot
>         2. Convert raw pmem0 to devdax
>         ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
>         3. Hotadd to System RAM
>         echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
>         echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
>         4. Before reboot hotremove device-dax memory from System RAM
>         echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
>         5. Create raw pmem0 device
>         ndctl create-namespace --mode raw  -e namespace0.0 -f
>         6. Copy the state to this device

What is the source of this copy? The state that was in the hot-added
memory? Isn't it "already there" since you effectively renamed dax0.0
to pmem0?

>         7. Do kexec reboot, or reboot through firmware, is firmware does not
>         zero memory in pmem region.

Wouldn't the dax0.0 contents be preserved regardless? How does the
guest recover the pre-initialized state / how does the kernel know to
give out the same pages to the application as the previous boot?
