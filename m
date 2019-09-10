Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878AD2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568096914;
	bh=Z8SdUBr/pxgrvYmv0xvoouEGCXHKvc9zLTkOKAKmVq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BgEsvRIxz6VNyAEtIN+7b+xVVTGv4B+03QDxohxvkOnCMosgqTt7SSlfqHwpHwkS2
	 IpYmTa+P6S/qIF6m2DreLgrg3FpxmxrsQtvlrn/R6y9i+vHlIX/2zn7Wu+2CUAiYyL
	 yBL54+Bh2MA2/PpiEionOmGY5U2/rZmKlXohz8lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391052AbfIJG2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:28:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46361 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390972AbfIJG2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:28:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so4832667wrq.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 23:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gnd3zJ6Jbj8de8UBRHzFgrvEzz4SiH/EdhT/uig12QU=;
        b=M3SXkENJpc9uwxmLGxNX1o823ojcUjwgXkF69PN1iNG6ZOy5qPpZwtqhbAPqIA3Ep8
         fQkJT3c8Gmjd7T3H6+SDVsQG/ZH2+y1oBW2v8W5cMTi3HZwv+8mMUG/P4ojOvuYHC8KU
         K2nES/2Tj3Pw0O9Sql2DevhrPJclzjrp35WHI0r3w3uRJKhdr9NUWGWYrSzjSFOIN2QY
         l9oCEXNZcT1l/E3eZvgUtQx5rfAScUQ5XxEmpVXXwW0SYlXHP9RSfuhnT+dDImCmNLOV
         X64Nthwd26AnA+Q1lmcT/HSUc0fB2KVF4SBKHCIvK9SMXTQ4YYd05yltweWPpZe7s+6J
         7FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnd3zJ6Jbj8de8UBRHzFgrvEzz4SiH/EdhT/uig12QU=;
        b=sY5vbMXbe3uTyxVdMj8wUBI4+qY+bnPYWd/C7bJ0JIwKfX1RRlw2jBji1OGlGqE2rt
         R7x8duS+d3LWyhDJlfzBVAIsW0/FZ4cBpS4Cki+XhoVeuEw8ecLWZsyr2hoZxIilOgAc
         d9eBMXqnp+RI/a2g1M4aAAuPPpgDJsL/9XvVF6DCujPY1HfVvD2KAYhGoGz8VLS+KhQT
         pri/y8+CBSBfenAzZoevIzE9/hcdfIEyX71nGLzHZw5rK3Ons73NWw+JIifNpcqsDSIy
         eqjiiaQW1reu1PCcecnodAumpCPnwsPthZioq+C0gvvpy40acSWcXw8ByRAiZjEKYuTs
         uUHQ==
X-Gm-Message-State: APjAAAVz8fnkgB9avxO7nDMSfAQvayCHZtO76urHI3GtvVt4F+nT3PLj
        bOGDFUuWww1ZLCyFBxAR0XA=
X-Google-Smtp-Source: APXvYqxg/VH934LWyW7E2gVt/dlgnyJMldvZXAtUgDiTcT1hzoCwXufdyp121qZy/khP9jtqycazyA==
X-Received: by 2002:adf:c504:: with SMTP id q4mr21604701wrf.266.1568096911367;
        Mon, 09 Sep 2019 23:28:31 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e30sm31326987wra.48.2019.09.09.23.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 23:28:30 -0700 (PDT)
Date:   Tue, 10 Sep 2019 08:28:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     hpa@zytor.com
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86/umip: Add emulation for 64-bit processes
Message-ID: <20190910062828.GA40888@gmail.com>
References: <20190905232222.14900-1-bshanks@codeweavers.com>
 <7BFFC7D1-6158-4237-AEF9-D10635F054FC@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7BFFC7D1-6158-4237-AEF9-D10635F054FC@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* hpa@zytor.com <hpa@zytor.com> wrote:

> I would strongly suggest that we change the term "emulation" to 
> "spoofing" for these instructions. We need to explain that we do *not* 
> execute these instructions the was the CPU would have, and unlike the 
> native instructions do not leak kernel information.

Ok, I've edited the patch to add the 'spoofing' wording where 
appropriate, and I also made minor fixes such as consistently 
capitalizing instruction names.

Can I also add your Reviewed-by tag?

So the patch should show up in tip:x86/asm today-ish, and barring any 
complications is v5.4 material.

Thanks,

	Ingo
