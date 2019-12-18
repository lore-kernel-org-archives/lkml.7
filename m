Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42889C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181672146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h195DNSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLRQue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:50:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43641 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfLRQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:50:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so1559788pga.10;
        Wed, 18 Dec 2019 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+tj1Z9v8cr7ACdf2R2Ew/Y9LtKlUu8NiSR7SyzGdRoI=;
        b=h195DNSIlkZxo5sGwcgO+LsWoLCfMJduTiPLh/xmLrbS72Sh6jilXsFlRJ4IcGBbKK
         zRYLt1aCBJ1DEAyeeTos8ckVeeIjXoejjrQSlaxUUkQKHUdVpFsE1BFmXMwso5ErztMw
         sWzMnuL9nnM+Yrj2Xv9ICAItQ/rsb3pJRbiPKeV0KNFYUJj6lmHKn427c0rlFFqenPYs
         Lv/yJtogt57M8UANMj5qi77zmg/jb4ef30KvneFHS6opWgBBwI5RG0KeEhpd9UZF7Q+Q
         Ppbenf+clwQgrXlQ2B+rCaZpYyb2PH1M4X2UxvWFhfSx6cK4xrSvn6DfqFNnGnDKsUgL
         plpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+tj1Z9v8cr7ACdf2R2Ew/Y9LtKlUu8NiSR7SyzGdRoI=;
        b=hCWUPcYOD+fxTs0/zcS/kVSWhtgJlWHaFMCCuT8Y/DecuGYS9DUoZ5PJIHb2LvzByM
         DZOI6HXKfSdFu1Jd+G3fWWnCf13xiJBga2B/3wOKYmSnYvZNc0yGceYInLudIqjwlDfn
         IgzoO7fMjluivnx817v53j1UGz70XdS6m3G/0eair67aYHW2WaBOGtR2VwTrNdvxNy30
         CJQb3AirfkyeKD6KVaTOY1+aP478FygOwYIzYbGxPnIUXL5qQ+0/N25g/P1loC5EjOn+
         aEGK9EVEd2fAXufZ18hTfxUrUQgNoa5dLOi/4MK/XuZ0bq8z0E3b0NUPVxjE4WQ2GF0T
         xWTA==
X-Gm-Message-State: APjAAAWbGGfPetg3CkppITToRKs6NdltWoe6Yg7tWVw86FccuGQPi+7F
        obET9YyA1EeMEePzB7Mc1o0CJwDtflF4z/26ju4=
X-Google-Smtp-Source: APXvYqxAMqWtgIgyX0oafExFE9ZK7f3uvfTl0N8a6WUU5MKPVRxj93QfDCBT4Y+PnoXHLhl5ns5jcnu5qL26rFzSpW4=
X-Received: by 2002:a63:e14a:: with SMTP id h10mr4034735pgk.74.1576687832667;
 Wed, 18 Dec 2019 08:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20191214001408.4878-1-srinivas.pandruvada@linux.intel.com> <20191214001408.4878-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20191214001408.4878-2-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Dec 2019 18:50:22 +0200
Message-ID: <CAHp75Vf_X-aTNtrNpC1feKTLEUTvZVT2LA9535i+QXCwNzv=xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] admin guide/pm: Admin guide for Intel Uncore
 Frequency limits
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 2:15 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Added documentation for the attributes to control uncore frequency
> selection.
>

I need either Ack for this one, or take mine for patch 1.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/admin-guide/pm/intel_uncore.rst | 23 +++++++++++++++++++
>  .../admin-guide/pm/working-state.rst          |  1 +
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/admin-guide/pm/intel_uncore.rst
>
> diff --git a/Documentation/admin-guide/pm/intel_uncore.rst b/Documentatio=
n/admin-guide/pm/intel_uncore.rst
> new file mode 100644
> index 000000000000..0986d9ab59d6
> --- /dev/null
> +++ b/Documentation/admin-guide/pm/intel_uncore.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Intel=C2=AE Uncore Frequency Selection
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The uncore frequency in the Intel(R) hardware is selected based on inter=
nal heuristics, which uses the current selected performance state and vario=
us system power constraints. In majority of the cases this selection is the=
 most optimal, so there is no need for placing external constraints from th=
e Operating System.
> +
> +But there are some customers who wants less jitters from dynamic uncore =
frequency selection. For them, power saving is much lower priority than con=
sistent performance. Currently these customers uses MSR 0x620, to place har=
d limits on the maximum and the minimum uncore frequency. They can now use =
Linux sysfs to place these limits and also have additional capability to pl=
ace hard limits under power constraint scenario.
> +
> +The Uncore frequency section attributes are present under "/sys/devices/=
system/cpu/intel_uncore_frequency".
> +The scope of these attributes is per die in multi-die systems or package=
 wide in non multi-die systems. There is a unique folder for each die or pa=
ckage. For example:
> +"package_00_die_00" for package 0 and die 0.
> +
> +Attributes:
> +
> +power_up_max_freq_khz (READ ONLY): This is the power up value of the max=
imum uncore frequency in KHz. This is sampled during the driver initializat=
ion time. This is not the absolute maximum uncore frequency as there is no =
capability for the Operating System to read that. This can be used as a ref=
erence to roll back settings once user changed this limit.
> +
> +power_up_min_freq_khz (READ ONLY): This is the power up value of the min=
imum uncore frequency in KHz. This is not the absolute minimum uncore frequ=
ency. This can be used as a reference to roll back settings once user chang=
ed this limit.
> +
> +max_freq_khz (READ, WRITE): This presents current maximum uncore frequen=
cy. User can modify this attribute to change to a new maximum uncore freque=
ncy in KHz.
> +
> +min_freq_khz (READ, WRITE): This presents current minimum uncore frequen=
cy. User can modify this attribute to change to a new minimum uncore freque=
ncy in KHz.
> diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentati=
on/admin-guide/pm/working-state.rst
> index fc298eb1234b..15094cf0a234 100644
> --- a/Documentation/admin-guide/pm/working-state.rst
> +++ b/Documentation/admin-guide/pm/working-state.rst
> @@ -11,3 +11,4 @@ Working-State Power Management
>     cpufreq
>     intel_pstate
>     intel_epb
> +   intel_uncore
> --
> 2.17.2
>


--=20
With Best Regards,
Andy Shevchenko
