Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F84C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BA1206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqTWyDWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDZQ0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:26:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46055 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfDZQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:26:36 -0400
Received: by mail-io1-f67.google.com with SMTP id e8so3384531ioe.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9QBvS1HDt9yRiJcfN0SfX1WCVVbWxGwFPxxo9FQbL8=;
        b=GqTWyDWpEeNJX4Gc79wUxopFK2Py5f+GSwre78pof74X2hFPo0P+XU2fxZfQ61ofxh
         TxX6aOP9re7vZxV7nFR+Mt+vcz8BidW8fj0lzWd/pX4+fn4YONGFoB6Yey27tmriWEkz
         qXZ3shm4btZLXNK+g+1fgJMiDOWDBfUy3h2Gb0oNFfOB1mwogetJ/T13o7FoMYahrC0g
         lZNgjZQo7V+AQXSNCo56IDphJOgcYYydAS2FZksVJzIuJ3etOoSVXo1Ko3DGfbldjd0+
         YUPSIObAc1tDRGQFEy35T319PL4iBcQflm7H5Y3zActHHeB+J/zQ7H6cT3LF1lVuKbIj
         mFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9QBvS1HDt9yRiJcfN0SfX1WCVVbWxGwFPxxo9FQbL8=;
        b=Venr4Wm7ki7XSBgtHzLT/1i3fWvh2KewJ5dxAqvWDbbf9uofKlebAZDVp36kpRc1gN
         alE/3E+nvVg9ae4Zcy61wmV/rx2PtaOnAc8AZtT3/VQ8+WUu4FSzFNoRScscxf8fENyd
         1/wedR2Qegby+QxSEKmOA5ENKv0GW4LIDM/VVsMdTk4Vs8+bTQ63YsOHKAx+J88M9KZi
         mprcBRD0rdQMwwGn5foeHJdZaQUSGD2/PV8FrJErO92QGaL1UTuwTRFL+rXiT41N2agk
         i3y8N1Lzmcjm5rICqbS5M/HOI2JU+NIjLvNsBXA9AHAaqUAo2ng+bBw73UvyM2I+httR
         aLlw==
X-Gm-Message-State: APjAAAV3TFZW5bLsaIZASLbfFAavg1Y7NKn0P6H0Ed5+vXPwhFQuP9W6
        jlzeWt/U+D4/MMWSQ1wD5RqLczFzsxgigfXFpT2faQ==
X-Google-Smtp-Source: APXvYqzmqAmr+acBs/S+LHQdZVVHbvsy+S6W77S2KAMTr7bSvx9S6J37uwYXwSSCXIiO9y4xOKmlxY9sPbHh0IbXy2g=
X-Received: by 2002:a6b:ea0e:: with SMTP id m14mr19784348ioc.86.1556295995642;
 Fri, 26 Apr 2019 09:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190412102738.12679-1-leo.yan@linaro.org>
In-Reply-To: <20190412102738.12679-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 26 Apr 2019 10:26:24 -0600
Message-ID: <CANLsYkyFXEiYh78uhhQRiqAOvv_u+oq5GS3z3-Lbj6RHm7x+sQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] CoreSight: Support static funnel with DT binding consolidation
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 04:27, Leo Yan <leo.yan@linaro.org> wrote:
>
> Since before there have no platforms use static funnel in mainline
> kernel (though maybe some in-house SoC has used it but didn't upstream
> for mainline kernel yet so we don't be aware for it), when enable
> CoreSight DT binding for hikey960, we found the SoC uses the static
> funnel in the link path and but it's not supported in CoreSight funnel
> driver.
>
> When support static funnel it's found the DT binding compatible string
> doesn't follow the same fashion between replicator and funnel; so the
> first two patches are firstly to refine the replicator DT binding and
> correspondingly, change the replicator driver to support new DT binding
> compatible.
>
> Patch 0003 is to update DT documentation to support static funnel (we
> call it as non-configurable funnel in documentation) and unify the
> compatible string with the same fashion for replicator and funnel.
>
> Patch 0004 is to support the static funnel in the CoreSight funnel
> driver.
>
> The consolidated DT binding compatible strings are as below:
>
>   Dynamic replicator:
>     "arm,coresight-dynamic-replicator", "arm,primecell";
>
>   Static replicator:
>     "arm,coresight-static-replicator";
>     "arm,coresight-replicator"; (obsolete)
>
>   Static funnel:
>     "arm,coresight-static-funnel";
>
>   Dynamic funnel:
>     "arm,coresight-dynamic-funnel", "arm,primecell";
>     "arm,coresight-funnel", "arm,primecell"; (obsolete)
>
> This patch set has been rebased on CoreSight next branch [1] with
> latest commit d5d246a56af0 ("coresight: Merge the static and dynamic
> replicator drivers") and tested on Hikey960/Hikey with perf commands:
>
>   Hikey960:
>
>   # perf record -e cs_etm/@ec033000.etr/ --per-thread ./main
>   # perf report --tui
>
>   Hikey:
>
>   # perf record -e cs_etm/@f6404000.etr/ --per-thread uname
>   # perf report --tui
>
> [1] https://git.linaro.org/kernel/coresight.git/log/?h=next
>
> == Changes for v5 ==
> * Marked the the obsolete compatible strings to be more abvious
>   (Suzuki).
> * Used pr_warn_once() to print out warning if DT binding uses
>   the  obsolete compatible string (Suzuki).
>
> == Changes for v4 ==
> * Consolidate the DT binding compatible strings for replicator and
>   funnel (Mathieu).
> * Changed replicator driver to support new compatible string.
>
>
> Leo Yan (4):
>   dt-bindings: arm: coresight: Add new compatible for static replicator
>   coresight: replicator: Add new device id for static replicator
>   dt-bindings: arm: coresight: Unify funnel DT binding
>   coresight: funnel: Support static funnel
>
>  .../devicetree/bindings/arm/coresight.txt     |  60 +++++++--
>  .../hwtracing/coresight/coresight-funnel.c    | 116 ++++++++++++++----
>  .../coresight/coresight-replicator.c          |   6 +-
>  3 files changed, 147 insertions(+), 35 deletions(-)

I have applied this set.

Thanks,
Mathieu

>
> --
> 2.17.1
>
