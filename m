Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FFC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F22184B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mLIyO2y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEKWI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 18:08:26 -0400
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:44735 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbfEKWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1557612504; bh=sVwX4Pbfsm9Uj9dzX0wgQUbE125Ae2WKACxSBlL18uM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mLIyO2y+0hf+tMf08WsNSspCjkvy/eujQBOD9Np9spL9tvaQ5VpLT3X41qYJ6rqag/SX5jfVJalTRHw7L/dfOsdFju/c6HiWJtZIlBcV2DVhS3LPy3Vkb55Iwfh4/9UVxZyFahyNB+DNt0DOj2obyD15t9tqeK+yfIeMP5zEIThfrMycWR75kZMi72/Okt6YWD+ygLeAN8+kV/UJoKyCMayDfJmvpGu+SRKPvmTC375S7JeZMDYxUutYvuE8lOhElDrGkOw+oVWNx+IbxZ3l4nINTlMBC0aPfmdSCFWHmWWUtsBCWFVJ0OtVX7xj0Hih0VEvu5ZW/lPUrcs+jv5IWA==
X-YMail-OSG: ET_0JFYVM1mGTvVnpqtxwdc0ELvATxbKogTCBvQCzVy35Szp0cIPZojhdHVPHuL
 QiKRUGrrWIK94HpWvEiHk8XYLyGAjPmww7HIcSIB90hbCZ1nfhYLEAR3Dhm3OmNiuxz0giDnv2wq
 6h_PsfkXUIiVBZUHMBRczQnwsO4SmP4P3.uo8226rn1KxCVzXsxQW6kIFX1.4ExpzzsSBhVnKC3c
 IUpevFKflaeAIkqxoOgxLYzx5c6zQV6BaNZqPwwW9rj_rC.awj4HeslhuvXyIuu1.IVgDlfZ9Tjp
 AtsLzmLxltsFJ4Lb23tDIf75zUZbwJerlrCIXS18rquMieacBywIMEAwhxUKXszD65slnQGrnKqE
 4iu16exxfVHLu0aLgb4xmxgnkKMzbZstC7Wcx..vT5PY_2bDIZ6ZT41BPsfpIlHOdDmeT3t.vs.g
 l4kMb9USU3DAh7ba9a8vNoJL7hws8yIRlojUo1UdMCLYmoseQ_48A57NlhqPJRbJf2uH6Mpi08pB
 hku6MXdoZ_W4pKWJ46lwQJo59zthHwE4ueiyBksShjhAvB5KdQ7OIZXXTl1OBaOxhonCKDelu5Dh
 ONiYL1dKPP_ZP.YJhkBZrxEh4c9DAxDHbkx9W4y7WJD.z4i6_GJ8WiT5OlqlpCWN42GWhzVYBAV8
 .r23iMCg8MLoYCfyakCruPAGLgd9_k1rYxuWecrPBFeMFHIz0vK3cydVLfHVBjXagMqJd2cJ.W7J
 iMSBxdYY1cjZ03NaXZY2ju0ATd3Xo1xqUfzVVWorAzI5dxUb0TL0V6JZ4_ydniGfKeURzSHdjDDs
 W_B28q53izGN6rIuGlBEuPWXR4zakerVGauSt.fzCR7B3UjyljoY.YmCBZ5tOdfTfn60OQ6LNbE7
 diXGn1lq1PmAOrGf6_v1K8lJ9Bxf38UpD7rNOFNatnQNovTx5pL2bdLNUoAbsYXd.xooMJV9gada
 5ydGLcDg6D83Evmiv2vQzmTpou0hFoeXW5jP70b3g7oRsReMgypj3JX8SpRY3u4VCbyW9cafVDug
 tuERVjNSF6qxZM_spWHFUWoHivgvFY_Dwxy_GNheYq2gb_SECn9pcEUgTV8.GAyrp_v2gp4Dvnrm
 6d0uDMErAwurCyZajfhpRCQ5b5s_ZTX4WAQnO0VA2bKxPi0aYzxZjEI7XqTxsAuhVt0zqEW.IT1B
 RNFYYCk8Rs0ipXhMCkJxA2lW9qjTv8pR5HXlH91bo0s50JiPnXM93sc9E.WFnoPk3r8ztT8.UMhp
 AyOXqe8VxoNmKCfj0HTq4R2E-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 11 May 2019 22:08:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 89f668ca3f757c7aa6565c3d3f390d4e;
          Sat, 11 May 2019 22:08:20 +0000 (UTC)
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
To:     Paul Moore <paul@paul-moore.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        casey@schaufler-ca.com
References: <alpine.LRH.2.21.1905110801350.9392@namei.org>
 <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
 <CAHC9VhSSwYk6isqz8N3nOO_O17C30E2EyCHKf5OqsdESeMoT7g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <24d602d2-a1a7-7b1e-9035-a2d732cd822b@schaufler-ca.com>
Date:   Sat, 11 May 2019 15:08:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSSwYk6isqz8N3nOO_O17C30E2EyCHKf5OqsdESeMoT7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2019 11:13 AM, Paul Moore wrote:
> On Sat, May 11, 2019 at 10:38 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
>>> These patches include fixes to enable fuzz testing, and a fix for
>>> calculating whether a filesystem is user-modifiable.
>> So now these have been very recently rebased (on top of a random
>> merge-window "tree of the day" version) instead of having multiple
>> merges.
>>
>> That makes the history cleaner, but has its own issues.
>>
>> We really need to find a different model for the security layer patches.
> If it helps, the process I use for the SELinux and audit trees is
> documented below.  While it's far from perfect (I still don't like
> basing the -next trees on -rcX releases) it has seemed to work
> reasonably well for some time now.
>
> * https://github.com/SELinuxProject/selinux-kernel/blob/master/README.md

On the whole this looks fine to me. I am less comfortable than Paul
is regarding changes that happen elsewhere, so I would be more likely
to base in the rc-1 than Paul. More developers test with SELinux than
Smack. I am in the process of putting an appropriate GPG environment
together for 5.3.

The LSM infrastructure work I've been doing should still go through
James, as it has global implications.

