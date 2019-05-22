Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C849C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AA221473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558557877;
	bh=u0vpqjRZCfZ1yomtUly1mF+4+X+k+4EtxlV6xG0hkYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zM7svF8oCo5/jWmaabzIdjj3HxOlVEIWMhx+C16hyB+GiRZcYnswds9TBmQ6tUuuC
	 xbZGl5bnf2zNFexErIO66BwwEZCut8duSbu3/q95wTNtHDyGIKuurp51NlSSTJAgmz
	 bP7BCvDxMBD5Mkb13vIUP/l3bzRPt0qjTqAc6Nck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfEVUog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:44:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55292 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfEVUof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:44:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so3541138wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S0ra+vNdOv3/9V7VGWXOVC+dvXqsahGY6CcRP5lsiNE=;
        b=f9XaVUuchVtyI1LFsaB2lIJMGKQ8MmptzCbg/PGOPHcIVBvLiC0xUCbsJ4KIURUG+c
         boeL7Yz/ZLdU6t+f3IrkmyBBY3jCshR8atJPYUctZoTUomiDUjfOd3v5w3IwfuoCF6mZ
         GOw3veVPVJNR/CukN0z0A9WyQczNcYvO+6sLaO31bwYUe9bJMe+zOL71kIwNv1tN+S+s
         4sq9eITKDsGGeqOhIlhK5q5NXIb0YkCOZcY+vRlNAaYPSLsvkRlSngj4I4Ef9fsCbs7g
         hqwEhSbhHRYPCBzhUvTAd2TjyZzf+xCaxwvebnHwIB9xiyJkDWY1dxFIAi+wrNbYyxCx
         sQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S0ra+vNdOv3/9V7VGWXOVC+dvXqsahGY6CcRP5lsiNE=;
        b=HQwBrcCsji4nB34U3FwN7pU0+suh55gxphhq24Ofc+Ktz/LEw7Ut8bhhhyRJLoWzDC
         FgZ0qn7ZdhphfLvI7O8svItCa3BfTPH3iTDcqanJewcB+XOS60DzAhJKN8xRD8TfarUz
         q+vTnYfVgEeFvzUDtVIlsLWGJrsWRxpyXdTgTMG341iwCWHHzeL7f3Qm6RL83yDw5ESK
         vM1biECEA7rGgD4vpvERyRspXEJnkhEVWaXCx9hWDVW9P/sWxP7/KNl3PyGF8EdsGB+Z
         k0JqvpPtu0pCTlT/5AHu0zlKbayGuWr6Lpe4pB+L/JK3CherhpIKLVkBa1X3RJQnqbx1
         h2mw==
X-Gm-Message-State: APjAAAWh7WbKTvTdBLrXM4Pp9ld2wT3AUhmBbraUlqDvQK7d5s0WCNKg
        OwNciHI7eJlp7bIEPxU51Wo=
X-Google-Smtp-Source: APXvYqz5Z7YzrxRoncvYEdf+W2IrIxTCI8BxGMTdNdj2FzG0H8YWcsHQySKsRboZFH7R8MEcrv7ZLg==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr8426905wmc.39.1558557874006;
        Wed, 22 May 2019 13:44:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a5sm22867571wrt.10.2019.05.22.13.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 13:44:33 -0700 (PDT)
Date:   Wed, 22 May 2019 22:44:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/19] v6 multi-die/package topology support
Message-ID: <20190522204431.GA18891@gmail.com>
References: <20190513175903.8735-1-lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513175903.8735-1-lenb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> 
> This patch series does 4 things.
> 
> 1. Parse the new CPUID.1F leaf to discover multi-die/package topology
> 
> 2. Export multi-die topology inside the kernel
> 
> 3. Update 4 places (coretemp, pkgtemp, rapl, perf) that that need to know
>    the difference between die and package-scope MSR.
> 
> 4. Export multi-die topology to user-space via sysfs
> 
> These changes should have no impact on cache topology,
> NUMA topology, Linux scheduler, or system performance.

Thank you Len:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

	Ingo
