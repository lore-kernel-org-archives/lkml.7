Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C379C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F5A20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwEvBQ+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfCYQTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:19:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46820 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:19:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id c18so8521637otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kNhjFyAJj2F2IJvSUMRthN84gt9w56CKqbJ/olM8L5c=;
        b=mwEvBQ+ipRV1kh+mAX4sg5T8MvtOw5lQLKAyDP5KtmkAwpb/YJeM70ld9m7o3fvbAp
         Jp0m9I1TqBMiAUvn0qWEKxfTi1HJU3s/C4KC7PFa3bUH0q7uXo52Ob+5h5rySV9gtzpq
         yY6pfmedYOVX5w77uC0WNodR7KU4F9Z228xCQin880bDGeqYrfsxBcpcodkU+r5qNCkZ
         fJyBXzfSAsyL47eA7d0IIonfarhs2sOu/Jix0Hb06w9cA2G7bJGjhQu/S9jJOX30fdmU
         QdXnwvs3wc+4DMIKDCkEQANbYSO9j/s5qgat5yS9B7tNqM+DmSGx72Nw8Tb2nVaDzTxa
         /01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kNhjFyAJj2F2IJvSUMRthN84gt9w56CKqbJ/olM8L5c=;
        b=PMW5LctadYF6QnIfoozFUYbo71VxE6VnCqt7xc5D0yIEyvMDf7fBCySuFVPume2HQd
         t2JNGPgJudFJo5ksgGHldnAk+TisDymShxMzhq1WfDL9SGCe0Lc7rf5/d4zhnkqOcUbS
         gKJdELYhV4L4NWGPcBSUtoG7C2N8J7+ujPBdBshvjejY90z57y5gPvw8WZa3SoA6KPyW
         syBwiQwpkcPSaOf/k1X9+8aB5ofhp9VxaV+tVfskJ+zFJgmLBNGvR8WOOkDwzBfvawTX
         VRYwOS9IfueLynVe2P4JkvxDbBEJyJRKeD4lR27okS+e2mYfQyGhNVkCVrSAFXiuB8tl
         qgGw==
X-Gm-Message-State: APjAAAWvhVVTpsa4vLEgmMq8XlGvk5NoOdzW1lH+ANOy6qGeyQVKuczN
        fFAV4QbF/6juhG0SWKTI4j5356nG
X-Google-Smtp-Source: APXvYqxwCD7u/nsuaz8zjuQ8HPzJ+ui04FJJBhLrRpeCfsUxtcLoyPMe+47GItlEnnVdu5AZuvnE3w==
X-Received: by 2002:a05:6830:20cc:: with SMTP id z12mr18834817otq.334.1553530756491;
        Mon, 25 Mar 2019 09:19:16 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c131sm6457965oif.3.2019.03.25.09.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:19:15 -0700 (PDT)
Subject: Re: Regression in 5.1.0-rc2: PowerBook G4 Aluminum fails to boot -
 bisected to commit 0df977eafc792
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <acc2d5a5-2fd4-4367-c8ef-497da951c208@lwfinger.net>
 <1c1f7eae-0c49-dcb2-f27b-96a83d811df7@c-s.fr>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <4d7e3fc5-82d8-5bcf-0891-97445e284c36@lwfinger.net>
Date:   Mon, 25 Mar 2019 11:19:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1c1f7eae-0c49-dcb2-f27b-96a83d811df7@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 3:46 AM, Christophe Leroy wrote:
> 
> 
> Le 25/03/2019 à 01:49, Larry Finger a écrit :
>> A build of kernel 5.1.0-rc2 resulted in a failure to boot on my PowerBook G4 
>> Aluminum. The bootstrap loads the initial kernel and issues the appropriate 
>> start, but the machine hangs at that point.
>>
>> The problem does not depend on the choice of PPC32 processor type. This 
>> machine has a 7447A according to /proc/cpuinfo.
>>
>> The problem was bisected to the following:
>>
>> commit 0df977eafc792a5365a7f81d8d5920132e03afad
>> Author: Christophe Leroy <christophe.leroy@c-s.fr>
>> Date:   Thu Feb 21 10:37:54 2019 +0000
>>
>>      powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS
>>
>>      When calling RTAS, the stack pointer is stored in SPRN_SPRG2
>>      in order to be able to restore it in case of machine check in RTAS.
>>
>>      As machine check is not a perfomance critical path, this patch
>>      frees SPRN_SPRG2 by using a field in thread struct instead.
>>
>>      Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> I reverted this patch and found that the system began execution, and then 
>> failed, likely due to the reassignment of SPRN_SPRG2.
>>
>> I had found this problem with 5.1.0-rc1, but -rc2 was out by the time I 
>> finished the bisection. Unfortunately, none of the changes in -rc2 fixed the 
>> problem.
> 
> I think I identified the issue, see https://patchwork.ozlabs.org/patch/1063962/
> 
> It is now booting properly under QEMU with your .config
> 
> Could you please test it on your target ?

Thanks. That patch fixes the issue.

Larry



