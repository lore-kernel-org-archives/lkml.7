Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD0C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6364C2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYnG3hJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfFYPcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:32:02 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:39514 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbfFYPcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:32:02 -0400
Received: by mail-io1-f53.google.com with SMTP id r185so3970138iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pl6j18xP2teXBCXiFz1+ekHc82RO1v4dtHxUKcwmnSI=;
        b=xYnG3hJyz4khT/uJKxphyWjZQFQ//q3hlVe230M5KEJnEbld76vZxH0dhqV8TKmWJo
         8zg7zuJTixxzeq6fETCF+7hxbRsPwcKAEkCZab4RmBRlN5IMuVc3B4C7pXw2hM4IWaoE
         +viBxP25ebZesMJgXEzosY21FqBH7jtJfUlmzSk9Xqaf1KVqMPvFeGw9qYdI1FAyqUaT
         zo13+vCCbXRgCJrm0BskV1m1GDyXrPUMogAFwWyI+mpp5Lh2zh74nwwVqsWMctY04xV2
         VGsgpcQXYd/nJHwJT/YRiRjkz9nda3bfc/nAg3kYnlZZYJDQVbNjlIO8uYcb4Ckl6opv
         hz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pl6j18xP2teXBCXiFz1+ekHc82RO1v4dtHxUKcwmnSI=;
        b=SRsOOqlZc1EFtKR3Ex+bSQVCWCOULCywUZisXj/YTUTQwDrJlIQ8lV50Dt0zFYoIeb
         xILwoJlZYNEz0uWhd5JmExl+83eYBBPdAVJgF0DdxYZYcIN+EiXyR2RipcGSj9En2zK7
         dJ5ud8IgfVjCHHQfSk/G2NSBG1aD8ZYN0UjL7K6JxfxprWg/jmCh3FJwep07Jz1PwTj1
         a/IBA0+5BRLH7Vhgd9ok8Sg59YMiU45tOxGYL8mzlhuZwY4IMot/JDqZHn0N9+eDH+uz
         bk8yl45cUP2YLntcxm0XJ4LJvJsnY+Cgf8eT7XZzeA5IKeErVCYzI21wHhB5uXmXupDu
         Rzow==
X-Gm-Message-State: APjAAAVa/9fs9JpNkWYjTdjbXyer9H3sXSUJqKI8IiieO2lQ9ymlpxyk
        UwvOS+9mhsv7VsiFsL8Bev0yIA==
X-Google-Smtp-Source: APXvYqyYSRUYb1ugPr+PA2M18DdrwhkX5IV3FjKk+sfHRCpVUDQ/fPnQ7D2WX3PZI8HQcUgp3KoyyA==
X-Received: by 2002:a02:bb05:: with SMTP id y5mr25232740jan.93.1561476721092;
        Tue, 25 Jun 2019 08:32:01 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id c2sm11755771iok.53.2019.06.25.08.32.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 08:32:00 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:31:59 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Xdp <xdp-newbies@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: bpf: test_libbpf.sh failed at file test_l4lb.o
Message-ID: <20190625153159.5utnn36dgku5545n@xps.therub.org>
References: <CA+G9fYsMcdHmKY66CNhsrizO-gErkOQCkTcBSyOHLpOs+8g5=g@mail.gmail.com>
 <CAEf4BzbTD8G_zKkj-S3MOeG5Hq3_2zz3bGoXhQtpt0beG8nWJA@mail.gmail.com>
 <20190621161752.d7d7n4m5q67uivys@xps.therub.org>
 <CAEf4BzaSoKA5H5rN=w+OAtUz4bD30-VOjjjY+Qv9tTAnhMweiA@mail.gmail.com>
 <20190624195336.nubi7n2np5vfjutr@xps.therub.org>
 <CAADnVQKZycXgSw6C0qa7g0y=W3xRhM_4Rqcj7ZzL=rGh_n4mgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKZycXgSw6C0qa7g0y=W3xRhM_4Rqcj7ZzL=rGh_n4mgA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:58:15PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 24, 2019 at 12:53 PM Dan Rue <dan.rue@linaro.org> wrote:
> >
> > I would say if it's not possible to check at runtime, and it requires
> > clang 9.0, that this test should not be enabled by default.
> 
> The latest clang is the requirement.
> If environment has old clang or no clang at all these tests will be failing.

Hi Alexei!

I'm not certain if I'm interpreting you as you intended, but it sounds
like you're telling me that if the test build environment does not use
'latest clang' (i guess latest as of today?), that these tests will
fail, and that is how it is going to be. If I have that wrong, please
correct me and disregard the rest of my message.

Please understand where we are coming from. We (and many others) run
thousands of tests from a lot of test frameworks, and so our environment
often has mutually exclusive requirements when it comes to things like
toolchain selection.

We believe, strongly, that a test should not emit a "fail" for a missing
requirement. Fail is a serious thing, and should be reserved for an
actual issue that needs to be investigated, reported, and fixed.

This is how we treat test failures - we investigate, report, and fix
them when possible. When they're not real failures, we waste our time
(and yours, in this case).

By adding the tests to TEST_GEN_PROGS, you're adding them to the general
test set that those of us running test farms try to run continuously
across a wide range of hardware environments and kernel branches.

My suggestion is that if you do not want us running them, don't add them
to TEST_GEN_PROGS. I thought the suggestion of testing for adequate
clang support and adding them conditionally at build-time was an idea
worth consideration.

Thanks,
Dan

-- 
Linaro - Kernel Validation
