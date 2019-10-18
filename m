Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A089FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724B521852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="byGuFyT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbfJRXqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 19:46:43 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46430 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfJRXqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:46:42 -0400
Received: by mail-il1-f196.google.com with SMTP id m16so634441iln.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=b8BrqKv43ztO9vYkl2B9lQT4SVbckdlOosZRspsIwmA=;
        b=byGuFyT4WoHgvclSKO9YILWrRzUHuG+gHQWeYK1nSvNA1i1nnHpPeB76F4U+hFuzMj
         HYrfhUCTyiRXixpLBO9BzNY1p6GG60P2UuA1v1NxLJWtIEhhd6bDT0U1/hmHIrZj7GtC
         QHRDgQdl+qsRbB7C/piwl3rpLiMXchxdR7QW65ggpHbUp9JHrmArdvk9GAEVjwF2DiJ/
         eBTIC4uqx4kkfbzIq+Y+lbPXsovUkObnpmJ8bjruDJZYdHs5hdVArdB3xNYAY49M7tU+
         ewr5xDWwV8dJUhYO4cCsUJT0hqsiPCgV9ENT1bbSo+UoYVPztfBACb9wQ3W0sjW5PWH2
         VjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=b8BrqKv43ztO9vYkl2B9lQT4SVbckdlOosZRspsIwmA=;
        b=Tn1/pyzX31rhYFILiGO7aj+q4ZfQW3EpKGbIZr8tkzOsWrt1olbFbyW3heGeBvhmzK
         VElw9j3uQ8CfOacUIg62Pw+liC4An7GqfTDoxDDTZ+S94ZNdijwYr94J5ABqvDNYZBu6
         3XO7YAR+n54zUJNh8d8JuttFlLJat8bXtCqd39TvpcmaAGEkOy+3BgVxicvU4Rdsfq4b
         yXfqQq0AzKp4qdR3E8i0XrTNddDMMKkgX4CCDVRwD56Tent3z7rc8FHUqtzasa7/faA4
         rFnSlk8XgVV8CqEX59g087kHVriiiGx1pGtgQHJZVxCUmp0yeroowrfkroZ2CjyhBg16
         U3Ww==
X-Gm-Message-State: APjAAAUfNvCcgxOpbYnxysTnFUMIhNao7FujYKjer4FRFVPJiXMTUBXq
        t9FofqjrDG0fN6vpVOWLxRez3A==
X-Google-Smtp-Source: APXvYqzEZhN5ARpmzjKQxSnAAowyxVdqO4Oylbrop4kel8/p8RfWLop7XY2QvWBDHUVLltGRz89BZw==
X-Received: by 2002:a92:d68c:: with SMTP id p12mr12731944iln.89.1571442402188;
        Fri, 18 Oct 2019 16:46:42 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id p7sm2923605ilh.10.2019.10.18.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 16:46:41 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:46:39 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: RISC-V nommu support v5
In-Reply-To: <20191018152520.GA32281@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910181645140.21875@viisi.sifive.com>
References: <20191017173743.5430-1-hch@lst.de> <CAAhSdy1dvFzEh_WZ8aDNyCKi968Dwxm+ru6D0DF08QoOq3JjLA@mail.gmail.com> <alpine.DEB.2.21.9999.1910172029170.3156@viisi.sifive.com> <20191018152520.GA32281@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Christoph Hellwig wrote:

> On Thu, Oct 17, 2019 at 08:29:59PM -0700, Paul Walmsley wrote:
> > On Fri, 18 Oct 2019, Anup Patel wrote:
> > 
> > > It will be really cool to have this series for Linux-5.4-rcX.
> > 
> > It's way too big to go in via the -rc series.  I'm hoping to have it ready 
> > to go for v5.5-rc1.
> 
> Yes, this is 5.5 material.  Btw, the buildbot found two issues that
> require one liner fixes, so I'll resend again this weekend.

OK, will wait for the next version.

I do have one significant request for the patch "riscv: abstract out CSR 
names for supervisor vs machine mode" for that next release.  Will follow 
up with a comment on that patch.


- Paul
