Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ECCC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE1920578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJtgPvGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfHMS7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:59:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46733 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfHMS7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:59:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id f9so4003166ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0u7BN29CLMZnWfORCWS1hbiMyqbWKAOria45XT6FwOU=;
        b=mJtgPvGBhkUvHoKaycDfPjauZ+0YHZj65HimqLO5OuLOGR3snn7HnQgEaAoDS4vomC
         iU+m0UB3EgfX6iZSeiiQsrHp81onXlmYZIMT9gSwIAIKdWQ+h9Pe9cMsskki2GcA8j51
         kt2UdlZViy6wUGzVsvJlEn8sidFz+Vt7AGOMYI2yp/xaGApOUAbKYDUDhURCMEv4njsh
         16MmIp9a6IfZpMpY5xeIZxYCAh1DfBtb5gBQzeynZEBkOnODLiA/RaDXRZXTOjoTr+c1
         1spfNPE0Qi9kK+Vnkrsoo3NqAW/aq9hh+Umhw7uNMiODUc8ybgfp2scdfLnRdycvxPvX
         TQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0u7BN29CLMZnWfORCWS1hbiMyqbWKAOria45XT6FwOU=;
        b=sJuy9D7/uOT6xptNAkB66cMAAse86Rkbe+o5G/6X4sW06WVhDOkqtnR7VWQlJOJFxF
         qVl7ErOiLpLF3pkSTaTePEz6MhLuhODU3qOcgFKnlZjj3AGInww6ii1ohGMatEg86Kmh
         DddGiN8sXbA5UEBmuXV1e4RTlaV+w/vlna4w23iUtuSFuC4iOb904YSAPzUlvVQxcRPT
         gnuxxhPG0SbQCobAaX/XNJVSUEBlEVAaj3vPVeQ9baZUIfhCySaeUZSDsakg9brAascg
         iqqJgIFGb8EnvDqjflg/vPoR8mRDD2sMdr+YT/+sDHhjEiTICh5mX0saFU3/YyUIWUYL
         KnWw==
X-Gm-Message-State: APjAAAVbT629gojkkQkQAsBeUaIWeYb2pzm2y150DzCynjDfQlFNvWlr
        pZFY5xT0+/bQJR2LGNGVQxRnfQ==
X-Google-Smtp-Source: APXvYqyRXtsoKu9SnfFnRKyYvn6LAfLvigbsl0ZaoJ2liTJsIIoMtB6k54ODKD/0bftwhoAPbedMfA==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr8037467ljc.105.1565722743295;
        Tue, 13 Aug 2019 11:59:03 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id i17sm19868876lfp.94.2019.08.13.11.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 11:59:02 -0700 (PDT)
Date:   Tue, 13 Aug 2019 21:59:00 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Jonathan Lemon <jlemon@flugsvamp.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] samples: bpf: syscal_nrs: use mmap2 if
 defined
Message-ID: <20190813185859.GB2856@khorivan>
Mail-Followup-To: Jonathan Lemon <jlemon@flugsvamp.com>,
        magnus.karlsson@intel.com, bjorn.topel@intel.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
 <20190813102318.5521-4-ivan.khoronzhuk@linaro.org>
 <036BCF4A-53D6-4000-BBDE-07C04B8B23FA@flugsvamp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <036BCF4A-53D6-4000-BBDE-07C04B8B23FA@flugsvamp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:41:54AM -0700, Jonathan Lemon wrote:
>
>
>On 13 Aug 2019, at 3:23, Ivan Khoronzhuk wrote:
>
>> For arm32 xdp sockets mmap2 is preferred, so use it if it's defined.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>
>Doesn't this change the application API?
>-- 
>Jonathan

From what I know there is no reason to use both, so if __NR_mmap2 is defined
but not __NR_mmap. Despite the fact that it can be defined internally, say
#define __NR_mmap (__NR_SYSCALL_BASE + 90)
and be used anyway, at least arm use 2 definition one is for old abi and one is
for new and names as their numbers are different:

#define __NR_mmap (__NR_SYSCALL_BASE + 90)
#define __NR_mmap2 (__NR_SYSCALL_BASE + 192)

, so they are not interchangeable and if eabi is used then only __NR_mmap2 is
defined if oeabi then __NR_mmap only... But mmap() use only one and can hide
this from user.

In this patch, seems like here is direct access, so I have no declaration for
__NR_mmap and it breaks build. So here several solutions, I can block __NR_mmap
at all or replace it on __NR_mmap2...or define it by hand (for what then?).
I decided to replace on real one.

>
>
>> ---
>>  samples/bpf/syscall_nrs.c  |  5 +++++
>>  samples/bpf/tracex5_kern.c | 11 +++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
>> index 516e255cbe8f..2dec94238350 100644
>> --- a/samples/bpf/syscall_nrs.c
>> +++ b/samples/bpf/syscall_nrs.c
>> @@ -9,5 +9,10 @@ void syscall_defines(void)
>>  	COMMENT("Linux system call numbers.");
>>  	SYSNR(__NR_write);
>>  	SYSNR(__NR_read);
>> +#ifdef __NR_mmap2
>> +	SYSNR(__NR_mmap2);
>> +#else
>>  	SYSNR(__NR_mmap);
>> +#endif
>> +
>>  }
>> diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
>> index f57f4e1ea1ec..300350ad299a 100644
>> --- a/samples/bpf/tracex5_kern.c
>> +++ b/samples/bpf/tracex5_kern.c
>> @@ -68,12 +68,23 @@ PROG(SYS__NR_read)(struct pt_regs *ctx)
>>  	return 0;
>>  }
>>
>> +#ifdef __NR_mmap2
>> +PROG(SYS__NR_mmap2)(struct pt_regs *ctx)
>> +{
>> +	char fmt[] = "mmap2\n";
>> +
>> +	bpf_trace_printk(fmt, sizeof(fmt));
>> +	return 0;
>> +}
>> +#else
>>  PROG(SYS__NR_mmap)(struct pt_regs *ctx)
>>  {
>>  	char fmt[] = "mmap\n";
>> +
>>  	bpf_trace_printk(fmt, sizeof(fmt));
>>  	return 0;
>>  }
>> +#endif
>>
>>  char _license[] SEC("license") = "GPL";
>>  u32 _version SEC("version") = LINUX_VERSION_CODE;
>> --
>> 2.17.1

-- 
Regards,
Ivan Khoronzhuk
