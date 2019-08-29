Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A35DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DE92077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfH2SEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfH2SEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:04:48 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F9F2C0546F2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 18:04:47 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id c22so4217739qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/g56CbzY6jStnVFv4SmkcoSCqpGf1hqTgm+yJUl5UlM=;
        b=ll20rw5SFRl02MG9Ta8owM7OsvxUlEbjcxg7+tJCRVyjxenjveaAoxShPRZr7x6JBh
         jcQWT/nvghaY3dgwp3fqZj4q0+6MQb1rc9YSnT9vq0Z8FUXjMMwz81zNkJDuBVisO1U8
         TtinX/lHf0+heiV6cf4yIssWPGMHc48IAUIpa8Z5XDAjtq2xN/CXsJX8LfJ9Ou10jh3w
         8a7dbBTAnP+LRkX6LVA1uPgOIJg7IVqXG2M8SVWvHWCkcreXwQsmc5HtXdIjJ3l9rhuw
         c1N66hTpjTSCWjs3dK+JMkb9EJB2/0r3jQSasxMVJZFtPRClMbBy3TbwLzJ5QryqERKx
         Bu7w==
X-Gm-Message-State: APjAAAV4Y3S71kIL7CHH6rZ/q23o5+8ppx1oSiz2Kx/6uRIkTnzz4J3z
        9FqfzUOmC/6cnh0dK21zukZ3ae1YuFKykfFr8m0uYl2hSUwMWR/SsyV1r4Xx611/SwbnsJW9/Ur
        thZnce+iATfwPgj/l/WbUpTav
X-Received: by 2002:aed:3f47:: with SMTP id q7mr11204042qtf.209.1567101886970;
        Thu, 29 Aug 2019 11:04:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRJwR4t1+ktKs4jFtCVoCNuKYwztEr1VyG5hto1oCuAaOHgiMXYRCME7xxyoCfhNCc+9WZfw==
X-Received: by 2002:aed:3f47:: with SMTP id q7mr11203999qtf.209.1567101886606;
        Thu, 29 Aug 2019 11:04:46 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t189sm1634698qkd.56.2019.08.29.11.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 11:04:45 -0700 (PDT)
Date:   Thu, 29 Aug 2019 11:04:44 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alexey Klimov <aklimov@redhat.com>
Subject: Re: [PATCH 2/2 v2] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190829180444.jkwqxgithvbjqtfi@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alexey Klimov <aklimov@redhat.com>
References: <20190828004621.29050-1-jsnitsel@redhat.com>
 <20190828004621.29050-3-jsnitsel@redhat.com>
 <20190829144002.zhuqxnsswgl65pnm@linux.intel.com>
 <20190829144140.6xaygqkfhsnmm67s@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190829144140.6xaygqkfhsnmm67s@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 29 19, Jarkko Sakkinen wrote:
>On Thu, Aug 29, 2019 at 05:40:40PM +0300, Jarkko Sakkinen wrote:
>> On Tue, Aug 27, 2019 at 05:46:21PM -0700, Jerry Snitselaar wrote:
>> > There was revealed a bug in the STM TPM chipset used in Dell R415s.
>> > Bug is observed so far only on chipset firmware 1.2.8.28
>> > (1.2 TPM, device-id 0x0, rev-id 78). After some number of
>> > operations chipset hangs and stays in inconsistent state:
>> >
>> > tpm_tis 00:09: Operation Timed out
>> > tpm_tis 00:09: tpm_transmit: tpm_send: error -5
>> >
>> > Durations returned by the chip are the same like on other
>> > firmware revisions but apparently with specifically 1.2.8.28 fw
>> > durations should be reset to 2 minutes to enable tpm chip work
>> > properly. No working way of updating firmware was found.
>> >
>> > This patch adds implementation of ->update_durations method
>> > that matches only STM devices with specific firmware version.
>> >
>> > Cc: Peter Huewe <peterhuewe@gmx.de>
>> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > Signed-off-by: Alexey Klimov <aklimov@redhat.com>
>> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> > ---
>> > v2: Make suggested changes from Jarkko
>> >     - change struct field name to durations from durs
>> >     - formatting cleanups
>> >     - turn into void function like update_timeouts and
>> >       use chip->duration_adjusted to track whether adjustment occurred.
>>
>> The code repetition looks horrible so I wrote a patch that should help:
>>
>> https://patchwork.kernel.org/patch/11121475/
>>
>> Read the remar that prepends the diffstat.
>
>Forgot from that remark that I did not have TPM 1.x available at hand
>(WFH today) so please also review and test it.
>
>/Jrakko

I will test it this morning, and once that is done I'll submit a v3 that
cleans up the version comparison in the update_durations function.
