Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82196C5B579
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 04:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609D52083B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 04:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfF2EBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 00:01:37 -0400
Received: from namei.org ([65.99.196.166]:49794 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfF2EBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 00:01:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5T41PhZ017591;
        Sat, 29 Jun 2019 04:01:25 GMT
Date:   Fri, 28 Jun 2019 21:01:25 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Eric Biggers <ebiggers@kernel.org>
cc:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, scottsh@microsoft.com, mpatocka@redhat.com,
        gmazyland@gmail.com
Subject: Re: [RFC PATCH v5 0/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <20190628040041.GB673@sol.localdomain>
Message-ID: <alpine.LRH.2.21.1906282040490.15624@namei.org>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com> <20190628040041.GB673@sol.localdomain>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Eric Biggers wrote:

> I don't understand your justification for this feature.
> 
> If userspace has already been pwned severely enough for the attacker to be
> executing arbitrary code with CAP_SYS_ADMIN (which is what the device mapper
> ioctls need), what good are restrictions on loading more binaries from disk?
> 
> Please explain your security model.

Let's say the system has a policy where all code must be signed with a 
valid key, and that one mechanism for enforcing this is via signed 
dm-verity volumes. Validating the signature within the kernel provides 
stronger assurance than userspace validation. The kernel validates and 
executes the code, using kernel-resident keys, and does not need to rely 
on validation which has occurred across a trust boundary.

You don't need arbitrary CAP_SYS_ADMIN code execution, you just need a 
flaw in the app (or its dependent libraries, or configuration) which 
allows signature validation to be bypassed.

The attacker now needs a kernel rather than a userspace vulnerability to 
bypass the signed code policy.

-- 
James Morris
<jmorris@namei.org>

