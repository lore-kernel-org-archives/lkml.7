Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEE5C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2325D20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QXat18OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEBRoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:44:38 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:32823 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEBRoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:44:37 -0400
Received: by mail-ed1-f51.google.com with SMTP id n17so2892183edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaSPhFrdJ9xcb9w7nOB/hv2LmsH6V06QJTIIuydXt8E=;
        b=QXat18OMVYiFj1J2lwckErIND4VxtD7m3nZmTH2CGaJZ+Hw7fVyhiWqHLoK622HkMp
         U9yMIC+ePTVWRGsI21RjnrUuMDsRxTmmjgzsyI3fQ3Qprp0+kiDd7tOOuYY19ZJMOfhl
         l/1rt08HauRtiP2hRqk2NjpJPuP+O+9ngov5zkBNLTuR7qrPf6ExGNub4tU8rsI/TrCn
         n8s8mKEfj18Fxht+PV1z/8GAgInkc9Qc/e9giORQoOAL+mVUg59lDwUFBXIKKGSVU4af
         HayfIxQWJSZlQl6kr16/h15Hk5Reu50LKaP/QJCHnyPavmaX8LyepIFk7cqxBrWSjJxB
         gfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaSPhFrdJ9xcb9w7nOB/hv2LmsH6V06QJTIIuydXt8E=;
        b=Qx1rAaJurspK23qrm6GiT/i/ww/5ItMjcBo+dhH15T013+enih8+f8TkfMXm61seZm
         CCOLAJBlUqIWO6tLn20OyQB1u6C7M3ucljNGXYJ7m+C/CauFUUm5ck4ZcmuF2eSp/5BT
         AZzHJ7/EL9cqPymFmj1rpbboTPOFmM8dvuobkpeqCmoqBFIkInV1a66R49SjMfc9CLcc
         rzadLlQXpYuWz/ACVCAfy+4SzlKvw4f7YULTywZONoWGDSE3o2eJPQUCFt62up3hvaks
         zQkPM4PsM0Lgz812ANuB9jsbZSuhfLLv+1x0RpPGpBLaAcBTwwHMtyBNE3GyH2HsEgVr
         dEoQ==
X-Gm-Message-State: APjAAAXL0m3mRQ55/DkmCWN5Wp+2JEKhD6autdGG8OxVIUPUFTgoznWh
        uBffUfZK+hX05BG4B6kZGc7hyKIvKHbG6p0O4Xl6EA==
X-Google-Smtp-Source: APXvYqwFjCWrvwlJewJq8jESh0fLZdmcYO3yLeAKyzDonK3UsuXpek6fTdQl1z2LIrzbiszd7BG6f/7lz+swTO1hQHI=
X-Received: by 2002:a50:a951:: with SMTP id m17mr3313780edc.79.1556819075931;
 Thu, 02 May 2019 10:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com> <20190502173419.GA3048@sasha-vm>
In-Reply-To: <20190502173419.GA3048@sasha-vm>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 13:44:24 -0400
Message-ID: <CA+CK2bA-jVEXvF-gi1N=8jD-+MPsqtn0aod=iBNJ0TrgiqqBSg@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Sasha Levin <sashal@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >device-dax/kmem driver. So, operations should look like this:
> >
> >echo offline > echo offline > /sys/devices/system/memory/memoryN/state

>
> This looks wrong :)
>

Indeed, I  will fix patch log in the next version.

Thank you,
Pasha
