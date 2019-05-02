Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43758C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1203A20C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SFbei6R/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfEBQsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:48:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34864 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEBQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:48:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so2737702edr.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcAYlClV3WYMLJTodjrLc+GMcN8cBX8qnEYUrl9knag=;
        b=SFbei6R/fTHbrGWi+/N+oWim6SS5KPKvxv1TfgMvbJ1pIR8OajbduDS3nFo+mTzicg
         XVys/It0mRnuhAz4kjM8EiZPi2qESa1Ad7BuVtZXc1AhD6SYmi1WTfMnCEAxTNkaT811
         wtR9FZXA8gRcO+e/pbRwpO9NwRgtNQkNQixypgNzB90FxwHw7uDXDkb5kVruMBFHCmWK
         aDFBzlffvUNDnS4Q6tEIHtK+tlNPSguzMFFvyNwltQHrvgbB4cHlbIie4LsGFzTGdkuJ
         7Yg0FEJD9BqWiLWh/W+DXQN7jVHxZsopXpdlsd205vwlCjzC9uuOvIUXoBsgyR88IvAg
         zT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcAYlClV3WYMLJTodjrLc+GMcN8cBX8qnEYUrl9knag=;
        b=qdB+ueB+etR+mH5kca/lBXHklnl612oHdqUPE+9MauTM0JF2TQRScgluq6Ufdx60+c
         k6VnuYmzUrE2pvwI24ReWOBqgRrFfJTd9qzd4cNxwb5YMQPFgZecdq4hqDLj3e7P4Ubx
         ZiW4OxraS5guTe4dvXJfD0oeD3NcsBu5bEW15AE2konYfnHA5JOMyZ3YO4Me84L7Vv77
         roG8tByI3nt9mMApNCjHL8y1uETJqi9Fc/jazYhYp10TqSPyw/mHn6JMeKOPtBxHQsxW
         oBDQ6ePXRBIT3oI1esxmfiDUBArVBaapWLGYK492Kb4aVl7zhQs6TQq8XqqZVOrHngL+
         Odpg==
X-Gm-Message-State: APjAAAWHja5sUpdCgKRQtqF9ojWlXp+u83d+KxR/8iYp0Ios5edvvWOb
        NHVge3MRdbj2l6R4FpRntD0MaTsXjoWfP0Nrq3zGXQ==
X-Google-Smtp-Source: APXvYqzbaWRuAebout5s4Iqp5ku1hhP9/l4QkLIfxTg/R4+sKpNKvDwBBtR0sOzGL8kxvPpg3HdXxRKpBddZWv64kk8=
X-Received: by 2002:a17:906:3154:: with SMTP id e20mr2340820eje.263.1556815683667;
 Thu, 02 May 2019 09:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com> <CAPcyv4iPzpP-gzuDtPB2ixd6_uTuO8-YdVSfGw_Dq=igaKuOEg@mail.gmail.com>
In-Reply-To: <CAPcyv4iPzpP-gzuDtPB2ixd6_uTuO8-YdVSfGw_Dq=igaKuOEg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 12:47:52 -0400
Message-ID: <CA+CK2bB3G_tO04M1eXPdm4b=OojD6QpYkW51YArj6z44RhQo+g@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Dan Williams <dan.j.williams@intel.com>
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently the kmem driver can be built as a module, and I don't see a
> need to drop that flexibility. What about wrapping these core
> routines:
>
>     unlock_device_hotplug
>     __remove_memory
>     walk_memory_range
>     lock_device_hotplug
>
> ...into a common exported (gpl) helper like:
>
>     int try_remove_memory(int nid, struct resource *res)
>
> Because as far as I can see there's nothing device-dax specific about
> this "try remove iff offline" functionality outside of looking up the
> related 'struct resource'. The check_devdax_mem_offlined_cb callback
> can be made generic if the callback argument is the resource pointer.

Makes sense, I will do both things that you suggested.

Thank you,
Pasha
