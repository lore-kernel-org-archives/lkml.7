Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C95C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6BD208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="BYGJMhpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfFUVpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 17:45:36 -0400
Received: from us-smtp-delivery-172.mimecast.com ([216.205.24.172]:24733 "EHLO
        us-smtp-delivery-172.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfFUVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:45:35 -0400
X-Greylist: delayed 972 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 17:45:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
        s=mc20150811; t=1561153534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tuPPC6lpYujCl3/C4gjdhayCmhw5/kYOpTCP4JitViI=;
        b=BYGJMhpp1VxhuumvghGFn9VR7b6a1f/PWnJAkP6dywcywZvkV1BbMqdQdaT3497Cxc0zuJ
        JYchvYoqd6Ckw4biZgiuSMvXIMmRogR3mKT/kxWLZ+r4s0/GAg+/II2HL3zrxCDwKdAQfB
        6sQJigkuLnYtvWoCAgsTb2+Qvmc6HR4=
Received: from smtp01.valvesoftware.com (smtp01.valvesoftware.com
 [208.64.203.181]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-sOngGh1eMlmn39ClzDlAwA-1; Fri, 21 Jun 2019 17:45:33 -0400
Received: from [172.16.1.107] (helo=antispam.valve.org)
        by smtp01.valvesoftware.com with esmtp (Exim 4.86_2)
        (envelope-from <pgriffais@valvesoftware.com>)
        id 1heRYG-000AIb-78
        for linux-kernel@vger.kernel.org; Fri, 21 Jun 2019 14:58:32 -0700
Received: from antispam.valve.org (127.0.0.1) id h1l7vo0171su for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 14:45:32 -0700 (envelope-from <pgriffais@valvesoftware.com>)
Received: from mail1.valvemail.org ([172.16.144.22])
        by antispam.valve.org ([172.16.1.107]) (SonicWALL 9.0.5.2081 )
        with ESMTP id o201906212145320014067-5; Fri, 21 Jun 2019 14:45:32 -0700
Received: from [172.18.41.51] (172.18.41.51) by mail1.valvemail.org
 (172.16.144.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Fri, 21 Jun
 2019 14:44:27 -0700
Subject: Re: Steam is broken on new kernels
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <edumazet@google.com>, lkml <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
From:   "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Message-ID: <6033e333-137b-9016-bfdc-62ed747835ef@valvesoftware.com>
Date:   Fri, 21 Jun 2019 14:43:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190621214139.GA31034@kroah.com>
Content-Language: en-US
X-ClientProxiedBy: mail1.valvemail.org (172.16.144.22) To mail1.valvemail.org
 (172.16.144.22)
X-EXCLAIMER-MD-CONFIG: fe5cb8ea-1338-4c54-81e0-ad323678e037
X-Mlf-CnxnMgmt-Allow: 172.16.144.22
X-Mlf-Version: 9.0.5.2081
X-Mlf-License: BSVKCAP__
X-Mlf-UniqueId: o201906212145320014067
X-MC-Unique: sOngGh1eMlmn39ClzDlAwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/19 2:41 PM, Greg Kroah-Hartman wrote:
> On Fri, Jun 21, 2019 at 02:27:41PM -0700, Pierre-Loup A. Griffais wrote:
>> This seems to have broken us:
>>
>> https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.1.11
>>
>> Here's some affected users:
>>
>> https://github.com/ValveSoftware/steam-for-linux/issues/6326
>>
>> https://www.reddit.com/r/linux_gaming/comments/c37lmh/psa_steam_does_not=
_connect_on_kernels_newer_than/
>>
>> https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DSteam-Networking=
-Kernel-Woes
>>
>> I don't really understand that distributions that claim to be desktop
>> products would have fast-tracked a server-oriented fix to all their user=
s
>> without testing one of the primary desktop usecases, but that's another
>> thing to figure out later.
>>
>=20
> What specific commit caused the breakage?

Unclear as of yet, we're starting that process on our end just now. Not=20
sure if a user has already performed a bisect and shared his findings in=20
one of the links below, but we'll be scouring these and doing our own=20
testing as next steps.

>=20

