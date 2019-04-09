Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9683DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DAF217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nCwQEG6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDIV7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:59:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33641 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfDIV7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:59:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id j10so92378otq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmqX/g5mbq2Od+OxDF2js1TlC1nvscxMxEFuMkQJU2k=;
        b=nCwQEG6CswwBLYCoKdIZwRaEhJ4XKrCkeuRPDyFLWebvCAAlYzM/pS7qQUMlqQhMoz
         YLJu4v5/UWcvsbTCVksMI7FzSjOCExUDSNR06gmQGum40x17ymJWs7YWVd0c2dzhIYU9
         UdA2KWPTvuoOmYi9926RObl3AY10zEt2EeB9MbA7UsxJuDLMhwUjnjuNLeNKcInTRRko
         Xuh/1YB33YdM3zptsBQS1b0AHl1ufPqXg0MMnWN8ijmsz11A23Wn6ocXnp3FtWMGgyuA
         W00ufC5BBaureneYxT2+f146yS1AP7B6irg1ZE5G+ewx/JPrYJdRwq7gYCp+BdgHSfvX
         r5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmqX/g5mbq2Od+OxDF2js1TlC1nvscxMxEFuMkQJU2k=;
        b=kl3vlUkDMC+qKNiZS/54DIWYPjtxRGCleBRZF/azLVN9Xix/MSMTPAsPWrd+pN2MYO
         YgzeBo8+YSPNB0s1SrfuNL0QHNCE/FCev1xMyK+rThnrD6og+EC6kOmyDsDeC3NPbFOs
         /zPM+qVOlI31DF985YiTzAEI8hSibxvGTINvI3TKm5kkLIbR/Djl4DjB7k4J8rrNs9tD
         cty2KOAYEq8zUh7Xudiogm9St2oCZxhNDku1+XvclcB0DmEksfxORJTr0wd0w5ZjSHu9
         CJKxyjbzDx6GPMBcfcfUsEFnQs9aJuc3prO+QbW6BdzRTRwjgNoZFGbIEUX7wq+f8I+1
         nwhA==
X-Gm-Message-State: APjAAAVMi4VD6BHJPjL2FJSDhsW7oIEktOEOMi1Cgeltx+FDe91pjKxp
        40LHQiAj3WC+6vHMZ9StB+j+NUab7YUScyd/gG9ZFw==
X-Google-Smtp-Source: APXvYqy7wGdGe/SiyvGaV0vknLas0SjlKPjli22qcgALSPMla/YkaxGuTxbdAj1w/p5GpPtrWC+OBLlEQljGCkHJ6Sc=
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr24843558oti.118.1554847157388;
 Tue, 09 Apr 2019 14:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190410071555.6a283e81@canb.auug.org.au>
In-Reply-To: <20190410071555.6a283e81@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Apr 2019 14:59:05 -0700
Message-ID: <CAPcyv4j=jj4b7_Xg90o2y44YnyKP4RcxE4zYR-k=jn1U=a-FtQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the nvdimm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dang it. should have validated that more people weren't following that
bad example.

Sorry for the noise.

On Tue, Apr 9, 2019 at 2:16 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> In commit
>
>   631804370762 ("tools/testing/nvdimm: Retain security state after overwrite")
>
> Fixes tag
>
>   Fixes: 926f74802cb ("tools/testing/nvdimm: Add overwrite support for nfit_test")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
>
> --
> Cheers,
> Stephen Rothwell
