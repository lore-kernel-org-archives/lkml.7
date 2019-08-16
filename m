Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32273C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093482133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="iHHkuZ/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfHPOgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:36:01 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:34372 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfHPOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:36:00 -0400
Received: by mail-wr1-f41.google.com with SMTP id s18so1778462wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZl4upPo0jcyESONP7Te6hf7D+lRgiZf13vZuiJH7y4=;
        b=iHHkuZ/iLH/TSkn4kUxE+/EmSlfdLnQYl58oz6pdhYCUlvX99XT0lYs5QTuxLMDqbY
         f+g2sVnLGXIbYQcK9kl99osi/1GlrPp9Prak4+u+XUwJ6/b8XhlK7FmMbBIEv2yJ++BJ
         oI6sZg4C71Zzx/7cYfqyQMiBqvts29M9DUU7WvbnZ3e7NsjglnAfvPPAaU1ZMoAXheKr
         3yqyfz49tP3j4rPTybRU/5uEe+nQ0y0dhf4BepEt540OuHk+xRLVMqTauyRPls+1EDcM
         0ftTTTn0BUPXxpldJZlpIvRUs6FioOt2pDwEYG1XMgS2U98lThi0qVIcUDqADXxDMFnk
         4vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZl4upPo0jcyESONP7Te6hf7D+lRgiZf13vZuiJH7y4=;
        b=pmNzOIzJGR7VBKqn8k4JfJfU+puyz8zxuA2dT/RcVbjBJe6+8E0g+rtnPBirPihM5O
         q0sSVZQa2ijfrinpdFGXqio++7omSueBUEr7hs46SVSrc/M/+rpTkmdarcxjrIBmPMb8
         aA4VJDrWlWdDY+7On0PEukguuF3WBMgviw7N0TXOdqzZ6tb4M3pxKbpwfH804HsIAkxG
         NBnbIMPZgbecLrbqxDkAZ8HoEf6+Ml58KaYGbluw65YUPZ7wYXfdGfRVR+32Vs9iMiLK
         tSJ4YHiopywUfuLOyW1g7ipM5CpkQpcrOkSkuahJcye45+I4daAL+BCD5yTZOZLeZw0H
         zyuA==
X-Gm-Message-State: APjAAAVywrUprYxuU9nikvO/EQ6FFRHA1UIx1+Je+WvPtlo+j1sxkMIc
        hhaiApBEH7iUgpsFipXYeyGxrmDcEm4bMA==
X-Google-Smtp-Source: APXvYqzsBu+mabN5KpqBDXKY6QZZMd2ePKsQQGpyK2tN2sEHcMNA9I+VbU+8hJvig5CXd6knO4mtoA==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr11848142wrq.29.1565966158397;
        Fri, 16 Aug 2019 07:35:58 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.47])
        by smtp.gmail.com with ESMTPSA id g2sm9083357wru.27.2019.08.16.07.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 07:35:57 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the bpf-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190816234613.351ddf07@canb.auug.org.au>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <144b1f43-cd36-9920-fc46-87d98b131e2e@netronome.com>
Date:   Fri, 16 Aug 2019 15:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816234613.351ddf07@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-08-16 23:46 UTC+1000 ~ Stephen Rothwell <sfr@canb.auug.org.au>
> Hi all,
> 
> In commit
> 
>   ed4a3983cd3e ("tools: bpftool: fix argument for p_err() in BTF do_dump()")
> 
> Fixes tag
> 
>   Fixes: c93cc69004dt ("bpftool: add ability to dump BTF types")
> 
> has these problem(s):
> 
>   - missing space between the SHA1 and the subject
> 
> This is dues to the trailing 't' on the SHA1 :-(
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
> 

Hi Stephen,

I made that typo, please accept my apologies :(.

The correct tag should be:

  Fixes: c93cc69004df ("bpftool: add ability to dump BTF types")

Regards,
Quentin
