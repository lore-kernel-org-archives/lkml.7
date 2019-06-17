Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED5BC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F25120657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP7fYX1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfFQJ1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:27:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46339 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:27:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so5456577pgr.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dUidyHQAftHbjerQV/i5Ugw4tqRsaZ6rcF/lI+eVsNg=;
        b=IP7fYX1QtOaM1GZZaP19/gJzQ+WdGbPMHu7ox2R+UUAh9IKBL9iwbck7DLhXtK/Zg/
         PMVerRsS/SMMQsr370+l54t6eXYBkE0pZeQENazWFiAdZ/zoiGyZeJ3aPwsf2rqiWbnD
         D2E2qNkWcBN9dwZduvXxDJ7CJkVc9nFD2DMNqsVRG1LuIISUCEsSZLELmrv3S9EcnGCm
         4bJP9kZnz+ahwDb0ZaUXqfTdsHXMSS7Qr0eYP57kJSkIxPZ9VS9Pj4kZgVXzFlQoaj2x
         irWpfwlGLckkM5yegrpBmLVm84iay9dx6JHXxSZL6ofR3qkZjwiW14aAHI0LTna2z05B
         BOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUidyHQAftHbjerQV/i5Ugw4tqRsaZ6rcF/lI+eVsNg=;
        b=pjKaXfW37DLylBNClkJWMiX4QVnYe4tfWUPCGaNNFqs7mO9wo+feIiAKaD4jc+gH2m
         89qTtQzBNe9O2zLI1q7aQE2SSvQWnBcu8rGHyV9X+y3s/QJLXO3Yi1WZl3fmkoBe8+4E
         SupDUvTUrXxgVNvlyl8FsIQaMeobmWffjr1i6fW0vrMFGiiRzhO9BaS0oHqzrfvjK4G2
         K8ctFy9cmLkSFZJgtL1NQU7Mw2ZqWuieIxXLEj+JeBvryNAWx95Mmpe3zcFl7kSDm9kw
         VN8BNJhvNIFSMtnnbTKqMHf1eVQwoG2c9v46VGXh2O/1nEnsyQZYvvQxWPxm2IhbhAqa
         d/bw==
X-Gm-Message-State: APjAAAV5wOsZQRmhjEe0sFkttZN9JCU26uwwK3yUaCXRN6x401ILoNod
        ZleYN8pOk1CydjlYPpNYobA=
X-Google-Smtp-Source: APXvYqz53GKM2zDcID98ilbdDtCAXVgPYIJEdqCrBU+h411vYFaSdMeVFTOnnUzXyq5MPCjyQN7tsA==
X-Received: by 2002:a65:510c:: with SMTP id f12mr46645590pgq.92.1560763636871;
        Mon, 17 Jun 2019 02:27:16 -0700 (PDT)
Received: from ubuntu ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id m20sm10282703pjn.16.2019.06.17.02.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 02:27:16 -0700 (PDT)
Date:   Mon, 17 Jun 2019 02:27:10 -0700
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, dm-devel@redhat.com,
        agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm-init: fix 2 incorrect use of kstrndup()
Message-ID: <20190617092710.GB3764@ubuntu>
References: <20190529013320.GA3307@zhanggen-UX430UQ>
 <fcf2c3c0-e479-9e74-59d5-79cd2a0bade6@acm.org>
 <20190529152443.GA4076@zhanggen-UX430UQ>
 <20190530161103.GA30026@redhat.com>
 <20190606092725.GA21792@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606092725.GA21792@zhanggen-UX430UQ>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 05:27:25PM +0800, Gen Zhang wrote:
> On Thu, May 30, 2019 at 12:11:03PM -0400, Mike Snitzer wrote:
> > On Wed, May 29 2019 at 11:24am -0400,
> > Gen Zhang <blackgod016574@gmail.com> wrote:
> > 
> > > On Wed, May 29, 2019 at 05:23:53AM -0700, Bart Van Assche wrote:
> > > > On 5/28/19 6:33 PM, Gen Zhang wrote:
> > > > > In drivers/md/dm-init.c, kstrndup() is incorrectly used twice.
> > > > > 
> > > > > It should be: char *kstrndup(const char *s, size_t max, gfp_t gfp);
> > > > 
> > > > Should the following be added to this patch?
> > > > 
> > > > Fixes: 6bbc923dfcf5 ("dm: add support to directly boot to a mapped
> > > > device") # v5.1.
> > > > Cc: stable
> > > > 
> > > > Thanks,
> > > > 
> > > > Bart.
> > > Personally, I am not quite sure about this question, because I am not 
> > > the maintainer of this part.
> > 
> > Yes, it should have the tags Bart suggested.
> > 
> > I'll take care it.
> > 
> > Thanks,
> > Mike
> Hi,
> Is there any updates about this patch? I want to check if it is apllied
> beacause I have to write it down in my paper and the deadline is close.
> 
> Thanks
> Gen
Could anyone look into this patch? It's not updated for about 20 days.
And I am really on a deadline to get this patch applied.

Thanks
Gen
