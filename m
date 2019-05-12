Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7276C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72532146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="CKf756Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfELG3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 02:29:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43783 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELG3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 02:29:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so5067537pgi.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pSWMt1O9RyRNp2R37obyg4EhfrggGYCpcdG8qEUd4/w=;
        b=CKf756SiRXeuNuJY5MCR440JDY0r/+ZbV+fmGloYC2vXpaJyT/W27LoJbDNwfzR4GQ
         0QjWahoJm+onBpzCptev7pIaQJ9YlLdaUR7mP1k/ZJCO9GL97fAU0dGj9MIuL8NPTjW0
         wVvy/KSOxZaznitl9ALWJGLTLFYMZN/OrKOjD90iROk6Y/NIP4X3TH0gxmuvg/EXXof7
         Cw2EjPaLTDIlTkAGW/+EjA4OukxKfRsSeHhQuh8mZFBDxgZiQYPTJxoQaLvtwyUnTkut
         BQSUmV1yieB7+26nVd4cj1T0gN70hi0WZaQaaBbl4/qCCwhrweUgpBeuDsHy/Vht8PMq
         S7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pSWMt1O9RyRNp2R37obyg4EhfrggGYCpcdG8qEUd4/w=;
        b=kXwvh3NMhbFdFdxUUtjuwnmmA3uf7wnPkk1+G7dgtDYcMLpx/wcYHGrnK0vAjjFApt
         LhqOwx+oKPp5MyWIRuOkTsONBNbTnu28Qe+0+w+bcsX8LbdDU2Uf7fYf1WTZw6DBDSka
         D2US02TkHqzTCAeqo9C7uITC2i/oLmnUCVKo6jr9gNkJrWNq/Drvdj4zt1JfHRkrMMAb
         O+/5cpwLKW2oTn7bbmaz2srCKkdyZP7VHn7eniZ7bD72y73pk6clSwmR4sITWJzZdN7B
         +Kf2nVg7zv1bwzuzuA4uRU/+RUflPNpNZEzH5QQXI9QWR8eKBV/ePe7hSlbp/BFr4QyS
         1JlQ==
X-Gm-Message-State: APjAAAUJmRnzBVa94jV096ysz7IU4rmsn3HJ6LvKpYhfwJthnbVbytfr
        kxqV9SL2Oh6iIB4UmL1b4vZrmA==
X-Google-Smtp-Source: APXvYqxprQsC0AXWjoX8Vnk2CDqxAQBeXRlCaMTi7hz2pRnNfQMIUWZqND2vSYrCfrN6LqxCvng/yw==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr26678309pfb.2.1557642549622;
        Sat, 11 May 2019 23:29:09 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id v1sm16037213pgb.85.2019.05.11.23.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 23:29:08 -0700 (PDT)
Date:   Sat, 11 May 2019 23:29:07 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests: bpf: Add files generated when compiled to
 .gitignore
Message-ID: <20190512062907.GL1247@mini-arch>
References: <20190512035009.25451-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512035009.25451-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Kelsey Skunberg wrote:
> The following files are generated when /selftests/bpf/ is compiled and
> should be added to .gitignore:
> 
> 	- libbpf.pc
> 	- libbpf.so.0
> 	- libbpf.so.0.0.3
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  tools/testing/selftests/bpf/.gitignore | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 41e8a689aa77..ceb11f98fe4f 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -32,3 +32,6 @@ test_tcpnotify_user
>  test_libbpf
>  test_tcp_check_syncookie_user
>  alu32
> +libbpf.pc

[..]
> +libbpf.so.0
> +libbpf.so.0.0.3
How about libbpf.so.* so we don't have to update it on every release?

> --
> 2.20.1
> 
