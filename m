Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76BBC31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8D82084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfFQTyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:54:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfFQTye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76A8B30872E1;
        Mon, 17 Jun 2019 19:54:28 +0000 (UTC)
Received: from redhat.com (ovpn-125-143.rdu2.redhat.com [10.10.125.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 522804146;
        Mon, 17 Jun 2019 19:54:27 +0000 (UTC)
Date:   Mon, 17 Jun 2019 15:54:25 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     bskeggs@redhat.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>, jasojgg@ziepe.ca,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/svm: Convert to use hmm_range_fault()
Message-ID: <20190617195425.GA4085@redhat.com>
References: <1558378918-25279-1-git-send-email-jrdr.linux@gmail.com>
 <CAFqt6zYmL2P9w0Z4yfPtB=ftiy-H6-_beYsXJq-nD9T5OAw6Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYmL2P9w0Z4yfPtB=ftiy-H6-_beYsXJq-nD9T5OAw6Dg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 17 Jun 2019 19:54:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 12:14:50AM +0530, Souptick Joarder wrote:
> Hi Jason,
> 
> On Tue, May 21, 2019 at 12:27 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Convert to use hmm_range_fault().
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> 
> Would you like to take it through your new hmm tree or do I
> need to resend it ?

This patch is wrong as the API is different between the two see what
is in hmm.h to see the differences between hmm_vma_fault() hmm_range_fault()
a simple rename break things.

> 
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > index 93ed43c..8d56bd6 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> > @@ -649,7 +649,7 @@ struct nouveau_svmm {
> >                 range.values = nouveau_svm_pfn_values;
> >                 range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
> >  again:
> > -               ret = hmm_vma_fault(&range, true);
> > +               ret = hmm_range_fault(&range, true);
> >                 if (ret == 0) {
> >                         mutex_lock(&svmm->mutex);
> >                         if (!hmm_vma_range_done(&range)) {
> > --
> > 1.9.1
> >
