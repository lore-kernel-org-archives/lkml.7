Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51EEC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CA92085A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iSUEzSFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFUAxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:53:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42363 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFUAxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:53:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so4620489otn.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IghIqITuGVBjgBvbbflv0TslA9+YilTAx3aDj+IKW0E=;
        b=iSUEzSFfmatZoJgKO1yj/Kcbx3Ywzei9QORLaR3Ctk/x/ZYE9lzCOtEprPLVw0JUmv
         e13psNOsRtWfcQB5DP4gjXZ+W67oU/THRjMaePL9RklilCagvxOCdWt2wqmYBo/G/hZJ
         BF53dTAMBZg+GSYbRutW2r3Kb9wAq82+yBo0pOfZimU+uELWz6e277eESoPJ5ltQj7fh
         Vp5uWFCUjk73zisVQgonagRy/navlO+k6ayJUPF8Mw2iLVsIUyelwZSrmXHMP4v5bTEr
         LHfazDoivo65gBtWJzg8uQ5nBE46PmVGr2J+/msk0Oa0gJQdaHhYGOrp+RToECfW9iI1
         5Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IghIqITuGVBjgBvbbflv0TslA9+YilTAx3aDj+IKW0E=;
        b=sqi4RjYZL0D/FmUbwUj2S1kpJ1gij/T3sy4Douy2RL+0UGlkvqGQzPZXBOlcshsYJG
         kuw7J0/g6VyPUFNd9NPAfLjhs+uA0Rlsvw3flEOyGFZAkS7wYbmnZKyE5UICEeIZgekp
         hnoC8uVPoBiHT+WsjUpPj+JcTocOaFSLTj2w5exX7fZ9COL6l+Q08NQYle2bDsozFyyE
         /DoKURbef9e/oLsXW/nY2/RL77vUNMq8jpAPbfuemKioDz2Ls++uwodVD0t3dMlb42cK
         A5aOqtTDm7DKDqLPFuSH7BIeqGhyzqTt8JNpaY+/tu0EEQGuYeEsRTGSfLf0Ah5EFpz2
         KAiQ==
X-Gm-Message-State: APjAAAVsav37RDskA+Uew6Rq82DplmKvszS0kspQ4vmbswbrnFH95MKj
        lXv6xvFUsjfHdukEdtIpM5NWO4lqv5Pd6JKAnlL6cw==
X-Google-Smtp-Source: APXvYqx5KcOBOzPCKgbcSAH1KU0s2av7WgxnuPirQK4Cf1comzME+lU9tyw6zXdJxCrPsxTVvDEls2SfMF3l78DzMSw=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr41545473otf.126.1561078427423;
 Thu, 20 Jun 2019 17:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190621004038.15180-1-vishal.l.verma@intel.com>
In-Reply-To: <20190621004038.15180-1-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jun 2019 17:53:36 -0700
Message-ID: <CAPcyv4hzK12RKns5pybmy=5B-yfCQ+-C4FO+2kRGjRZP4wa5GQ@mail.gmail.com>
Subject: Re: [PATCH] device-dax: Add a 'resource' attribute
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 5:41 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> device-dax based devices were missing a 'resource' attribute to indicate
> the physical address range contributed by the device in question. This
> information is desirable to userspace tooling that may want to use the
> dax device as system-ram, and wants to selectively hotplug and online
> the memory blocks associated with a given device.
>
> Without this, the tooling would have to parse /proc/iomem for the memory
> ranges contributed by dax devices, which can be a workaround, but it is
> far easier to provide this information in the sysfs hierarchy.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me, applied.
