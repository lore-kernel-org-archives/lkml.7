Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A18CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20824222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JljwbGRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440826AbfJRFAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:00:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34455 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfJRFAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:00:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so8447831wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TGIeMHWXK53sHye5G1LgnfCP8Ga7F8A0ZVwuDPcGRt4=;
        b=JljwbGRTq1E6mquIfDwk+xIsr8rGHug6c2MDq2EbaJSII1XUYxA/xrd2MX5v/Wb+yy
         yMqgKBOTpFzBB7hjADLAg/CkmrD946ZY+ATcnXTBsYxMeYzmRmgbQDdKyPqdiDj2qMha
         XgbjW27wieRO9ktfmfDUGR4J3YTSIMf9hV4A62eqGAtTX3Vc7m3MeNR9ie7VWLXQ8c55
         uSO/mVVKpXDWD1lTVkfjKuaiZVNECxJxPjk+lt7j0OxeJeR1qdiqSC8ziCRuE5pZvlzs
         JDBLG+vv+qjCPme7i7SjW4VSHZYY0M3+dhj/TUgQ2r/TyudulEdFpv0UWuK7UF0RH01h
         8dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGIeMHWXK53sHye5G1LgnfCP8Ga7F8A0ZVwuDPcGRt4=;
        b=qQGe/GSLWazhg7jOZmLPubBBlgonvrtigVNLZ/JRDN++tk9BV9IzC4da/znl/QGckb
         V0hMb0cjquwJlmJ4Y0UkWiKMdRGLEDVifw6o7DjJLrCALtyQabrUE4CSID3PtPdmi79m
         lM/L5M7+0dXUUqE3UyXnZQWZ9WJx+WGgWkTfAj2iCQTqWeUNKSJf8SZ4o8VsbaCzzz10
         OGGD6N4iMtBT22obcL3up76MYWBygyAAQolHja5M4fMGX+vxNU64uWI3UcKb02/q1iwn
         R+ZCb59YcLxd03exLC6qsEzQD4aHaL+UlUOTt5uOvOEZPJoIJ13rXoWZDY23R6reKrYJ
         ufUg==
X-Gm-Message-State: APjAAAVkI28h+jy62QZpgQyq6owTOgpmznrKAsIAdbq1SKuqaUcXN3qd
        bZs5wBS/+GfutNtxEnmzXMyY2+ft
X-Google-Smtp-Source: APXvYqw2h7j0z61HR1StZiLhVSnluIve/ZvioYgT9l/NCWXf13qZK2iZSZmrNPZxvp9A/BW7wSEurQ==
X-Received: by 2002:a05:600c:143:: with SMTP id w3mr5566109wmm.17.1571371361356;
        Thu, 17 Oct 2019 21:02:41 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40ac:ce00:18e1:7d90:ccf5:4489])
        by smtp.gmail.com with ESMTPSA id u25sm3951686wml.4.2019.10.17.21.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:02:40 -0700 (PDT)
Date:   Fri, 18 Oct 2019 06:02:38 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] riscv: init: merge split string literals in
 preprocessor directive
Message-ID: <20191018040237.3eyrfrty72r63pkz@ltop.local>
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
 <20191018004929.3445-4-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018004929.3445-4-paul.walmsley@sifive.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:49:24PM -0700, Paul Walmsley wrote:
> sparse complains loudly when string literals associated with
> preprocessor directives are split into multiple, separately quoted
> strings across different lines:

...
 
>  #ifndef __riscv_cmodel_medany
> -#error "setup_vm() is called from head.S before relocate so it should "
> -	"not use absolute addressing."
> +#error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
>  #endif

Using a blacslash should do the trick :
	#error "blablablablablablablablablablablabla" \
			"and blablabla again"
Or if need I cn fix Sparse if needed and desiable.
 
Best regards
-- Luc Van Oostenryck
