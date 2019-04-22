Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC86AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCC720859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQxrawuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfDVQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:04:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40155 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:04:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so6018231plr.7;
        Mon, 22 Apr 2019 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kXkiAfTwmCa9p1Avt7HB+P8BjxcnubiRLfnKV0dvTXc=;
        b=nQxrawuXjuOuIl4OmDuQUizpd21r0JiUnbHOwTggTYT5Tk/XgdSTLpxOeAJnHNbG/4
         TfRLNxTz+wzw25maA+pZOQd2TQmo5JLU9tV1oG9tIirC25vZoWNqBq1bhmRXyWKYiRBD
         Xx8J1fl5h4lFelP4Yx+KfY2Qe3PI1/Xb5GwyvspT0L0LREMihWHp6oCO4QEZqrlNFfFB
         /+xDk0Kj8v5xb3ZrwAj57mCTcUe47t4YienfrIQykRBgeKKo8AyIsyZgH9xBKBpNBJrF
         Jlf9uR0hg6ZbvZgtHO4qZCfvUbSfLUEjFoKfiIr1YTD78kD1FsCzYK1eyqUcdLOiJk6e
         5l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kXkiAfTwmCa9p1Avt7HB+P8BjxcnubiRLfnKV0dvTXc=;
        b=hn6RWktBVCmZDCX/mCqjPAc/TUrJQ6sTXV9RLN0pHBbRz0rfRBz1hZVgB7EKqmITuX
         PaDLEGDS7aVIXPvufmH7qYL7hIWXVWkY+xtKF+70csmVZmOV1n3xmLldSbXXINpnPPKt
         1JGRigPI/6OmQmM+VZUXPulwn83zvQKBKKtDf2qAs5/DQ1NtXUU6naKnF63Lnf8Q/X0H
         nTPZyxoI707PaV7td6IMnGpppikAvN9Rxhy2GnECZ2IlP8uenq80Rzi9Kyo771Gnh6nM
         uuNqSbCFTPdoPpTt9XsvdHDsPSCB2LmooMqJfF92dBbJG/zf4QKY3/DyeHjvVvlipVMb
         uxsw==
X-Gm-Message-State: APjAAAXCeYaQwKkjo4GXtbyrUbs28i/X3brom9lyglAvvBYmjXgElZeE
        ICIAKv+XuHlyKRjC84lJX1c=
X-Google-Smtp-Source: APXvYqyIvt+/4LHNtWu9fpcvG27kHSF6uMg8xZm6ZxepckvAgNBs8SDRiZclgMtKRfFtSvBOLabBSw==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32mr18303329plf.82.1555949048266;
        Mon, 22 Apr 2019 09:04:08 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id q128sm19279928pga.60.2019.04.22.09.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:04:07 -0700 (PDT)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     David Ahern <dsahern@gmail.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Julian Anastasov <ja@ssi.bg>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
 <dc7c06ae-204d-c287-04a4-d48875476d09@gmail.com>
 <20190421204126.GA19213@ubuntu>
 <458669e6-3d94-1daf-f80b-3c8d740790fa@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <925fe55a-918e-e899-6f3c-43731712e369@gmail.com>
Date:   Mon, 22 Apr 2019 09:04:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <458669e6-3d94-1daf-f80b-3c8d740790fa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/22/2019 07:58 AM, David Ahern wrote:
> On 4/21/19 2:41 PM, Stephen Suryaputra wrote:
>> Hi David,
>>
>> I looked at patchwork. This patch hasn't been accepted. Is there a plan
>> to resubmit? It is very useful. I had to debug refcnt issues multiple
>> times for my employer.
> 
> I think the inlined versions of dev_put and dev_hold are better for
> performance.
> 
> I could submit it with a DEBUG config to enable. It has been invaluable
> to me over the past 3+ years debugging refcount problems.
> 

Sounds a good plan to me :)
