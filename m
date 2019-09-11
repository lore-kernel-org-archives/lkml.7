Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE33C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1602075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfIKTpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 15:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbfIKTpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 15:45:19 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 411B559451
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:45:18 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id q12so26239681qkm.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 12:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7i0Etx6MLYI/45jnP4DYISG5JeNZkAJR7nS2nO9OITA=;
        b=U8xA+yTUo5xmPf77t4nO40TqA77PsxTyLT1DkC+aKe3dajvjgszXoh06ZEenUE2oOO
         mTnA25atCSDmmwm00fn6o7YQtOPoekqYtgnpb82Qo8hbgpjcFO3v4xXVorBxADgVgQFx
         xxNeWiCv5tsgns+fndD2/F2RjNFkMXsfATTnnEoBMBzr31lFvLVzCo3O4xKrzypHJakU
         KORO2844IXaJXR2G+744Z4+Pd/6fTkTFtXHukItT/l5GgV6yWhrm1Na4ozU3KteEyq5U
         NwJhzFEUQ7ROpC2Bpt5DfkJ0GoNBlqH8L84E1+qNp56N080EkZnJZTcFChKYOWk/Jgcy
         9yGw==
X-Gm-Message-State: APjAAAWlz7BPojxjnj9dO6ulZjAOd2OlSo96sNVv3zLrg4eG/B+S9o20
        OwNEUjCyjLHXJQ7voZercYi7+HgQ4S5jrAbWWH7iqomiV+HBD3qBORWsfdie3ppRnhK/wvYfQ8A
        m6jjwXe6dPVofd2d7RM4xy8Va
X-Received: by 2002:ac8:688:: with SMTP id f8mr18556206qth.51.1568231117499;
        Wed, 11 Sep 2019 12:45:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymdm0tl7ApS6BtYz0XIfOtihacBxBgcLFt4hc1wZ8x+mNF59Zj9qGHloLFh99pIpLmjDzc6w==
X-Received: by 2002:ac8:688:: with SMTP id f8mr18556165qth.51.1568231117225;
        Wed, 11 Sep 2019 12:45:17 -0700 (PDT)
Received: from [192.168.1.4] (192-0-145-99.cpe.teksavvy.com. [192.0.145.99])
        by smtp.gmail.com with ESMTPSA id t40sm13404749qta.36.2019.09.11.12.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 12:45:16 -0700 (PDT)
Subject: Re: [PATCH glibc 2.31 1/5] glibc: Perform rseq(2) registration at C
 startup and thread creation (v12)
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20190807142726.2579-1-mathieu.desnoyers@efficios.com>
 <20190807142726.2579-2-mathieu.desnoyers@efficios.com>
 <8736h2sn8y.fsf@oldenburg2.str.redhat.com>
 <7db64714-3dc5-b322-1edc-736b08ee7d63@redhat.com>
 <87ef0mr6qj.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <4a6f6326-ea82-e031-0fe0-7263ed97e797@redhat.com>
Date:   Wed, 11 Sep 2019 15:45:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ef0mr6qj.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 3:08 PM, Florian Weimer wrote:
> * Carlos O'Donell:
> 
>> It would be easier to merge the patch set if it were just an unconditional
>> registration like we do for set_robust_list().
> 
> Note that this depends on the in-tree system call numbers list, which I
> still need to finish according to Joseph's specifications.

Which work is this? Do you have a URL reference to WIP?

> (We have something that should work for us as long as we can get large
> machines from the lab, but I agree that it's not very useful if glibc
> bot-cycle time is roughly one business day.)

Yeah, we have to discuss how to accelerate this.

-- 
Cheers,
Carlos.
