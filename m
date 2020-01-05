Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33343C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00039207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 11:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgaObkLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgAEL0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 06:26:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31230 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgAEL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 06:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578223568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQIjgQihDEwHoAnpdzjkTor2gvcSRP7S37u8Euy9Qi0=;
        b=HgaObkLtPCOosKqefQjfzo73drW1Qn72OVicL3mCzlTBYEtVuuoyAdbHwL/hv+nDcNUe0R
        vTI8DDULhZW6FAHOPvzcBkze3lntYrcVyjN2rGM9DT1GN8IOjxyPneMKutfThuzD7KpZ+M
        dM5j655x4SE/BGJ3Mp65asCMbZGdQZY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-5Hc4hRGUN8SRE0_Vg6aXug-1; Sun, 05 Jan 2020 06:26:05 -0500
X-MC-Unique: 5Hc4hRGUN8SRE0_Vg6aXug-1
Received: by mail-qt1-f197.google.com with SMTP id c8so32480403qte.22
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 03:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hQIjgQihDEwHoAnpdzjkTor2gvcSRP7S37u8Euy9Qi0=;
        b=bw8tRoq7xiOcQjt7ZJ0KDn7LYubvYyKpc9irnYRhV8vFjkTWpCtldpJNtCV6523mU8
         MdSC0mPjWm3+nqZuwzVTKa0/viD8Kp5XatKuWONLZhu/BagA/YfY17jK79+MDJdSik+X
         hjb5hajuIvLC+P0cTqrLC+c2okCawWE9ppj6ERfo4bDVBFpWqv9Bz0xkqevY9QEOilM8
         m7TebKgYrxnn69OV61Dxy+hSSUoXJgjMHHBdoYpgCMokVSZfIG/z4KT5KmhixjIZ62m/
         a7nhv7q1lWZszrBmEY2KSgzkFHoDC4/83T6qLZTTm3S/EtTE54TW50HmzPaTcFx6rDNb
         FwfQ==
X-Gm-Message-State: APjAAAWEBx7brR76xHzFeA8ZqFJqIDvhdewJIIm01zyctSq5AbcXO2V6
        bsC+EoTTr5MnR4fKr7x3RusuJ3oXq9n6n+O9XvzWwn1jAAyrQE/O2T9+Zt45EDkThpoWm0E/lfJ
        y4ZdbHr1j89G+bBgU0J8g+rGE
X-Received: by 2002:a37:a70c:: with SMTP id q12mr65108289qke.484.1578223564594;
        Sun, 05 Jan 2020 03:26:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsb1Rq8qapXmNnmFjtPqA5IVovmngfDr1VhqP99yHJoF6zlFQia7pHWSTzJN2AHPaTc4CzPw==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr65108276qke.484.1578223564358;
        Sun, 05 Jan 2020 03:26:04 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id u57sm21651162qth.68.2020.01.05.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 03:26:03 -0800 (PST)
Date:   Sun, 5 Jan 2020 06:25:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Liu, Jiang" <gerry@linux.alibaba.com>,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
Message-ID: <20200105062023-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
 <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
 <42346d41-b758-967a-30b7-95aa0d383beb@linux.intel.com>
 <0c3d33de-3940-7895-2fe2-81de8714139c@redhat.com>
 <46806720-1D1C-40C3-BEE2-EDB0D4DA39BF@linux.alibaba.com>
 <7e151886-408e-2c1d-3958-77c26b8a4ac0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e151886-408e-2c1d-3958-77c26b8a4ac0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 05:12:38PM +0800, Jason Wang wrote:
> 
> On 2020/1/3 下午2:14, Liu, Jiang wrote:
> > > Ok, I get you now.
> > > 
> > > But still, having fixed number of MSIs is less flexible. E.g:
> > > 
> > > - for x86, processor can only deal with about 250 interrupt vectors.
> > > - driver may choose to share MSI vectors [1] (which is not merged but we will for sure need it)
> > Thanks for the info:)
> > X86 systems roughly have NCPU * 200 vectors available for device interrupts.
> > The proposed patch tries to map multiple event sources to an interrupt vector, to avoid running out of x86 CPU vectors.
> > Many virtio mmio devices may have several or tens of event sources, and it’s rare to have hundreds of event sources.
> > So could we treat the dynamic mapping between event sources and interrupt vectors as an advanced optional feature?
> > 
> 
> Maybe, but I still prefer to implement it if it is not too complex. Let's
> see Michael's opinion on this.
> 
> Thanks

I think a way for the device to limit # of vectors in use by driver is
useful. But sharing of vectors doesn't really need any special
registers, just program the same vector for multiple Qs/interrupts.

-- 
MST

