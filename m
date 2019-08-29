Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C516208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPUqryHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH2Uhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:37:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50426 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2Uhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:37:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so5075287wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4ntHy8qnLbvltzVHdmKX4Hf7t3TRxi31vLBSSClDxqI=;
        b=GPUqryHr9ZAzl3WbDifnBpLLMrSrRUKhrn5jIgV6sHE3bYkxc7UZo11aH11NXOFQzx
         9w6nSExWKFIWDMhwYoXfqtalNZ1R+rqWUdF4zQxhvky+XjfWida5OtXsn8HEHlMQ4wYY
         Pv8CppKVPD46jjQMOPCbHN/B45G/yyKRjM/ubUKSwakI6y+CHJq7ll8o4IGgu8k2uG07
         lp1cDiyV48vd4aqYUt8T85oFFjk0n7A0at41Z+b5JB+UMbSqGrGKepPtIUuL7K9FiMVw
         u57Q8qsPJZj9z894iXneK4oQUOmHoprWWElXBKtt0P/kqelJFltygw1NnTINYTqA5QEv
         hGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4ntHy8qnLbvltzVHdmKX4Hf7t3TRxi31vLBSSClDxqI=;
        b=Te7g/H0GfUrbhatEXa+0Y0OQNMuoNMzij+zB6aU4+9udou/L8gP3i2lPhcJitjAzEY
         P56NR4mjw+L7Cl1QD0SAWVkMfeKA3r0wvMggiP4sQYrbd7Fh9Mj53qOg6QJBdLtC8GCw
         iJLU3KCPECmjR8VPT7jHbvTVV9gcQla/bb4ENVRmRdfxNVMJ+AUDhG1doOEVO4HB1rJ1
         /6rQxDaPaPxU+FmyZuzeJdj9H++LMhZkUWyPBS9qLKKRJ/kZpAjHziHynUDbRhhekEZ9
         /rW/+Fz/gskwW1nxBprXc2QDA9FNIZ+tS/fueyeUrH1MBRquphbzv3znzZbUmemdvAaN
         sPMw==
X-Gm-Message-State: APjAAAXJhhWmJ3TKhbHLm8d4yXzb2UkG0LmTllGfAfhHyb+Pmd7V2KxN
        hLmBcvIqrvpc630QWv76MOH147LDthkVXy/+z5Y=
X-Google-Smtp-Source: APXvYqx2WpzAiKrB02C0yYvWAiFObW37TDnFKI2EGSeI0yuO5w7AJEx8KIoJDRvldRo0IHzdmEWiW/MAlWdN88MsK+c=
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr2287775wmg.150.1567111054983;
 Thu, 29 Aug 2019 13:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com> <CANiq72niUcQv-TFn=_0Ui7nEM9ESKNC7n6GPQs2AKXVsg6ZV=A@mail.gmail.com>
In-Reply-To: <CANiq72niUcQv-TFn=_0Ui7nEM9ESKNC7n6GPQs2AKXVsg6ZV=A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 29 Aug 2019 22:37:23 +0200
Message-ID: <CA+icZUUi9Tsjha+unG+DasXZ9oBb6XcuZvj+N9h=b4XH7cHmqg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] treewide: prefer __section from compiler_attributes.h
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        David Miller <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:24 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Aug 29, 2019 at 12:55 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Changes V2 -> V3:
> > * s/__attribute__((__section/__attribute__((__section__ in commit
> >   messages as per Joe.
>
> I have uploaded to -next v3 so that we get some feedback tomorrow
> rather than waiting for Monday.
>
> I added a few changes, please take a look at the commits:
>
>   https://github.com/ojeda/linux/commits/compiler-attributes
>

Thanks for taking care and bringing this to linux-next asap.

- Sedat -
