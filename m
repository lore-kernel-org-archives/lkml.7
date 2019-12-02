Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F782C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1829E20705
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZhxTDuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfLBSJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:09:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727670AbfLBSJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575310141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4ecEttM3yApxyxrsr44NMQb+oeialaWZ1R4NWHga6Y=;
        b=WZhxTDuDjU0wiZug6+8AoXZKGF5uYFMkTOeBHxYfqKTp+utizSJzN9MTVRKIilfeTyR0BN
        8FVkgqdgRSkh+UEocQII3nu6K52HJ3t5qVLKCZxYzL32zc+8VRHh2FgTvUF340N/JoMB/l
        fTu2YeRuVK6uwZQwRLOZqNTEIf1CpmE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Nll4BfliMLmaHagutXiA0A-1; Mon, 02 Dec 2019 13:08:57 -0500
Received: by mail-lj1-f197.google.com with SMTP id b1so58837ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R3A1rQuYRQ18AFn43+yCBqk/Ud+1TsgtYotLFNawFuU=;
        b=k8gQ/ntwjTQRd9/CEWFZXObEm/tidvTwuJ95cNtFGXG8/72IkHXI6VchMxnL+xbtrW
         u6jojGRGitmZJm4XWWYf4EwZvjrUMj87duobexp5UFZdXn5uTJQml05A69qtUZqfgX5Y
         1eFnDvxwso/L2snoOsEkcOxl9nMx84lPbBb/z4fqwwUyLEgeja2TzJt5JNebWSiOVhPq
         c5gzUnHUOmCeBEUkO79bpxabLBk7GDKvPLMxZxYqAlmCaS9vVuWksTSJstY9sw+uE/gf
         dzSnghlBTdqZMqY+ABi5mWwWXw+9CUgfb7YFlkvBxSZOpsCRnN4XfP26D69LetUQhUJp
         F6Dg==
X-Gm-Message-State: APjAAAVZGN3fTTkjnGSaW2N72hZEAHeeQ6OHM17CbKSb98qSFhIyFhGa
        MrthaUS4aRBGlhAoVkx/7yioM1FWZ8OTG9NGLePi3PeuFMaLs/SPQDIm2/n/9u+M3hzjEVJizmn
        HHkbGdFrPdXC6qO/SlsHtQl1b
X-Received: by 2002:ac2:5931:: with SMTP id v17mr202395lfi.166.1575310135540;
        Mon, 02 Dec 2019 10:08:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+ErVGcirRgq/taxG0hc0PK3IZELxdIQ1H+CTFmxm/d8vQkPE9sNJgKnUenWoxN34oySG/8A==
X-Received: by 2002:ac2:5931:: with SMTP id v17mr202380lfi.166.1575310135338;
        Mon, 02 Dec 2019 10:08:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v2sm148047ljv.70.2019.12.02.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:08:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE3941804D1; Mon,  2 Dec 2019 19:08:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 0/3] perf/bpftool: Allow to link libbpf dynamically
In-Reply-To: <CAEf4BzbUK98tsYH1mSNoTjuVB4dstRsL5rpkA+9nRCcqrdn6-Q@mail.gmail.com>
References: <20191127094837.4045-1-jolsa@kernel.org> <CAEf4BzbUK98tsYH1mSNoTjuVB4dstRsL5rpkA+9nRCcqrdn6-Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 02 Dec 2019 19:08:52 +0100
Message-ID: <87zhgappl7.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Nll4BfliMLmaHagutXiA0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Nov 27, 2019 at 1:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> hi,
>> adding support to link bpftool with libbpf dynamically,
>> and config change for perf.
>>
>> It's now possible to use:
>>   $ make -C tools/bpf/bpftool/ LIBBPF_DYNAMIC=3D1
>
> I wonder what's the motivation behind these changes, though? Why is
> linking bpftool dynamically with libbpf is necessary and important?
> They are both developed tightly within kernel repo, so I fail to see
> what are the huge advantages one can get from linking them
> dynamically.

Well, all the regular reasons for using dynamic linking (memory usage,
binary size, etc). But in particular, the ability to update the libbpf
package if there's a serious bug, and have that be picked up by all
utilities making use of it. No reason why bpftool should be special in
that respect.

-Toke

