Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ABDC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2505120663
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfF0GWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0GWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:22:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CEF1356CD;
        Thu, 27 Jun 2019 06:22:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC06B5D719;
        Thu, 27 Jun 2019 06:22:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EB94016E08; Thu, 27 Jun 2019 08:22:31 +0200 (CEST)
Date:   Thu, 27 Jun 2019 08:22:31 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenyuw@linux.intel.com,
        zhiyuan.lv@intel.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
        hang.yuan@intel.com, alex.williamson@redhat.com
Subject: Re: [RFC PATCH v3 0/4] Deliver vGPU display vblank event to userspace
Message-ID: <20190627062231.57tywityo6uyhmyd@sirius.home.kraxel.org>
References: <20190627033802.1663-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627033802.1663-1-tina.zhang@intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 27 Jun 2019 06:22:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Instead of delivering page flip events, we choose to post display vblank
> event. Handling page flip events for both primary plane and cursor plane
> may make user space quite busy, although we have the mask/unmask mechansim
> for mitigation. Besides, there are some cases that guest app only uses
> one framebuffer for both drawing and display. In such case, guest OS won't
> do the plane page flip when the framebuffer is updated, thus the user
> land won't be notified about the updated framebuffer.

What happens when the guest is idle and doesn't draw anything to the
framebuffer?

cheers,
  Gerd

