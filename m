Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B837BC17442
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82843214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOxHRcrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKHWtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:49:05 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39145 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfKHWtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:49:05 -0500
Received: by mail-il1-f196.google.com with SMTP id a7so6125623ild.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wae4FJoeXjSSIN6WIXQxANW3IlPt4nOq6cEJ/vITa3A=;
        b=GOxHRcrE0GKpkZiencP0jt95fTcpXZu3TT/w8qFPOAI1mUd4gXgqcDwTAP9ZO8VVBF
         dfM1YjK+KmAMZhiV4Ye8m2zv7rUjCvLdhyPxjljrUBBM9yiB0bRlRhvaDuJpq7Yy1u/5
         I+xLRGkI5d6OspOjyvamyLC23bO5rQ3nqRQjsHAVLKmbtM2EAtIrJAdtErkIt9Q90Efe
         1tR7mz4sEa0BFC70rowh5G2LredBxgpA2+GHxSizEhvpAvPUiriRC4XPVMDZJDM7My4n
         8uj/ZQhV4z8zrvhTdFYIOquVUpvg3HnxPHC0eBLVt/5OG9969RMRROFZZvbjKWwKb+4p
         DIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wae4FJoeXjSSIN6WIXQxANW3IlPt4nOq6cEJ/vITa3A=;
        b=hHk5L8/wt92iIKROZ2/TL2lrWJI1DtNTU4Ksox5FzRYcsiYcbkTpCRWCg84d0Uoz61
         2s03mvnmWTn24/UaGTYtPTVqbzpnoM8nkItejUW7ZbIiHFtF58JvsYdCwQHHGNm1X0IA
         DK0oKLMnw/kauHbVsWFEibisEEsuPQ5TqSipXc44Wv7EA9j8Okdg5H62Lg0dXz0JITmd
         GJf/hvEWtDjLXrdKAtK0Yp2Yu4Kyq7r1KpbL8P4MzLiUD5ZPvD1e/ZtyryOKWFBjTNWD
         ZsdkUv0Y6mO4lbpUcDocF8EMvGvqvto9AI92jhJ30LqR+DtKWiVM1BCrO8ZwCqPOwnpV
         RFqg==
X-Gm-Message-State: APjAAAVMKu/8s9dUXESG/AIfsyESO8x9C2fWHxan6hs2RrYd0jQBNTcL
        F3mKGdNI2JEn0NoYbd/TsZ2+nkN1UYSBvHcaYic=
X-Google-Smtp-Source: APXvYqwGvQxpaAT2c4juU7qywbaTWicJVh6do/fR5zn/PMCh4PQSoYdT8lHJE18e6mZ1pxxNXn3mKG1mTo/ocB3dE5E=
X-Received: by 2002:a92:5e49:: with SMTP id s70mr16569333ilb.130.1573253342983;
 Fri, 08 Nov 2019 14:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20191107205914.10611-1-deepa.kernel@gmail.com>
 <1672a5861c82c2e3c0c54b5311fd413a8eee5e64.camel@infradead.org>
 <8D8B600C3EC1B64FAD4503F0B66C61F23BB95B@SHSMSX103.ccr.corp.intel.com>
 <addba4e401c3bf23b86cf8dff97256282895e29f.camel@infradead.org> <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <8D8B600C3EC1B64FAD4503F0B66C61F23BBA24@SHSMSX103.ccr.corp.intel.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 8 Nov 2019 14:48:51 -0800
Message-ID: <CABeXuvoiX639HchLbgTHLiXPh=Yr2dJHUp2Yqc6pNJ3As1OJ8A@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: Turn off translations at shutdown
To:     "Zeng, Jason" <jason.zeng@intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Tian, Kevin" <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > For VMM live update case, we should be able to detect and bypass
> > > the shutdown that Deepa introduced here, so keep IOMMU still operating?
> >
> > Is that a 'yes' to Deepa's "if someone wants to make it conditional, we
> > can do that" ?
>
> Yes, I think so. Thanks!

Are these changes already part of the kernel like avoiding shutdown of
the passthrough devices? device_shutdown() doesn't seem to be doing
anything selectively as of now.

Thanks,
Deepa
