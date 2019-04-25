Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C7C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D55206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S8gasJAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfDYR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:57:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35757 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:57:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id y67so696079ede.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lfFoLZ1bSmGmdUbBHFXNJ+M6oegr5l9R4TFlcxu7Mw=;
        b=S8gasJAVn+ZWmiT/2uWvL9vkKwOoktSsgWDJ2pt28Jwb8U3hd4RYZILlgs1ZJSbb32
         E8pkwIX2WZ5U7s0jN5OFpHJANArcLfSTG2WfhU0d/yE03quAyfTD+ozv8EsylrGARl0T
         Q47fyZiS5Uwz5G+0wsjfnj+2u2oPWY05lYUanIDY7LgNL4FubQm9/F7oW4oEqNThrg84
         gLONpjU+mkfLCeD5a8uQeIbLsAUPMjwvrtbFH/bnTAbaqEuYWZAP012PG9WJeaoH5kLo
         K72nQU2oKXRez7H4b59QLM2pnJhyW8VIp8FGqSBLbgfBlnZF9Iex1qPjic/qyWHcnHbT
         3/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lfFoLZ1bSmGmdUbBHFXNJ+M6oegr5l9R4TFlcxu7Mw=;
        b=g1+Gjmw/Fa7hXvh7jTOogoKevEqIFwtPdrAbk2BMo4NQsgxRgwa0zbSR1ya0cK6QpM
         ktDX8d3MVGbufPOg49KgojkR+9xHLGUAjI3mPVOg5QEkBODBmmAvfP+wYkKEjPeo6kJQ
         hc2gka8gm++LfKbKwZJB6gzm1RLmpwdpEbg2V1X8WSA/5e4F0lquDu2/MT+V+B1r70Wd
         2fgjowgCV+Fn7O0/LQUoDIwnOJ4TW+8ZX16+GVCu4TwbQI5lJ0vh3EYLxhBJW2NAAXyH
         MClOjLVIUiHUb3az7/F4dOxg+5HE798VwVVr8N6mxjuPRQ3pqm9+BdB6tB5BQFmi8BhN
         fyjQ==
X-Gm-Message-State: APjAAAWnWIAmfPl6sn7sbVH1+NWp15e9b5cMVviZDQnFS71TZ3JrpyfH
        IrcONx1hulKSll2BBYhN55gwisTNpcnPfycBxHryXg==
X-Google-Smtp-Source: APXvYqw1cnJsUKvmbES+9b09tCQYh+M//QuIDsABsPOCGjahHfAnSjITfrASIQUqNSCPM/SZxSQ7kryctJSAM+dJY2g=
X-Received: by 2002:a17:906:944b:: with SMTP id z11mr3858668ejx.151.1556215056839;
 Thu, 25 Apr 2019 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190423203843.2898-1-pasha.tatashin@soleen.com>
 <20190425152550.GY12751@dhcp22.suse.cz> <20190425153138.GC25193@fuggles.cambridge.arm.com>
 <20190425154156.GZ12751@dhcp22.suse.cz>
In-Reply-To: <20190425154156.GZ12751@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 25 Apr 2019 13:57:25 -0400
Message-ID: <CA+CK2bDLkSTdrYx+zth9=EJxigQR1-nMt52avt7-NpguAWwoVw@mail.gmail.com>
Subject: Re: [PATCH] arm64: configurable sparsemem section size
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        rppt@linux.vnet.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, sboyd@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I gave *vague* memories of running out of bits in the page flags if we
> > changed this, but that was a while back. If that's no longer the case,
> > then I'm open to changing the value, but I really don't want to expose
> > it as a Kconfig option as proposed in this patch. People won't have a
> > clue what to set and it doesn't help at all with the single-Image effort.
>
> Ohh, I absolutely agree about the config option part JFTR. 1GB section
> loos quite excessive. I am not really sure a standard arm64 memory
> layout looks though.

I am now looking to use Dan's patches "mm: Sub-section memory hotplug
support" to solve this problem. I think this patch can be ignored.

Pasha
