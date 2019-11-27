Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F52C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4766C20684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xIVYfmQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK0PwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:52:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52665 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0PwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:52:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so7617775wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PilGUsLheeDsuCz8PhEf2YyoiKda8wUs7xbi5G40ET4=;
        b=xIVYfmQD4KLxdeTV1cESzSbgx4Dy7vU+bquY3ql3fwngODljLv0DZick3OIqzJm7td
         60vpz2g5YYhHkmTYLEMhJ/WKMjwEuDLOKstf8c86kNEtpwhWTI/+cbIy112vEPlTr6FP
         Ixta2hBUK9VLFaigbShvyYzhyGPrv1mAMQ4qBbXDWIpuQwF05Mh8mYgRYJVzsyXwVqNy
         7d2T6NwNr9aOGJL6y7JbuuMTaZjIbsfQTD0k7bXdZa/MFdGMH9AT4cCXWxA7TqG+OLKo
         WlhVyIkUe5mPdMnWYtsQygsuIUI6diwkVU1FNEst0pzszY5LS5xjBsy+SfB/WxLcXbGC
         EjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PilGUsLheeDsuCz8PhEf2YyoiKda8wUs7xbi5G40ET4=;
        b=kXMjpjUNjPAXI2rZJUkjWOWIyJ4i51ARVJKsiSOM8bK3S3WcuYjEHzYHsPHzNhzUSQ
         MrJV1rEN/fDFocA+aIpqPY90aVBDR+Ly6Hy80ETsJSAStFpRisBKzLZJ6qy2hEUTxP+e
         6xcRzmFLMS/anNSPiK6Ch2m/qy8hWRjqzZCacIxnalr0Un4i+D6RO2NzUnCqP8ysfsZ1
         JT4mwz8ANVwewvfx5SnZ1ARjhcT0N3Ejyn77iwP9svskTPYmEo3nyu12df4i+1i7XEez
         QQWs/qnnjevBWg66qG+bsQ0PUUABAdlvsCHAsIeBVWqbscmSFq3vtNMloFIBdFuHGoLV
         xUEA==
X-Gm-Message-State: APjAAAWFQoQubJSkpylj1SGNBdN4zdsJAkjRD3uYOWDR3I8PgXarLyFE
        kVD7L8z2qMt0jeBPF2BUbGJIGw==
X-Google-Smtp-Source: APXvYqzbO7LGEhMBvBzFWAUcaOzo3L3nFGLbkU8pQ7CaoYsQGUEJSd29pNFLiSVDoiOZp7TtTiDWMQ==
X-Received: by 2002:a1c:200f:: with SMTP id g15mr5120223wmg.96.1574869928383;
        Wed, 27 Nov 2019 07:52:08 -0800 (PST)
Received: from [172.20.1.104] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id d12sm18239305wrc.3.2019.11.27.07.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 07:52:07 -0800 (PST)
Subject: Re: [PATCH 3/3] bpftool: Allow to link libbpf dynamically
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <20191127094837.4045-1-jolsa@kernel.org>
 <20191127094837.4045-4-jolsa@kernel.org>
 <fd22660f-2f70-4ffa-b45f-bb417d006d0a@netronome.com>
 <20191127141520.GJ32367@krava> <20191127142449.GD22719@kernel.org>
 <d9bc04a6-0f72-9408-7c2e-2fb30e6a8f74@netronome.com>
 <20191127154849.GK22719@kernel.org>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 mQINBFnqRlsBEADfkCdH/bkkfjbglpUeGssNbYr/TD4aopXiDZ0dL2EwafFImsGOWmCIIva2
 MofTQHQ0tFbwY3Ir74exzU9X0aUqrtHirQHLkKeMwExgDxJYysYsZGfM5WfW7j8X4aVwYtfs
 AVRXxAOy6/bw1Mccq8ZMTYKhdCgS3BfC7qK+VYC4bhM2AOWxSQWlH5WKQaRbqGOVLyq8Jlxk
 2FGLThUsPRlXKz4nl+GabKCX6x3rioSuNoHoWdoPDKsRgYGbP9LKRRQy3ZeJha4x+apy8rAM
 jcGHppIrciyfH38+LdV1FVi6sCx8sRKX++ypQc3fa6O7d7mKLr6uy16xS9U7zauLu1FYLy2U
 N/F1c4F+bOlPMndxEzNc/XqMOM9JZu1XLluqbi2C6JWGy0IYfoyirddKpwzEtKIwiDBI08JJ
 Cv4jtTWKeX8pjTmstay0yWbe0sTINPh+iDw+ybMwgXhr4A/jZ1wcKmPCFOpb7U3JYC+ysD6m
 6+O/eOs21wVag/LnnMuOKHZa2oNsi6Zl0Cs6C7Vve87jtj+3xgeZ8NLvYyWrQhIHRu1tUeuf
 T8qdexDphTguMGJbA8iOrncHXjpxWhMWykIyN4TYrNwnyhqP9UgqRPLwJt5qB1FVfjfAlaPV
 sfsxuOEwvuIt19B/3pAP0nbevNymR3QpMPRl4m3zXCy+KPaSSQARAQABtC1RdWVudGluIE1v
 bm5ldCA8cXVlbnRpbi5tb25uZXRAbmV0cm9ub21lLmNvbT6JAj0EEwEIACcFAlnqRlsCGyMF
 CQlmAYAFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQNvcEyYwwfB7tChAAqFWG30+DG3Sx
 B7lfPaqs47oW98s5tTMprA+0QMqUX2lzHX7xWb5v8qCpuujdiII6RU0ZhwNKh/SMJ7rbYlxK
 qCOw54kMI+IU7UtWCej+Ps3LKyG54L5HkBpbdM8BLJJXZvnMqfNWx9tMISHkd/LwogvCMZrP
 TAFkPf286tZCIz0EtGY/v6YANpEXXrCzboWEiIccXRmbgBF4VK/frSveuS7OHKCu66VVbK7h
 kyTgBsbfyQi7R0Z6w6sgy+boe7E71DmCnBn57py5OocViHEXRgO/SR7uUK3lZZ5zy3+rWpX5
 nCCo0C1qZFxp65TWU6s8Xt0Jq+Fs7Kg/drI7b5/Z+TqJiZVrTfwTflqPRmiuJ8lPd+dvuflY
 JH0ftAWmN3sT7cTYH54+HBIo1vm5UDvKWatTNBmkwPh6d3cZGALZvwL6lo0KQHXZhCVdljdQ
 rwWdE25aCQkhKyaCFFuxr3moFR0KKLQxNykrVTJIRuBS8sCyxvWcZYB8tA5gQ/DqNKBdDrT8
 F9z2QvNE5LGhWDGddEU4nynm2bZXHYVs2uZfbdZpSY31cwVS/Arz13Dq+McMdeqC9J2wVcyL
 DJPLwAg18Dr5bwA8SXgILp0QcYWtdTVPl+0s82h+ckfYPOmkOLMgRmkbtqPhAD95vRD7wMnm
 ilTVmCi6+ND98YblbzL64YG5Ag0EWepGWwEQAM45/7CeXSDAnk5UMXPVqIxF8yCRzVe+UE0R
 QQsdNwBIVdpXvLxkVwmeu1I4aVvNt3Hp2eiZJjVndIzKtVEoyi5nMvgwMVs8ZKCgWuwYwBzU
 Vs9eKABnT0WilzH3gA5t9LuumekaZS7z8IfeBlZkGXEiaugnSAESkytBvHRRlQ8b1qnXha3g
 XtxyEqobKO2+dI0hq0CyUnGXT40Pe2woVPm50qD4HYZKzF5ltkl/PgRNHo4gfGq9D7dW2OlL
 5I9qp+zNYj1G1e/ytPWuFzYJVT30MvaKwaNdurBiLc9VlWXbp53R95elThbrhEfUqWbAZH7b
 ALWfAotD07AN1msGFCES7Zes2AfAHESI8UhVPfJcwLPlz/Rz7/K6zj5U6WvH6aj4OddQFvN/
 icvzlXna5HljDZ+kRkVtn+9zrTMEmgay8SDtWliyR8i7fvnHTLny5tRnE5lMNPRxO7wBwIWX
 TVCoBnnI62tnFdTDnZ6C3rOxVF6FxUJUAcn+cImb7Vs7M5uv8GufnXNUlsvsNS6kFTO8eOjh
 4fe5IYLzvX9uHeYkkjCNVeUH5NUsk4NGOhAeCS6gkLRA/3u507UqCPFvVXJYLSjifnr92irt
 0hXm89Ms5fyYeXppnO3l+UMKLkFUTu6T1BrDbZSiHXQoqrvU9b1mWF0CBM6aAYFGeDdIVe4x
 ABEBAAGJAiUEGAEIAA8FAlnqRlsCGwwFCQlmAYAACgkQNvcEyYwwfB4QwhAAqBTOgI9k8MoM
 gVA9SZj92vYet9gWOVa2Inj/HEjz37tztnywYVKRCRfCTG5VNRv1LOiCP1kIl/+crVHm8g78
 iYc5GgBKj9O9RvDm43NTDrH2uzz3n66SRJhXOHgcvaNE5ViOMABU+/pzlg34L/m4LA8SfwUG
 ducP39DPbF4J0OqpDmmAWNYyHh/aWf/hRBFkyM2VuizN9cOS641jrhTO/HlfTlYjIb4Ccu9Y
 S24xLj3kkhbFVnOUZh8celJ31T9GwCK69DXNwlDZdri4Bh0N8DtRfrhkHj9JRBAun5mdwF4m
 yLTMSs4Jwa7MaIwwb1h3d75Ws7oAmv7y0+RgZXbAk2XN32VM7emkKoPgOx6Q5o8giPRX8mpc
 PiYojrO4B4vaeKAmsmVer/Sb5y9EoD7+D7WygJu2bDrqOm7U7vOQybzZPBLqXYxl/F5vOobC
 5rQZgudR5bI8uQM0DpYb+Pwk3bMEUZQ4t497aq2vyMLRi483eqT0eG1QBE4O8dFNYdK5XUIz
 oHhplrRgXwPBSOkMMlLKu+FJsmYVFeLAJ81sfmFuTTliRb3Fl2Q27cEr7kNKlsz/t6vLSEN2
 j8x+tWD8x53SEOSn94g2AyJA9Txh2xBhWGuZ9CpBuXjtPrnRSd8xdrw36AL53goTt/NiLHUd
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <d78a306f-a736-63d1-4d14-695ba33d3d9c@netronome.com>
Date:   Wed, 27 Nov 2019 15:52:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191127154849.GK22719@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-11-27 12:48 UTC-0300 ~ Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com>
> Em Wed, Nov 27, 2019 at 02:31:31PM +0000, Quentin Monnet escreveu:
>> 2019-11-27 11:24 UTC-0300 ~ Arnaldo Carvalho de Melo
>> <arnaldo.melo@gmail.com>
>>> Em Wed, Nov 27, 2019 at 03:15:20PM +0100, Jiri Olsa escreveu:
>>>> On Wed, Nov 27, 2019 at 01:38:55PM +0000, Quentin Monnet wrote:
>>>>> 2019-11-27 10:48 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
>>>>> On the plus side, all build attempts from
>>>>> tools/testing/selftests/bpf/test_bpftool_build.sh pass successfully on
>>>>> my setup with dynamic linking from your branch.
>>>>
>>>> cool, had no idea there was such test ;-)
>>>
>>> Should be the the equivalent to 'make -C tools/perf build-test' :-)
>>>
>>> Perhaps we should make tools/testing/selftests/perf/ link to that?
>>
>> It is already run as part of the bpf selftests, so probably no need.
> 
> You mean 'make -C tools/perf build-test' is run from the bpf selftests?

Ah, no, sorry for the confusion. I meant that test_bpftool_build.sh is
run from the bpf selftests.

I am not familiar with perf build-test, but maybe that's something worth
adding to perf selftests indeed.

Quentin
