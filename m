Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F018AC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FAA21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDwa6TX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfEWAad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:30:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37784 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfEWAac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:30:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so2147520pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 17:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xHxRAHny7MqHauNPa2NCJChMz/QrdToa+RjUnndgfSg=;
        b=mDwa6TX/Kk7zbHpul3PnRMnRcFAHtg9Xxdc24+ZinXhxG+fPbcQ0lPXhcjw/e+SZyJ
         r5hiBcHtBWBMwvP2O9xuJuOXbPIS5SCp6p6tUIyVMHWNxuM62iB4Uj6Pn0qx7gcmRuxg
         gJi3DXM9pmth7tPBqKf1GX6YqHxDX4SYivy9rKzzLH5ElV38ltdHrjtODYKScuRGI4kD
         9K+PNNQfm8ukf//NHwhMV23ACI4bA/xitFgvwUGihvzNvZoOs54eKctiQFJnhFeSD8eS
         t6luF5jNUCiJV/2I7K/pFakZUOUa1to+ZeqR/47TZoriFWBcz2Serh1dRKcRuH0c4m7z
         Ensw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHxRAHny7MqHauNPa2NCJChMz/QrdToa+RjUnndgfSg=;
        b=MhcOoomkwZh4glvn86s4Km4RIDzJq5E/eNuVYmqug0bxK/OAh/TvEYUVWlDg+brVdr
         ZJn1FGcamt1ctvOV/1RTd/26PihiMzJgd7iXgstutkA/fffbAS6QcF2G6SfQcGoKi1Nw
         OE0ELTUZBgQlaD+bYM4MUSQrl4Da7HUyoqwdpgwXzui6Q2ZZpGzap9I7lkLJvCPFaJ4W
         h9xCq1sc6u7gMC45gTkvHnlfpum8e95VBcYsILXiErPhovlQagUDRvOLLHrAeC2ogAjp
         SfJ8XfpD2MdeUj3EAklLhx+dJc1I8yZ5xL4D70yNBjGeeWA+4K1VeXOFAMoyoDLnZ5C9
         /QJA==
X-Gm-Message-State: APjAAAWEgILahzhBxiMUde0jiadsMSkUf330d/93PfHP9z257juxOpXO
        h7c+QZX3svgYc0OEIKV2ONn+XF3ZFaLaZw==
X-Google-Smtp-Source: APXvYqx1MHKMwqJEbU5hkmTBcGxpBnQe5zFPViq/JF0SDYv8vRUjL2Cq5gOLB3j2uOASfDfbJKSAtw==
X-Received: by 2002:a63:1b65:: with SMTP id b37mr93264021pgm.408.1558571432112;
        Wed, 22 May 2019 17:30:32 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id q27sm40498511pfg.49.2019.05.22.17.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 17:30:31 -0700 (PDT)
Date:   Thu, 23 May 2019 08:29:23 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <20190523002923.GA14060@zhanggen-UX430UQ>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905221353.AD8E585E6D@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 01:54:47PM -0700, Kees Cook wrote:
> On Wed, May 22, 2019 at 09:50:55AM +0800, Gen Zhang wrote:
> > On Tue, May 21, 2019 at 01:44:33PM -0700, Kees Cook wrote:
> > > This doesn't look safe to me: p->uni_pgdir[n] will still have a handle
> > > to the freed memory, won't it?
> > > 
> > Thanks for your reply, Kees!
> > I think you are right. Maybe we should do this:
> > 	kfree(p1);
> > 	p->uni_pgdir[n] = NULL;
> > Is this correct?
> 
> That's what I'm not sure about. I *think* so, from reading the code, but
> I'd love to have Greg (or someone more familiar with the code) to
> double-check this.
> 
> Otherwise, yeah, this looks right. Please send a v2 and we can debate
> the correctness there, if it turns out to be wrong. :)
> 
> -- 
> Kees Cook
Thanks for your suggestions, Kees.
I follow your guidance and work on resubmitting a patch.
Thanks
Gen
