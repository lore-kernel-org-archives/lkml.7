Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F1C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E0820862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/aYGmU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfEVQtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:49:05 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:35260 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfEVQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:49:05 -0400
Received: by mail-it1-f182.google.com with SMTP id u186so4154312ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXHwKRBaxNZUqH116t+JoeDJ1ugnuKx/lu7qvYOcfvA=;
        b=L/aYGmU8ZKf2hWToIHwxxXaDfR/JGv6e+gE3X0402R7BWItbU86h0f1fs99z/VrC6X
         W7FwuMvSNsqL807Yf2RSOq/Nv/7iyjsCSJnk0dAgkpktRS2LYmQVxlj0FvHbCT9t0CFO
         1I+Ri+8y8+10X7bxkKVVRzgOPZKnMdABq4eD+cyGPS9SqeD2UuIv4+sk4cH/qDtfvBrS
         v+HXxlotFwyLw7meHG0wkaDfpXNRsjD3yXZHBtQF7iShFDT3EbZCT8Q6p1KNDTj6AM8m
         sd5gY2G0xu2opHQoBRP4S+JOHrf/lIasQkNfLHnwf+iGjQTC4Y9nG3IRxUfO9t8sbLyc
         rovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXHwKRBaxNZUqH116t+JoeDJ1ugnuKx/lu7qvYOcfvA=;
        b=o6X7YnSSSmsiP9IeGl9daXTdkKEz149O7CHolZcZVUAgIBu7OgkumUcuoDCFn7evBv
         +gl1Ct3Nv4T4pNfkufTw/ygf/dYfgGasvBn1pxow7dt5Z3lndK/sCoR/tPLZfAYODLMJ
         1765yEkBNK6Hx0Hf5iA0Dj1NUBSQd3FcUoNv+xryNAZcCwG2r92JKdj6zwDL0PSvpzKF
         LwnfmFCgneM535o9YYjAU0T35LpuSuDpn68Ii0h6di68kSkJ3SXaWqPHoIwUfAaGKhnm
         n6enHCmMqKKOAABQS7qSD6uAvLRcBpc88FE8Yb4PyoLYoJMsaSZhE3J5rfHnBmakvaY8
         7osg==
X-Gm-Message-State: APjAAAVwfzHHGM5sdyZUG3A/2oepcaAMUBGB1fXGCtIfaCh2jIKuMeYf
        5oJuK6/r6hpFzA7QQevJovrB1i0TmMgPEFwnFlmMeA==
X-Google-Smtp-Source: APXvYqx979Re4l+BscFyslcBECPYgnFbyyVgk69PzAWenrhlVcn1OmEIR+W5zqCRv6z+q/2iy0HGvPRlVdRjrlkgUv4=
X-Received: by 2002:a24:a943:: with SMTP id x3mr6102296iti.64.1558543744085;
 Wed, 22 May 2019 09:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190521224013.3782-1-matthewgarrett@google.com> <alpine.LRH.2.21.1905221203070.3967@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905221203070.3967@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 22 May 2019 09:48:52 -0700
Message-ID: <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com>
Subject: Re: [RFC] Turn lockdown into an LSM
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 7:40 PM James Morris <jmorris@namei.org> wrote:
> An LSM could also potentially implement its own policy for the hook.

That was my plan. Right now the hook just gets an ASCII description of
the reason for the lockdown - that seems suboptimal for cases like
SELinux. What information would you want? My initial thinking was to
just have a stable enum of lockdown reasons that's in the UAPI headers
and then let other LSM tooling consume that, but I haven't spent
enough time with the internals of SELinux to know if there'd be a more
attractive solution.
