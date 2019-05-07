Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D55AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0223320449
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="IoMCwYAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEGUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:40:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37992 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:40:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so19974893edl.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Id82w3zmCw69bC990k5wJX0+RNJ/yd54rmawO3O5848=;
        b=IoMCwYADikrhWMRO0YX8OYBTqY+UbPI476whvUkAKOfnTtA+5x3+EStH9HMj0ASU6j
         mBZdPmBRH215QlWMsUul9UlGsW6qRsP+HI5Wbw4KyfVWE3dD7YRZH9rGw1qLHLKlskSq
         WLw67vfHbQG8eNGUdgdPdRE4bjnvIqKVGrOuNzdB2jkA4vbcyVvqrZibmLWlSsNG5x3Y
         H36DSO6DLp/kZ5Ezm5pLqmGGcJsy+Mx1gUX3AQsm54mERaKXxzWMz4b+gTYcD/o5af6+
         pwU34Q6CwfHThMgqdHV0JcgK6llnHKxVoGhDerQx/XWd18wWAAf459MGG8lHCQJEiSad
         5t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Id82w3zmCw69bC990k5wJX0+RNJ/yd54rmawO3O5848=;
        b=lrvLopstE9SFTElBYBWkkoed4q8H1csNwiSI7o0T2Cc5UtLRMiWT0ywMEuI3fvGhMj
         51JBhFTRKBCg1suO1+zGU7eNPzpg1NL0pOlASfsetpst21XI7260fkHWbZKaJbf518N7
         pO0apb9dtyrlXRyJ/wLme7xP5BrigXgQfuSWvE5dV4V8lW7hBGu2G8QqG46F+D/s0/S8
         xtGJrJP0VauVAlZsfhiTRK2lqUqyDMJBiLlBOeH0hTLxRLpOYh7WErme+YsjYGBgoBCl
         LAGPpgJTq+Uk6WRQPAOWOBN/MYhjfyLV8AkuXuBavQEMngdkB29HIO3j/D7RoxTLcVv+
         oD6w==
X-Gm-Message-State: APjAAAVavztYDOAV8T/cirSN8COV2t3ur2JuNcYfiSdMssZMwpx3X+xW
        XMs5u8MIGZYunEAYVjm/frno7g==
X-Google-Smtp-Source: APXvYqyaRGYa/8yGTPMBa3T2oP7SqyidqAh1hGDpH7fzy8BcRA8VWUqjzXW4I20lZcjT3CiYAZGZiw==
X-Received: by 2002:a50:a5ed:: with SMTP id b42mr34559690edc.178.1557261636543;
        Tue, 07 May 2019 13:40:36 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id t2sm4751397eda.41.2019.05.07.13.40.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 13:40:36 -0700 (PDT)
Date:   Tue, 7 May 2019 22:40:35 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] pidfd patches for v5.2-rc1
Message-ID: <20190507204034.kgwqkgw6lc3hzukd@brauner.io>
References: <20190506123659.23591-1-christian@brauner.io>
 <CAHk-=wh692HhZ+s=WWCw81mWFvXEGpXKccHcmpRUrO9p3KKD=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh692HhZ+s=WWCw81mWFvXEGpXKccHcmpRUrO9p3KKD=w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:39:05PM -0700, Linus Torvalds wrote:
> Oh, and this causes "git status" to mention the
> 
>   samples/pidfd/pidfd-metadata
> 
> file, because you generate it, but don't then mark it in a .gitignore file..

Oh, sorry. You want me to send a follow-up that fixes it?

Christian
