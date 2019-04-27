Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA1C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902862087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghyKR+jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfD0Xwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 19:52:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36844 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfD0Xwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 19:52:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id w20so2657148plq.3;
        Sat, 27 Apr 2019 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kc5ZOqDYTaWLHCWQm/ywH7ZTUELxqFoRaRpFMKkK8po=;
        b=ghyKR+jnS7+IWnBGrAW2c/z/NF8WGJ/VgD+oHIKPH7SW6PO1vbc2B+rKFYol+7AIEL
         0DMZQPuVjbJX72O9AIIHhRLYhtC2sb8GX52RgM0KDE43+MzMn5wN+Z0TjUBt/es48E/L
         2cVVR4KNtlgoz75kE9ZCSJIOvNahCC6yqSpZPqMXZyoCA6UPc2UajfLClp+QhQGtWGRa
         PFsLSORaNmjKZoa1TgrtM4qV7W3sr/xAW/SkA0+IMs9RBR0ljFTX5owU4Q4KjOjHNJYz
         ZDqjp/OexXCCANqLtPfoOu3SB7m5mFHMlH4dOJg4UAEFmZwVtXRYw+7IQGMFLbAYzlY5
         XgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kc5ZOqDYTaWLHCWQm/ywH7ZTUELxqFoRaRpFMKkK8po=;
        b=NybA0mcyclksOFeGJGLtpp83CXllO9zTFPK06KH1ew1xlHXcA0v0babNb9tDJjCyxC
         PZTimiiYxXCxzZK7KR3JvpUHkRHB46/c+PVAxsugWrAwH91gnU6ELh4Q1xZwB+41BsL6
         cQGpslRG6OeWJ6/wkDCJpn1R44iyfWI2o654D8pkqfxIkh+fg1dNPuU5SAI0KEJw08sT
         Jcimgx3g+CVnvahOAbNUYT7iq4PYNaTsOWcH4v4dhjC7hQqFrFqae1kalJ5Ctbb94EzD
         wval7V/ywNQ5yIlTVWhI2O64x2ljV8L8K2hUdMUm53l0yTgXqfNI875JtjxfTVEf3vBJ
         C20A==
X-Gm-Message-State: APjAAAVMbGVe4lrB4f9m9xaMe+QURXdwZFDE/I7A5OhdYugEv3HZkXCs
        VNaS/wVWBTPjSK4CplB/ROw=
X-Google-Smtp-Source: APXvYqxvqI6px1PYLTcLpGNbjcWrwhi8rggYKjbd69J+qRrfgNlCoBuzGxJRHLOK5MvU9xrxdrHEWA==
X-Received: by 2002:a17:902:7d91:: with SMTP id a17mr53997399plm.338.1556409154295;
        Sat, 27 Apr 2019 16:52:34 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id i15sm43975343pfr.8.2019.04.27.16.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 16:52:33 -0700 (PDT)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
 <9d430543-33c3-0d9b-dc77-3a179a8e3919@I-love.SAKURA.ne.jp>
 <920ebaf1-ee87-0dbb-6805-660c1cbce3d0@I-love.SAKURA.ne.jp>
 <cc054b5c-4e95-8d30-d4bf-9c85f7e20092@gmail.com>
 <15b353e9-49a2-f08b-dc45-2e9bad3abfe2@i-love.sakura.ne.jp>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <057735f0-4475-7a7b-815f-034b1095fa6c@gmail.com>
Date:   Sat, 27 Apr 2019 16:52:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <15b353e9-49a2-f08b-dc45-2e9bad3abfe2@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/19 3:33 PM, Tetsuo Handa wrote:
> 
> I'm waiting for davem why it is safe to move the dst entry from
> "a device to unregister" to "a loopback device in that namespace".
> I'm waiting for an explanation how the dst entry which was moved to
> "a loopback device in that namespace" is released (i.e. what the
> expected shutdown sequence is).

The most probable explanation is that we make sure the loopback device
is the last one to be dismantled at netns deletion,
and this would obviously happen after all dst have been released.



