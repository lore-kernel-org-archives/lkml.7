Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30CAC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0AC217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot0McPrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfEKUNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 16:13:49 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38626 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 16:13:48 -0400
Received: by mail-wr1-f50.google.com with SMTP id v11so11180134wru.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ip4RZx0TTO3E1HLKVBRw8YK0+0l2BEgCp16M3P2qMU=;
        b=ot0McPrcsF11QNsWBy5WBrZ0wrLdsbznu40hGrZl6C9CsoKLZMOLdCvn8NEJdQnmXg
         9nnFdAwMQ1S25AaAAqStsSlmK++CxzfIcMFkbjPcsO3GInTfTw2RpqSo/1djxiEDogey
         VJ7Ww+7EgD6DsMWPAgiOPeUqbq9M1Rzm+gHlzjxUG8cTEilcIGgy03RCGNiIjONH8xFH
         vnJiPhrUwZh1x31LP0fElyDKrZfLj3Crm2E1c8Jxj01n/uNVBsTMqtp0wnGMJAik+aFd
         ipMwnLQtNT3Pjtv9YkhcvLRkQgkkL2EBXjN2XMPQES/El824LyIhYTt+NtTF1LqrmgI9
         dNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ip4RZx0TTO3E1HLKVBRw8YK0+0l2BEgCp16M3P2qMU=;
        b=qgYjZejIg6P/KbvyoHx5qewpkLe8E0jJn080cNgt/JTPNWrzVRM4xrNwkqBJviCLo9
         lmIRwcB5azR4TLcb8yLWDk2XbFRd/elvy5XVrukYX9/OUhlEfS/P9aU1TchJ77S0lgx/
         PDQtAaHqteHTeouxhCQ3BZI20vvmQlMevizVrG6PwQcDIByQIP3Hnn/E5ABpLXh+4cN2
         GC3cE/88LEy65P+1qBXT8zIjiL/otqRCL/WZklgik3zCJks5VI/blQjPZS/FPWh5I3q9
         X5t/MBA5fw51xFUBZWtR+deG25F4jS3NKoojdDpIPvYk9FLwpSx2NxFuKSiX4U/WaUez
         OtVw==
X-Gm-Message-State: APjAAAXlhFJ7xqVi6yeBWJVY5HP8kdW4e7F4U7GT9Sk+vadlbgo8RL1f
        pj/ZMUbATE8tDFSt3BU5yOCFoNE=
X-Google-Smtp-Source: APXvYqwoM7+/NQL5XXhUKbpuRlAQZfHydOKcroLab3HC/s+zlsVZ62nINXrUPPK8EBH/eErut2hfnQ==
X-Received: by 2002:adf:e686:: with SMTP id r6mr1786806wrm.90.1557605626712;
        Sat, 11 May 2019 13:13:46 -0700 (PDT)
Received: from avx2 ([46.53.254.98])
        by smtp.gmail.com with ESMTPSA id e16sm8880686wrw.24.2019.05.11.13.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 13:13:46 -0700 (PDT)
Date:   Sat, 11 May 2019 23:13:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org
Subject: FYI -ffreestanding shrinks kernel by 2% on x86_64
Message-ID: <20190511201344.GA11535@avx2>
References: <20190511200223.GA14143@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511200223.GA14143@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 11:02:24PM +0300, Alexey Dobriyan wrote:
> I compiled current F29 kernel config on x86_64 (5.0.13-200.fc29.x86_64)
> with -ffreestanding. The results are interesting :^):
> 
> 	add/remove: 30/22 grow/shrink: 1290/46867 up/down: 33658/-1778055 (-1744397)
> 	Total: Before=83298859, After=81554462, chg -2.09% (!)
> 
> That's original config with modules compiled built-in.

Argh, it's the other way: adding -ffreestanding shrinks kernel by 2%.
