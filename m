Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA3C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3768208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rfl6geAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfEUPpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:45:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44730 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfEUPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:45:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so8606741pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCgLiR019LUQfhnXl76ud5P8ct/eu8hvw0HpmgFMVXQ=;
        b=rfl6geACXaznE893Xv6EgsaoZwgicisSZNkTyws+FFmrjw0cygFwzOxsanbZMxvOf7
         6nSazz6qkCSgtzpNrz//Z0sti/qux5BfsEeQpe+9GbUFQ4F7Dmk2r0FnoE/WPfRXN90k
         8RRBaIX56/CJcvv0P1a5qYQ1bFdsoK2JKwlFNG+uJDsWnxUChFVNBCQvAXr0vq4KGSph
         JuAiFZCdMhxHo3BqWgWC3bsYnHIJhGI7oCzQKzV+gVv1tTbiJ9kaSZR453A4nFGOR1+e
         q8xc6+uuS8Hm84nvH19ohB3e+sXPemZlk/aeTiv3iKYhyfTJWvEpqn/jfzhFmFW28wgf
         xcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCgLiR019LUQfhnXl76ud5P8ct/eu8hvw0HpmgFMVXQ=;
        b=JJFzuGeUqfKpJAeVMh5jKQn/wuNLbxuAVx1atLnA2S1yd5Cv/1lvpH4WGl7rlwrpBj
         ZrcPjpMVI/giahrzk6UglHxXSXOxjGIqcyZaXCWYYkjvTIwR00qDNUK79JuCNbKNFH4s
         yKDHhrCHpQJqenwzAdnUwRz7SKon5fN5CGjR60h4FsxjZCuLy2EKhtJ8zzwIU7g2hps5
         ZZyowI1ZhOFOqc9tAkLtGEhE9dETlELbRmNthWsOBUK8KbeEoECONSG08YAAxMRhs7Ql
         XsCAfYoerOZyERFYsVbq3VGpX+ebL30qxluGZW8vthJ4mud+wAB6k+V5hAQeVagATe/g
         84/w==
X-Gm-Message-State: APjAAAUFY3neGI3oIWC7IaxdaFgfXesEEP2kIrRsV6pC59IgCu1nCnVr
        Qf6iTfTVFqxUvUuhgPd/+qqyBQ==
X-Google-Smtp-Source: APXvYqy660k6G3n/CoK0UJH2aQhhfLekgKFUK4qr3XL++igjtjitHM44q7FxegqNyS4YiSWiviy6/A==
X-Received: by 2002:a17:902:848c:: with SMTP id c12mr34232829plo.17.1558453550759;
        Tue, 21 May 2019 08:45:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:6169])
        by smtp.gmail.com with ESMTPSA id 127sm26255492pfc.159.2019.05.21.08.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 08:45:49 -0700 (PDT)
Date:   Tue, 21 May 2019 11:45:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ying.huang@intel.com, mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, josef@toxicpanda.com,
        hughd@google.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] mm: vmscan: remove double slab pressure by
 inc'ing sc->nr_scanned
Message-ID: <20190521154548.GA3687@cmpxchg.org>
References: <1558431642-52120-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558431642-52120-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:40:41PM +0800, Yang Shi wrote:
> The commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
> has broken up the relationship between sc->nr_scanned and slab pressure.
> The sc->nr_scanned can't double slab pressure anymore.  So, it sounds no
> sense to still keep sc->nr_scanned inc'ed.  Actually, it would prevent
> from adding pressure on slab shrink since excessive sc->nr_scanned would
> prevent from scan->priority raise.
> 
> The bonnie test doesn't show this would change the behavior of
> slab shrinkers.
> 
> 				w/		w/o
> 			  /sec    %CP      /sec      %CP
> Sequential delete: 	3960.6    94.6    3997.6     96.2
> Random delete: 	2518      63.8    2561.6     64.6
> 
> The slight increase of "/sec" without the patch would be caused by the
> slight increase of CPU usage.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
