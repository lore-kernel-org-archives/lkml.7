Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1694C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588F22086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ISl1taxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfJBLAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:00:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46583 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJBLAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:00:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id d1so16603525ljl.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YqW4lirDp6dhPL53QREOEClblGXQffbz/DGv2dLJs4Q=;
        b=ISl1taxiHeTMVMMOn0n8wcdg1xJCR1fcz2fZFt8tGPPObtsnfloz8d6yuwZ/9jaDBC
         EpdDdSIVXj2fa5iKwOBPzK1izqeisJnL+CPOwUoqWwMd4nnpL+vDOFHoSeaHcSqS4GjT
         iCUvnNTfZGkmnxxuPGn9m+87WKlq8hpi7/JB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YqW4lirDp6dhPL53QREOEClblGXQffbz/DGv2dLJs4Q=;
        b=kM657xP4nH2p1I5IAgJ96RXEW61XkH8gn/9sZr6YZT30G1sKsy5DC1aBqrONfPqQHY
         ZCFzudpUmYqebSTapCP4lYxEnHH3i1wLUoSzAyvtpCsMQo0PMhnmilCT9cYQ+iO8RckD
         vEtAwMk3iO6ukKU2UgcM1upuA7YxeXHvBpaqyOKTFk44aBODgTzeunLzTkj0hWYuxEP6
         /SJax4b9BEv7gRyjC2jN07FM/pNxmvEbTbyHLciIOoiWzUPSdpMKh/VKAktUekzEKaif
         jtJPV3DzsrZqoCglE2r/5Hoyd8botLGrxgX+RnMSwdYWGcTUO6HgGwvFRXKyfXlURe+w
         v3fA==
X-Gm-Message-State: APjAAAWgD9GL/Qu8iThlZXLIk4SLm4ZXZ5Wzs3AiOoCAq9JGgODQD2Ji
        0O1Gyp3QFBC7cTV8ljFEm+0SKQ==
X-Google-Smtp-Source: APXvYqzu9K6EJ442RqSftT7bhnv6pnQOGABkdQlZVfOHCKr4mFhLt1GwBoceHpgFO7VessYbj9nmHg==
X-Received: by 2002:a2e:86d5:: with SMTP id n21mr1977522ljj.1.1570014037566;
        Wed, 02 Oct 2019 04:00:37 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y22sm4544784lfb.75.2019.10.02.04.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 04:00:37 -0700 (PDT)
Subject: Re: [PATCH v3] string-choice: add yesno(), onoff(),
 enableddisabled(), plural() helpers
To:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Vishal Kulkarni <vishal@chelsio.com>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <8e697984-03b5-44f3-304e-42d303724eaa@rasmusvillemoes.dk>
 <20191001080739.18513-1-jani.nikula@intel.com> <87eezvbgp1.fsf@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <dc08714c-c76f-10f1-a5e7-7972beeb4552@rasmusvillemoes.dk>
Date:   Wed, 2 Oct 2019 13:00:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87eezvbgp1.fsf@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2019 12.11, Jani Nikula wrote:
> On Tue, 01 Oct 2019, Jani Nikula <jani.nikula@intel.com> wrote:
>> While the main goal here is to abstract recurring patterns, and slightly
>> clean up the code base by not open coding the ternary operators, there
>> are also some space savings to be had via better string constant
>> pooling.
> 
> Make that
> 
> """
> While the main goal here is to abstract recurring patterns, and slightly
> clean up the code base by not open coding the ternary operators, using
> functions to access the strings also makes it easier to seek different
> implementation options for potential space savings on string constants
> in the future.
> """
> 
> to be more explicit that this change does not directly translate to any
> space savings.
> 
> Rasmus, okay with that?

It's rather fluffy, but it doesn't make unfounded claims about space
savings, so in that regard I'm fine with it.

[It's probably just my lack of imagination, but I still fail to see how
one could ever achieve better than the linker creating just 1
vmlinux-wide instance of "enabled", which I believe happens regardless
of whether one uses these helpers or not.]

Rasmus

