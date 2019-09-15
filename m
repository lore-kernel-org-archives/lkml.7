Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8622EC4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF09214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apS9vQuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfIOVik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 17:38:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42589 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfIOVif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:38:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so6892380pgp.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Zo435XJyX1bpVOOHXwPV4uWYj4585Ad4T3dwyk9iQBE=;
        b=apS9vQuM+nyi+pTFjOA6vggWXSkRtfqgt6CtOE6zLQt0J4MDkpvxLGenxAaNvfGCBu
         40ISP0O70fCIZQd+Ekho/Ctny3LuLMnHQk1F/KPPApOGMpftC3/zbljQqQw21/zMfn56
         SlfcgTljTciiJ1OG1AOBB6p5rxIIceF8KrtuxdwmDed3zdz/gtiF21dptyjepYcKGB6C
         upoEAKrNO9dVvyNdGorxD9grkpDQvF4mdz+2xyL5MY+hnX9JIQIM8z4QqUqfmLX9CO9I
         uEqp5ZbacaWHFbSpzC2BNbBiTxOfiqeDiCLHuePEedSD6Vjbqkr3CdqDAQ+XZZDk7kTG
         rKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Zo435XJyX1bpVOOHXwPV4uWYj4585Ad4T3dwyk9iQBE=;
        b=PtJOHedT5qPblDBaxMHgvMfnAl6uCesoDIGzfA5v4pLfD1nTgW+G06jtqJH4bMvjsP
         JXkD+wPkovfjzXNODH4wrmY7PF2EL1TYi6iI4DH8jKlGpR3FR9OZ1zG9DTls/IFSdYhs
         Z3kKrooC32dWMfh+e+6YUb5R7MgZgynsJbs3kmwecTvg6+HCzWEjflGGipTCeSqTIkfT
         8CJI+M1owjBHR4f6BqhrhEvyqpKjqhr+b8QDa7gfCP1WNUI5VP3p4uO3aRzVtweQa5z5
         aUXrlYFwR2bSBjbBYdys1Hq9ftccJvkhppeaJGBZEPCzTGgHzllUFnl15axoPErAFDzA
         c0yQ==
X-Gm-Message-State: APjAAAVcunoeRcx9cXN7fioyZUCqgEfYGkM+XdbOzfb/hrZENsXBk+uk
        9JxSysprkw6lZKYyLXMRq7v1Kw==
X-Google-Smtp-Source: APXvYqw1ARgEFVmt+QDLxtWvIcZOKj0fu7MaTaZ1QI/bvgVgbu2fbkvM8XEGc6raOZ0YXRFCLVWvbg==
X-Received: by 2002:a62:2f85:: with SMTP id v127mr65402991pfv.68.1568583514459;
        Sun, 15 Sep 2019 14:38:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r13sm12826494pgp.63.2019.09.15.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 14:38:33 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:38:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
Subject: Re: [RESEND v4 4/7] mm, slab: Return ZERO_SIZE_ALLOC for zero sized
 kmalloc requests
In-Reply-To: <20190915170809.10702-5-lpf.vector@gmail.com>
Message-ID: <alpine.DEB.2.21.1909151423290.211705@chino.kir.corp.google.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-5-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Pengfei Li wrote:

> This is a preparation patch, just replace 0 with ZERO_SIZE_ALLOC
> as the return value of zero sized requests.
> 
> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
