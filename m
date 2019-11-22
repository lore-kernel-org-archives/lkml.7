Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B33C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC5F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hKlrfXpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfKVTvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:51:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:38899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfKVTvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574452266;
        bh=L29OLBT+tru+BdFXCdEH+CgR6TFlGQgZY+brgWyp24A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hKlrfXpJlzCuLyfu+4hBvZvNZGZTk2cSRD5SFjWd6pufd2NG5Xw/PEMCtlF02HkMM
         UMTU1ov6nnSbmBTvKX4gzEaCxD9fw5awWS7+EYQjbfyQos34kGDjf/Ec2SrZMJVhOd
         O532swIfGCChNTvRb/ZtO4MivYB1mOBkzZ34q0kk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.200]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1iaNc13a7E-00FWZU; Fri, 22
 Nov 2019 20:51:05 +0100
Subject: Re: [PATCH 06/12] parisc: Replace cpu_up/down with
 device_online/offline
To:     Qais Yousef <qais.yousef@arm.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Richard Fontana <rfontana@redhat.com>,
        Armijn Hemel <armijn@tjaldur.nl>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-7-qais.yousef@arm.com>
 <20191120110933.wjtmpc4pmqmxhmma@e107158-lin.cambridge.arm.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <057185a2-e876-4237-c0bf-8754d302fdfc@gmx.de>
Date:   Fri, 22 Nov 2019 20:51:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120110933.wjtmpc4pmqmxhmma@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TjjoncP5rrfchomn+mBut45SywhKYItfA29irUHYTgFU3WpTX5u
 i7IjKap+NYc8HqNvLbwWpC0dTBn5tNzYkwivBjqi+C1uLgRIhYBMnvfNMKttMX+LyIKhe6e
 C1SFVZaMx6NuQe5hjCYS+47xag+QuBza9QqcRb4Lzok+O2CbpgOwhmfvQYpBfpTPXSXS54n
 Nz1ou2HsFM5iT/epOpZ9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:skMMlvcopGA=:YRugpkzyzlzFqc3w60qasE
 AZ+tCQTcSDrjV0BtfUsx/5relNatpWrah7blvHbQ9NakY/xurl8UuuG8Q4kgRaDBYjium/0aO
 2/AfsfmR+UEZVWLxspls8EQAGUqs6QYZmSRV4ylNlYDNLc2lS0V5hl4TXSbP7J4PrXv5cXQwL
 btCoBW3NGvHfYXwNwi6/O40c2WblGz8JublOxmNV4PhzPDnXIsd5/vdu54gsCcq1oDeeB3mDi
 Py5yAUYrtd9QHk/8bk3QDIwCf8+z/m2JoT9tbNhVzfdVY8TZ3akSMbcA32VTdMFSX8xNCRogN
 H23eSm65tojcCCi6s2rxM7/UfAD/jLFHAxi+oGVqd3RKcBYX/LTHOwlMnnqvTXpwIwsDm4c3F
 GJ6NpmRLvmYzJxqiDxGQmyfBbWXvsrk9K8CHMXMnh/SU2/h5/dCWbzVnRPy6/GTwrSn+gTPw7
 zd35bXmhmgcfApcjrMyvforH4tiS5l/hn1v8/7Zmh9C6Mvt9TIlK2UY2i40krHIZxEucC0dWO
 f5q85uqtgh6OOWQimLORyyazwW90tCpiRYuAudrurZ1nrRrJcJN8KVJDm3AWN6rGAKvc0jQCW
 vf/9kV1uGf5g9fG+SjonoRqoPs0YRdrfsPU+ibJzWBYIE4AtvuzKMUO9PTl2ftkYkbYAnmUyz
 DRcGtkosCLRDKwkv+bM3bISwW8UmqjgBGXtVMjtIrVZ3lDAD5F8cfsAB7noDQZndKlLYwyiz4
 ySZ7QBKmZB1LChpklwaEKL2e5a+HPEvgO3IQGuYAoCmazqTUZ7ivGCf11lMlkqbU+bzC4XgqA
 PRP1vOpY6wRXNMkdzIFD2tKGe+Qnb3E/P94hBbwOlGCAvF1X4bsfVGQrPEtM12HLvOXwueEcx
 kwIYt9Gf9NZDOO+RRh6mRmDPd42tgJQTyXEbwl6JkC3kZsDnRDzYGPXtn4DozK1vIuoOONYhC
 CjVSU3hZwFCrqpj+LrVHU68Y2suSf762vNl2SyziK2Sj8GTxHkuJyR2bf8g8mVVYY9Xvo+SHB
 QR9XZci4/k6T0agDDXQxn5eqeUA4IthbF2tJgs92tZtgo1pLQn/95Nt2vmHZd1uJNwf6vzPk0
 tx/bs21x3zd54oyfbFmX9yAs3yPQJqW7+BC4KiG6KRlRki3bNdbKKhTctqC4cBkKo/S/lB77H
 AJk1gr2qmOZjXwu6Hkn04q9ABqALi7FD/7R6A1vztPPraHJJfTVGUdKsCsPY1QrBq3G5quClk
 E68EM+wKg1tC27SsWU/7x34o0X8L8QbtSzdjmcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.19 12:09, Qais Yousef wrote:
> On 10/30/19 15:38, Qais Yousef wrote:
>> The core device API performs extra housekeeping bits that are missing
>> from directly calling cpu_up/down.
>>
>> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
>> serialization during LPM") for an example description of what might go
>> wrong.
>>
>> This also prepares to make cpu_up/down a private interface for anything
>> but the cpu subsystem.
>>
>> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
>> CC: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> CC: Helge Deller <deller@gmx.de>
>> CC: Richard Fontana <rfontana@redhat.com>
>> CC: Armijn Hemel <armijn@tjaldur.nl>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: linux-parisc@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> ---
>>
>> Couldn't compile test this one.
>>
>> I'm not confident that this is a correct patch to be honest. This __ini=
t
>> indicates we're booting the secondary cpus and that might be too early =
in the
>> process to use the core API..?
>
> Helge, James
>
> Do you have any comment on this? I have no means to test it and I'd
> appreciate if you can spin it through one of your systems.

I pulled your cpu-hp-cleanup branch from git://linux-arm.org/linux-qy
and compiled a 32- and a 64-bit parisc kernel.

I faced one compile warning:
linux-2.6/kernel/cpu.c: In function =E2=80=98hibernation_bringup_sleep_cpu=
=E2=80=99:
linux-2.6/kernel/cpu.c:1237:1: warning: control reaches end of non-void fu=
nction [-Wreturn-type]

Other than that the 32- and 64-bit SMP kernel booted nicely.
You may add to the series:
Acked-by: Helge Deller <deller@gmx.de>   # parisc

Thanks,
Helge


>>
>>  arch/parisc/kernel/processor.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/proces=
sor.c
>> index 13f771f74ee3..4dde5fe78f0c 100644
>> --- a/arch/parisc/kernel/processor.c
>> +++ b/arch/parisc/kernel/processor.c
>> @@ -212,7 +212,9 @@ static int __init processor_probe(struct parisc_dev=
ice *dev)
>>  #ifdef CONFIG_SMP
>>  	if (cpuid) {
>>  		set_cpu_present(cpuid, true);
>> -		cpu_up(cpuid);
>> +		lock_device_hotplug();
>> +		device_online(get_cpu_device(cpuid));
>> +		unlock_device_hotplug();
>>  	}
>>  #endif
>>
>> --
>> 2.17.1
>>

