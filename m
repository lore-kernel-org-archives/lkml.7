Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26461C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED699208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408878AbfFLKgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:36:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408253AbfFLKgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:36:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0633AF97;
        Wed, 12 Jun 2019 10:36:50 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] x86/xen: disable nosmt in Xen guests
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        tglx@linutronix.de, xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
References: <20190612101228.23898-1-jgross@suse.com>
 <5D00D1A602000078002376A9@prv1-mh.provo.novell.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <8392fdc4-a6b2-a3aa-dca6-0a0ad7a411be@suse.com>
Date:   Wed, 12 Jun 2019 12:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5D00D1A602000078002376A9@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.19 12:19, Jan Beulich wrote:
>>>> On 12.06.19 at 12:12, <jgross@suse.com> wrote:
>> When running as a Xen guest selecting "nosmt" either via command line
>> or implicitly via default settings makes no sense, as the guest has no
>> clue about the real system topology it is running on. With Xen it is
>> the hypervisor's job to ensure the proper bug mitigations are active
>> regarding smt settings.
> 
> I don't agree with the second sentence: It is in principle fine for the
> hypervisor to expose HT (i.e. not disable it as bug mitigation), and
> leave it to the guest kernels to protect themselves. We're just not
> at the point yet where Xen offers sufficient / reliable data to guest
> kernels to do so, so _for the time being_ what you say is correct.

Okay, I'll add something like:

This is true as long Xen doesn't support core scheduling together with
exposing the (then) correct sibling information to the guest and
indicating that case via a sutable interface.


Juergen

