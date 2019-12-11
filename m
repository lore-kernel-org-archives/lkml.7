Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C167CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90985214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB/cDp9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfLKJR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:17:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27866 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726983AbfLKJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576055845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D9+DxR55aT8isgzR0NmN2S4cLz7LDrDrCDjDym5Lmw=;
        b=OB/cDp9m4cjXt+InrzQ4ZrU5gpDdMS7TaQf0gEyfX+tAX2A9gBFe/hSoU6t35nZiFaV5qO
        SxzfUfJ17LdXEAW9i5ZY6Gg9nB8mdvYodhqnkfmBfalsxaODDSv85WMt3tBDnPU0sjfFMK
        klVqJK4hp0oD9OlZDqMYd97XQGZ6Mps=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-dGKTayoOOp-hfTQ39DxaHA-1; Wed, 11 Dec 2019 04:17:24 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so2146973wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3D9+DxR55aT8isgzR0NmN2S4cLz7LDrDrCDjDym5Lmw=;
        b=mf8ykhIGOUR4g7RrGHr9hIA8xeRP54WCseuDeg9toWen96Wam3uR7Npb8mH996hJT+
         ZNOS1y0esnYnrut+LponbYDyjDNeZweYrO4AVgng57CgL3WAiun11Bu2/4tlp8gkD1b0
         /eiNzF1H4P5Pcjem09nkkJ6DrMQxGyr5aBwb6MIwyE/CJ7wV0guFixDrk69xqK60eus5
         c+pdIKjxqqeQwXQkiqtJSG7NYsyGVT0S2UmqKhOtscdP0F218DQ6KQ0n6J8tvRAavswh
         b4OFxTsUJDDtUIsKPuDKcFBAA187Gol5UvMZnYz+Tf8a8TKqR6CxpFM1mgmg/LfAI8EM
         Tc/Q==
X-Gm-Message-State: APjAAAVtM+TDrua8yBv1m3MqHkTRk0HvZChRPPjuI+oCnRrT/xyxqRGK
        QFpfCi6g2bklQTDyNjgpi/qxx70ct/8t7GCDS26vZZ1JuU2z+5KhE9K+PGD49fS3uL+aWUHpfnl
        t2qHS7pN4H1HBc3ptB66DqbLY
X-Received: by 2002:a7b:c936:: with SMTP id h22mr2260258wml.115.1576055843218;
        Wed, 11 Dec 2019 01:17:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDgCob433Db0I04qpsUB8UPAdNFpNw1LiUtYCYQae7vpJwK2lrbtOi8uXyJ8INBI/BCX2BpQ==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr2232931wml.115.1576055524198;
        Wed, 11 Dec 2019 01:12:04 -0800 (PST)
Received: from t460s.bristot.redhat.com (host100-201-dynamic.10-87-r.retail.telecomitalia.it. [87.10.201.100])
        by smtp.gmail.com with ESMTPSA id 25sm809486wmi.32.2019.12.11.01.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 01:12:03 -0800 (PST)
Subject: Re: [PATCH -tip 1/2] x86/alternative: Sync bp_patching update for
 avoiding NULL pointer exception
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
 <157483421229.25881.15314414408559963162.stgit@devnote2>
 <20191209143940.GI2810@hirez.programming.kicks-ass.net>
 <20191211014401.2f0c27f259a83d1f32aa6f2e@kernel.org>
 <20191210173209.GP2844@hirez.programming.kicks-ass.net>
 <20191211000943.GG2871@hirez.programming.kicks-ass.net>
 <20191211170919.54f6546d294f8a45c0a176c7@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <19e2a826-d62e-a4f5-8059-b4d9c11a8ca6@redhat.com>
Date:   Wed, 11 Dec 2019 10:12:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211170919.54f6546d294f8a45c0a176c7@kernel.org>
Content-Language: en-US
X-MC-Unique: dGKTayoOOp-hfTQ39DxaHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 09:09, Masami Hiramatsu wrote:
> Hi Peter,
> 
> On Wed, 11 Dec 2019 01:09:43 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Tue, Dec 10, 2019 at 06:32:09PM +0100, Peter Zijlstra wrote:
>>
>>> I feel that is actually more complicated...  Let me try to see if I can
>>> simplify things.
>> How is this then?
> This looks perfectly good to me :)
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

too!

Thanks!
-- Daniel

