Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE357C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5FA2578D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+Oh6cI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfE3Kyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:54:51 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46006 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfE3Kyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:54:51 -0400
Received: by mail-ot1-f45.google.com with SMTP id t24so5130196otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H9yxvCBVLUZ22iym/X49g7BmHyoRHVeYfpzhUUaExWk=;
        b=f+Oh6cI/+BXPVeuDxFfHoLSzuWDrYh7O/5x6u6aq/mFFWzISCX7o9nZZYGMesH4+D/
         pQl6V3p5ozIEo6z7k9LdXIqP6UaSSD8yIdtDeBDhdbkoUAXGUzvmuunmn3GR5oUkXhtF
         1jHM5F44DvOIDq4BHcDgpTjBZkA9iMfAE+SQ8kC8CZFSbYow6gEMtObX9AlJlgCHY6TS
         +0E70BJQS/cCiz7H5GdwtmUuKihM+PQMVQsXFBDmMxqDji3sbk6oQ78lafiur047Vrt3
         i293GhbZ2MqJ7zfjDkGVxxCRkC4SIyVNnbhkk7bA3CDz1xQECHp0pBC+b16v3QZwPKHo
         wFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9yxvCBVLUZ22iym/X49g7BmHyoRHVeYfpzhUUaExWk=;
        b=YXGivxz2rLK7TTOQDOLEltWzMt1ad0hnpzY0MJy6h8jk/YDyxoM2pOlUB3jVfGX5se
         6ky137my3CF4ejCVmHEQu1bg33fjps7SUv0Fa8JUUkhCNwLqUtqRTB8Im1W1F7IFkRsL
         YUUuCe9Jy3wjLZtVX7F5PYwHAHAmjwLgzzZoSJ5lKRopgnr0TstU2ZDgIQPR1jWlFTxf
         c+PwxQdiyv1qc5pColMQCjWgblPKO56y+Ijnb7nNB20NE6o09I8nS4pvKMdXsAXcet2N
         as+RMr/kABflnqVEySC7KnXu4oQAvj15OrfuCDXwUMGJNETir/pZlGjKKxnfsvLQSpCs
         +4Mw==
X-Gm-Message-State: APjAAAW61BG7Jahh49IltqoOINuItwzznoVTa/C/ykPDgWKSjzVN6tEw
        YNcIljJmK8hlc6QOjG207rP5ZA==
X-Google-Smtp-Source: APXvYqzrwDU340MtHjWTjnUNSNlrdSArjnqCVKEBR3/2qQV4Yxlwn7OtgMX4ZGuWt7LiDY3MzbBLIA==
X-Received: by 2002:a05:6830:1408:: with SMTP id v8mr2180538otp.48.1559213690489;
        Thu, 30 May 2019 03:54:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id l20sm810412otj.62.2019.05.30.03.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 03:54:49 -0700 (PDT)
Date:   Thu, 30 May 2019 18:54:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
Message-ID: <20190530105439.GA5927@leoy-ThinkPad-X240s>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, May 08, 2019 at 03:19:58PM +0200, Jiri Olsa wrote:
> hi,
> this patchset adds dso support to read and display
> bpf code in intel_pt trace output. I had to change
> some of the kernel maps processing code, so hopefully
> I did not break too many things ;-)
> 
> It's now possible to see bpf code flow via:
> 
>   # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
>   # perf-with-kcore script pt --insn-trace --xed

This is very interesting work for me!

I want to verify this feature with Arm CoreSight trace, I have one
question so that I have more direction for the tesing:

What's the bpf program you are suing for the testing?  e.g. some
testing program under the kernel's folder $kernel/samples/bpf?
Or you uses perf command to launch bpf program?

[...]

Thanks
Leo Yan
