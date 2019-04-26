Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCF1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A375C2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PwMxOmAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDZFfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:35:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37966 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZFfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:35:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so1523718lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxo1C77LCpO+psJrdF0wkVInexAcV6zrC0JqBooE20s=;
        b=PwMxOmAsKahZlfo2iZ9sBJAnBP49w+3B+ILKI1GtDNEx5uKYLMfw+RAZTuNd/QSFDX
         DDMwFRhD2u31RtzUeF/KUgF7tdHDvFeRBRwZLkigTj9sy64YhPZNdvgOPrIOvc8oLgmA
         2ZYGS0oIfXX2huR5drgOFQ09xgO8BKshAUXPmC7nOiCBvaAPc0HuHyM2z8+KK1rEqB1r
         Ijk8ZR5LdItdIs31kRW9N7eHjBdx7wX5E+wqXnCzvatZmya9K4oPECVBkamK5xzLnMl7
         7trQLnVovXMUnzur6u5blFauPNi/a0YVaburq5by8ibWvCUzUrUya3bEcsa3mcNJaOW9
         024A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxo1C77LCpO+psJrdF0wkVInexAcV6zrC0JqBooE20s=;
        b=tENoVaz8GHsOvfcPoBy/PlVgLPURhqHHcmITfkNlf15hbGFbPAjsuFmnIpSbzNBBhB
         NhNBY8EIdliy6JbXSSlHWUHrnKwgRAz7m7X35Qgr2o8Ur1bR307xHKTgsUVz+ksdHX6P
         a9/nT4RNhzI6fzoPD3b3Z7kP+HIYfMb+QYijnmydDK8WEUW1C/ZrRY0df2TsOZhB0602
         g71lhzQ0wHJb7xfG09qYe/pNT156mgX973MDA7OGvhiVB/PV7Gjr76Pk6WRKYp6eXUk0
         oQzcyATdKAQLdzlvM2hIkVwSbu3HMXqhy210wt5EG49CpXHgqImU8DI4AwMmpBYlNVJ4
         BfBA==
X-Gm-Message-State: APjAAAVOx3dVj+tqmdV7hJL5Mjpn1dh8YQG2dL4QvqWWZAFl2i+nzBFo
        ls5zVdZpzJbtSGBDRKBy/PI/lGFQXdCybZT2XBNlAQ==
X-Google-Smtp-Source: APXvYqw976bRUl5Uh58lZhG+e/95HRJRYg52VkNXmo2VGCql1DDUro/qPNTfbfaD/30cjwsA461YeNMI4U3jv94oJtk=
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr23259706lfm.160.1556256923148;
 Thu, 25 Apr 2019 22:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-3-git-send-email-yash.shah@sifive.com> <20190425101757.GB8469@e107155-lin>
In-Reply-To: <20190425101757.GB8469@e107155-lin>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 26 Apr 2019 11:04:46 +0530
Message-ID: <CAJ2_jOGi3uTX2GhbFC-m7hHkSFAAS_-F7J-L_=3OYKpeexaaQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: sifive_l2_cache: Add L2 cache controller
 driver for SiFive SoCs
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 3:48 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Apr 25, 2019 at 11:24:56AM +0530, Yash Shah wrote:
> > The driver currently supports only SiFive FU540-C000 platform.
> >
> > The initial version of L2 cache controller driver includes:
> > - Initial configuration reporting at boot up.
> > - Support for ECC related functionality.
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
>
> [....]
>
> > +static const struct file_operations l2_fops = {
> > +     .owner = THIS_MODULE,
> > +     .open = simple_open,
> > +     .write = l2_write
> > +};
> > +
> > +static void setup_sifive_debug(void)
> > +{
> > +     sifive_test = debugfs_create_dir("sifive_l2_cache", NULL);
> > +     if (!sifive_test)
>
> Drop the conditional check above, Greg K H removed lots of them recently.
> In his words: When calling debugfs functions, there is no need to ever
> check the return value.  The function can work or not, but the code
> logic should never do something different based on this.
>
> He may not like to see this :)

Sure, thanks for pointing it out. Will drop all the conditional check
in debugfs functions.

>
> > +             return;
> > +
> > +     if (!debugfs_create_file("sifive_debug_inject_error", 0200,
> > +                              sifive_test, NULL, &l2_fops))
>
> Ditto.
>
> > +             debugfs_remove_recursive(sifive_test);
> > +}
>
> --
> Regards,
> Sudeep

Thanks for your comments.

- Yash
