Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C981FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3DA20815
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfE0PoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:44:11 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45511 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0PoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:44:10 -0400
Received: by mail-wr1-f50.google.com with SMTP id b18so17259482wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2A4/Dy7CeUNWJQHbbLk0HO1r8qYMXPrMtWyOg+ikpyk=;
        b=rn87ZKkRswkp6xaHFggHfpbYjtNTCW9E1rPbKwuFO3LdDBvYSK86wbp3vGylYb5D7G
         9cD7N7I5dOQQaB2xxJDVmKbTtmtFAqBcqUp2IXltoElxv0xxYuL/LK/hdJH0gpKJsEcB
         O6AYJQRm0y30oezGVlaf82HFvNx+9/UB29KLeKghWUatN94bZe07VMTYHZPyWknGhBkR
         ei/BfVUf4Y6dtxQf6ZbxT1IUTwe0ibKOAOCzd/BJHYSBUBCzZ+DSqp7X76cx633wqCyw
         ek/M0uCjtRXDiITHOMKUyb7gET6/+C8W10g8Lh/Bf2O2PL+WlYRsZE0rqHuLfFL5IeD2
         djFg==
X-Gm-Message-State: APjAAAXSA2EezQ8KUxDAW3PwOe+QUDRTI6m50qWlMgcHCgL+oG423hc0
        lajrB6CPexa5RgglMqxAjuyE5A==
X-Google-Smtp-Source: APXvYqxek10K/dO9NSTEttg+mnORuKnxwc7jyGofKaHXmyE/ma/6TRaCxUAv7G+DGuJ8bDopIl1MFQ==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr6429556wro.60.1558971848967;
        Mon, 27 May 2019 08:44:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553? ([2001:b07:6468:f312:c92d:f9e8:f150:3553])
        by smtp.gmail.com with ESMTPSA id s62sm22814951wmf.24.2019.05.27.08.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 08:44:08 -0700 (PDT)
Subject: Re: [RFC/PATCH] refs: tone down the dwimmery in refname_match() for
 {heads,tags,remotes}/*
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
 <20190526225445.21618-1-avarab@gmail.com>
 <5c9ce55c-2c3a-fce0-d6e3-dfe5f8fc9b01@redhat.com>
 <874l5gezsn.fsf@evledraar.gmail.com>
 <xmqqef4jewj6.fsf@gitster-ct.c.googlers.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a40c5388-4274-6bfa-4213-6013601c8fae@redhat.com>
Date:   Mon, 27 May 2019 17:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqef4jewj6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/19 17:39, Junio C Hamano wrote:
> I do not think lightweight vs annotated should be the issue.  The
> tag that the requestor asks to be pulled (from repository ../b)
> should be what the requestor has locally when writing the request
> (in repository .).  Even if both tags at remote and local are
> annotated, we should still warn if they are different objects, no?

Right, lightweight vs annotated then is the obvious special case where
one of the two is a commit and the other is a tag, hence they ought not
to have the same SHA1.  I'll take a look.

Paolo
