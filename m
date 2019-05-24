Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F66C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EE420879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558702448;
	bh=2DPAS6U9MkK6H99Wj2Dj1ObTdbh7LvHGDMm/wdboGNk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=JkjHKSAz9YEAaRT3FX8NVmlvMQWwfA1XFCn6TKDOcBI7dshAXTr0RhLjsnxIaZKEA
	 3oBnjIbt2ZpUC8haJyw1yhUuCKudi+3LftMj/+qEQBhYhUl3bo/Ue+QP+BJW/mhP8y
	 wb+IZSPXuCSkbDHNsP4MOJaiE8XkjyTSt/zrywjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391300AbfEXMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:54:07 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39807 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390946AbfEXMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:54:06 -0400
Received: by mail-pl1-f180.google.com with SMTP id g9so4146058plm.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGrwwhyQGwZ240SOWzANJeQRyK9PCdGpkGuUDnJ+N0A=;
        b=EAsPCaueLWnwoNyr/vnXSVMuNsyo/PlhQG9ehOCDtc1DJWDcttLmToqf2Z0DbW1Zn4
         mNWpiQYFW7pebvtP8MqHmPAV3YKULOq6TqevDYaOiJ1svJp50MucFOlhcVVx7jK/gy4n
         0Hxcii/wREwv13+bukDparIi4vgleyxsfskjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGrwwhyQGwZ240SOWzANJeQRyK9PCdGpkGuUDnJ+N0A=;
        b=LWUlMsBP9S5PPyZj9qNwuNaaTPks/FPCOD5oiiUOoo0q20Js33OUgYoswtpZqTctuG
         B572JlCsU5w/a29Ojt9g/RrIauy8uKLIYqqP28ut4xs43a6Bl4IpKzwE6JeUr7E9MCWm
         f5r9MeVOqqU5+Bhs1l9IJYGKwq2nL55asJpiSrj7rn2PbqdG6nqSG0F9wHV6RlLbT+Ma
         VJpvmtq1IIa63DMlMtEsMh5fJlshOON1LfSpUqn2OcXJUXEDyOlAEK9nkhqmtnEzljMW
         aAgnzyN8ffdToucF8cmTXPc1Y2P2/9fA6HAi9NTdt/pv8h3Gi7k8+E15bf9ai6+MsGGA
         46Tg==
X-Gm-Message-State: APjAAAWPLLTnXM0iEx01lKcU1uwk+UjXrvbae8MALzv2sjSvDKWxaolQ
        xrQWch5fDYIOUHpz2SjDKskk3WItmDJzQQ==
X-Google-Smtp-Source: APXvYqxeg+xCGTQIPiHKdyLxz560XprN1Lj94nGLAvX6va+hMM29aYWbnsGzSnMKk1lY0x6Sg9YStw==
X-Received: by 2002:a17:902:46a:: with SMTP id 97mr77650464ple.66.1558702445881;
        Fri, 24 May 2019 05:54:05 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id c14sm2230019pgl.43.2019.05.24.05.54.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 05:54:05 -0700 (PDT)
Date:   Fri, 24 May 2019 08:54:02 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Theodore Ts'o <tytso@mit.edu>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
Message-ID: <20190524125402.GA616@chatter.i7.local>
References: <20190522193011.GB21412@chatter.i7.local>
 <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
 <20190522195804.GC21412@chatter.i7.local>
 <20190524045708.GH2532@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190524045708.GH2532@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:57:08AM -0400, Theodore Ts'o wrote:
>> I'm perfectly fine with Link:, however Reported-By: usually has the 
>> person's
>> name and email address (i.e. PII data per GDPR definition). If that pehrson
>> submitted the bug report via bugzilla.kernel.org or a similar resource,
>> their expectation is that they can delete their account should they choose
>> to to do so. However, if the patch containing Reported-By is committed to
>> git, their PII becomes permanently and immutably recorded for any reasonable
>> meaning of the word "forever."
>
>Many (most?) bugzilla.kernel.org components result in e-mail getting
>sent to vger.kernel.org mailing lists.  So even if they delete the
>bugzilla account, there e-mail will be immortalized in lore.kernel.org
>and their associated git repositories.

I wouldn't say that most -- to my knowledge, it's only about 5-6 
components of the 50+. It's hard to tell how much that is by volume, 
though, because certainly not all components see much activity.

We *can* excise things on lore.kernel.org. It's a massive pain, since 
message archive is a git repository itself, so will need to be rebased, 
reindexed and remirrored -- but it *is* possible. On the other hand, 
once a commit makes it into the kernel's git tree, it becomes impossible 
to edit it without affecting the PGP integrity of all git tags following 
it. Since PGP signatures can be considered a core aspect of the git tree 
integrity, we can then argue that editing commit history of linux.git is 
unreasonable per GDPR's own guidelines. We can't make the same claim 
about lists on lore.kernel.org.

>So perhaps a better approach is to put a warning alerting bug
>reporters that submitting a bug means their e-mail will end up get
>broadcasting in public mailing list archives and public git
>repositories?

That's probably something we should do. I'll investigate it.

-K
