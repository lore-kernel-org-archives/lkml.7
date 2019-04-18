Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C55C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B6921479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3J/S91z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDRXXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:23:10 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38539 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfDRXXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:23:09 -0400
Received: by mail-yb1-f193.google.com with SMTP id w206so1461750ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+pUOWkruuYVGS6vVl9afkdSKWdQYXkdtIW5c5qtNkk=;
        b=V3J/S91zvhdIsxczAIhDN4RNbtYuvdlVC9PzTHew68ooaWiyOmIzUVaSPliEY9p1OY
         HSAHA3qVbr2d9M3MwsCt2zE2zNYLdUcXruwqCapnc+yhkrPneA4s5qF2hnetCxNOZqCQ
         6ric8g0nQgy1Q3d+QJNst3+mEOYjnd5XpuztkW1YZ7vErMTcuQ/HykMNRMsCZj2wonq1
         ovo1UJ+0hi10+DZWhBpgN0UToA38ff1h6q+0axaFk6VcEehVOUINpHY4rYPnINRjTv2V
         zDYblqeDeHGwtrBQwhwfwGobhtb8Rd3nZeOWblqTxcMQLPL7Q5/2QsCvhvOb4PrOq71u
         P/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+pUOWkruuYVGS6vVl9afkdSKWdQYXkdtIW5c5qtNkk=;
        b=QbyAyW3zqkZcI8l83dPYS//CwXf9CpyAhCjiB0PGCaoGrYp1enKK9K6F40DW1F7j2h
         22Rq8mI5UV8U3VhPPIsRzNkqlkPdv6pUtD2BHNsxWDJJJf/3QXVISXEkFa3BpV6xacr1
         ENJnsNgsC6asTxkPmfy/n5ehpiBqGLpshJqVlSPaMx1fwoaXkbWlExRFlsKUm+6h272l
         4NZKItekoD60A/mv7Q3eRn9FEL0zmy3Os0KqgQa8vfKhHWQRFvq7DSgTYvd9rzGkGbd6
         pbxd6OHVERLTs9b/+FqXUZZp3Ku3UMn4HNgpTq/BekcGsMr2j7LOsYEZ3WGzGcVl8npz
         80Og==
X-Gm-Message-State: APjAAAU0lH9gO8IKowDhPST9y8nGR/QsfNuwzPfRwutACJW9T3mlv5En
        14zupyZ3Rnjpj21v1tiCvahlIQ==
X-Google-Smtp-Source: APXvYqyd8wbDl2/kCkX1/RPPkWx+jXHsMHSz/7OsQFsdBAspZOHpBoGuURvbbpqrdECxDf7LiFFmgw==
X-Received: by 2002:a5b:885:: with SMTP id e5mr273910ybq.349.1555629788498;
        Thu, 18 Apr 2019 16:23:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id m5sm2378771ywm.67.2019.04.18.16.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 16:23:06 -0700 (PDT)
Date:   Fri, 19 Apr 2019 07:23:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Message-ID: <20190418232300.GB4524@leoy-ThinkPad-X240s>
References: <20190320100508.6950-1-leo.yan@linaro.org>
 <20190418053339.GA4524@leoy-ThinkPad-X240s>
 <155562436407.15276.5265889537123283982@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155562436407.15276.5265889537123283982@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 02:52:44PM -0700, Stephen Boyd wrote:
> Quoting Leo Yan (2019-04-17 22:33:39)
> > Hi Michael, Stephen,
> > 
> > On Wed, Mar 20, 2019 at 06:05:08PM +0800, Leo Yan wrote:
> > > clk_gate_ufs_subsys is a system bus clock, turning off it will
> > > introduce lockup issue during system suspend flow.  Let's mark
> > > clk_gate_ufs_subsys as critical clock, thus keeps it on during
> > > system suspend and resume.
> > 
> > Could you pick up this patch?  Or should I resend it?
> > 
> 
> I can pick it up. Is it critical or can it wait for v5.2?

It's fine to wait for v5.2.

Thanks,
Leo Yan
