Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B127206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRPSymH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfECXvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:51:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36539 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfECXvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:51:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id w20so3435402plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=/v1v4aNvDfNFfttgsVtzy3kY0RVedl3D8tUljv1zAac=;
        b=iRPSymH8jHPmd2Cicp5YTQszsOxvO1QMb+3XK95xzwov90HZaqbTIrbd61H2dwOnGz
         agxAPDeiU+R4JD5dA5WQcHoxZug8SvLdIvZFBPK8vHG3sqiImhKzoM+FjfMX3yU4egAU
         EggmHi9x0JoP3ZsJln/vx9qKEKQ8e96u4RtP+NuwhWXhzs03bEkDpkwLANmEZJHL3j7v
         ie7G34hqRvMPYoBK3yMTRJnLJJr2b9F7MtZz4zlcDGJ1mcanvL7pFiG4ormKMuYpeFhU
         DdFbYrQhm9fpos1QuT26/ae2DzNPqVWp505liC6Dwj/I+CIkB3nNMHdDh7Q5ksMSyRZA
         VDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=/v1v4aNvDfNFfttgsVtzy3kY0RVedl3D8tUljv1zAac=;
        b=PoPKRAuV1aErQgBQCfU0rlSUP5iiqoGAKtw9e1RT3F54YN8nvOfq/eC+fi6bcHB0BL
         oNToqogNelOcZa95gL2NYz8aqB8M3E9KifNo8ngRrO5ontEwIvD4IypGPO72siQS9Zc+
         hzaVFqECBe+n/JjBxAJnq2Qq+742lXmw9xWJtnqWD6gfhCJwZYm0b8mbIsogS7+lCYvb
         ElSOuYOg6sgmmaTjbneQ7dIG5ewoofBWv1hCdr6OltBGoyq2e1uGADKrfw4r5qZcVF/d
         WV3i5iKzLsQCxkfPPvWFYnlafZb+c6q8U4pvbdaWpl+qLM5WBcK2oX5+9074eMc0cxjt
         aS2A==
X-Gm-Message-State: APjAAAUibXar2+XIiPQ+jnb2L5hCpD3zpqNOX7sK6Jema971V4WFZXlo
        CU7GnbKTAAbWU5t7657dWQU=
X-Google-Smtp-Source: APXvYqwmABD80erTWhOVsPHUb1/g2PQaRG4m6qiLRYfjdYK+RzZAltgX+A78j1TjHssgBeYj1XS6/w==
X-Received: by 2002:a17:902:b605:: with SMTP id b5mr14250755pls.206.1556927503867;
        Fri, 03 May 2019 16:51:43 -0700 (PDT)
Received: from localhost (193-116-98-44.tpgi.com.au. [193.116.98.44])
        by smtp.gmail.com with ESMTPSA id n67sm4618075pfn.22.2019.05.03.16.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 16:51:41 -0700 (PDT)
Date:   Sat, 04 May 2019 09:51:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [tip:sched/core 24/27] kernel/power/suspend.c:431:10: error:
 implicit declaration of function 'suspend_disable_secondary_cpus'
To:     kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, tipbuild@zytor.com
References: <201905032053.KmG848Ye%lkp@intel.com>
        <20190503160458.GF2606@hirez.programming.kicks-ass.net>
In-Reply-To: <20190503160458.GF2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556927451.rwdz1vqk9f.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra's on May 4, 2019 2:04 am:
> On Fri, May 03, 2019 at 08:34:57PM +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sche=
d/core
>> head:   65874bd36e6ae3028539e989bfb5c28ad457368e
>> commit: c2cb30bfceceba8a2a0d5713230a250dd6140e22 [24/27] power/suspend: =
Add function to disable secondaries for suspend
>> config: x86_64-randconfig-l3-05031806 (attached as .config)
>> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
>> reproduce:
>>         git checkout c2cb30bfceceba8a2a0d5713230a250dd6140e22
>>         # save the attached .config to linux build tree
>>         make ARCH=3Dx86_64=20
>>=20
>=20
> The below appears to fix.
>=20
>=20
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -150,6 +150,8 @@ static inline void suspend_enable_second
>  #else /* !CONFIG_PM_SLEEP_SMP */
>  static inline int disable_nonboot_cpus(void) { return 0; }
>  static inline void enable_nonboot_cpus(void) {}
> +static inline int suspend_disable_secondary_cpus(void) { return 0; }
> +static inline void suspend_enable_secondary_cpus(void) { }
>  #endif /* !CONFIG_PM_SLEEP_SMP */
> =20
>  void cpu_startup_entry(enum cpuhp_state state);
>=20

Oops, thanks for that, it looks okay.

Thanks,
Nick
=
