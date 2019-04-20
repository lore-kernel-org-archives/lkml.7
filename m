Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71AAC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBF22147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Oc6rl2uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfDTVCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:02:18 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42963 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDTVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:02:17 -0400
Received: by mail-ot1-f54.google.com with SMTP id 103so6783324otd.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKqLga59d4C5WqOdUK7t52EEoHtdJECj+oe5cCG0PQ8=;
        b=Oc6rl2uFMlm9BBCHIv8btu4Y26T3t+YFcb4O6IdwoABM+3bo2TLj43f1U3RfSjZtM2
         RAHEUZPp0UoeOhHx+WIToPW9MM2OPanmlt/bVMDwck+kih+3ADBw+x6ms38gl8hSv7ml
         Vzwl62Io7+VDVOaV4SQhfpQdfdT0ZcaT2KJTn4GHlvxhpfEQPkLTNniPLs5hYEEVyi4B
         KYeYo5ELVNawQw3sDYE1K5TDyW77y144xSTV3eCkXJnaemo+7+6uawiSTFixJVhfH3Q+
         w0teD2VVLBw2Ci9Tmtwbmwrw/DG+vaU/qqsKWXSxW/V6keZ3vyOI/2T60r0qojlYBokd
         rmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKqLga59d4C5WqOdUK7t52EEoHtdJECj+oe5cCG0PQ8=;
        b=fgyDt9BXBhdW/mxwBYvewr+jRsjrTd3aDdeOtML93JEa7wsRQbtuYxj810Akryo3D8
         FTdZdiXSfEL4z/fR4tEV7Foq8wHOUdWYiNyQGdJyGGcA+HXRwt41HbeeFWTcOl5dWwx6
         ZqroRxpLXfrDj5TBhmMmZ7yIzW8MRCegZm1/q5sbsZe8mXlE0klmfImx0r/vfmSMHx6f
         4ugoTo+xWrkT5NHul59AmPiTPNejsw71meWoeYtJ8bx+RDL9+wpNtyy1KDqc7axJYC9b
         EoWBdgERZTa8KSZcJ5oJw33XvwO38RZEPbg3Wk+xkA3pa/ooFfI6OwPQlrAmbEOOpomQ
         dYqA==
X-Gm-Message-State: APjAAAXWhpzSH8ERxXMLMzL5AQ7Z2oD/biYVSq+AqCxtrAPKRMKxoY4O
        j02bJBxpI4/RYpFbqWMQ0hD4d032PAeUtcCkRKJWdQ==
X-Google-Smtp-Source: APXvYqx5EXLH90eAk9pNJDt0nfkqlWI3JEav607Ybl6aSejlE/nKG5/6NUbeBq0DGylbF9d345OSd5Rpb1gqeaXAWpc=
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr6869693otb.214.1555794135898;
 Sat, 20 Apr 2019 14:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com>
 <20190420153148.21548-3-pasha.tatashin@soleen.com> <CAPcyv4j9sG6Wy3EfTuPb0uZ2qp=gr9UgUhpnXQA_g6Ko9KFmLA@mail.gmail.com>
 <CA+CK2bA2QTzZtFvGRMaG10_TretDr6CGgZc4Hyi_1pku4ECqXw@mail.gmail.com>
 <CAPcyv4jrxMNEEeUZZG3=CdkYSyX7OtJLv_ZQ1gbML7bscePiQA@mail.gmail.com> <CA+CK2bA-wDwRT5Gv2p9Nm1Vr8LNg84rQdE6=s2m2hQLYqj5Rog@mail.gmail.com>
In-Reply-To: <CA+CK2bA-wDwRT5Gv2p9Nm1Vr8LNg84rQdE6=s2m2hQLYqj5Rog@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Apr 2019 14:02:04 -0700
Message-ID: <CAPcyv4gBu5QhgRQ+maJs108JwBrcCa9U1e9wgO8FP6Q3qwy69g@mail.gmail.com>
Subject: Re: [v1 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
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

On Sat, Apr 20, 2019 at 10:02 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > Thank you for looking at this.  Are you saying, that if drv.remove()
> > > returns a failure it is simply ignored, and unbind proceeds?
> >
> > Yeah, that's the problem. I've looked at making unbind able to fail,
> > but that can lead to general bad behavior in device-drivers. I.e. why
> > spend time unwinding allocated resources when the driver can simply
> > fail unbind? About the best a driver can do is make unbind wait on
> > some event, but any return results in device-unbind.
>
> Hm, just tested, and it is indeed so.
>
> I see the following options:
>
> 1. Move hot remove code to some other interface, that can fail. Not
> sure what that would be, but outside of unbind/remove_id. Any
> suggestion?
> 2. Option two is don't attept to offline memory in unbind. Do
> hot-remove memory in unbind if every section is already offlined.
> Basically, do a walk through memblocks, and if every section is
> offlined, also do the cleanup.

I think something like option-2 could work just as long as the user is
ok with failure and prepared to handle it. It's already the case that
the request_region() in kmem permanently prevents the memory range
from being reused by any other driver. So if the hot-unplug fails it
could skip the corresponding release_region() and effectively it's the
same as what we have now in terms of reuse protection. In your flow if
the memory remove failed then the conversion attempt from devdax to
raw mode would also fail and presumably you could fall back to doing a
full reboot / rebuild of the application state?
