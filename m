Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC83C43630
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9DA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439160AbfIYPQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:16:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfIYPQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:16:19 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05B5285540
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:16:19 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id w16so10087666ioc.15
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WoZ3HLwN6X4dNm7Y0wAK5ji0bCw6LaTLIwuuJsi7KNE=;
        b=dAgPUZqgi+B8w1gGMKBLdnOdIl3zSQzkGooV2pneC//poH9FyHOQKVoRaq+PzxvzO5
         oVY5ndP2T9XI7ZuOcdDZ+8W41cwPd+ScW4akgQU+kBz5h9OpmwRQCir1ytPLFOig96N7
         mqG+8EKFcRXa8fqp8U3eA1Fw8/ejZqCdXpJSVeRZ35JWguB3aIzhrK61Gusyfy0hX2BG
         e4BWm0QAGtt5Z/h9CBBcGYi5nXTTREtqxkJNhbkZu28fUCsp+tEYolk1f39VSENyM+Tk
         kQ7aCVsb/FciTYW0aLlMb4XFU7/5hW1m5s2bFzzl3fO6cQoZatmuNk+5oAG/n/UrMlQF
         4ebw==
X-Gm-Message-State: APjAAAVpt3nn3bSBwSrb2jkdGjYKtNZyuEuoK81bbqVf/rRJJCzwXI1L
        dQY6HTrlW33ftLHWcmkPn7hX58OznQAFBDGa6wdRblWR3IuG4byK60MpIpW2Fzkoh0bppQxi7Dq
        +3DISj0CBX79goZZP4L4i/jTA
X-Received: by 2002:a6b:b593:: with SMTP id e141mr11215323iof.233.1569424578389;
        Wed, 25 Sep 2019 08:16:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyclCyMAN4oFi2IQAAmhPq0cIxvkiB9BgZVPkpxcPaiUF3OHEyJLBDQ0SzqmUXs9Ly1ogiCAg==
X-Received: by 2002:a6b:b593:: with SMTP id e141mr11215286iof.233.1569424578099;
        Wed, 25 Sep 2019 08:16:18 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id w16sm217154ilc.62.2019.09.25.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 08:16:17 -0700 (PDT)
Date:   Wed, 25 Sep 2019 08:16:16 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] efi+tpm: Don't access event->count when it isn't
 mapped.
Message-ID: <20190925151616.3glkehdrmuwtosn3@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20190925101622.31457-1-jarkko.sakkinen@linux.intel.com>
 <CAKv+Gu9xLXWj8e70rs6Oy3aT_+qvemMJqtOETQG+7z==Nf_RcQ@mail.gmail.com>
 <20190925145011.GC23867@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190925145011.GC23867@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 25 19, Jarkko Sakkinen wrote:
>On Wed, Sep 25, 2019 at 12:25:05PM +0200, Ard Biesheuvel wrote:
>> On Wed, 25 Sep 2019 at 12:16, Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com> wrote:
>> >
>> > From: Peter Jones <pjones@redhat.com>
>> >
>> > Some machines generate a lot of event log entries.  When we're
>> > iterating over them, the code removes the old mapping and adds a
>> > new one, so once we cross the page boundary we're unmapping the page
>> > with the count on it.  Hilarity ensues.
>> >
>> > This patch keeps the info from the header in local variables so we don't
>> > need to access that page again or keep track of if it's mapped.
>> >
>> > Fixes: 44038bc514a2 ("tpm: Abstract crypto agile event size calculations")
>> > Cc: linux-efi@vger.kernel.org
>> > Cc: linux-integrity@vger.kernel.org
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Peter Jones <pjones@redhat.com>
>> > Tested-by: Lyude Paul <lyude@redhat.com>
>> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > Acked-by: Matthew Garrett <mjg59@google.com>
>> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> Thanks Jarkko.
>>
>> Shall I take these through the EFI tree?
>
>Would be great, if you could because I already sent one PR with fixes for
>v5.4-rc1 yesterday.
>
>/Jarkko

My patch collides with this, so I will submit a v3 that applies on top of
these once I've run a test with all 3 applied on this t480s.
