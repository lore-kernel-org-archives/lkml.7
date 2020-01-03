Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462D72085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578050223;
	bh=ZTWVLu1rOPLzy39EvIOvq5YGL+FAy+FCK8lZiKvt53o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dSSRYKUt6mMfW5bfkL+sxKNWeTdbla1XSJrOcEhsfP3+OqPkxj14nGF3RSdkWCSzt
	 I+bRLVnHwMMqB/Eac11ScUe5IWQTDOzMtvoEVIy9aqDakfQqagZ8lU7C6rDHlOSUm2
	 JMuYgEN4Or+D0AEDUvzaLmzOK6+w9c9vpc02TnJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgACLRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:17:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36290 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgACLRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:17:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so41375831edp.3;
        Fri, 03 Jan 2020 03:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Cz1bHF5KTHAkw4Fc68MgiqMwjrbDHHdLD3F5Ae3Ezo=;
        b=U2kTEpxLUAwEzsGJfscFLX4v3GZNYiWttCWG/tuuKQMPovjtkmn1KZLDYMoeQut83F
         yHhvVzsyVrme/DdSeVPB/7jDi84eVMOwNp6Lzie1s0Z8V+V6y+zLiXcX2764dV70CUjk
         KdQb8IahE44EdKgNppBWj+oLPApaDTZvOhsRG6Q4BA8WlwNRh6/hdR6HgpEN7PGnKIOu
         xu455aZUdKO2ePCYERlWuyToYZbY9K6iOjyb9VTX0Q1JAI8KwDb6HZo975d/ujcXcV37
         cO6r1vGJoYj6sCAX/nMFBhOT2r3N44Cz68blkwriz9rjdWlTjUBmxXMpsyw4tYLHEm4s
         5yYw==
X-Gm-Message-State: APjAAAXqMiq1fl11ua07wVnr/ulIpyQwhT/RiLUlPMIrzcPuOxbTjEJb
        bPXRnBAvD55+rzReCCq9cRQ=
X-Google-Smtp-Source: APXvYqwm0Aou1t/E4yDsF/8shNlUmMED7vothBxjbyR0PYteuXhZsEv8NzzR+qZMCInWvdpwvwuN7A==
X-Received: by 2002:a17:906:a88e:: with SMTP id ha14mr91081234ejb.169.1578050218870;
        Fri, 03 Jan 2020 03:16:58 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id y4sm7699793ejr.41.2020.01.03.03.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 03:16:58 -0800 (PST)
Date:   Fri, 3 Jan 2020 12:16:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: Remove unneeded "snps,dwc2"
 from hsotg node
Message-ID: <20200103111655.GA1605@pi3>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
 <20191219103536.25485-3-benjamin.gaignard@st.com>
 <20191230153758.GB4918@pi3>
 <bbc7e34c-75c2-dfe0-70f3-0685e8e54fed@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbc7e34c-75c2-dfe0-70f3-0685e8e54fed@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 08:50:39AM +0000, Benjamin GAIGNARD wrote:
> 
> On 12/30/19 4:37 PM, Krzysztof Kozlowski wrote:
> > On Thu, Dec 19, 2019 at 11:35:36AM +0100, Benjamin Gaignard wrote:
> >> Remove "snps,dwc2" from hsotg@12480000 node compatible list because
> >> "samsung,s3c6400-hsotg" should be enough.
> > The more detailed compatible is almost always "enough". Some other nodes
> > also have detailed+generic compatible. In this case there is a driver
> > matching "snps,dwc2" so why removing it?
> 
> First because, unlike the others dwc2 devices, this compatible wasn't 
> describe in the bindings file
> 
> so I had to investigated how it should work and, on samsung DT files, 
> only "samsung,s3c6400-hsotg".
> 
>  From driver code point of view that seems coherent (we do the same for 
> stm32).
> 
> With that in mind I have decided to remove "snps,dwc2" from exynos DT 
> file rather than add it everywhere else.
>

Actually fine with me, although I would be happy if Rob or Mark could
confirm that it is a preferred approach.

Rob, Mark, could you share your thoughts?

Best regards,
Krzysztof

