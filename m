Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37570C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2372071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbQjbtZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKZSuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:50:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfKZSuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574794248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0r4KWfIOtxgISfApasmXgGWya0QXrhQe0FmvwJZ3LCk=;
        b=DbQjbtZ6dLNlWnrB7grb///Q7m7FnK0AuzaDMFidDT1GA0lGtTp+pq/aQ24OdYRs3vG859
        lczNQ/pj0g79+6fkvKIcMGS6Ctk3SAox9h3bzYn3ps0usg/jgv7VyicTL8/9wwomJDsYFu
        y0WvKrZy8dIm6ydDfjLSISfb5u5Ejgg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-P-npiKjbOyOrWo4xEfxl8A-1; Tue, 26 Nov 2019 13:50:47 -0500
Received: by mail-lf1-f70.google.com with SMTP id y4so2717100lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 10:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oJf7PTKEEbEjo8GcSBfvuP8BlJ48R6NcwJ+kR4IpGyQ=;
        b=BVCzAh8BWhwIV+1E5VEhJsra7gUFhn2Lbrt8sTraiBKkPUIR+3yKnHAlwfvxEjI5k8
         SVqsNlI5zt4Fu1KFc+pIZwjl4UXfV6YmLXSS6zA1KKZ2Qbf+dryH3rZd0A5f9GTw7Ybm
         uIqv51kbOY+LT2xaix16s5dKS206AA6BQTNdISq7Z5bavHIvbVpaiS5fY/U8z8TgTTjL
         5PYaase80HQr91GZsTzkxIt1ROcq6DIqoxoW32FKFS4MLeLDV24Cqqd76gd1k3Zabt0w
         OFUsH8fqWEZKHgOFicq5ixj2Zh2Tw/SGYuZBrQpR/SSwRG5j9Pu+Wg2PO/V5uhWlgB3n
         Th6A==
X-Gm-Message-State: APjAAAV+MLB8ZUUi8Ez+kOsf7OKXRB3MQe4/kem0mb/2cpJ4zTWgtydz
        09nqF1QnrPMfBco9GlS4hUuX+SMBOI6LuPhjs/xuUa7ABDlaJJziuebRkRXAJ2g5stAMeiXyiES
        rLwVaA4Z6aCxfKU+VGsvLiR8A
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr28710582ljm.241.1574794246177;
        Tue, 26 Nov 2019 10:50:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHUc+oquSTaDm4CLKd9afrY/tGbnKn6DtP9DUe78i1wuycX8Rquk69fvv3hGcR7RNE9dzAcw==
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr28710563ljm.241.1574794245996;
        Tue, 26 Nov 2019 10:50:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d24sm5904329ljg.73.2019.11.26.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 10:50:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2B69C1818C0; Tue, 26 Nov 2019 19:50:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
In-Reply-To: <20191126183451.GC29071@kernel.org>
References: <20191126151045.GB19483@kernel.org> <20191126154836.GC19483@kernel.org> <87imn6y4n9.fsf@toke.dk> <20191126183451.GC29071@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Nov 2019 19:50:44 +0100
Message-ID: <87d0dexyij.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: P-npiKjbOyOrWo4xEfxl8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:

> Em Tue, Nov 26, 2019 at 05:38:18PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n escreveu:
>> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
>>=20
>> > Em Tue, Nov 26, 2019 at 12:10:45PM -0300, Arnaldo Carvalho de Melo esc=
reveu:
>> >> Hi guys,
>> >>=20
>> >>    While merging perf/core with mainline I found the problem below fo=
r
>> >> which I'm adding this patch to my perf/core branch, that soon will go
>> >> Ingo's way, etc. Please let me know if you think this should be handl=
ed
>> >> some other way,
>> >
>> > This is still not enough, fails building in a container where all we
>> > have is the tarball contents, will try to fix later.
>>=20
>> Wouldn't the right thing to do not be to just run the script, and then
>> put the generated bpf_helper_defs.h into the tarball?
>
> I would rather continue just running tar and have the build process
> in-tree or outside be the same.

Hmm, right. Well that Python script basically just parses
include/uapi/linux/bpf.h; and it can be given the path of that file with
the --filename argument. So as long as that file is present, it should
be possible to make it work, I guess?

However, isn't the point of the tarball to make a "stand-alone" source
distribution? I'd argue that it makes more sense to just include the
generated header, then: The point of the Python script is specifically
to extract the latest version of the helper definitions from the kernel
source tree. And if you're "freezing" a version into a tarball, doesn't
it make more sense to also freeze the list of BPF helpers?

-Toke

