Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDC6C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E72F218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfDXCcA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 22:32:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfDXCcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 22:32:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0466CAF1F;
        Wed, 24 Apr 2019 02:31:59 +0000 (UTC)
Date:   Tue, 23 Apr 2019 19:31:52 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>,
        Christoph Lameter <cl@linux.com>,
        linuxppc-dev@lists.ozlabs.org, jgg@mellanox.com
Subject: Re: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is
 atomic
Message-ID: <20190424023152.vrnyx4r4oapt7vdy@linux-r8p5>
Mail-Followup-To: Daniel Jordan <daniel.m.jordan@oracle.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>,
        linuxppc-dev@lists.ozlabs.org, jgg@mellanox.com
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-6-daniel.m.jordan@oracle.com>
 <964bd5b0-f1e5-7bf0-5c58-18e75c550841@c-s.fr>
 <20190403164002.hued52o4mga4yprw@ca-dmjordan1.us.oracle.com>
 <20190424021544.ygqa4hvwbyb6nuxp@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190424021544.ygqa4hvwbyb6nuxp@linux-r8p5>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Bueso wrote:

>On Wed, 03 Apr 2019, Daniel Jordan wrote:
>
>>On Wed, Apr 03, 2019 at 06:58:45AM +0200, Christophe Leroy wrote:
>>>Le 02/04/2019 à 22:41, Daniel Jordan a écrit :
>>>> With locked_vm now an atomic, there is no need to take mmap_sem as
>>>> writer.  Delete and refactor accordingly.
>>>
>>>Could you please detail the change ?
>>
>>Ok, I'll be more specific in the next version, using some of your language in
>>fact.  :)
>>
>>>It looks like this is not the only
>>>change. I'm wondering what the consequences are.
>>>
>>>Before we did:
>>>- lock
>>>- calculate future value
>>>- check the future value is acceptable
>>>- update value if future value acceptable
>>>- return error if future value non acceptable
>>>- unlock
>>>
>>>Now we do:
>>>- atomic update with future (possibly too high) value
>>>- check the new value is acceptable
>>>- atomic update back with older value if new value not acceptable and return
>>>error
>>>
>>>So if a concurrent action wants to increase locked_vm with an acceptable
>>>step while another one has temporarily set it too high, it will now fail.
>>>
>>>I think we should keep the previous approach and do a cmpxchg after
>>>validating the new value.
>
>Wouldn't the cmpxchg alternative also be exposed the locked_vm changing between
>validating the new value and the cmpxchg() and we'd bogusly fail even when there
>is still just because the value changed (I'm assuming we don't hold any locks,
>otherwise all this is pointless).
>
>  current_locked = atomic_read(&mm->locked_vm);
>  new_locked = current_locked + npages;
>  if (new_locked < lock_limit)
>     if (cmpxchg(&mm->locked_vm, current_locked, new_locked) == current_locked)

Err, this being != of course.
