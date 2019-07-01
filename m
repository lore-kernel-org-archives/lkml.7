Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234DBC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F062F2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAAuoTuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGALdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:33:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40562 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfGALdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:33:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so7229073pla.7;
        Mon, 01 Jul 2019 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oN7DVtuYqL0FXJ3oIM6FfobBi2SgwN99M5srNRJ7EfE=;
        b=hAAuoTuDi51XGTQ+LAJB40q7NYUR+gX4DJgBVaWDVUDv503g/ZpNgKHG9lD33tl+kx
         gvyEPwxFwd8u+0SOJ4Sa5Ec+Pl32KTr6zR9Vr3OnLoOZQzao/+XJdDJXhlOQQDQFHH3A
         4R7D5J5E6Og7AImsmjjEVC3Ne0PC7Eru336gr1lZyjD/xcO69UfJSI+kqutpafq+qoQK
         c+gkxOkTUzKpaVPe1egtUFjTwI6WvsczqBX19tjyLjbm9rKdBe36u2vJdk63qrsunSPh
         2viJhP0hPE7WggtKnIrpBIrpu97Ok5UpzThMsuoi/r5eAmwAZiI0rLgYSBtY00BnMaq2
         535g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oN7DVtuYqL0FXJ3oIM6FfobBi2SgwN99M5srNRJ7EfE=;
        b=Ul9ahYqQtLmWRnt6qx0k/61/hbEMvThJ4o/rE+leU4xZWjBLNnqb62u4N1t9JOdm+0
         SSHRqMv9dx2RXX31RMjnQXjvZ/oKWMW0Te+RSss8Os8dRi+9144EJNKYcOZUVd4ykvT3
         BEw7+UIUJ8EaFT0Aggp8BYJkupWSYhy+7UzvED1ItvKpN097SPduUelhpNrsGuzJDqQx
         0/DP+betYDM1Oeourj5MOUGaAJeDlNaJgRnRibhd+H9uu75GWafw9E95+n5lg4YXD9jw
         EuldAT+Q9Jgd5B4i2w8m5vjs51CqyC2dSpNxDk7eOfW5hT/v/phqVSbQrVffSQwP27dX
         2Y4Q==
X-Gm-Message-State: APjAAAV7G1Cuacy5Zmhd12fsXtDPZnWbSjZfUcRL7Rr4NkAOHU3zU5pb
        h5UmE6MAD1pZ7cx7hlJ0lDE0C/jvEBcfnUdrfh4=
X-Google-Smtp-Source: APXvYqzx6J3QenK6zg5ze+te61eBe4jG1PuVIuGx4L0AuHtuVR7ojU2OYfznxEnfZVz+9hiJglDjfg51FDnrGcrmC8U=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr29121105plp.18.1561980791748;
 Mon, 01 Jul 2019 04:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190630171408.8673-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20190630171408.8673-1-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Jul 2019 14:32:59 +0300
Message-ID: <CAHp75Vf-p3O10_Ns_NY4JoWBS1S34z-NW0jVJdCdqszdGVmoQw@mail.gmail.com>
Subject: Re: [UPDATE][PATCH 10/10] tools/power/x86: A tool to validate Intel
 Speed Select commands
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Cox <alan@linux.intel.com>, Len Brown <lenb@kernel.org>,
        prarit@redhat.com, darcari@redhat.com,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 8:14 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The Intel(R) Speed select technologies contains four features.
>
> Performance profile:An non architectural mechanism that allows multiple
> optimized performance profiles per system via static and/or dynamic
> adjustment of core count, workload, Tjmax, and TDP, etc. aka ISS
> in the documentation.
>
> Base Frequency: Enables users to increase guaranteed base frequency on
> certain cores (high priority cores) in exchange for lower base frequency
> on remaining cores (low priority cores). aka PBF in the documenation.
>
> Turbo frequency: Enables the ability to set different turbo ratio limits
> to cores based on priority. aka FACT in the documentation.
>
> Core power: An Interface that allows user to define per core/tile
> priority.
>
> There is a multi level help for commands and options. This can be used
> to check required arguments for each feature and commands for the
> feature.
>
> To start navigating the features start with
>
> $sudo intel-speed-select --help
>
> For help on a specific feature for example
> $sudo intel-speed-select perf-profile --help
>
> To get help for a command for a feature for example
> $sudo intel-speed-select perf-profile get-lock-status --help
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Updates:
> - Copied Makefile from tools/gpio and moified the Makefile here
> - Added entry to tools/build/Makefile
> - Rename directory to match the executable name
> - Fix one error message

Thanks!
I pushed to my review and testing queue, while still waiting for some ACKs.

It seems I can promote the driver itself now,w/o tools, if you want me to do so.

-- 
With Best Regards,
Andy Shevchenko
