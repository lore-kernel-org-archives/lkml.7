Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417F120854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfCNLbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:31:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfCNLa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:30:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35FE98B95B;
        Thu, 14 Mar 2019 11:30:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF8F75D706;
        Thu, 14 Mar 2019 11:30:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D5DC21750C; Thu, 14 Mar 2019 12:30:56 +0100 (CET)
Date:   Thu, 14 Mar 2019 12:30:56 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RfC PATCH] fbdev: list all memory bars as conflicting apertures
Message-ID: <20190314113056.sa4zkunxgyxef3t5@sirius.home.kraxel.org>
References: <20190313110741.6541-1-kraxel@redhat.com>
 <20190314103713.GQ2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314103713.GQ2665@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 14 Mar 2019 11:30:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:37:13AM +0100, Daniel Vetter wrote:
> On Wed, Mar 13, 2019 at 12:07:41PM +0100, Gerd Hoffmann wrote:
> > Simply add all pci memory bars to struct apertures_struct in
> > remove_conflicting_pci_framebuffers().  That allows to drop
> > the res_id parameter.
> > 
> > TODO: actually remove the res_id parameter.
> 
> I think best to do that in a cleanup patch afterwards.

I was just lazy and didn't want update all callers for the first patch
draft.  But doing a test run ...

> Maybe if you want to be paranoid in the conversion add a check that we're
> not skipping the pci bar requested in res_id. Then we could test this for
> a kernel and remove the parameter later on.

... that way before actually dropping the parameter surely makes sense.

New version on the way,
  Gerd

