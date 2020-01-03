Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC88EC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD21222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578041868;
	bh=UctUroM4nN96wkH2WxGx4Y08JnLKZp1J2MkJoCunL9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kPUyX79A3wMqtchbvXcImxs5dgGdqO9Vr4FpKf9tts5wa6GooZeM5ob3POpjUZ3T2
	 7MsjoYJxSSoIsBTrnLaORFf3uhgSTljtAGVMQvWjifsqR5RMOrZ1K696FKCK7e9JWC
	 9VSD6KYHQ21Rej2cdbXlB9XdegSVp/ABpEWIrmUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgACI5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:57:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38676 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgACI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:57:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so41132722edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 00:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r6qIuR+7bvXSiJDqaws/93bA9gUxPMySdOOHdmUI+9c=;
        b=Uas7W9I4m4qeQIjEB5GONGAgf/kMbyQ7cIpdqvYqrv5maqGulSwKmtGvffwl0KTQYf
         yWbVSP/dzfsBwAgENB02o1l+umXUq7RyNHv03rXv903jTUNE1j/eOFeerH52fsMjRUsm
         f29ttysfB+aG21Et3Ra/XMTbiOlibi8yMpadfkPkdvvmLQdDHZ2tcZoGXkZBajV8mO9x
         aOMOQPksdUMBkPRG8fwu+jrgTICYFEfa2oS93kLwJgdTUm5OQSgz73UgwX7da7QTSEke
         QtAUjI2HFO5SdPm5p+BUvkVI6si+o4Sq9+NQxrWKkrtzaEKiLnJhFXCzKwAbcpwwWmJ3
         cnqA==
X-Gm-Message-State: APjAAAWAncqo8ovmKYkmuf/EwsG/XdxFJMjQ7ho+3q5C/q66Y5qoKOvk
        uRVq0SKQQ86BdNT1FSJiA/U=
X-Google-Smtp-Source: APXvYqyTfPYeweyUs/D/35Bz3a7w+2H8lIK0gttyBHOE77/P2n2tGa1xOmAoP3pGN5h2t8468x1m2g==
X-Received: by 2002:a50:93a2:: with SMTP id o31mr92253605eda.160.1578041865550;
        Fri, 03 Jan 2020 00:57:45 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id qc1sm5717229ejb.49.2020.01.03.00.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 00:57:44 -0800 (PST)
Date:   Fri, 3 Jan 2020 09:57:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tero Kristo <t-kristo@ti.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu: Enable compile testing for some of drivers
Message-ID: <20200103081201.GA1439@pi3>
References: <20191230172619.17814-3-krzk@kernel.org>
 <201912311551.tBrb3BhH%lkp@intel.com>
 <20191231080722.GA6804@pi3>
 <923b1f2f-2b5c-8b6e-6083-243beae09777@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <923b1f2f-2b5c-8b6e-6083-243beae09777@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:40:16PM -0600, Suman Anna wrote:
> Hi Krzysztof,
> 
> On 12/31/19 2:07 AM, Krzysztof Kozlowski wrote:
> > On Tue, Dec 31, 2019 at 03:43:39PM +0800, kbuild test robot wrote:
> >> Hi Krzysztof,
> >>
> >> I love your patch! Perhaps something to improve:
> >>
> >> [auto build test WARNING on iommu/next]
> >> [also build test WARNING on v5.5-rc4]
> >> [if your patch is applied to the wrong git tree, please drop us a note to help
> >> improve the system. BTW, we also suggest to use '--base' option to specify the
> >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >>
> >> url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-omap-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191231-022212
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> >> config: ia64-allmodconfig (attached as .config)
> >> compiler: ia64-linux-gcc (GCC) 7.5.0
> >> reproduce:
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # save the attached .config to linux build tree
> >>         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
> >>
> >> If you fix the issue, kindly add following tag
> >> Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > I saw it already while compile testing my patch. I must admit that I
> > could not find easy/fast fix for it.  Probably the
> > omap_iommu_translate() helper should be made 64-bit friendly but this
> > obfuscates the code. 
> 
> >The driver and hardware supports only 32-bit addresses.
> 
> Yeah, is there a reason why you are trying to enable the build for the
> OMAP IOMMU driver on 64-bit platforms or other architectures - the IP
> and driver is only ever used on ARMv7 platforms, and it should already
> be available for COMPILE_TEST on those.

It's the same reason we enable compile testing on all other drivers
which will never be used outside original platforms. There are many
of such examples because we want to increase the build coverage to as
many different configurations as possible. There could be also another
benefit - easier code reusability - although it is purely theoretical in
this case, I think.

Best regards,
Krzysztof
