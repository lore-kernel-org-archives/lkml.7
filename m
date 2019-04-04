Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC7BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCDA21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfDDVaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:30:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfDDVaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:30:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C494331676A0;
        Thu,  4 Apr 2019 21:30:07 +0000 (UTC)
Received: from flask (ovpn-204-248.brq.redhat.com [10.40.204.248])
        by smtp.corp.redhat.com (Postfix) with SMTP id BA33B6013B;
        Thu,  4 Apr 2019 21:30:04 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 04 Apr 2019 23:30:03 +0200
Date:   Thu, 4 Apr 2019 23:30:03 +0200
From:   "rkrcmar@redhat.com" <rkrcmar@redhat.com>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 0/6] KVM/x86: Add workaround to support ExtINT with AVIC
Message-ID: <20190404213001.GA21138@flask>
References: <20190322115702.10166-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322115702.10166-1-suravee.suthikulpanit@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 04 Apr 2019 21:30:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-03-22 11:57+0000, Suthikulpanit, Suravee:
> This series is one of the prerequisites for supporting AMD AVIC with
> in-kernel irqchip (kernel_irqchip=on).
> 
> Since AVIC does not support ExtINT interrupt, which is required during
> the booting phase of Windows and FreeBSD VMs (e.g. PIT -> PIC -> ExtInt).
> This results in VM hang in the boot loader with kernel_irqchip=on mode.
> 
> This series provides workaround by temporary deactivate AVIC and fallback
> to use legacy interrupt injection (w/ vINTR and interrupt window).
> Then re-activate AVIC once the intrrupts are handled.

The solution looks reasonable (although it seems dangerous to me) as we
only enable the workaround if the interrupt cannot be immediately
injected.

The interesting part is that split irqchip works, yet it cannot inject
ExtInt correctly either -- does the guest OS behave differently, or does
split irqchip just ignore the ExtInt?

Thanks.
