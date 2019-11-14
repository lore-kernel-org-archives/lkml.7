Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE52206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7dmBbpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNMVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:21:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22491 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbfKNMVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573734092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZX7pGUHhWmTDW+4G9DVRk0+x/DIsEoLM1+7MqBPpmg=;
        b=B7dmBbpau4dVYxMwSicg9fysX+OqldBVSz3zzZFa+fmVbvLnDBGVLoEDIYcPwIkBp/y5Qe
        dlkowGO82urZzHglN4KD/AjlJqbnEGNRRNdG5qDzr762QaP3tG7Xj4DO7tXM6mRVvguOAA
        Q2zIbZPF0oSVmmEv4N3grv2O0G/Uy8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-fGPYAQngOrqdrOVl2fN1jg-1; Thu, 14 Nov 2019 07:21:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48110800C77;
        Thu, 14 Nov 2019 12:21:27 +0000 (UTC)
Received: from [10.36.117.13] (ovpn-117-13.ams2.redhat.com [10.36.117.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE5E55ED4B;
        Thu, 14 Nov 2019 12:21:23 +0000 (UTC)
Subject: Re: [PATCH v1 01/12] powerpc/pseries: CMM: Implement release()
 function for sysfs device
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
References: <47DFy90198z9sSZ@ozlabs.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8e2dc539-e4fc-6eae-568c-21a8e809c0fc@redhat.com>
Date:   Thu, 14 Nov 2019 13:21:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <47DFy90198z9sSZ@ozlabs.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fGPYAQngOrqdrOVl2fN1jg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.19 10:08, Michael Ellerman wrote:
> On Thu, 2019-10-31 at 14:29:22 UTC, David Hildenbrand wrote:
>> When unloading the module, one gets
>> [  548.188594] ------------[ cut here ]------------
>> [  548.188596] Device 'cmm0' does not have a release() function, it is b=
rok=3D
>> en and must be fixed. See Documentation/kobject.txt.
>> [  548.188622] WARNING: CPU: 0 PID: 19308 at drivers/base/core.c:1244 .d=
evi=3D
>> ce_release+0xcc/0xf0
>> ...
>>
>> We only have on static fake device. There is nothing to do when
>> releasing the device (via cmm_exit).
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Cc: Allison Randal <allison@lohutok.net>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Arun KS <arunks@codeaurora.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> Patches 1-10 applied to powerpc next, thanks.
>=20
> https://git.kernel.org/powerpc/c/7d8212747435c534c8d564fbef4541a463c976ff
>=20
> cheers
>=20

Thanks! I'll probably resend patch 11/12 to give it more attention and=20
to fixup one comment leftover in patch 11. I guess if we get ACKs these=20
two patch should also go via your tree to avoid collisions.

--=20

Thanks,

David / dhildenb

