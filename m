Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A98FC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD5A21D81
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irgS5jj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfJBQeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:34:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfJBQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570034055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHp0IRavFv6k75hSfwI8GgILVpxCIaI6kh++kqYoKfc=;
        b=irgS5jj95G6MC6mBevj0kjxWEhNycyo8cLCdn2s7PqSNuhbUKM0sJSBLG6mV8SFHJwFCwu
        07fxvOzS7gEX8Mzpc58nO0GM+hV+g3hAvnvVIpsTtNX8NbACdsvPaPWnfL0xtWkvy6FmQr
        gU6AaIb/M//TRbY9vF/CBtYxkQprfLU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-7D7kTEf8ME-SUUVi1BQPlA-1; Wed, 02 Oct 2019 12:34:11 -0400
Received: by mail-wr1-f69.google.com with SMTP id z1so7695990wrw.21
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I6XFWKpfqvJrdaaj+xbfZj6ljYeuF1ybj7fA5MzV5N0=;
        b=oHeyQc7drR7aHPxNy3FYC7YecjBpCH68qeeGveyV+07i+WPHGCZpq9O9e3x/LNOEDb
         4Sq/PrVuNRoTqHhLrB5igEnMaC4LjCkujtrGC6zy77b+dHoPgjlKW8jd9Y8YpZmkGIwV
         /hvr65Mv5R7WddChlQeht9Oy3oC51FG5lL9wh5qrgaLflRxbrms4Wz0yzTxf4uqPGMps
         rjc5Lpaz6wJqn8IeQNsf8NRxro7fLALhJ+qz4W6/I52j4KTWG3taiC+YMD2jTRRAVvaA
         Vd5nXyNQpyYqZQX4XGCFMwHVve4XhmspztapUzSuqBNul21NwwVNX+t0AT9zYOximxJF
         sBIA==
X-Gm-Message-State: APjAAAXngLNFNq7IHyZ2LDOUmpi5du6yiszXO3A2dAgPEwxEq/ctjgok
        hHIBTqm47r9bH7Z1+MqE1U9gCuk3IORCawBj7HokKjtaspFJa7ou/vh0sKFTOZstvGWM0oRbBtR
        VUJ0utu1wFVtxCivc14fZkjqA
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr3455838wro.83.1570034050575;
        Wed, 02 Oct 2019 09:34:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdD+Gk4vCq7Ct5eOLEC/jlIajvKDgUnnwoXlT8qVIQmCU7KJeHnpfiKFNNXuIVKUYACLVmkw==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr3455817wro.83.1570034050311;
        Wed, 02 Oct 2019 09:34:10 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.82.15])
        by smtp.gmail.com with ESMTPSA id 79sm9893462wmb.7.2019.10.02.09.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 09:34:09 -0700 (PDT)
Subject: Re: [PATCH 2/3] x86/alternatives,jump_label: Provide better
 text_poke() batching interface
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.110246515@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <26c0b59a-18b7-38cd-ed68-520ec604ccb4@redhat.com>
Date:   Wed, 2 Oct 2019 18:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190827181147.110246515@infradead.org>
Content-Language: en-US
X-MC-Unique: 7D7kTEf8ME-SUUVi1BQPlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 27/08/2019 20:06, Peter Zijlstra wrote:
> Adding another text_poke_bp_batch() user made me realize the interface
> is all sorts of wrong. The text poke vector should be internal to the
> implementation.
>=20
> This then results in a trivial interface:
>=20
>   text_poke_queue()  - which has the 'normal' text_poke_bp() interface
>   text_poke_finish() - which takes no arguments and flushes any
>                        pending text_poke()s.

I liked the changes. My only concern is about the internal vector. I though=
t
about making it internal in the past, but I chose to make it "per use-case"
because there might cases in which more entries would be needed, without th=
e
restriction of using static memory. This might be the ftrace case...

[ more in the next email ].

-- Daniel

