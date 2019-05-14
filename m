Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4386CC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CDC2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ie1FW8t/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfENOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:55:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42026 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfENOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:55:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id d4so10449214qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kGY/UxYYLr+YI89dChLQwq+Sl4QElIXlRa9KLaAqLc=;
        b=Ie1FW8t/zgtSHMLE2lv6OkWmsD0oHrb8dnkzxez9BUMpQYX4t445sRjeAKgrjA7gNq
         WZ+YK+yyNYBGivt+XlQQ0/ID8fRy14jEYu/8aGAM5rft2MiqJH6UfW2XSfA1rJ9EH9VU
         oNJrwWHJU3YNPOJaAq0LTm9px6raXtNI79sLYOu686Yg4euDvJ3lIePTNVKPqrMDG/0t
         pdecmTsjtjsMD1DGa8Ynj3tu+Oo6MZfqLnX8+iccbLm0GEXBQqjsEa4x7oxY3k8XhKeg
         rC9ZW9jRKt3+aUCnp1hidNEQG50mtkTRoJinWF+6rgMSvDuVjhdiFV5dP4GLYc5Vl0tF
         sRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kGY/UxYYLr+YI89dChLQwq+Sl4QElIXlRa9KLaAqLc=;
        b=X+iWErW5xlMHJPGG4lcKJOU/hNzGJ4fE7h01MLtpQ/pgY5U8D7O+uY2jCl1pWTGxqD
         /L6epxku+VYdJnMi+Q5p96AWxRuomlLARRDitaDQ/8atMJ2uI53EjWBI10ggQnzxNNc1
         BfCvHBFCHNksbu81VUfHnfqXwUu0S9+qwoSP41GM3uaLwNYF/brWFtRkeMQ9F1Zht95L
         1SSe6wpxa7evnIoqltIyTpmiU3UL+hLp3UeJq93EefYIWxY9ornaWqYMCeSVlE0LhIYX
         rKzq+lp4V+1QFAR8AYqfa4vG7MR+dBlG1YGLcs5Uamvn0J+NISxllHguQc77Jmv7hbMu
         1m5w==
X-Gm-Message-State: APjAAAXf/hSVdLEjjxN7LZhqmM+Ii24idyRbFxCLBQoouue7/WwaItBe
        ZHi9PGySxlX1+wvE9C8Rufj0wYFlz9Q=
X-Google-Smtp-Source: APXvYqyyouR/emlU+oGf1TyeVSV5Y8Cb0m/ABHv93umiARSns7lGaXQJkvikuj3dJnQac8uYNBfw3Q==
X-Received: by 2002:a37:508a:: with SMTP id e132mr27875371qkb.281.1557845748158;
        Tue, 14 May 2019 07:55:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r143sm546809qke.62.2019.05.14.07.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:55:47 -0700 (PDT)
Message-ID: <1557845746.6132.27.camel@lca.pw>
Subject: Re: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
From:   Qian Cai <cai@lca.pw>
To:     Gary R Hook <ghook@amd.com>, "jroedel@suse.de" <jroedel@suse.de>
Cc:     "Hook, Gary" <Gary.Hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 14 May 2019 10:55:46 -0400
In-Reply-To: <ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
References: <20190506041106.29167-1-cai@lca.pw>
         <ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-07 at 13:47 +0000, Gary R Hook wrote:
> On 5/5/19 11:11 PM, Qian Cai wrote:
> > [CAUTION: External Email]
> > 
> > The commit e7f63ffc1bf1 ("iommu/amd: Update logging information for new
> > event type") introduced a variable "tag" but had never used it which
> > generates a warning below,
> > 
> > drivers/iommu/amd_iommu.c: In function 'iommu_print_event':
> > drivers/iommu/amd_iommu.c:567:33: warning: variable 'tag' set but not
> > used [-Wunused-but-set-variable]
> >    int type, devid, pasid, flags, tag;
> >                                   ^~~
> > so just use it during the logging.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >   drivers/iommu/amd_iommu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index f7cdd2ab7f11..52f41369c5b3 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -631,9 +631,9 @@ static void iommu_print_event(struct amd_iommu *iommu,
> > void *__evt)
> >                  pasid = ((event[0] >> 16) & 0xFFFF)
> >                          | ((event[1] << 6) & 0xF0000);
> >                  tag = event[1] & 0x03FF;
> > -               dev_err(dev, "Event logged [INVALID_PPR_REQUEST
> > device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
> > +               dev_err(dev, "Event logged [INVALID_PPR_REQUEST
> > device=%02x:%02x.%x pasid=0x%05x tag=0x%04x address=0x%llx flags=0x%04x]\n",
> >                          PCI_BUS_NUM(devid), PCI_SLOT(devid),
> > PCI_FUNC(devid),
> > -                       pasid, address, flags);
> > +                       pasid, tag, address, flags);
> >                  break;
> >          default:
> >                  dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x
> > event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
> 
> I did manage to overlook that variable when I posted the original patch. 
> But it looks to me like 41e59a41fc5d1 (iommu tree) already fixed this... 
> I'm not sure why it never got pushed to the main tree.

Jroedel, I am wondering what the plan for 41e59a41fc5d1 (iommu tree) or this
patch to be pushed to the linux-next or mainline...
