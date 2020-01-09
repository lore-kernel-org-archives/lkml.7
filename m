Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,WEIRD_PORT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3D92067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jdkL7b50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgAIPnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:43:11 -0500
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:43964
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbgAIPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578584588; bh=GynvVWkye0xBlmVu4h0lFCLIMMIFqomtA1dO3a+pU24=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jdkL7b50bhe4ZPwB1uWSJyT7Mn8FnAgfmlDtVUBB4vlPa3tjwMNuQp9dBcl02A0lIz+TiQFANyygwL2l9NDHylN+ke2GQp4pe1u8GYMye4nTGN535suxdOreqr9Wcchf0fT34rQFCHSutt8lQZUSS1b3ZVSSdCi/Znl+GC2+19SlJQQj5zzUTwUdvGdD4hJkGxqnEYWTjzUTDBCSCCfIcRWgMp22SLB3BMgchUCsfvIg1TZjKmhT4QJixoFGFZNTC6eBvLPc0Jv5pZTNdI2dZn+BmttKGQVSz4nIXFgELEQGT6xuehd6aNTU0u8BYhZMxIGImUmxW6qcDDyhB8H/4g==
X-YMail-OSG: IVBCZQ4VM1nx3Tr8w0iUkf9bqb7URPR73qo5zrLjT5VVNBE3b4a3LlBJgVM9J5P
 xpDmTyJrTl2mG9GUu0hvIV4tejemUtfOsUQwOSW98guJmwbN8apfGzFn2RCGHL2xBZp0LUjE7F15
 HknZny0ijrIFPLR6VMwcd2gxWjGzYnVqPrqWrbOLm9oVZbz1h0yQC61VzmhxX_Co94QBVFexamQb
 NsPHk9kwlTx.n7EM56Cvvfe951ASHuMi1LHTDbC1vZFEZ93JdApJykFD20CaPa3IOXlczPN8uXPY
 tMlGCDYgylx6IXJxGzR0c3eD0DN1a3EaioaX9EnG0.DM2yVBUGj9ngTHWf0c8q2fUkNYXvuw7arQ
 U7bgHzaviDR9EoXBem9PJL5jDdmsKeHzswtCTp267UXmG9NWLYEZWQYUQkpTzgSUf.0xwG_kN45L
 2b7zXv2b4st7eDECGx73aJc_7WV8mMSIlr8ZEAyXO8bWQJeymODD11Lruve.K152Lu6XBL9H2Yq_
 NQTct8ax5TJORuxv.hoStW4Z7He1jFXi1S6OnmK8Ykj12p9Di8AfFczFQNNIUqeOKLgwQhhIi4aY
 r9W4oX7kfc1bxrH54AjLf95r4BWJtnIaCnwr1lXZsCZosWw9C0DgOekYzWYEZ4QapC4Saro7K_dc
 bNJvU2zIdmwRWIH8sk.03QyuAtLgnZcE4BBVtpADloeKF6HOwQSk7sZLh6N_8nuzQGj91cgvHwzu
 vHZJBRqCoi_X5oNJ3Mv8P5vxqploWs8WNMpC6j31n.dDzXw07VtK.VrfYagbcbwhrbslEqBMQwVv
 MugtYuIbPmQs.eR3eOxBMc4QhZLcvqBetgYWYDaIkanmBLgKM4hZy1X8ZQTk2YuRqmVfeQcOL.TI
 RGvMBS4aAXOIgINK_FaRlxhwvQvckPGPXvIv09I4ti0bTl5J4e6VQLhrsOBdlaHUBlR1hxGtGUkX
 XWxmAEcmgxQaKIU7ZYbfVxufN.rMskZOA7pNo5y1oNxjrym2DfTVYtP1BhfOb7fglrC3EX5kDKN_
 cyZx55LaowPyCg26XDHMLJqNibvuM_kZ6aKJmokvmGUD7Z5s3nI2bYLWF65FXgU9o6vi.5A_GUdo
 DKsPoKCSFjQ7b..etYrPi80rTr9wSVBXmTmCC71dBbMlLPAEoOQ9XhG4hekxK1zR2Syme8o0YxnR
 nnY6d02fYQ9AdnI7XAf_NGJFKuOAiS0q2rEakfqhBeQDeSDnOJ6vTG0zX1fQBgJO1GiGaJKeJRaK
 i6bD0qsc8VdowBiq4GvvA2SxKKt4KqzeGs1gvvLgx4AVad3IMbmjGnUZScjIKMcfr5TU7eRnqfPa
 kMqAs4kKwaJhb0gNc7zbfRlQLV128bc4AippwDgwIyG8DnCyyc0uV19fSK5hXVXtbwQcWj.3Axyc
 ksfGHrHTA0a19uoNxVTo2jc8ARBZ4.GN6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jan 2020 15:43:08 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b368b29d34131436c200bb3a9f554b09;
          Thu, 09 Jan 2020 15:43:05 +0000 (UTC)
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Dmitry Vyukov <dvyukov@google.com>, Daniel Axtens <dja@axtens.net>,
        Alexander Potapenko <glider@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <00000000000036decf0598c8762e@google.com>
 <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com>
 <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net>
 <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
 <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com>
 <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
 <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <da692bca-79dc-7801-20ff-ca1aae32facd@schaufler-ca.com>
Date:   Thu, 9 Jan 2020 07:43:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/2020 12:50 AM, Dmitry Vyukov wrote:
> On Thu, Jan 9, 2020 at 9:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Jan 8, 2020 at 6:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 1/8/2020 2:25 AM, Tetsuo Handa wrote:
>>>> On 2020/01/08 15:20, Dmitry Vyukov wrote:
>>>>> I temporarily re-enabled smack instance and it produced another 50
>>>>> stalls all over the kernel, and now keeps spewing a dozen every hour.
>>> Do I have to be using clang to test this? I'm setting up to work on this,
>>> and don't want to waste time using my current tool chain if the problem
>>> is clang specific.
>> Humm, interesting. Initially I was going to say that most likely it's
>> not clang-related. Bug smack instance is actually the only one that
>> uses clang as well (except for KMSAN of course). So maybe it's indeed
>> clang-related rather than smack-related. Let me try to build a kernel
>> with clang.
> +clang-built-linux, glider
>
> [clang-built linux is severe broken since early Dec]
>
> Building kernel with clang I can immediately reproduce this locally:
>
> $ syz-manager
> 2020/01/09 09:27:15 loading corpus...
> 2020/01/09 09:27:17 serving http on http://0.0.0.0:50001
> 2020/01/09 09:27:17 serving rpc on tcp://[::]:45851
> 2020/01/09 09:27:17 booting test machines...
> 2020/01/09 09:27:17 wait for the connection from test machine...
> 2020/01/09 09:29:23 machine check:
> 2020/01/09 09:29:23 syscalls                : 2961/3195
> 2020/01/09 09:29:23 code coverage           : enabled
> 2020/01/09 09:29:23 comparison tracing      : enabled
> 2020/01/09 09:29:23 extra coverage          : enabled
> 2020/01/09 09:29:23 setuid sandbox          : enabled
> 2020/01/09 09:29:23 namespace sandbox       : enabled
> 2020/01/09 09:29:23 Android sandbox         : /sys/fs/selinux/policy
> does not exist
> 2020/01/09 09:29:23 fault injection         : enabled
> 2020/01/09 09:29:23 leak checking           : CONFIG_DEBUG_KMEMLEAK is
> not enabled
> 2020/01/09 09:29:23 net packet injection    : enabled
> 2020/01/09 09:29:23 net device setup        : enabled
> 2020/01/09 09:29:23 concurrency sanitizer   : /sys/kernel/debug/kcsan
> does not exist
> 2020/01/09 09:29:23 devlink PCI setup       : PCI device 0000:00:10.0
> is not available
> 2020/01/09 09:29:27 corpus                  : 50226 (0 deleted)
> 2020/01/09 09:29:27 VMs 20, executed 0, cover 0, crashes 0, repro 0
> 2020/01/09 09:29:37 VMs 20, executed 45, cover 0, crashes 0, repro 0
> 2020/01/09 09:29:47 VMs 20, executed 74, cover 0, crashes 0, repro 0
> 2020/01/09 09:29:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:27 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:37 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:47 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:26 vm-10: crash: INFO: rcu detected stall in do_idle
> 2020/01/09 09:31:27 VMs 13, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:28 vm-1: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:29 vm-4: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:31 vm-0: crash: INFO: rcu detected stall in sys_getsockopt
> 2020/01/09 09:31:33 vm-18: crash: INFO: rcu detected stall in sys_clone3
> 2020/01/09 09:31:35 vm-3: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:36 vm-8: crash: INFO: rcu detected stall in do_idle
> 2020/01/09 09:31:37 VMs 7, executed 80, cover 0, crashes 6, repro 0
> 2020/01/09 09:31:38 vm-19: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:40 vm-6: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:42 vm-2: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:44 vm-12: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:46 vm-15: crash: INFO: rcu detected stall in sys_nanosleep
> 2020/01/09 09:31:47 VMs 1, executed 80, cover 0, crashes 11, repro 0
> 2020/01/09 09:31:48 vm-16: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:50 vm-9: crash: INFO: rcu detected stall in schedule
> 2020/01/09 09:31:52 vm-13: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:54 vm-11: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:56 vm-17: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:57 VMs 0, executed 80, cover 0, crashes 16, repro 0
> 2020/01/09 09:31:58 vm-7: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:32:00 vm-5: crash: INFO: rcu detected stall in dput
> 2020/01/09 09:32:02 vm-14: crash: INFO: rcu detected stall in sys_nanosleep
>
>
> Then I switched LSM to selinux and I _still_ can reproduce this. So,
> Casey, you may relax, this is not smack-specific :)

Wow. I wasn't expecting clang to be the problem, just a possible
required condition. I am, of course, quite relieved.

>
> Then I disabled CONFIG_KASAN_VMALLOC and CONFIG_VMAP_STACK and it
> started working normally.
>
> So this is somehow related to both clang and KASAN/VMAP_STACK.
>
> The clang I used is:
> https://storage.googleapis.com/syzkaller/clang-kmsan-362913.tar.gz
> (the one we use on syzbot).
