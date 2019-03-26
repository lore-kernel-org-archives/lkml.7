Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26496C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EED2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQ0tJ4hP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfCZUTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:19:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37198 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbfCZUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:19:23 -0400
Received: by mail-io1-f68.google.com with SMTP id x7so12052798ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hB29KTCJlsbqFhKCwkDQh+R5X5tiePaO6kD9ZEWJZbo=;
        b=OQ0tJ4hPqATnNwystXYKaNCD6UwL4/fn6mB5FjSIT7nVHn9ZHVjLZh0CMgN/brQrXT
         aYz6NoTlh8J65LM3tlc86k0Txf9ueKoV3gRloJbdspXVXYX3WkMeKgqh3qDeQu2+0HoG
         B6no9aLMDIzH7YGkM2iTOkVbPUV9sOoBR5zkQNw++/AlKs12qosWNOOIF0O9XMm8epIg
         LsVRWZqQ9vHJ52cyp1QlthYMFfGoqNfiA/0A/qNH1ZSPh8qCrf93jJwP2XUSJptAo2kC
         xZiVKKYya8uktZ9LPP9n7+jki09yQRga4RnKJtsnmH0rxosZa9KcuAloNQaKsLiEVL9x
         lQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hB29KTCJlsbqFhKCwkDQh+R5X5tiePaO6kD9ZEWJZbo=;
        b=ThA37iHCe86KFGFJRZggVFD442xMTcMP61TG39vZcOR9gRmcZzh7s5oQsw8gKj6D0q
         F9Q/alVti11RJ6O2fm5PHpRHlGYvgFq8It+7w2ioc1tTXg+xtDRSFMXrKj9gcQMbL0tg
         rPTousJejvdvZ9akvFJwxK/vGxZkT9AtaHnm1Pw1+LyxfCZYKApyFchfsIZ/e92qgTo0
         Qmkj2AyiJm3S/laQdGOE79ZoRyt6gV6YSET8mzNkAeY4kw7xxcTHb77XrEUkRDth+uh/
         NZ0Pg6eSrjCR0mpesi7JVOOYCeE/7RvGav60xXavZKPCEuXHqfuubLoiz6vNuTuNoq7W
         ij1Q==
X-Gm-Message-State: APjAAAUWC8mDnWg4ow5kXuQVme/3+CdZEUIkgyVz5h8VjIGL8nlaVrij
        dDgGViRFYp4rE79vntpiG0zVlF90ywk+AaNu03kzTw==
X-Google-Smtp-Source: APXvYqwpSgfoWd0foYi7OK3mePaE1gVvnrZtRJ0wlPPomG3EqUY9wyTQY9JGiNPSzHPcdRLYbBCG6+jifqs5L2vaQLI=
X-Received: by 2002:a6b:e509:: with SMTP id y9mr22448630ioc.169.1553631562467;
 Tue, 26 Mar 2019 13:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360>
 <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com> <alpine.LRH.2.21.1903270523240.5235@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903270523240.5235@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 26 Mar 2019 13:19:10 -0700
Message-ID: <CACdnJuskoACijaifrNQhqRtr07uPN7LT8m=FNgcxgJRiwDLVkw@mail.gmail.com>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:57 AM James Morris <jmorris@namei.org> wrote:
> - Assign an ID to each lockdown point
> - Implement a policy mechanism where each ID is mapped to 0 or 1
> - Allow this policy to be specified statically or dynamically

One of the problems with this approach is what the default behaviour
should be when a new feature is added. If an admin fails to notice
that there's now a new policy element, they run the risk of kernel
integrity being compromised via the new feature even if the rest of
the kernel is locked down.
