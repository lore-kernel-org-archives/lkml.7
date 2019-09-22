Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2719C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7143B20820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VrnFgAt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfIVPbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 11:31:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:56213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbfIVPbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 11:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569166278;
        bh=YoXIXkYV3zE+NhPqBiJ3pF9qGQYXkgsHykXIwc3fGyg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VrnFgAt7KkHcOyMc4ez/CYMrsSym91OgKikLMjwyzILj3xEg7jj6FVb3PdPCjl1S/
         +9ahDtrCqlgUf4ltkLBRheeUboVpRGuutoIKQ7r/n1IYAmRGGdBHyNpFgUOQATCCXX
         ZEV/u6SUNB7N1VDQ/n1fW28+F034PL/t43ndgqW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.42] ([88.152.145.122]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1i5R1B3x4S-01210a; Sun, 22
 Sep 2019 17:31:18 +0200
Subject: Re: threads-max observe limits
To:     Michal Hocko <mhocko@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
 <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
 <20190917153830.GE1872@dhcp22.suse.cz> <87ftku96md.fsf@x220.int.ebiederm.org>
 <20190918071541.GB12770@dhcp22.suse.cz>
 <87h8585bej.fsf@x220.int.ebiederm.org>
 <20190922065801.GB18814@dhcp22.suse.cz>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 mQINBE2g3goBEACaikqtClH8OarLlauqv9d9CPndgghjEmi3vvPZJi4jvgrhmIUKwl7q79wG
 IATxJ1UOXIGgriwoBwoHdooOK33QNy4hkjiNFNrtcaNT7uig+BG0g40AxSwVZ/OLmSFyEioO
 BmRqz1Zdo+AQ5RzHpu49ULlppgdSUYMYote8VPsRcE4Z8My/LLKmd7lvCn1kvcTGcOS1hyUC
 4tMvfuloIehHX3tbcbw5UcQkg4IDh4l8XUc7lt2mdiyJwJoouyqezO3TJpkmkayS3L7o7dB5
 AkUwntyY82tE6BU4quRVF6WJ8GH5gNn4y5m3TMDl135w27IIDd9Hv4Y5ycK5sEL3N+mjaWlk
 2Sf6j1AOy3KNMHusXLgivPO8YKcL9GqtKRENpy7n+qWrvyHA9xV2QQiUDF13z85Sgy4Xi307
 ex0GGrIo54EJXZBvwIDkufRyN9y0Ql7AdPyefOTDsGq5U4XTxh6xfsEXLESMDKQMiVMI74Ec
 cPYL8blzdkQc1MZJccU+zAr6yERkUwo1or14GC2WPGJh0y/Ym9L0FhXVkq9e1gnXjpF3QIJh
 wqVkPm4Two93mAL+929ypFr48OIsN7j1NaNAy6TkteIoNUi09winG0tqU5+U944cBMleRQOa
 dw+zQK0DahH4MGQIU0EVos7lVjFetxPjoKJE9SPl/TCSc+e0RwARAQABtChIZWlucmljaCBT
 Y2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXguZGU+iQI4BBMBAgAiAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCVAqnzgAKCRDEgdu8LAUaxP7AD/9Zwx3SnmrLLc3CqEIcOJP3FMrW
 gLNi5flG4A/WD9mnQAX+6DEpY6AxIagz6Yx8sZF7HUcn1ByDyZPBn8lHk1+ZaWNAD0LDScGi
 Ch5nopbJrpFGDSVnMWUNJJBiVZW7reERpzCJy+8dAxhxCQJLgHHAqPaspGtO7XjRBF6oBQZk
 oJlqbBRFkTcgOI8sDsSpnsfSItZptoaqqm+lZpMCrB5s8x7dsuMEFaRR/4bq1efh8lSq3Kbf
 eSY59MWh49zExRgAb0pwON5SE1X9C84T2hx51QDiWW/G/HvJF2vxF8hCS7RSx0fn/EbPWkM6
 m+O1SncMaA43lx1TvRfPmYhxryncIWcez+YbvH/VqoLtxvz3r3OTH/WEA5J7mu5U1m2lUGNC
 cFN1bDsNoGhdlFZvG/LJJlBClWBWYHqHnnGEqEQJrlie9goBcS8YFUcfqKYpdmp5/F03qigY
 PmrE3ndBFnaOlOT7REEi8t3gmxpriTtGpKytFuwXNty1yK2kMiLRnQKWN7WgK70pbFFO4tyB
 vIhDeXhFmx6pyZHlXjsgbV3H4QbqazqxYOQlfHbkRpUJczuyPGosFe5zH+9eFvqDWYw2qdH+
 b0Nt1r12vFC4Mmj5szi40z3rQrt+bFSfhT+wvW9kZuBB5xEFkTTzWSFZbDTUrdPpn2DjYePS
 sEHKTUhgl7kCDQRNoN4KARAA6WWIVTqFecZHTUXeOfeKYugUwysKBOp8E3WTksnv0zDyLS5T
 ImLI3y9XgAFkiGuKxrJRarDbw8AjLn6SCJSQr4JN+zMu0MSJJ+88v5sreQO/KRzkti+GCQBK
 YR5bpqY520C7EkKr77KHvto9MDvPVMKdfyFHDslloLEYY1HxdFPjOuiMs656pKr2d5P4C8+V
 iAeQlUOFlISaenNe9XRDaO4vMdNy65Xrvdbm3cW2OWCx/LDzMI6abR6qCJFAH9aXoat1voAc
 uoZ5F5NSaXul3RxRE9K+oWv4UbXhVD242iPnPMqdml6hAPYiNW0dlF3f68tFSVbpqusMXfiY
 cxkNECkhGwNlh/XcRDdb+AfpVfhYtRseZ0jEYdXLpUbq1SyYxxkDEvquncz2J9urvTyyXwsO
 QCNZ0oV7UFXf/3pTB7sAcCiAiZPycF4KFS4b7gYo9wBROu82B9aYSCQZnJFxX1tlbvvzTgc+
 ecdQZui+LF/VsDPYdj2ggpgxVsZX5JU+5KGDObBZC7ahOi8Jdy0ondqSRwSczGXYzMsnFkDH
 hKGJaxDcUUw4q+QQuzuAIZZ197lnKJJv3Vd4N0zfxrB0krOcMqyMstvjqCnK/Vn4iOHUiBgA
 OmtIhygAsO4TkFwqVwIpC+cj2uw/ptN6EiKWzXOWsLfHkAE+D24WCtVw9r8AEQEAAYkCHwQY
 AQIACQIbDAUCVAqoNwAKCRDEgdu8LAUaxIkbD/wMTA8n8wgthSkPvhTeL13cO5/C3/EbejQU
 IJOS68I2stnC1ty1FyXwAygixxt3GE+3BlBVNN61dVS9SA498iO0ApxPsy4Q7vvQsF7DuJsC
 PdZzP/LZRySUMif3qAmIvom8fkq/BnyHhfyZ4XOl1HMr8pMIf6/eCBdgIvxfdOz79BeBBJzr
 qFlNpxVP8xrHiEjZxU965sNtDSD/1/9w82Wn3VkVisNP2MpUhowyHqdeOv2uoG6sUftmkXZ8
 RMo+PY/iEIFjNXw1ufHDLRaHihWLkXW3+bS7agEkXo0T3u1qlFTI6xn8maR9Z0eUAjxtO6qV
 lGF58XeVhfunbQH8Kn+UlWgqcMJwBYgM69c65Dp2RCV7Tql+vMsuk4MT65+Lwm88Adnn6ppQ
 S2YmNgDtlNem1Sx3JgCvjq1NowW7q3B+28Onyy2fF0Xq6Kyjx7msPj3XtDZQnhknBwA7mqSZ
 DDw0aNy1mlCv6KmJBRENfOIZBFUqXCtODPvO5TcduJV/5XuxbTR/33Zj7ez2uZkOEuTs/pPN
 oKMATC28qfg0qM59YjDrrkdXi/+iDe7qCX93XxdIxpA5YM/ZiqgwziJX8ZOKV7UDV+Ph5KwF
 lTPJMPdQZYXDOt5DjG5l5j0cQWqE05QtYR/V6g8un6V2PqOs9WzaT/RB12YFcaeWlusa8Iqs Eg==
Message-ID: <f1b89360-a70c-0a30-6a7b-9bafe74701ed@gmx.de>
Date:   Sun, 22 Sep 2019 17:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190922065801.GB18814@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hZ0/oPh8BMsNwmO8NIgDcfjBBcKM/vGKsBdPf05+6x+g7BGA1FV
 MuTbuT+CG1J0eut7CP5I3ofCfyFcRCIubspj/EFE0+LAvzcq48N66/obpuHykF1Cqgin6Xk
 PjcPQ+qcR7XGAE29qJ1lDICgSU8wevT459om3ZN3Twr8nZGT2lLu7+s6b32dDIBo94rTfhN
 J383YhZfwgQ3eMlhl8pRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ciKWOFGbqc=:z/cFftQ6FgJel4DWezQvdA
 xq3tFXI6KKiehVS4ny30fSzQWwwCjifgNUDeIqoKug4JGR3BXvbv+Ar0JrGek8KlYvpFK2LIo
 xJKNMmflzFtKn9TXeWaPEKYVI2flttAA7TLmIMfiS8R5wm46dzDzKl8U7GNnBuzFrmjwwa56K
 vf9Gv1tShPbe2vaO/9fGRqY4detwbCJlpIEzjJp1MUpZKeRWultR5ZBjP6b80HG4yoto/01JC
 U2skceHBhV1XGDWIEYqJWvqBtlROcIs84/iqHn45ww85hYsGyjkS83PSCXTcgs6bXoJIOcohc
 lnGr/0S67BJSgUVrjZc98ulbiWFZs9sOT7ikEKVG6s8vM3rIGqLB9Sgv8Sf2as/R7mPHWny5f
 3G2m8eqmcmfXZrGNJMYd6N7oxxnpz4EZzyZdqVO+1tr5arJ4Q1E/H9QYRvYmHdQGPoDHuTsos
 nFrLmprr1/036hGfEp5pQXiMDSIliHFWP0YP1T+bFJEdxzuRAY8u+jPqnYTRfOJ+Ripss0bNm
 waRCI7YQDZG49eg8xmV2bp2NMz3ZNPK+ty9LkEu1AhNpQthLj6HLdEIptI9a1ns85e/dfjGz9
 9J8p+t5MJF/I75AjLhU4+81nl7HOO6KfQzVoYb7NkS4LFumXAPBUzWYQ7VKLFGTB/gbaow6U5
 kFMDamTGxlqUYnByVzv7CHuO11ZMqCAT8wfKquAENI0NBXpbloIxOV9jznGzf0HsmqaQ+N5Xz
 zHtj9/rEUw2r+cTTk3AVELwp+PNTm36CXSMzwo9XEZUvtt3uqw6UnTXsM8iPI6CCpRet0G00h
 GFW6m6lkC4jSZnTLxGA6GNEGB6WgUBS0I2dJJ3DIDNGLdmFYWv0gqeqMHXGye+OLfz7Uf9QCg
 pWs1OymsaObGFobWqxByPGggVaIiZ/b9bsE+ru7B4+fFCfAO+7x81RzYCCXMdQjS9hUkda9s9
 wExjK99RW8B1yLCFIxilhldNfGxG/16nJBR2E1OqRw6W6WqJAtxf3HQ2DWJdRHUEB/dYdBtxv
 fYfMjXyggBYmBOv4tq9REpj4G/blpnZpELYyh/PGSZPe2fBPkEEfvHYTlON0I3yqf9/lUHhGL
 ySa8x49NTk3p8ELl0KHzvJiQh184924yILALD6SfB2+oUrKMdJkxiEUt11fCMPWpJXEWdR2oB
 hNluL8aCkZDfDfTvVaLmXsl5auCDoAzi9LpREbLEaQia7lKlwZMBPwges0lbDpCnvZCpBSdTW
 14Bq5YCtbo++sAGEVRnUkY5QF7cfO55nV3VOVgF7HxYm3TP11+mmERkIPz8M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/19 8:58 AM, Michal Hocko wrote:
> On Thu 19-09-19 14:33:24, Eric W. Biederman wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>>
>>> On Tue 17-09-19 12:26:18, Eric W. Biederman wrote:
> [...]
>>>> Michal is it a very small effect your customers are seeing?
>>>> Is it another bug somewhere else?
>>>
>>> I am still trying to get more information. Reportedly they see a
>>> different auto tuned limit between two kernel versions which results i=
n
>>> an applicaton complaining. As already mentioned this might be a side
>>> effect of something else and this is not yet fully analyzed. My main
>>> point for bringing up this discussion is ...
>>
>> Please this sounds like the kind of issue that will reveal something
>> deeper about what is going on.
>
> Yes, I have pushed for that information even before starting discussion
> here. I haven't heard from the customer yet unfortunatelly.
>
>>>> b) Not being able to bump threads_max to the physical limit of
>>>>    the machine is very clearly a regression.
>>>
>>> ... exactly this part. The changelog of the respective patch doesn't
>>> really exaplain why it is needed except of "it sounds like a good idea
>>> to be consistent".
>>
>> I suggest doing a partial revert to just:
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 7a74ade4e7d6..de8264ea34a7 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -2943,7 +2943,7 @@ int sysctl_max_threads(struct ctl_table *table, i=
nt write,
>>  	if (ret || !write)
>>  		return ret;
>>
>> -	set_max_threads(threads);
>> +	max_threads =3D threads;
>>
>>  	return 0;
>>  }
>>
>> proc_dointvec_minmax limiting the values to MIN_THREADS and MAX_THREADS
>> is justifiable.  Those are the minimum and maximum values the kernel ca=
n
>> function with.
>
> MAX_THREADS limit makes perfect sense because crossing it reflects a
> real constrain for correctness. MIN_THREADS, on the other hand, is only
> the low gate for auto tuning to not come with an unbootable system. I do
> not think we should jump into the admin call on the lower bound. There
> might be a good reason to restrict the number of threads to 1. So here
> is what I would like to go with.

Did this patch when applied to the customer's kernel solve any problem?

WebSphere MQ is a messaging application. If it hits the current limits
of threads-max, there is a bug in the software or in the way that it has
been set up at the customer. Instead of messing around with the kernel
the application should be fixed.

With this patch you allow administrators to set values that will crash
their system. And they will not even have a way to find out the limits
which he should adhere to. So expect a lot of systems to be downed this wa=
y.

Best regards

Heinrich

>
>>From 711000fdc243b6bc68a92f9ef0017ae495086d39 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Sun, 22 Sep 2019 08:45:28 +0200
> Subject: [PATCH] kernel/sysctl.c: do not override max_threads provided b=
y
>  userspace
>
> Partially revert 16db3d3f1170 ("kernel/sysctl.c: threads-max observe lim=
its")
> because the patch is causing a regression to any workload which needs to
> override the auto-tuning of the limit provided by kernel.
>
> set_max_threads is implementing a boot time guesstimate to provide a
> sensible limit of the concurrently running threads so that runaways will
> not deplete all the memory. This is a good thing in general but there
> are workloads which might need to increase this limit for an application
> to run (reportedly WebSpher MQ is affected) and that is simply not
> possible after the mentioned change. It is also very dubious to override
> an admin decision by an estimation that doesn't have any direct relation
> to correctness of the kernel operation.
>
> Fix this by dropping set_max_threads from sysctl_max_threads so any
> value is accepted as long as it fits into MAX_THREADS which is important
> to check because allowing more threads could break internal robust futex
> restriction. While at it, do not use MIN_THREADS as the lower boundary
> because it is also only a heuristic for automatic estimation and admin
> might have a good reason to stop new threads to be created even when
> below this limit.
>
> Fixes: 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
> Cc: stable
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  kernel/fork.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2852d0e76ea3..ef865be37e98 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2929,7 +2929,7 @@ int sysctl_max_threads(struct ctl_table *table, in=
t write,
>  	struct ctl_table t;
>  	int ret;
>  	int threads =3D max_threads;
> -	int min =3D MIN_THREADS;
> +	int min =3D 1;
>  	int max =3D MAX_THREADS;
>
>  	t =3D *table;
> @@ -2941,7 +2941,7 @@ int sysctl_max_threads(struct ctl_table *table, in=
t write,
>  	if (ret || !write)
>  		return ret;
>
> -	set_max_threads(threads);
> +	max_threads =3D threads;
>
>  	return 0;
>  }
>

