Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77FC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A47207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7df1BCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgAEKnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:43:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51951 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgAEKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578220977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRbZ0RjIa8H/cOxd2x24HFOzfU7e/RH05WrdITWM4vc=;
        b=C7df1BCtGqUInDjvodrgqMplmEJCuUR8w0GkNZlueClXKyUlKiK576HyQlvHFXzoVNzif4
        DPUB23ePf0QZMvnAi1jtRNPXyolF53eDkAVKe29OJ5zASRIEV7+2xZ6dVSb6l2cdKd3Mph
        630Y68RzH2awrMkNTkzHUmzeHXlSkvk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-q9fdW6aaPeSh3lERlMIE-w-1; Sun, 05 Jan 2020 05:42:56 -0500
X-MC-Unique: q9fdW6aaPeSh3lERlMIE-w-1
Received: by mail-qt1-f200.google.com with SMTP id p12so32396036qtu.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 02:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BRbZ0RjIa8H/cOxd2x24HFOzfU7e/RH05WrdITWM4vc=;
        b=FWd00FnSpWqholdOxKJ3sq1Pr+scCopCu2wga5YsO9iCOxSik5/mIQhp7ZO+tYPgjy
         MaF7NHjL8A7s4p9rzNUxs9n1xF5O2TD+wmiTEeDDYEs4F04mlUEj3yCuP8R4S0ioDbDP
         gEGGE52qikoQYrdYkhHcktPyE8w094nJAUcIqlE/tekDmJAYGZyw9/QCDSjvx6Zs/wqo
         MgqoHGKWo/yAFOtdQo4VNQk17u5DkdObaBObyTq7gnFF/rIcAljA8a59suOVadc7zfJ1
         RyY50e/AGZvLgSOGF4t2gyn2naFXHzb9d6JLeOc+XDJsQvNlvQyn5tuNhDjJkoQven2M
         4M8w==
X-Gm-Message-State: APjAAAXPRpyqye8VlYRpVmYoNzF3YZjhFrMWd+0saHYJ/UiF6ipiLHT2
        9W7CnuBbx60nl/eTPVRFGZ4PwtWOwPDSfmNYWO4A6FlcwKPQrhmymUNgxSxrgTCabGhjhud6J/S
        Sra5of3nDRejsY5B485SZq/dU
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr72765883qtn.43.1578220975920;
        Sun, 05 Jan 2020 02:42:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxj37eEGp0vK5+GAdvI9b+oNDJsVwzEDoaTsQeftbJEGASoWKbu6C/R5mfmWJzInC+HeiO7bA==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr72765874qtn.43.1578220975732;
        Sun, 05 Jan 2020 02:42:55 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id u7sm18701159qtg.13.2020.01.05.02.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 02:42:54 -0800 (PST)
Date:   Sun, 5 Jan 2020 05:42:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Liu, Jiang" <gerry@linux.alibaba.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, jing2.liu@intel.com,
        chao.p.peng@intel.com
Subject: Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Message-ID: <20200105054142-mutt-send-email-mst@kernel.org>
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 09:16:19PM +0800, Liu, Jiang wrote:
> > 2) The mask and unmask control is missed
> > 
> > 
> >>  but the extension doesn’t support 3) because
> >> we noticed that the Linux virtio subsystem doesn’t really make use of interrupt masking/unmasking.

Linux uses masking/unmasking in order to migrate interrupts between
CPUs.

-- 
MST

