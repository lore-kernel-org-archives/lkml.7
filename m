Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B59EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A6A20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SF6Z79xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfCDDGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:06:31 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39871 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfCDDGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:06:31 -0500
Received: by mail-qk1-f170.google.com with SMTP id x6so2068718qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 19:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SZenl6cB66qwgrDNL51fYcS3OY/z1uUQwYTqTUFbEgU=;
        b=SF6Z79xJdSaEQZ/iHzLjAgb1Qg7lrK2m9tSemuPBjAy8Gb6X5ah6Fj1GeSmn/8hzTH
         oZlP1UmUqeiZi22edQVKw5NIpzivPy0ylQlu8ZIFDUSjyKEi5goKQHh7SHFuRFNLvy4+
         pnuFjuyXMgAJOPT8aJgdsV3q7kFS1cnq467XpWQQGDdTM451XFRRr5HqfIXnbyPLDgss
         DT3hXAepGlHNUhttCriph3D5XhUpZG5xBLmopLAivgl+Rize8PGKZPcgJ9YJ3UH9NJNC
         yVRPJWGxtuJhTk66G6QXMAAhqmdZsnA5tYNc09AcS4/oVZEnZnrNIU4DZS0EWxNSenEh
         V6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SZenl6cB66qwgrDNL51fYcS3OY/z1uUQwYTqTUFbEgU=;
        b=Ym+cWZonUc06H5+iTIcqgN11aOhCuFYcyeLBzjgg6Pp6VJVe73N/57Gfl2Nk8cB2+k
         TgoLQAB3a7LN2bG1vDX9kwrk1b8ASXlYk+JCKlE7CCN6+FBnUcPi1X93pNOB0lSwzJWZ
         f1yFkDiVmlEUhTL5MK0QJKt/UzQMuQug2ZtuwO0741DIGOzlt/olZH7AcM/cuELGECzw
         US2L3PTzjB8xw2641cDH3tIbRjFFswXlikOJPiELX/a1q+nc4g4WBPzmu3LcxU2DFJwt
         UM0xkAIAGxtpfUorJcV+bT0fMgVQ3UMJ0Sc4q9LRrv4qjdgAlCb+JwxIrL/jnKm5vwu0
         xPhw==
X-Gm-Message-State: APjAAAUm8mZKbmMy3sE2LHOcs2LIEgHe8rfvffNSuGmIv+EwOdl4b2Ra
        Tkd9s+SbNYAItdlMU9oQbkawsDQJIL0=
X-Google-Smtp-Source: APXvYqwJzjftsVzLEzEBfxBPtBg3hMpSp01DFN0IbUdtxC3UsWcNOgA2+Lw7Bz5g/e4K0lRv6OBpgQ==
X-Received: by 2002:a37:c554:: with SMTP id p81mr12134479qki.337.1551668790240;
        Sun, 03 Mar 2019 19:06:30 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 46sm3644139qto.87.2019.03.03.19.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 19:06:29 -0800 (PST)
Subject: Re: [PATCH -next] lockdep: skip debugobjects for lock_classes[] init
To:     Bart Van Assche <bvanassche@acm.org>, peterz@infradead.org,
        mingo@redhat.com, will.deacon@arm.com
Cc:     longman@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
References: <20190303040224.7666-1-cai@lca.pw>
 <c20aa0f0-42ab-a884-d931-7d4ec2bf0cdc@acm.org>
From:   Qian Cai <cai@lca.pw>
Message-ID: <59ac7210-03f5-99db-8ffd-47dbfc307709@lca.pw>
Date:   Sun, 3 Mar 2019 22:06:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <c20aa0f0-42ab-a884-d931-7d4ec2bf0cdc@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/19 1:19 PM, Bart Van Assche wrote:
> [PATCH] locking/lockdep: Only call init_rcu_head() after RCU has been
>  initialized
> 
> init_data_structures_once() is called for the first time before RCU has
> been initialized. Make sure that init_rcu_head() is called before the
> RCU head is used and after RCU has been initialized.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

I like your approach more.

Tested-by: Qian Cai <cai@lca.pw>
