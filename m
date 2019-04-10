Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C27C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99D320850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0XoHP8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfDJOQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:16:34 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42908 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfDJOQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:16:34 -0400
Received: by mail-yb1-f196.google.com with SMTP id l124so863817ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8ABffEdZGV5cihLZzSHe2fhMN6ofhtObW3edkrWfCs=;
        b=F0XoHP8usrEVkRqi/39Q5G7p1Znhdzs54MQuTynfelohW8v07Lvor7o0OFxpPdsaxI
         0QomlGzN85H47lfms4oFdvxrzaB7VgL/67pa4iaTJenTZZ7fJU5k5tXJNKis7AVlAO/i
         +n4ET2R6ywH9/I2tkRLxZ8HS0g0ca+rZu3+9jyHleEfyyX0oCOZ2jWojccTgcoQBP490
         vhHm+qQcT3Fd7qVjbo1Mr2C4GSH7wDeEZV4QxjBnOuqOaX+vHLKx7jBVgJDscyVBeae6
         WnenZJ1MR9RdSJ+PV8iLsKrPoF/bDO2KDmFPmhKPnnVXKhtUtoaK9Hq5u+0xy4ZUeaYY
         Gcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8ABffEdZGV5cihLZzSHe2fhMN6ofhtObW3edkrWfCs=;
        b=V8/NO9YoRvpUz9K5sw7bwos1OV52YDNlZBSH8DW3e9klt2yzo3NiW7R21N4d3DQJR/
         zrWFHSOmChEfnrdZ1ORJDm/X03qto5jR6XWB3gwLU2K4DAKE3wezVVOEBT/Tr8675ceK
         ShBgodoucnbKt6MLOxKizLbhOiV5SeLrB+0eawuaLt3Sk3ST92fm9nmtgA5yYSTtzNPD
         q2Xx4HBn0s0UWiJbKKwalr21CR1Y8d0kJ25FgMXoWc8pwNBSGo69uxHhrVecnZrwoiXe
         HsypUcSRnvN9kaLNr5HT7xrP60AGohFmW12tkKZdv5RT5s6/Yh8dG6dt2hbYFXxqNC+n
         Meag==
X-Gm-Message-State: APjAAAVSqgivViJeZGKjhCcsagQMRYlWizaz3K7C9ptJmuX0PvQPLMdG
        SM727n4dVb7u4y3c+4AwyeZ5SwJtyrszHbczijNbZA==
X-Google-Smtp-Source: APXvYqw2DPEt+HE29JBOXuQMLkC+u5ybFpqsKLj+gBHmwUrzVapCEb2SOpluQyjI/41bNTG7oGeRoF4axJPwE0/temQ=
X-Received: by 2002:a25:1a8b:: with SMTP id a133mr21702120yba.428.1554905792918;
 Wed, 10 Apr 2019 07:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
In-Reply-To: <20190410101947.8603-1-juha-matti.tilli@foreca.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 10 Apr 2019 07:16:21 -0700
Message-ID: <CANn89iK9DcDi68WQn0z2R65L1fQpa88nUnpe_di1OWGhhoqAQw@mail.gmail.com>
Subject: Re: [PATCH] net: add big honking pfmemalloc OOM warning
To:     Juha-Matti Tilli <juha-matti.tilli@foreca.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Murphy Zhou <xzhou@redhat.com>,
        Yongcheng Yang <yoyang@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:20 AM Juha-Matti Tilli
<juha-matti.tilli@foreca.com> wrote:
>
> A system administrator is not notified (except via an obscure SNMP
> counter that most sysadmins don't know to look for) if packets are
> dropped due to out-of-memory condition when SKBs use pfmemalloc
> reserves. This can for example lead to NFS connections hanging on
> high-volume systems.
>
> Implement a ratelimited big honking out of memory warning that directs
> the sysadmin to bump up vm.min_free_kbytes in case this problem happens.
> Our experience shows that with default vm.min_free_kbytes (90112, or
> about 90 megabytes), NFS connections hang approximately once per day,
> whereas with 901120 (default multiplied by 10) NFS connections never
> hang.
>

If NFS sessions hang, then there is a bug to eventually root cause and fix.

Just telling the user : Increase the limit is the same thing than admitting :

Our limit system or TCP or NFS stacks are broken and unable to
recover, so lets disable the limit system and work around a more
serious bug.

Maybe the bug is in a NIC driver, please share more details before
adding yet another noisy signal in syslog

SNMP counters are per netns, and more useful in the modern computing
era,  where a host is shared by many different containers.



>
> Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@foreca.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Murphy Zhou <xzhou@redhat.com>
> Cc: Yongcheng Yang <yoyang@redhat.com>
> Cc: Jianhong Yin <jiyin@redhat.com>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index fc92ebc4e200..7d8ef239b9af 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -99,6 +99,8 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
>          * helping free memory
>          */
>         if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
> +               printk_ratelimited(KERN_WARNING
> +                                  "dropped packet due to out-of-memory condition, please bump up vm.min_free_kbytes\n");
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
>                 return -ENOMEM;
>         }
> --
> 2.17.1
>
