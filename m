Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C8C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FBC208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="b7fhwy9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfE2JyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:54:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34515 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfE2JyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:54:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so1820343ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lNs/p+JI3D1zMvTvnIvX3YzQkmwKplKfx1eyegHlUGs=;
        b=b7fhwy9KHyUHN1+JlY54Izh0UyO3XPFFISf05d3A09WpwVuLvrThPkOQMuiPkXAHd2
         av6G2ajatkgXHfRYOzoCM73Yl7wigIk/GrANkMIGKS0APqqPU8ml399Qb+v4pbmh3kd6
         8y9/xQ49KErSRP5pPjn1hWTvlBpTrg8GTFRC8fdrGE++BIime5+AGff2+5UUnMDQfXFk
         Vvh7BeWG2cAK2O6qE/SzBVHqhgh019YeN0H0NM71HAyAE0UoVUa5bk1oPzWvK9d3Fo2o
         tImwEqaC5PM0ibTBMRTPr956imoYfWybaalHs2WbQ4RmAaj5VaZ3Zwvh9WBR09VmmcFc
         Ap+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lNs/p+JI3D1zMvTvnIvX3YzQkmwKplKfx1eyegHlUGs=;
        b=YyT2eUrSv8qvW5n0Ux2ZgpzPMV9c/zjnvBVFYt0jDDHvNZau50TiVIz+zrVHXt7HX3
         emNi5sxXEOjcxEv5KocWIUQYG/zYTHyEwy6pSdbcV4TkOqHDwHseG8Nn76Au+GZxIzVP
         dItK/7RdcX4nQ9lm7gTfs8vyMwnpc2j0MF/ZQgmOFpLWhAZOKgzUKoham0BX/e+xNOgq
         TE1mLvctzUQBlVhyXrHUsrOhLcdl11qcu0cLtf/iCqlVpcJBwfissV7v6WQqAW3OhsGU
         gJYM/SestfGtdDF6NxMMpO4hlPQwGRC+Rh09LWKNcfCibgPzdni3qE+DSHxa1FCP0QJ0
         SI2Q==
X-Gm-Message-State: APjAAAWKe3F+IcpbCxrzc8KUgPGzKdLA6JBdIdVxuxn7/iAfRGH7hfEd
        A1zU4PzVr10Pz6WFeuAMOU3QhzkeeD4=
X-Google-Smtp-Source: APXvYqy3vMRQTqltRLbu1to0t8Uw2L6vp3NNLrEAEyPljntAyQr8TzYLsDyYWbDU7gEOUTVGvhAhRg==
X-Received: by 2002:a2e:9193:: with SMTP id f19mr26590199ljg.111.1559123646154;
        Wed, 29 May 2019 02:54:06 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.1])
        by smtp.gmail.com with ESMTPSA id g81sm3390192lfg.22.2019.05.29.02.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:54:05 -0700 (PDT)
Subject: Re: [PATCH bpf] libbpf: Return btf_fd in libbpf__probe_raw_btf
To:     Michal Rostecki <mrostecki@opensuse.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190529082941.9440-1-mrostecki@opensuse.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e28170e1-cf06-87ef-812b-9b9e6185d925@cogentembedded.com>
Date:   Wed, 29 May 2019 12:53:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529082941.9440-1-mrostecki@opensuse.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 29.05.2019 11:29, Michal Rostecki wrote:

> Function load_sk_storage_btf expects that libbpf__probe_raw_btf is
> returning a btf descriptor, but before this change it was returning
> an information about whether the probe was successful (0 or 1).
> load_sk_storage_btf was using that value as an argument to the close
> function, which was resulting in closing stdout and thus terminating the
> process which used that dunction.

    Function? :-)

> That bug was visible in bpftool. `bpftool feature` subcommand was always
> exiting too early (because of closed stdout) and it didn't display all
> requested probes. `bpftool -j feature` or `bpftool -p feature` were not
> returning a valid json object.
> 
> Fixes: d7c4b3980c18 ("libbpf: detect supported kernel BTF features and sanitize BTF")
> Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>
[...]

MBR, Sergei
