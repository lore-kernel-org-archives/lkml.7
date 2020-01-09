Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF57206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQVu7+Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbgAIQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:47:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60618 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730602AbgAIQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578588457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9FIl7rDMUNIt3w4+k0tpPrJircKZXQ1T/Tj9bbLmLY=;
        b=eQVu7+IakbEhvvuTQvJ1E2YaqRP5Q2rwiY6oPMwpVXh8Nhq4QEwVnMd6c3maA8NaonvA5D
        4iLxD3773TqmpRTpsD3GuMxvhSNnp/0ahAFDTgV+3WXvbqiG3S384kUL4R25QmXw4CLbyK
        nw/653vxPa4m88CFTIbV8xvs6nVI29o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-gF7Ek3tiMP2QLdbAGqY0bA-1; Thu, 09 Jan 2020 11:47:32 -0500
X-MC-Unique: gF7Ek3tiMP2QLdbAGqY0bA-1
Received: by mail-qk1-f199.google.com with SMTP id 12so4497255qkf.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U9FIl7rDMUNIt3w4+k0tpPrJircKZXQ1T/Tj9bbLmLY=;
        b=Ovqv7jtfervpIFDorTNxITnTXDuFVacnXH64uBYSBseqJjRiTPrWzJ7mgxrcUbUxB6
         SlszWa6wRyX++eLuUru5Kaa30VVQgi55m9Cwj6aEmHrllqTPD+PEeKBv+tKS1AyjSuf2
         lfdXlizTdPm2L+C64rquanPv1Vpl9aRxxZgAj7nJ/BzdWWKGY3+XaRBfAm24p7f2YrOU
         vcOHs0ayN386A9RVaoMZW51NvFIkfnA0RYyg926+B6wYfKLbmRgEIQm5kaMfABWh7TS9
         mZX7E0GSd0r7g1cYwis+TsB3FitQXxydiElWr7kQZzzdC/szBLHc0EhDBa7CVWy0o8om
         yrpw==
X-Gm-Message-State: APjAAAW6jZ7+vWixmpAhT7dzxp4Ramlv6BiPjBg/85u6uIJWLQv/gG5B
        fUsCKVhofAnWC3zxKciStmd4H5jT7ofkhYiFuvBtLdZFGphwbSiP26PRwZrn5Jm/5jOQI8fAdQp
        DrIqJ0F7699P6BUQdkSI6TkT+
X-Received: by 2002:ac8:5548:: with SMTP id o8mr8935323qtr.338.1578588452255;
        Thu, 09 Jan 2020 08:47:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwAKBfw/mcHeuQ026GQ49p5hdE4B6gg9fnX8ron2h9YThB1fl/A2F3tWZ+1vWN8URbak9EJFg==
X-Received: by 2002:ac8:5548:: with SMTP id o8mr8935302qtr.338.1578588452030;
        Thu, 09 Jan 2020 08:47:32 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id o55sm3628837qtf.46.2020.01.09.08.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:47:31 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:47:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Liu, Jiang" <gerry@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Message-ID: <20200109114209-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
 <20200105054142-mutt-send-email-mst@kernel.org>
 <02D38CC0-8DD5-44E1-92B2-0F9E97A112CE@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02D38CC0-8DD5-44E1-92B2-0F9E97A112CE@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:06:06AM +0800, Liu, Jiang wrote:
> On Jan 5, 2020, at 6:42 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Thu, Dec 26, 2019 at 09:16:19PM +0800, Liu, Jiang wrote:
> >>> 2) The mask and unmask control is missed
> >>> 
> >>> 
> >>>> but the extension doesn’t support 3) because
> >>>> we noticed that the Linux virtio subsystem doesn’t really make use of interrupt masking/unmasking.
> > 
> > Linux uses masking/unmasking in order to migrate interrupts between
> > CPUs.
> This is a limitation of the PCI MSI/MSIx spec.
> To update the MSI/MSIx vector configuration, we need to write to msg_high/msg_low/msg_data registers.
> Because write to three 32-bit registers is not an atomic operation on PCI bus, so it may cause incorrect interrupt delivery if interrupt happens after writing 1 or 2 registers.
> When Intel remapping is enabled on x86 platforms, we don’t need to mask/unmask PCI MSI/MSIx interrupts when setting affinity.
> For MMIO MSI extension, we have special design to solve this race window. The flow to update MMIO MSI vector configuration is:
> 1) write msg_high
> 2) write msg_low
> 3) write msg_data
> 4) write the command register to update the vector configuration.
> During step 1-3, the hardware/device backend driver only caches the value written. And update the vector configuration in step 4, so it’s an atomic operation now.
> So mask/unmask becomes optional for MMIO MSI interrupts.

Oh I see. That needs some documentation I guess.

One question though: how do you block VQ from generating interrupts?

There's value in doing that for performance since then device can avoid
re-checking interrupt enable/event idx values in memory.



> > 
> > -- 
> > MST

