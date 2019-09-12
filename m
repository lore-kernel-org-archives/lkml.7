Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8B5C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CD8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQvte52r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfILImV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:42:21 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40491 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfILImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:42:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so773683lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNrIuUYLDbT7zQ5324Ye/I2/Q3u9VnMzuPI9RQmmH+s=;
        b=HQvte52rfMzXkfmg2dy9fX6VpDW3IFfdlGC05XQ8K1w8RM25pVju8tCDde4KUH0v1a
         1kcdT7UH/73YhhPccKsaGWDyC+Sz+Wb6IX/AHz34Gb0cW2pCuGQRxZhr8jDVO1REPKTg
         jwEpA+OPl7mOutzaxAJv2kNWbY5ouhp4RVMwiy22nCjmfGZ+3EozFEdOLX9t+9uGjz3t
         bBEXwt2yJqGwzYLFaPWKmr6RdcKpM7iziqyRJYi127B5fZCPWJI/JZSJ0wUocRLM5+dS
         Gc+Gp17oJ9b/iyPdk67fWEsZUWN8K4JROeX14wCj6dt/srxxNI6pKTv+Ztoedr/7VPPN
         Ba9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNrIuUYLDbT7zQ5324Ye/I2/Q3u9VnMzuPI9RQmmH+s=;
        b=UeirZG+/miPkV2ILYNxvEtQsekcYJPHnEIQ4IZLm+XPhTc/TKfUc4xx69xBpkNX46u
         aAQ1y9tJtJT3GdpIXRad/XS1gUdEXdhDW76qQQjEuCXYwvTKwYvSQU+jeBghlWq59X7Y
         oQM8P+9BJs3HB/xcfiFq60cJMZ0Vmq6LZ1Wj6SQuxtEXf0R5Uxml/T5iOHF76XwbDkr6
         zIsMJ3zbjSbJFiNG+oriBlAU6UiYs3C1U1Qt/TIHZ4UZAfw4PK8iYDEJjt76r7YV9mT2
         eakQF1k44DLcp3IFhtAxXhX4CrzIKQbLYbccEAZUthe83oUlC95GCoa12PD1nexrERHm
         JqwQ==
X-Gm-Message-State: APjAAAV6harkhsHCNpEItgFYXn1XMhZAmgUyzRwTujMBI30oCX4e6OZg
        VizP9ciJzhC7L89j7EHHo91axQrB7gAxi21OC/A=
X-Google-Smtp-Source: APXvYqxyEQdbpMlCuAav1TG4x6BjkXais5Z79dXqr0CkWkZVoUFV3EnetqKauoIdCFU9Ic5EJVQo610gutjyqWbL3VU=
X-Received: by 2002:ac2:4351:: with SMTP id o17mr1127056lfl.131.1568277737781;
 Thu, 12 Sep 2019 01:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com> <CAPcyv4hzoSp-bFx19Yj71H7x3D66-TE4uCpcHm4S9sJsGtXugA@mail.gmail.com>
 <be3c626c2e9d14fe2fa9d0403bc02832231cc437.camel@perches.com>
In-Reply-To: <be3c626c2e9d14fe2fa9d0403bc02832231cc437.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 12 Sep 2019 10:42:06 +0200
Message-ID: <CANiq72==rV-CY5d3poN6j10qSuF2ux-sJGqZS+YOXeZgGmmh3g@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To:     Joe Perches <joe@perches.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:15 AM Joe Perches <joe@perches.com> wrote:
>
> I am adding Miguel Ojeda to the cc's.

Thanks Joe!

> Of course you are welcome to try it, but I believe that
> clang-format doesn't work all that well yet.
>
> It's more a work in progress rather than a "standard".
>
> I believe you'll find that the patch series I sent
> ends up with a rather more typical kernel style.
>
> I suggest you try to apply the series I sent and then
> run clang-format on that and see the differences.

Indeed, it is not there just yet. There are a few differences w.r.t.
the kernel style that aren't supported yet. However, for block/batch
conversions, it is very useful.

Luckily, one of the biggest ones (the consecutive macros alignment,
and we have a lot of them given this is C and a kernel) is going away
with LLVM 9 which is about to be released next week.

> Ideally one day, something tool like clang-format
> might be locally applied by every developer for their
> own personal style with some other neutral style the
> content actually distributed.

If that day comes, I hope we can all agree to a single format and
apply it everywhere as other major projects have done. I think
agreeing to a given style is much, much easier for any of us when
formatting is fully automatic -- because at that point you don't need
to spend mental cycles (and memory!) on it. :-)

If I had to guess, I would say the path forward will start with some
subsystem maintainers starting to apply clang-format systematically on
their trees. That is why I think it is very useful that Dan tries it
out and let us know his impressions.

Cheers,
Miguel
