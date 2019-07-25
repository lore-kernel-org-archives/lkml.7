Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E82C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A61229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="3U3ZMeJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfGYW3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:29:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33321 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfGYW3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:29:21 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6PMSwxw1194262
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 25 Jul 2019 15:28:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6PMSwxw1194262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564093739;
        bh=4ykevK9YbkNdcTB8EQnPhiho4iIrDyKoSbuKRzNUzc4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=3U3ZMeJPQCHGx9Dpb1bs49duz7rCLHLN/ZOdFMaVxYjp82SkPaSlBpUcrTti8RZqc
         NPukC2lYq6JJxtO4OVjA1UA/bJjsz+w6pCNOhB7/OaNKOX2/jiM9s/k48dQ1POosql
         Wd4fOIRPOlge1ZKfJDL6nPNxHHaINv9d3h/CgU2cbYZSTC/yIR7avuTgBwxHcM3sSt
         4UFhLlSflilWZ1WYnj3u8W1qp674eQe2DHbX3ITh99fhMpOa8o2y/Ys4AEuKH7qur1
         7e0r3SxZSjKuEYy0H2ZTASEA3PIAY5DSO1Q+G2FRM0DBbxovFJ7dIgwxEsVZL4Acxy
         RdZ34jklIwcQA==
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20190724231528.32381-1-jhubbard@nvidia.com>
 <20190724231528.32381-2-jhubbard@nvidia.com>
 <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
 <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
 <345add60-de4a-73b1-0445-127738c268b4@nvidia.com>
 <alpine.DEB.2.21.1907252343180.1791@nanos.tec.linutronix.de>
 <3DFA2707-89A6-4DD2-8DFB-0C2D1ABA1B3C@zytor.com>
 <alpine.DEB.2.21.1907252358240.1791@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e080b061-562f-568f-782d-b014556acdba@zytor.com>
Date:   Thu, 25 Jul 2019 15:28:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907252358240.1791@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 3:03 PM, Thomas Gleixner wrote:
> On Thu, 25 Jul 2019, hpa@zytor.com wrote:
>> On July 25, 2019 2:48:30 PM PDT, Thomas Gleixner <tglx@linutronix.de> wrote:
>>>
>>> But seriously I think it's not completely insane what they are doing
>>> and the table based approach is definitely more readable and maintainable
>>> than the existing stuff.
>>
>> Doing this table based does seem like a good idea.
> 
> The question is whether we use a 'toclear' table or a 'preserve' table. I'd
> argue that the 'preserve' approach is saner.
> 

I agree.

>> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> 
> I surely excuse the brevity, but the formatting mess which that brevity app
> creates is not excusable.
> 

I'll try to improve it...

	-hpa

