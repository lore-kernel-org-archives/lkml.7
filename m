Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19139C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CB120693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3ufbsrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfD0RQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:16:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36230 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0RQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:16:45 -0400
Received: by mail-io1-f65.google.com with SMTP id d19so5565762ioc.3;
        Sat, 27 Apr 2019 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0NFNfTlqzrEILRdFrwDZ3rrY4cqvZ4bmpdMMmnpH0oE=;
        b=M3ufbsrUFN+2LK/I+4v+jPtf3xAJmKfYcDv1Zgw5ZfysAg1GgAFcU7WARA+bTpBwXb
         cw040N575uffPSZbjIWRXik5KxWU5W5lJf8DuoNw0ycbQDzheY8zAca9J455aBDNfHEV
         8jAagNz61Vuz0rkNvo5adUxi+uBOa1Xdk9q/8EWYP0K//ZSzQHqpByCbsx4VGsf68K0+
         O053baWJwpVkFRA63DK95DQ1lZmIvkP9caSboks6+Nc6+UO9hMHlAm50kcH8Xw/97hfM
         NJux4pYveRzLVMeaTCNYuNbJ7i1WQ3kgrbAUrkI3T52Sgf0SqpblVsdBicWkoA8FyhG3
         hvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0NFNfTlqzrEILRdFrwDZ3rrY4cqvZ4bmpdMMmnpH0oE=;
        b=IV9v5TJJ/PU90sik51TnDoolpF4VwYYJE8hnJvtyFh9pJ6N5tp3kqqg9ID0EnJqmi2
         LhUanRc2GcNOE/5rMsCCgze6Cp5AAl36r839SkdeOD6WaLyqu9C8sbYs/XPbBwxc/qlT
         TI1VeHzs1Eon98BHiTS+BlstrTVhkWLoUX6XjOpM9caewR9P0H7ulWCEAXbDkGGKtVAa
         8h196BNu3oO54IsddxWYnIvpyRFMpgvtCMe1tgICDXb5G90WF+DmWImXXzxHGU5qOHje
         SNd1T0TyW8D7jUz09wuh1Iky2EtGH5xwVVwBV9c6nYhbywP3iROvmq0j50o2KKL8RZEh
         S8Kg==
X-Gm-Message-State: APjAAAU5YbFhJjE5CdX4JSa3b7J9Es5qARTbXZuQ59mYDsccPwIYcSJe
        dSGL4BuXnky7PlyxRDVaYqw=
X-Google-Smtp-Source: APXvYqyqFArI13YubcCmeTJeOKOJu5TqD/clpZj+DiONKXJRKkMix68t6lU/J2W2sgfv0hEV16VmhA==
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr4808954iog.187.1556385403948;
        Sat, 27 Apr 2019 10:16:43 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:7dcd:8cf4:8ba5:a6c? ([2601:282:800:fd80:7dcd:8cf4:8ba5:a6c])
        by smtp.googlemail.com with ESMTPSA id q141sm5609723itc.2.2019.04.27.10.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 10:16:42 -0700 (PDT)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
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
From:   David Ahern <dsahern@gmail.com>
Message-ID: <cc054b5c-4e95-8d30-d4bf-9c85f7e20092@gmail.com>
Date:   Sat, 27 Apr 2019 11:16:41 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <920ebaf1-ee87-0dbb-6805-660c1cbce3d0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/19 7:43 AM, Tetsuo Handa wrote:
> This bug is the top crasher for syzbot and thus we want to fix. I need your
> response regarding commit caacf05e5ad1abf0 ("ipv4: Properly purge netdev
> references on uncached routes.") why you chose "a loopback device in that
> namespace".
> 
> On 2019/04/16 23:00, Tetsuo Handa wrote:
>> Hello, David S. Miller.
>>
>> I have a question regarding rt_flush_dev() introduced by commit caacf05e5ad1abf0
>> ("ipv4: Properly purge netdev references on uncached routes.") which went to
>> Linux 3.6-rc1. That commit started replacing "a device to unregister" with
>> "a loopback device in that namespace", but there is no description why that
>> commit chose "a loopback device in that namespace". If a device to unregister
>> is "a loopback device in that namespace" itself, rt_flush_dev() becomes a no-op
>> because dev == net->loopback_dev from the beginning. Apart from a problem that
>> usage count keeps increasing because dev_put(rt->dst.dev) is not called after
>> rt->dst.dev was replaced with a loopback device, replacing "a device to unregister"
>> with "a loopback device in init namespace" (like shown below) avoids this problem.
>>

Moving resource use to the init namespace is not really solving the core
problem. It would be better to understand what changes are needed to the
shutdown sequence of a namespace to ensure proper cleanup.

In this case why are dst entries not getting cleaned up? This one is
referring to entries on the uncached list. What is using the dst entry
and why isn't it getting released?
