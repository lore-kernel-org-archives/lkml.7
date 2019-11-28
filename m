Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D01A216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="J8UmETHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfK1IWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:22:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45319 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfK1IWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:22:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so4097165wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JPyHkE/xlemi6rCp8JUhdM9TMa4vGSjDKh4lPExeQCo=;
        b=J8UmETHv38orrOYb0TTqKrNrSQ4cqwdmIiORyLBsbvTLDJEkdMZXO7O3+SvABe3rkU
         L6ZHUPdH2QOP7wSbsPeb6ixQCiYGGbphMD3yupiji/z2bmJgC/AGF3TGIY9xYqn9blA7
         5Ok9NLV1JLs6AnZB6Xkz5HL2NXuVAdpWxUAJn34jeBkFKLCi92VJkY0H7x0UI/aVLlf+
         Y1Im4RG94SM/PXWZ1bMDDD7KQ6ABkPoM36tXnN2RbMVw2nwWYMdvEn+Or765n+NmWRQ4
         6X7GGL9+GKtf24TEUq79+UDjSAsZ8s07R02Y2T+Vm66FJ8v1NuNE842cTwYmMDnSfsIb
         ZBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JPyHkE/xlemi6rCp8JUhdM9TMa4vGSjDKh4lPExeQCo=;
        b=javjf30zC0awxr0s0r/sFCVutTBy61AEjdPoE6IpRaW4+THq/sK9NEjI5WNXNcS30f
         kJClCpCfNKoY5FBK4JAehJErEvsSRXmszLLU8UNZb1DZs7Eem+46z0/KrVq4qEW97+cK
         yMIAbuMcXEzV2dLVOoORninfIo5esU0Vr6Eo4ttPGs355cn4oiN0rG2mNuekDHRGD5Xs
         MwrUQ3ugySXa4K4Sg1A9rxZY0ytYeVSaYJJlIxqWUO+sta2tyzk4dGQE5KkvQODHjIWO
         C0o8xigx/RWkMaP+KEura+KJmWlzVxv/64sznrL1RHENHSt9p5WYXj4FJQQzZ39/9ggs
         gxRg==
X-Gm-Message-State: APjAAAVJfqaH/JJ8I6jFNn2SQ2JFNkRr8z+LrUBh/4XNhRpxMoiUfjiK
        Tbb83AFIEYsOj4KTALt+5AflLFopO74=
X-Google-Smtp-Source: APXvYqzNunvWbU7bVVRiqPGhDWFBwBuqffvTBGkKnTfQj/3s1HECNvbWbEH4wjZR5NTEqjoD0lJFRw==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr44894801wrs.388.1574929340640;
        Thu, 28 Nov 2019 00:22:20 -0800 (PST)
Received: from ?IPv6:2a01:e0a:410:bb00:ac7e:81e:c2cd:dd25? ([2a01:e0a:410:bb00:ac7e:81e:c2cd:dd25])
        by smtp.gmail.com with ESMTPSA id n188sm4426236wme.14.2019.11.28.00.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 00:22:19 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/2] openvswitch: support asymmetric conntrack
To:     Aaron Conole <aconole@redhat.com>
Cc:     netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
References: <20191108210714.12426-1-aconole@redhat.com>
 <eb0bdc35-7f29-77c7-c013-e88f74772c24@6wind.com>
 <f7tsgmkyja6.fsf@dhcp-25.97.bos.redhat.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <57c14a3f-25fa-76c3-d846-a616f198467e@6wind.com>
Date:   Thu, 28 Nov 2019 09:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <f7tsgmkyja6.fsf@dhcp-25.97.bos.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/11/2019 à 22:19, Aaron Conole a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:
> 
>> Le 08/11/2019 à 22:07, Aaron Conole a écrit :
>>> The openvswitch module shares a common conntrack and NAT infrastructure
>>> exposed via netfilter.  It's possible that a packet needs both SNAT and
>>> DNAT manipulation, due to e.g. tuple collision.  Netfilter can support
>>> this because it runs through the NAT table twice - once on ingress and
>>> again after egress.  The openvswitch module doesn't have such capability.
>>>
>>> Like netfilter hook infrastructure, we should run through NAT twice to
>>> keep the symmetry.
>>>
>>> Fixes: 05752523e565 ("openvswitch: Interface with NAT.")
>>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>> In this case, ovs_ct_find_existing() won't be able to find the
>> conntrack, right?
> 
> vswitchd normally won't allow both actions to get programmed.  Even the
> kernel module won't allow it, so this really will only happen when the
> connection gets established via the nf_hook path, and then needs to be
> processed via openvswitch.  In those cases, the tuple lookup should be
> correct, because the nf_nat table should contain the correct tuple data,
> and the skbuff should have the correct tuples in the packet data to
> begin with.
> 
>> Inverting the tuple to find the conntrack doesn't work anymore with double NAT.
>> Am I wrong?
> 
> I think since the packet was double-NAT on the way out (via nf_hook
> path), then the incoming reply will have the correct NAT tuples and the
> lookup will happen just fine.  Just that during processing, both
> transformations aren't applied.
Ok, I didn't look deeply, thank you for the explanation.

Regards,
Nicolas
