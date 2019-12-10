Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7757C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988A8205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoR6Yr/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfLJVaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:30:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbfLJVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576012200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Dn0X1y8qWY4L6jupdvIYtGjXctpKGwYZyUlMuuX+gk=;
        b=QoR6Yr/J4bbjg/p1mvjp7aha9lOWnKDi9ZOSF9vhAgamPAx0hMo1FaX41vIJkJE+j2Lh2K
        ISZwzpZ2cts5uzgcrjzSZoPLxVlaazc7O+KU167PfBAEoT4Re2QMxxZODBx+13nljlG4+s
        XZwH0VLWZ0q7q7gg9ZpkjHENCtlY+f4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-bIhh8MvmPpScaMffIORNmg-1; Tue, 10 Dec 2019 16:09:59 -0500
Received: by mail-lj1-f197.google.com with SMTP id f1so4060362ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6Dn0X1y8qWY4L6jupdvIYtGjXctpKGwYZyUlMuuX+gk=;
        b=LoJOxX9z4ETSRGDYXH7AaIYd0BqPbKJdizLQLCcDPE8I+BXi7Is0P5MwcJM8saLtHp
         fj5P3SAHlXtJrNwxTWYOc2RFxYIDAulqMOTSqzv8fs1XkLNVtzdqRTuYMGoSn4Checbv
         X+oHH8b0ffQgdLB2w1hC2L6xqithVheKOpKPh5jbRVtfju9J590RRru/UWWFC0xkpJP+
         +AHJ505KSSVskHZhY03TlWPG5MdSOVNMoW62fFsSyxoXF7+qs7FXoyC80i2mBRZhDQ4T
         9oQErcvYuPUurMrNlea+Y4a8XbQwiWTLUlCPiqUcXOkhF7FE4rho2OQ4Ki2gRKJPl9WU
         9wiA==
X-Gm-Message-State: APjAAAUFTLP8vFknDvvtdtRxOkFzvx6Mefj6I/O6IWMZpNRX1TOK24uz
        1+2C2XAX8XaSxX+3n0xhRCQff8WLg8WM+WdZ+y2CpF5a0euJPSwy3kSTQgn6dBw4uRdvD7H9mx0
        QvbV4+okdDF1++BD43vNozKKR
X-Received: by 2002:a2e:a408:: with SMTP id p8mr3996819ljn.145.1576012197677;
        Tue, 10 Dec 2019 13:09:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvMCPn/czOu2GRrVuQOc/gN/GQSbTQE0kUF3zFgRZi0rgmbc3zka5Cy/ldLQX+t9WQBZ45iA==
X-Received: by 2002:a2e:a408:: with SMTP id p8mr3996800ljn.145.1576012197452;
        Tue, 10 Dec 2019 13:09:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f8sm2469467ljj.1.2019.12.10.13.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 13:09:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6C981803C1; Tue, 10 Dec 2019 22:09:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v2] bpftool: Don't crash on missing jited insns or ksyms
In-Reply-To: <20191210125457.13f7821a@cakuba.netronome.com>
References: <20191210181412.151226-1-toke@redhat.com> <20191210125457.13f7821a@cakuba.netronome.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 10 Dec 2019 22:09:55 +0100
Message-ID: <87eexbhopo.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: bIhh8MvmPpScaMffIORNmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

> On Tue, 10 Dec 2019 19:14:12 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> When the kptr_restrict sysctl is set, the kernel can fail to return
>> jited_ksyms or jited_prog_insns, but still have positive values in
>> nr_jited_ksyms and jited_prog_len. This causes bpftool to crash when try=
ing
>> to dump the program because it only checks the len fields not the actual
>> pointers to the instructions and ksyms.
>>=20
>> Fix this by adding the missing checks.
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
>
> and
>
> Fixes: f84192ee00b7 ("tools: bpftool: resolve calls without using imm fie=
ld")
>
> ?

Yeah, guess so? Although I must admit it's not quite clear to me whether
bpftool gets stable backports, or if it follows the "only moving
forward" credo of libbpf?

Anyhow, I don't suppose it'll hurt to have the Fixes: tag(s) in there;
does Patchwork pick these up (or can you guys do that when you apply
this?), or should I resend?

-Toke

