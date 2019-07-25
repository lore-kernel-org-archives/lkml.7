Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92364C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6935A21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+5aYuGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfGYRfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:35:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40724 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfGYRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:35:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so23394787pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tnaeq0Y3gkRSznLM6wB5JlAIZ9EuxGX/RgrHx+lQ6GU=;
        b=C+5aYuGN+LuL47FHCQgQ9iMOaKrQPwI6rEsMqVIxiLRCFl0kcnZ69GnOd+kfP+3l/4
         NMb0HnaCFhUke7ZRA8n8Z0DCNmrjLMoGxxCqmbIwNuIV0ruFj/VzEPzf1NxzCK7O0O/1
         WwxUoiojsmZ35+KD2hXhb20xaKkY5xMReRfSlsK060VHSPiRJjQNeU0qIF4ti/MYIiXl
         TVTBQMIxdpAY9/Ovwh1DGI07f48+LwYAf7s17RpCoY2bgEOG6JiF1f1mt4xb3JiH+TIs
         QITDNjyjPq5oIcqvi7vBU1qOv+Woc3yaux5G3GVaKl8i1XTSaLP1H0Kw6ycxoL4ekXbb
         2IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tnaeq0Y3gkRSznLM6wB5JlAIZ9EuxGX/RgrHx+lQ6GU=;
        b=NYhdzHsEDUAoF1TjY+j9DT1OJLrf8JS4vKlrzrocJsP0wIx0ILQjL8F8EkWbI3jLJ2
         bqQMcnux2z8WNmxxnWrxn+Yt6G58EMPDMGjTQt+G3KTL4NuGmo0EWZO2xKPsDJLrVHe+
         CnJQg7JAbs04YTDR01w+IuzutwcWjf9DQ48Uozm6xe0JJQ3Z5Cmd+GeWW6drIRfOj7LX
         xRWW0FroUSV1Ywg7u3jINYp7oOapHtxeGtGAZBrSnv6RcP71+qbziTnRMAYIV+67n+P/
         zjybWXepupwebsCabIrRrVzj21aPJpkWYA9Me2Z5P9P58bGDqrOx5Gk8to8PapH9KuQw
         HqOQ==
X-Gm-Message-State: APjAAAX1FVHUNAYCBQS9oAdVoIo0vdc8i6nSv8Y3dpY2QhWWkvYaYIw2
        F/851WlkRrf2KeQHgKs74Y4=
X-Google-Smtp-Source: APXvYqwe+yUchsfysKmX+u+rwDIkY25DbaaG/Uj2Zbrvveshs2+AdWjHxuGcXkR4lEW/BnFn30cwhQ==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr61150026pgv.315.1564076153804;
        Thu, 25 Jul 2019 10:35:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z4sm78975766pfg.166.2019.07.25.10.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 10:35:53 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:36:38 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
Message-ID: <20190725173637.GC31961@Asurada-Nvidia.nvidia.com>
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
 <20190701122158.GE8166@8bytes.org>
 <91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
 <20190701215016.GA16247@Asurada-Nvidia.nvidia.com>
 <d4bccb17-2f7a-65e4-6c89-e37cceb6d935@arm.com>
 <20190702210400.GA14593@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702210400.GA14593@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to ping this but it's been a while.

Robin, did you get a chance to resend your version?

Thanks
Nicolin

On Tue, Jul 02, 2019 at 02:04:01PM -0700, Nicolin Chen wrote:
> On Tue, Jul 02, 2019 at 11:40:02AM +0100, Robin Murphy wrote:
> > On reflection, I don't really think that size_t fits here anyway, since
> > all the members of the incoming struct scatterlist are unsigned int too.
> > Does the patch below work?
> 
> Yes.
> 
> > ----->8-----
> > From: Robin Murphy <robin.murphy@arm.com>
> > Subject: [PATCH] iommu/dma: Handle SG length overflow better
> > 
> > Since scatterlist dimensions are all unsigned ints, in the relatively
> > rare cases where a device's max_segment_size is set to UINT_MAX, then
> > the "cur_len + s_length <= max_len" check in __finalise_sg() will always
> > return true. As a result, the corner case of such a device mapping an
> > excessively large scatterlist which is mergeable to or beyond a total
> > length of 4GB can lead to overflow and a bogus truncated dma_length in
> > the resulting segment.
> > 
> > As we already assume that any single segment must be no longer than
> > max_len to begin with, this can easily be addressed by reshuffling the
> > comparison.
> > 
> > Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> > Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> Thank you!
> 
> > ---
> >  drivers/iommu/dma-iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 129c4badf9ae..8de6cf623362 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -721,7 +721,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  		 * - and wouldn't make the resulting output segment too long
> >  		 */
> >  		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> > -		    (cur_len + s_length <= max_len)) {
> > +		    (max_len - cur_len >= s_length)) {
> >  			/* ...then concatenate it with the previous one */
> >  			cur_len += s_length;
> >  		} else {
