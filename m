Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F605C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31E3207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 14:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbfFMO7j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 10:59:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41976 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732607AbfFMOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:52:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id 107so19230005otj.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cX5FJ+aRLK1/hJQi/LFkmdjYRZCST630rgnMW1p6Y9Q=;
        b=NfQPIfi5lqZf9K9btqqanz60LSun8pBuJoZRF0FSZYbKM1KgGA79St9zPztY8LVNlT
         kWdMQXdAdtZnhUL40Dl3Pith2JzwkzNtICOj1awCj/97xLWANOCzRh2Uw2/4bplhZC5Z
         vgfSwMoOyb7qekmiQLfOULWxEm4uyaZ/sllowp5KC4KhBS0U41OeZnMUo1eYu7NCpzdn
         QOeOZIYFIOw6fM3HkPhOGaCENtfKk3ivhL0CBa1Yg/ZMquK+acZPH6EnrwbS974jNITs
         yOd4+arOcDSbzVHqCu4bm+RaUUERSBBrcVqma+LnZ1Bi40RnrigE64PKHLEBjbehjEy5
         iB0w==
X-Gm-Message-State: APjAAAXO4E8J4wd+XyRjDH+/qYOEVhXe1u9MaUp1Cg7r+Wa0Aa7cJixb
        CPEd3HwMo+s13TpYXb5DwIUtnzGgtGwMmHmvxIVsuA==
X-Google-Smtp-Source: APXvYqxRB6BRxrdXY5Q3tPDTiXrspZ+X0DJKJW0lvcZsECrW6fO2C8nJipqu0uODNrCrt6ss96YP2Qradhs9HoewLK0=
X-Received: by 2002:a05:6830:1249:: with SMTP id s9mr26932374otp.33.1560437558004;
 Thu, 13 Jun 2019 07:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190409204003.6428-1-jsavitz@redhat.com> <20190521143414.GJ5307@blackbody.suse.cz>
 <CAL1p7m6nfPkWoEEAjO+Gxq-ZiRY7+1jU_7dVcw2-hjC22xz-4A@mail.gmail.com>
 <20190528121036.GC31588@blackbody.suse.cz> <20190613120228.GA26668@blackbody.suse.cz>
In-Reply-To: <20190613120228.GA26668@blackbody.suse.cz>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 13 Jun 2019 10:52:22 -0400
Message-ID: <CAL1p7m7T+ASfEd9dXEDg59XQEdp=eUE9fj5q-7hyEXat=_hL0A@mail.gmail.com>
Subject: Re: [PATCH v2] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, Phil Auld <pauld@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just did a quick test on a patched kernel to check on that "no
longer affine to..." message:

# nproc
64

# taskset -p 4 $$
pid 2261's current affinity mask: ffffffffffffffff
pid 2261's new affinity mask: 4
# echo off > /sys/devices/system/cpu/cpu2/online
# taskset -p $$
pid 2261's current affinity mask: fffffffffffffffb
# echo on > /sys/devices/system/cpu/cpu2/online
# taskset -p $$
pid 2261's current affinity mask: ffffffffffffffff

# dmesg | tail -5
[  143.996375] process 2261 (bash) no longer affine to cpu2
[  143.996657] IRQ 114: no longer affine to CPU2
[  144.007472] IRQ 227: no longer affine to CPU2
[  144.013460] smpboot: CPU 2 is now offline
[  162.685519] smpboot: Booting Node 0 Processor 2 APIC 0x4

dmesg output is observably the same on patched and unpatched kernels
in this case.

The only difference in output is that on an unpatched kernel, the last
`taskset -p $$` outputs:
pid 2274's current affinity mask: fffffffffffffffb
Which is the behavior that this patch aims to modify

This case, which I believe is generalizable, demonstrates that we
retain the "no longer affine to..." output on a kernel with this
patch.

Best,
Joel Savitz



On Thu, Jun 13, 2019 at 8:02 AM Michal Koutný <mkoutny@suse.com> wrote:
>
> On Tue, May 28, 2019 at 02:10:37PM +0200, Michal Koutný  <MKoutny@suse.com> wrote:
> > Although, on v1 we will lose the "no longer affine to..." message
> > (which is what happens in your demo IIUC).
> FWIW, I was wrong, off by one 'state' transition. So the patch doesn't
> cause change in messaging (not tested though).
