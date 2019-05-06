Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DFBC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D1D21019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Gesm1Mat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEFSB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:01:26 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38714 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfEFSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:01:26 -0400
Received: by mail-ot1-f48.google.com with SMTP id b1so12341463otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1iYiXewvQHx5myE/g1Y4h4JHD9obTw48tmYZs0bXqI=;
        b=Gesm1Mat5Nvdr9Z6ppAbheRkkXki5hmEJfki+aAZEgQWtXeZOTMMrgHdcrUMVJlQDM
         EoFBqW0epQyBVW0aMfUQWMZnSCnDG8Y/vtE5zcyaAH6Zdl9pu/EraJnHe6FBYcMXyLyp
         VZWggnrv7fI/MHQOhvLueK8w7k5e1LgXjHwFDufU47j2WbehxdNld3it11T/RfmzXJrP
         ljgYCI7GsW9S1KDe1lCVZ4mK3cyWa3kT8S9i8NiXyvnLEBSmbjhWarFP7+6KuIOEkME3
         7O9VFfUN9zNq29/cUxKNj4nEuJwTTMN48lYv1nIyegLPGtL2vWXAzQYZsJ+V1TQeTBnW
         0sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1iYiXewvQHx5myE/g1Y4h4JHD9obTw48tmYZs0bXqI=;
        b=N2/jQrSU98T/8re8Nd0X6RAH2BNn53sXpFZxoz+cFTIKhtD9SpQE15bjgW7Rs8tsfy
         vWxMT2lwtbUCdwzmNwpCNpXliCAOj0c7nS77LvIoxKBTWRvrVm/G06HLUgt4aaP27xf6
         HW20WrBlZELHjF7FfcC6OLLTbj4trsp8H+nZvj4qlxAWYz0rI3xyyxR/CfFrbYDGN6+T
         q5G3ZBb3kuzUiQ4xlNLgK9gsqg0e7noEuiDPxxbFV5Bvbw8g9A0IMcvC/KvFeSaMPKLC
         6FLZQ2ka2yPVaNUn1NspwH70QQSoZWzmrq5Ep1jcXa+RgPGSPnaws3TWpk8by4F4hrBg
         Kz7g==
X-Gm-Message-State: APjAAAUzRqXgrpqcHAemwpW9suuhN1zfk/n3nqdkMkaAQVOeJQ288GWM
        werviiJaYVygjMJjfnzie39cX4m27p7I4l61QF939w==
X-Google-Smtp-Source: APXvYqyX9nJzOdD3XQZPHP+tb9t4162dRKXqMf2zXk6saJvTjLay55UFP+hEuwJnc0ji6oilX5u1sKGnO6ke6FVIfL4=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr17304018otn.367.1557165685323;
 Mon, 06 May 2019 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com> <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
In-Reply-To: <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 May 2019 11:01:14 -0700
Message-ID: <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
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

On Mon, May 6, 2019 at 10:57 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > -static inline void remove_memory(int nid, u64 start, u64 size) {}
> > +static inline bool remove_memory(int nid, u64 start, u64 size)
> > +{
> > +     return -EBUSY;
> > +}
>
> This seems like an appropriate place for a WARN_ONCE(), if someone
> manages to call remove_memory() with hotplug disabled.
>
> BTW, I looked and can't think of a better errno, but -EBUSY probably
> isn't the best error code, right?
>
> > -void remove_memory(int nid, u64 start, u64 size)
> > +/**
> > + * remove_memory
> > + * @nid: the node ID
> > + * @start: physical address of the region to remove
> > + * @size: size of the region to remove
> > + *
> > + * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> > + * and online/offline operations before this call, as required by
> > + * try_offline_node().
> > + */
> > +void __remove_memory(int nid, u64 start, u64 size)
> >  {
> > +
> > +     /*
> > +      * trigger BUG() is some memory is not offlined prior to calling this
> > +      * function
> > +      */
> > +     if (try_remove_memory(nid, start, size))
> > +             BUG();
> > +}
>
> Could we call this remove_offline_memory()?  That way, it makes _some_
> sense why we would BUG() if the memory isn't offline.

Please WARN() instead of BUG() because failing to remove memory should
not be system fatal.
