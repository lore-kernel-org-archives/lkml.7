Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67EC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6587720717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfFEKJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:09:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfFEKJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B95A53001463;
        Wed,  5 Jun 2019 10:09:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-131.ams2.redhat.com [10.36.117.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8BE1001DD2;
        Wed,  5 Jun 2019 10:09:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8B2FC17523; Wed,  5 Jun 2019 12:09:42 +0200 (CEST)
Date:   Wed, 5 Jun 2019 12:09:42 +0200
From:   "kraxel@redhat.com" <kraxel@redhat.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lv, Zhiyuan" <zhiyuan.lv@intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Yuan, Hang" <hang.yuan@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH v2 1/3] vfio: Use capability chains to handle device
 specific irq
Message-ID: <20190605100942.bceke6yqjynuwk3z@sirius.home.kraxel.org>
References: <20190604095534.10337-1-tina.zhang@intel.com>
 <20190604095534.10337-2-tina.zhang@intel.com>
 <20190605040446.GW9684@zhen-hp.sh.intel.com>
 <237F54289DF84E4997F34151298ABEBC87646B5C@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237F54289DF84E4997F34151298ABEBC87646B5C@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 05 Jun 2019 10:09:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Really need to split for different planes? I'd like a
> > VFIO_IRQ_SUBTYPE_GFX_DISPLAY_EVENT
> > so user space can probe change for all.

> User space can choose to user different handlers according to the
> specific event. For example, user space might not want to handle every
> cursor event due to performance consideration. Besides, it can reduce
> the probe times, as we don't need to probe twice to make sure if both
> cursor plane and primary plane have been updated.

I'd suggest to use the value passed via eventfd for that, i.e. instead
of sending "1" unconditionally send a mask of changed planes.

cheers,
  Gerd

