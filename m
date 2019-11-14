Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F26C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D39120718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8PupHaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNRxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:53:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46591 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbfKNRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573754022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qEEEpz4UiZrRRK6yxzZEgZbLhacFZha0lL4NHGQd9V8=;
        b=L8PupHaq8mOh0yp1G7Pq0JpLRImdzzyxEHbocHwBwDAxZGvswQ73kz0cXipyMn2tuSjIKg
        wZIJeO5r3MAoeE8F9pXoKnuoCa/vr6drR24EH2mEnVa1Yoe77NxohzpBB/MUHYVVcfz3J7
        vVgplKOluh+zt8Tiu55zfebPTqJMa60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-GZmwaodeNN6FcVuzd5K8fA-1; Thu, 14 Nov 2019 12:53:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A6918A8526;
        Thu, 14 Nov 2019 17:53:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2B6A10027B9;
        Thu, 14 Nov 2019 17:53:32 +0000 (UTC)
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20191113193350.24511-1-longman@redhat.com>
 <20191114174553.GC7222@zn.tnic>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8f7e0f4b-5100-67b5-fcb5-f7a968b96110@redhat.com>
Date:   Thu, 14 Nov 2019 12:53:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191114174553.GC7222@zn.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: GZmwaodeNN6FcVuzd5K8fA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 12:45 PM, Borislav Petkov wrote:
> On Wed, Nov 13, 2019 at 02:33:50PM -0500, Waiman Long wrote:
>> For MDS vulnerable processors with TSX support, enabling either MDS
>> or TAA mitigations will enable the use of VERW to flush internal
>> processor buffers at the right code path. IOW, they are either both
>> mitigated or both not mitigated. However, if the command line options
>> are inconsistent, the vulnerabilites sysfs files may not report the
>> mitigation status correctly.
>>
>> For example, with only the "mds=3Doff" option:
>>
>>   vulnerabilities/mds:Vulnerable; SMT vulnerable
>>   vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT vul=
nerable
>>
>> The mds vulnerabilities file has wrong status in this case.
>>
>> Change taa_select_mitigation() to sync up the two mitigation status
>> and have them turned off if both "mds=3Doff" and "tsx_async_abort=3Doff"
>> are present.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  arch/x86/kernel/cpu/bugs.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index 4c7b0fa15a19..418d41c1fd0d 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -304,8 +304,12 @@ static void __init taa_select_mitigation(void)
>>  =09=09return;
>>  =09}
>> =20
>> -=09/* TAA mitigation is turned off on the cmdline (tsx_async_abort=3Dof=
f) */
>> -=09if (taa_mitigation =3D=3D TAA_MITIGATION_OFF)
>> +=09/*
>> +=09 * TAA mitigation via VERW is turned off if both
>> +=09 * tsx_async_abort=3Doff and mds=3Doff are specified.
>> +=09 */
> So this changes the dependency of switches so if anything, it should be
> properly documented first in all three:
>
> Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> Documentation/x86/tsx_async_abort.rst
> Documentation/admin-guide/kernel-parameters.txt
>
> However, before we do that, we need to agree on functionality:
I agree that the documentation needs to be updated. I am going to do
that once we have a consensus of what is the right thing to do.
> Will the mitigations be disabled only with *both* =3Doff supplied on the
> command line or should the mitigations be disabled when *any* of the two
> =3Doff is supplied?

The mitigation is disabled only with BOTH =3Doff supplied or
"mitigations=3Doff". This is the current behavior. This patch is just to
make sure that vulnerabilities files reflect the actual behavior. Of
course, we can change it to disable mitigation with either =3Doff if this
is what the consensus turn out to be.

Cheers,
Longman

