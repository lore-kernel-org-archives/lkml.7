Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D1C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE1C20715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434080;
	bh=EQc/LaSz4eRaJByoiZb2ipCt0IaDpCp3+GhULDtcYWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EGR+mKmLdudEksztQ55eFRik4FqgoOm09xWmhN1CaDkS46XxbBQ+OMSspEKi0X16M
	 z8Y4cPyjL77FPsL/5oOtIU5KtohWGeT2NJxq5hrNxinjx6IeolhWFnEoEd8W7jznxc
	 1YU+Aj2NJpRX5CwDpZH6Bb5oHXg6aoYdkLUPc9YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKVOr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfKVOr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:47:59 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155422071B;
        Fri, 22 Nov 2019 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434078;
        bh=EQc/LaSz4eRaJByoiZb2ipCt0IaDpCp3+GhULDtcYWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FY9hIt7gHlIrXLiJjfTrngT1JuA8auWUoxGefy3wnjz1lUJagg58qQeJDqVu35C5T
         RlXgqOKuIyqzm0XEHPf9wSSS8MfVuP5kY+MEUPElkfNP9bHHk48ESyfcj+mP6Bf/9N
         IxNivswgdnD6gb8XdyvVnW+izOhnPrAqvI1QqlOE=
Received: by mail-qv1-f46.google.com with SMTP id s18so2971565qvr.4;
        Fri, 22 Nov 2019 06:47:58 -0800 (PST)
X-Gm-Message-State: APjAAAX1kTNLScWxt2EsDLviaKdy+N+j/jeIR4c8KiFyHSIsj1aMaW7S
        pcVC04mMH7hdDvlVu0EaJNFPE7rIyeM0kZaeZw==
X-Google-Smtp-Source: APXvYqyhWIT3yYojkaDSRZHcglQ9AlPu/F+glNafGG7BMM/cuqSID3+8L1W2SEkE6TxBfitLGOKJZjTbCwxWZfeti28=
X-Received: by 2002:ad4:42b4:: with SMTP id e20mr3174130qvr.85.1574434077237;
 Fri, 22 Nov 2019 06:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20191120190028.4722-1-will@kernel.org>
In-Reply-To: <20191120190028.4722-1-will@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Nov 2019 08:47:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
Message-ID: <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, iommu@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
>
> Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> mboxes and io-channels") added device link support for IOMMU linkages
> described using the "iommus" property. For PCI devices, this property
> is not present and instead the "iommu-map" property is used on the host
> bridge node to map the endpoint RequesterIDs to their corresponding
> IOMMU instance.
>
> Add support for "iommu-map" to the device link supplier bindings so that
> probing of PCI devices can be deferred until after the IOMMU is
> available.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> Applies against driver-core/driver-core-next.
> Tested on AMD Seattle (arm64).

Guess that answers my question whether anyone uses Seattle with DT.
Seattle uses the old SMMU binding, and there's not even an IOMMU
associated with the PCI host. I raise this mainly because the dts
files for Seattle either need some love or perhaps should be removed.

No issues with the patch itself though. I'll queue it after rc1.

Rob
