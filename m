Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD339C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8FD2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aneJfRUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfKFP0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:26:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727996AbfKFP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573053962;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDyn55vQ0zC56fcCjJAvaWSHX2sqlnGb0sAKw8IHj/s=;
        b=aneJfRUvdywDzDWd/WOkeJ8ZA1q+pFDq3KXhhpFZu636uqw6IduSJQ9+IjIOiRWUiWU0Qd
        28lJn/QfoVbEwK3gjIJaQtjaF+wE/oY1eyjuRH7kozSnrzPVRBcHeNeY63M1hPE3mNtaq3
        uz4DNtgLWY2bfjUkj6K26WlB71uyaHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-EXmaXr8tOJKEjNTa7TImNQ-1; Wed, 06 Nov 2019 10:25:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D983D107ACC3;
        Wed,  6 Nov 2019 15:25:57 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-121-160.rdu2.redhat.com [10.10.121.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04D8960BE0;
        Wed,  6 Nov 2019 15:25:55 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH] security/keyring: avoid pagefaults in
 keyring_read_iterator
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
References: <20191018184030.8407-1-crecklin@redhat.com>
 <30309.1571667719@warthog.procyon.org.uk>
 <b8aa0f7c-0a90-efae-9fb7-aa85b19a0d9a@redhat.com>
 <3c87bfba-9dc9-665f-17e8-0656e87c658b@redhat.com>
Organization: Red Hat
Message-ID: <3390b0d2-0f8e-3240-2ebb-94400456fdf0@redhat.com>
Date:   Wed, 6 Nov 2019 10:25:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3c87bfba-9dc9-665f-17e8-0656e87c658b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EXmaXr8tOJKEjNTa7TImNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2019 07:10 AM, Chris von Recklinghausen wrote:
> On 10/21/2019 11:46 AM, Chris von Recklinghausen wrote:
>> On 10/21/2019 10:21 AM, David Howells wrote:
>>> Chris von Recklinghausen <crecklin@redhat.com> wrote:
>>>
>>>> The put_user call from keyring_read_iterator caused a page fault which
>>>> attempts to lock mm->mmap_sem and type->lock_class (key->sem) in the r=
everse
>>>> order that keyring_read_iterator did, thus causing the circular lockin=
g
>>>> dependency.
>>>>
>>>> Remedy this by using access_ok and __put_user instead of put_user so w=
e'll
>>>> return an error instead of faulting in the page.
>>> I wonder if it's better to create a kernel buffer outside of the lock i=
n
>>> keyctl_read_key().  Hmmm...  The reason I didn't want to do that is tha=
t
>>> keyrings have don't have limits on the size.  Maybe that's not actually=
 a
>>> problem, since 1MiB would be able to hold a list of a quarter of a mill=
ion
>>> keys.
>>>
>>> David
>>>
>> Hi David,
>>
>> Thanks for the feedback.
>>
>> I can try to prototype that, but regardless of where the kernel buffer
>> is allocated, the important part is causing the initial pagefault in the
>> read path outside the lock so __put_user won't fail due to a valid user
>> address but page backing the user address isn't in-core.
>>
>> I'll start work on v2.
> Actually I'm going to back off on a v2 effort at this point and request
> that folks comment on the code as-is. Changing keyctl_read_key to use
> its own kernel buffer might be a worthwhile effort, but it doesn't
> appear to me to have any effects on preventing pagefaults on user pages
> at inopportune points of the code.

Does anyone have any more feedback on v1 of this patch?

Thanks,

Chris

>
> Thanks,
>
> Chris
>
>> Thanks,
>>
>> Chris
>>

