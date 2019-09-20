Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1A3205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569013718;
	bh=Gy1AwUzTvd3mDHQcE/21HXuBb94yxSnNRM2jjyiuhsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xj31Zmb3RIf4GjwaD9GpjRDGQ4e0We3sKERHbpe55ZDaYF4zxgmyAZHNKHNGtLqUH
	 SuXr/Zb+daL17eHwWDqjwC0aiDuJZDhF1pugFO6SEljlK6JCsOVV1r/lNd6CVBKlYd
	 iUxH8Kag8t6rmJ8t+6LKyJkwhDtmRm/bvdFNRtrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393440AbfITVIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:08:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42047 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbfITVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:08:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so8719083qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 14:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tk0/PH3z5NFDWEmG2DQ0oCDmwhwymD90qA9Pv0LPVfc=;
        b=YxsUU2SIBQyhB3UwRX9kDs5Flby2JMKjEnc2oNvbCqnlnVJyXLjX1DV1v7VimriKJN
         RnyDPRO/RgvWecgD3dMPtCN8kaDtaOpVPnBWRvvcVc81AziCXOb40dGVEimnfvYGQDf8
         Gd+VF4qIgpk+uUtP5Az+zqp+DzVYjfHZksXpFx9lkI3XRcJBc3BxDzV0wxgf/5c2loI+
         TE+qi81KOHrFwWPcqulpkWPks4ya3C5uGxSAqNnaB0yruDu1ZVi/jo9iQeN+m91s7GNK
         9Tzaua+5LjrJMQ0+nsfVsU5QTkmHIDKuC9OtXSW7Fe6FO4qR/0MJ7TuvIz8zb8vSw2XC
         bp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tk0/PH3z5NFDWEmG2DQ0oCDmwhwymD90qA9Pv0LPVfc=;
        b=mqzL/VnO+bhv9aectGyl23FVfm1VrE5XtubyqCgFq5wSSRIAVP/QN0vpDmchxL0Epz
         hy90P1Qb+p0y5t7khJLNatShqwUsq4SypZ6PuqCvB1+eGxAV61lpEhsByc2EXkkF0yWE
         dA2VJH9I3VACkxPpLnyhslV8UddVNVi1aG5dwn4Pf9xWFJ0RtQXFslVdL51z9rdQWTho
         DJUHb2Ce3kfkTkzWAvhU4KWnB6XyAbzeERjf89hMHU5rVtDM5Qd2RHC9lLsh0+nHInAh
         BTypo6cHqJqputucM0+6vTqV8uVHCJxXc+SADjGBP5zMlWMhIQ3Bu5Y0/Jd3WGHW0B48
         5gmA==
X-Gm-Message-State: APjAAAX18lpXK+N8BRkO42Gxrurb9osH66mrhL3NXQvSVVFQC7M0hmdS
        47WoAFG83COu2+POXimLDn0=
X-Google-Smtp-Source: APXvYqzgm5p8S6Up8L+kpcjBzjxCa+t73CQnais4OUcVkXFTM13yZhZgOrjUpEATsMl2BM8dH0Hl5Q==
X-Received: by 2002:a37:5f47:: with SMTP id t68mr6050651qkb.497.1569013716571;
        Fri, 20 Sep 2019 14:08:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::7520])
        by smtp.gmail.com with ESMTPSA id m14sm1484720qki.27.2019.09.20.14.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 14:08:35 -0700 (PDT)
Date:   Fri, 20 Sep 2019 14:08:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     ~@devbig004.ftw2.facebook.com, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Marcin Pawlowski <mpawlowski@fb.com>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>
Subject: Re: [PATCH] workqueue: Fix spurious sanity check failures in
 destroy_workqueue()
Message-ID: <20190920210833.GC2233839@devbig004.ftw2.facebook.com>
References: <20190919014340.GM3084169@devbig004.ftw2.facebook.com>
 <CAJhGHyBd53ogp35FkmwDhzCv7=MipXwyoHGPVXjsaxSH540O8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBd53ogp35FkmwDhzCv7=MipXwyoHGPVXjsaxSH540O8A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 19, 2019 at 10:49:04AM +0800, Lai Jiangshan wrote:
> Looks good to me.
> 
> There is one test in show_pwq()
> """
>  worker == pwq->wq->rescuer ? "(RESCUER)" : "",
> """
> I'm wondering if it needs to be updated to
> """
> worker->rescue_wq ? "(RESCUER)" : "",
> """

Hmm... yeah, good point.  Let's do that.

> And document "/* MD: rescue worker */" might be better
> than current "/* I: rescue worker */", although ->rescuer can
> be accessed without wq_mayday_lock lock in some code.

Will apply this one too.

Thanks.

-- 
tejun
