Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493E2C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F8A222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="it07uPHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgAGS0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:26:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37811 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgAGS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:26:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so279496qky.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7T+Uz+ziIhwrQC1V0AO3Y5+ZIkKPGfie4ADyDKB8cAU=;
        b=it07uPHDjGFZLQpswrCddH3xbdXVBbPpx7Nx/qj/M+AFTfNxE4quAolxqS+arqL82c
         bl2Dty4s2fHhhM+letMeeVrn66LuHeYFxq+gNVaSLml043l3Mgqb4ZuFwUwnaUla9vBU
         XCvnGSIeEWBLy3HClWG54PiF0P9CP0Kw/yorUkncnr/GVkjNLF0VOPdoEqQc1YZs648M
         +wTyOAeW9mG/SF5WZayTC41edK3kWoBdjfGk0WyEi0tItDsszZY4wPlWG0TOaJoVLoYS
         XPL4BZeApnwa5rKBzKuaVQbj42euhCwi2RU/Q78YPwDBnIw92QRCD1G8blFVRkcADxlx
         9fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7T+Uz+ziIhwrQC1V0AO3Y5+ZIkKPGfie4ADyDKB8cAU=;
        b=EvA8zOBbCKeT288rAJtJ0+/I5bnYycZQDqxniBULKS8gCPlviNgNRKRVWfklSz/930
         2fUkclORbnHog2Fu5OYBFhGxMVKKBMuzkzm1p5ZfF0YlbRxCRWxWsUzRPW2jB4fnBXcQ
         Wan2CkGZOSmPSDgPZOiQnmNrXFW9npaJcs4XqiNBUtHJrHyHeYSiAGeemgJR8m6pLB/p
         8IHyvleg1thCvfqCo3IVaxY28z2/865UxEWadWK9FBwBgyHz9DOJru0pnFayLl+ruYc8
         AuWSHh09SKbRZnh2ghFkgWmnLKSr/fSQD0reB+TcSV4XeZPUCtumXCQzdDG0VPvlvtIE
         qxCA==
X-Gm-Message-State: APjAAAVTpkipcic9kvm8DdSakpRgt/OLq9IzYrKW1QUg7LmTFtF1Uy4U
        yWf6lLSzsZ5vT+WAEJY8/N2CTQ==
X-Google-Smtp-Source: APXvYqx7dejdsvwplVt1zaxwDZ5VHKGR9kLeMkjdXFz1Pgrfhz+vaitLElnr3cudKfk5O3dhcZdagQ==
X-Received: by 2002:a37:bcc4:: with SMTP id m187mr655640qkf.329.1578421601844;
        Tue, 07 Jan 2020 10:26:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t29sm186540qkm.27.2020.01.07.10.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 10:26:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iotYv-0008Q7-0P; Tue, 07 Jan 2020 14:26:41 -0400
Date:   Tue, 7 Jan 2020 14:26:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     madhuparnabhowmik04@gmail.com
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org, rcu@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200107182640.GC26174@ziepe.ca>
References: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 11:05:08PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>  drivers/infiniband/hw/hfi1/verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index 089e201d7550..cab2ff185240 100644
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -515,7 +515,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
>  				       opa_get_lid(packet->dlid, 9B));
>  		if (!mcast)
>  			goto drop;
> -		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> +		list_for_each_entry_rcu(p, &mcast->qp_list, list
> +								lock_is_held(&(ibp->rvp.lock).dep_map)) {

This is missing a ',' and isn't indented properly. Does it even
compile?

The idea seems sound though.

Jason
