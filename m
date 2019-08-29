Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8968C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C452073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jEkJhc78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfH2QMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:12:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42882 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfH2QMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:12:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so1822253pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PTQEC1Y4Yke23JK/LTgM0w8mgR2qZy0PBRnUbbY2XIo=;
        b=jEkJhc78PLM/JgFtQZWk7kdLuecagNe2WAYo89y8WuOW4zoGzT+kbSB8NIBe0zcalQ
         8PuF7Tdx7O8kY3LHOmHoCLfdJE91HQsCRyH1tciyLHfk3TBVMVq54nZfsIqsE4hgd3fB
         +OG0j04f8N9mNquyfOwl+bczuWP6l61lZjAEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTQEC1Y4Yke23JK/LTgM0w8mgR2qZy0PBRnUbbY2XIo=;
        b=J224Bkxf+3i5CcyiT5rJBMcimPcQ+Wdl/sAhK0BNwRkyDSeaSynR4W85sNX99deFPg
         SP4WtIyKdMndRgSVZXBRAir5qVMJIF6GBgY6Y092E9ZugbuTH8eaH1tuBLZ+AfheIrfm
         u1/Z9Ln417k6i5mp1byOy8BlSfbaqEXFhKlQA8GRAf/UCS1HfetWhqbzW4DvWCEJ8wCU
         WoBvrfFxlz++daIFbll8uDiK2Ro72coLUmxG+dVhN4SBKxkGdbB5Gv8jmcXWWGO8HOiM
         hk2OGBWo+YwZllX816RFdNZck4AyhGJ3Kz/eY1nRU6kcI6HSx8inHVWpX5RS/sWa1g4Q
         b7gA==
X-Gm-Message-State: APjAAAXOwxwKIyIRwNQyz/8QR3XbmuPhTm21X56/PM3pr88gNjw0qZGT
        hccvCuBRb63GKOk3SSwpoA2RMA==
X-Google-Smtp-Source: APXvYqy1FKWow3z/gmrxsTdklap8cVSHO9/ZQ8Lf2Lm5FnOpYJcBns/BeEGMcIZIyZEJa9XDM04jcg==
X-Received: by 2002:a63:ff66:: with SMTP id s38mr9209438pgk.363.1567095133110;
        Thu, 29 Aug 2019 09:12:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm3891410pfx.56.2019.08.29.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:12:11 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:12:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Drew Davenport <ddavenport@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <201908290910.BA3ED6BDEF@keescook>
References: <201908200943.601DD59DCE@keescook>
 <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
 <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr>
 <201908241206.D223659@keescook>
 <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1ed94a-4dd0-e5cb-0b87-397b512d465e@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 06:55:59AM +0200, Christophe Leroy wrote:
> Euh ... only received this mail yesterday. Same for the other answer.

Yeah, my outbound mail was busted. :(

> I think you wanted to use In-reply-to:
> [...]
> But still, Andrew is seing double ... And me as well :)
> 
> Fixes: Fixes:

I had a lot of failures in that email. :)

Thank you Andrew for cleaning this up.

-- 
Kees Cook
