Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37CFC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972E02070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0nBNKPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfF1HBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:01:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45865 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfF1HBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:01:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi6so2696353plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=Oej4Il0Mb4EFBZMtlZZn5pX80rvSmbWkyqLWJge1d2k=;
        b=L0nBNKPlIlQRaPgZW8NPCGfKolxLNRUS50MpuU1bGXBabvPyJ3Mz5hRD/k76+mno5m
         SH8fndCLLAjnbIYegvNVs6uFK1m2r+C9h4WprcRraHhb5YOcDOEQurasElg0F7Mjl1Ll
         BOMwQsGJ3h6xvjSbhZ3X0S1kQSzZORXEDmlwVhBUFV66u6zzFwJboR8NkmswnzWZB6gX
         Uyo36sqMhSEcKDYu98NdsvvA8+XO3ORJZyLOE8GokAt6AvGeUxer4bknEjBm0X6YvOxm
         N05VWKTbRnCL48tEMSifhCNYv3MlPeyD0Gq6fpg8QpUKb8KklPhBRoELPDN1mx9TGfpL
         uVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=Oej4Il0Mb4EFBZMtlZZn5pX80rvSmbWkyqLWJge1d2k=;
        b=WOGGZ3pGg6fbe3Q9xjrMRYhkrqyexeuNv6n4eKNvBpvhMIthU6PBhStp0T9gP1jnA1
         vF7vEUEIZXws5pB5Yxc0PUqHahRpqrIT/N28BAmTMyaKVKIUGipvyoPr1bz2SQTL/scB
         99kLxtIMpP0p1VCXbGfXGkd4wI5hqqrqkZwNgH21V1gH9JpItMf1FQaoLMIVSCNjd8nb
         Gyjrlxk9PNTz3QYod3PH4NePUOXyHR9uTrEr3yrrN1mbpaqfeUQcL4iaJIcig1JygP7K
         isfb2Wk2imLxPZ8xa+WaptNOLOjxSqtVFHafDwxVtqbfZJrXrZWrbKJe4kM1LNV0IhKH
         19nA==
X-Gm-Message-State: APjAAAWLja6Pr22jQ5C3WUf1Hr8+L6F1YINzkrZHlPi4png9yBJK/R8E
        wmDHT0gBqkwi369Gi0IfXEc=
X-Google-Smtp-Source: APXvYqwanWf3ASBp72KqH/U1FXF/IN4IimSrhXCm/tnJ9qfR5cPx0y2Rd8fi6o7KB62zMjGhVN4dkg==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr9289889plb.114.1561705312662;
        Fri, 28 Jun 2019 00:01:52 -0700 (PDT)
Received: from localhost ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id b29sm2333297pfr.159.2019.06.28.00.01.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 00:01:52 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:01:59 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <841386feda429a1f0d4b7442c3ede1ed91466f92.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <841386feda429a1f0d4b7442c3ede1ed91466f92.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1561704544.gobmve95sq.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao's on June 27, 2019 9:23 pm:
> With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' to
> enable function tracing and profiling. So far, with dynamic ftrace, we
> used to only patch out the branch to _mcount(). However, mflr is
> executed by the branch unit that can only execute one per cycle on
> POWER9 and shared with branches, so it would be nice to avoid it where
> possible.
>=20
> We cannot simply nop out the mflr either. When enabling function
> tracing, there can be a race if tracing is enabled when some thread was
> interrupted after executing a nop'ed out mflr. In this case, the thread
> would execute the now-patched-in branch to _mcount() without having
> executed the preceding mflr.
>=20
> To solve this, we now enable function tracing in 2 steps: patch in the
> mflr instruction, use 'smp_call_function(isync);
> synchronize_rcu_tasks()' to ensure all existing threads make progress,
> and then patch in the branch to _mcount(). We override
> ftrace_replace_code() with a powerpc64 variant for this purpose.

I think this seems like a reasonable sequence that will work on our
hardware, although technically outside the ISA as specified maybe
we should add a feature bit or at least comment for it.

It would be kind of nice to not put this stuff directly in the=20
ftrace code, but rather in the function patching subsystem.

I think it would be too expensive to just make a runtime variant of
patch_instruction that always does the SMP isync, but possibly a
patch_instruction_sync() or something that we say ensures no
processor is running code that has been patched away.

Thanks,
Nick

=
