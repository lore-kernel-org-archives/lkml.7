Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ACBC04AA9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65942085A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="z8Qh5l7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfECAe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:34:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44188 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfECAe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:34:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so1959498pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B5WWF5FFM5YBJUnKNf5sx1J+mjTtHvq3USn00Drosfs=;
        b=z8Qh5l7JiwsSFs/jEew897kzKOiC62hiO6FgmfKWH8AzV5cpmom8RlzurcWZPFqrsz
         di7vpPq1mhoNzY/q4swF7yAftkbhHMi3acxmVzYGfcUUQiKZVsIDizLPvTT57Pkp1LVS
         2hohjlj5ItTs7DSSMaykXpxLrlcIiebhWcVdL6wUOXPruCf5sYI3CTpsS1HFeMg4Mv6L
         CcNHe0Y2Gj+sQfBwkob0BOCHgO/i2s1s9H464QrnqrgwtcIsw+gQ9lTRo0Hv4bWwhDFD
         95RLG2S/yqL9RW5ZCbAw1hZZtPGlN6GI4mDCO8MHzpvRzww8yH/kw/XhO0OqnOaDZRUG
         8mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B5WWF5FFM5YBJUnKNf5sx1J+mjTtHvq3USn00Drosfs=;
        b=r4+Sl2Uz/nYcXYG3Y4EfMfihpbpzJNhE0+wh9eRfX7NFK2lyNR/Gk1al24iChAbzks
         FcnECQ+UUw54Hj1+icADjQjtV7mYl1i+ElWayo8QH1u3iKRbDzvxwRqns4YnTRmMI+EM
         MjQMICYc1UPbTS6fb88/ZIpoSyCUkmzC0sFkrw+qimocSSxHWU+oxj2WD8f20t7zcowp
         wgrlXKCxRuHUkjiLM+05U/97TLCYkstErCkMGLZXDmh/YA12IRFacdJcGqbq3eIVr/Vj
         95fGxfHu2EkLP48mWej84g5VL6ae0ErX3+w+BhqXM6c1M1vHOuFKVDJ/D6sIgmmbUJBJ
         rAhQ==
X-Gm-Message-State: APjAAAWJxFZ9PwrN5M7mE46yqEgAtn64XJsbeSXkMP831GmpYcn0hc80
        QMre36ccfaMLyEddrUVXlpmWNQ==
X-Google-Smtp-Source: APXvYqxhbQaVIAGRU4JpLY7JC4nQOEPGAOCB+MsVHycjQWI5T4AjZA2qIuayAoRIk6bJMsB3OlLs6g==
X-Received: by 2002:aa7:8284:: with SMTP id s4mr3443937pfm.235.1556843695632;
        Thu, 02 May 2019 17:34:55 -0700 (PDT)
Received: from [10.251.13.47] (109.sub-97-41-130.myvzw.com. [97.41.130.109])
        by smtp.gmail.com with ESMTPSA id l10sm463400pfc.46.2019.05.02.17.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 17:34:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the running kernel image
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <alpine.LRH.2.21.1905030901180.7491@namei.org>
Date:   Thu, 2 May 2019 17:34:51 -0700
Cc:     Matthew Garrett <mjg59@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <343EE650-4077-4882-94D6-28BBDBA32182@amacapital.net>
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com> <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com> <alpine.LRH.2.21.1905030653480.32502@namei.org> <CACdnJuusGU2DMXaPAjH3+QOcSj-9q6njbxxG-9s2PweDKognvw@mail.gmail.com> <alpine.LRH.2.21.1905030901180.7491@namei.org>
To:     James Morris <jmorris@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 2, 2019, at 4:19 PM, James Morris <jmorris@namei.org> wrote:
>=20
>> On Thu, 2 May 2019, Matthew Garrett wrote:
>>=20
>>> On Thu, May 2, 2019 at 2:07 PM James Morris <jmorris@namei.org> wrote:
>>> One possible direction is to (as previously mentioned) assign IDs to eac=
h
>>> callsite and be able to check this ID against a simple policy array
>>> (allow/deny).  The default policy choices could be reduced to 'all' or
>>> 'none' during kconfig, and allow a custom policy to be loaded later if
>>> desired.
>>=20
>> Ok. My primary concern around this is that it's very difficult to use
>> correctly in anything other than the "all" or "none" modes. If a new
>> kernel feature is added with integrated lockdown support, if an admin
>> is simply setting the flags of things they wish to block then this
>> will be left enabled - and may violate the admin's expectations around
>> integrity. On the other hand, if an admin is simply setting the flags
>> of things they wish to permit, then adding lockdown support to an
>> existing kernel feature may result in that feature suddenly being
>> disabled, which may also violate the admin's expectations around the
>> flags providing a stable set of behaviour.
>=20
> Understood. Most uses will likely be either a distro or an embedded=20
> system, who I'm assuming would provide a useful policy by default, and=20
> perhaps a high-level abstraction for modification.
>=20
>> Given that, would you prefer such a policy expression to look like?
>=20
> Perhaps a write-once policy, injected from userspace during early boot?
>=20
> The policy could be simply a list of:
>=20
> lockdown_feature true|false
>=20

I=E2=80=99m not convinced this is worthwhile.  As I see it, there really are=
 only two privileges here: root can read kernel memory, and root can corrupt=
 kernel state.  A policy that root can=E2=80=99t corrupt kernel memory excep=
t using, say, eBPF is useless =E2=80=94 it gives warm fuzzy feelings but not=
hing else.
